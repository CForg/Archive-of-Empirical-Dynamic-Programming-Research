
program ssp44(input,output);
uses GPC ;

{$L fmopt.pas}
{$I fmopt_shared.header}
{$I ./ssp44.global}


{ procedure sspnested; }

    (*numerical functions *)
    function  spow(a,b : real): real; forward;
    procedure difference(moms:moms_type;var sr: simrecord_type;var dmpf : text); forward;
    procedure cumsum(indiff, invwght : pointer; scwght: real; var cumtot:real); forward;
    procedure product (m1,m2,result:pointer); forward;
    procedure scalarmult (mm:pointer;sc:real); forward;
    procedure zedmom (mm:pointer); forward;
    procedure zedall_eval (mm:pointer); forward;
    procedure zedall_inagg (mm:pointer); forward;
    procedure zedmom_exp(mm:pointer); forward;
    procedure zedhist (var hist : histogram_type); forward;
    function  sum(mm : pointer):real; forward;

(* indexing and initializing routines *)
  procedure Sset(var st : clock_type); forward; (* set the index for sp^ *)
  procedure smpset(var smp : sample_type); forward;
  procedure sspdecode(var smp : sample_type; call : call_type); forward;
  procedure invSset(var st : clock_type; nind : integer); forward; (* createstate from ind *)
  function equivalent(sind : integer): integer;  forward; (* return state equivalent to sind, sind if not redundant *)
  procedure invAset(var act: act_type; nind : a_range); forward;
  procedure sldispose(var slst : statelist_type); forward;
  procedure stdispose(var s    : stateptr); forward;
  procedure stnew(var s    : stateptr); forward;
  procedure slinit(var sl    : statelist_type); forward;

(*transition and utility *)
  function trans(sp : stateptr):statelist_type; forward;
  function ev(state:stateptr): real; forward;
  function sspqual(state : stateptr) : boolean; forward;
  function sspplus(state : stateptr) : boolean; forward;
  procedure set_utility(mom:momentptr; state : stateptr;integrate:boolean); forward;

(* input and output routines *)
{  procedure write_header; forward; }
  procedure mom_mask(moms: moms_type);forward;
  procedure read_moments; forward;


(* main routines *)
  procedure unpack(smp : sample_type); forward;
  procedure incrmom(var newmom,accmoms:moment_type; prob : real); forward;
  function cmpmom(var m1,m2,dff:moment_type): boolean; forward;
  procedure solveit(smp : sample_type); forward;
  procedure exact_dist(smp : sample_type); forward;
  procedure empgap(smp : sample_type;var outvec : compressed_type); forward;
  procedure calc_momdist_new(smp : sample_type; invec : compressed_type; var cumtot:real); forward;
  procedure calc_quad       (smp : sample_type; invec : compressed_type; var cumtot:real); forward;
  procedure comp_offsets; forward;
  procedure compact_exp(var sr : simrecord_type; vinptr : pointer); forward;
  procedure writeoptimal; forward;
  procedure draw(var u: real); forward;

  (* external name 'ox_ranu'; *)

var
      trackia            : boolean;
      pgmpar             : pgmparptr;
      mymodel            : param_type;
      problems           : problems_type;
      emlist             : emlist_type;
      dplist             : dplist_type;
      state              : stateptr;
      evslst,
      cslst,
      sp0,                   (* stack of states coming from action choices *)
      sp1,
      slst               : statelist_type;
      tlreal             : tlreal_type;
      vact               : vact_type;
      mmeans             : moment_type;
      fmenv              : environmentptr;
      envlet             : string(1);
      efile              : file of expected_type;
      myrfile            : file of real;
      sampfile,
      pathfile,
      ranfile,
      histfile,
      typefile,
      momfile,
      pname              : string(50);
      fdtoday,
      fdtomor            : distptr;
      fx0, fx1           : dist_type;
      u_tmat             : usermatrix_type;
      meptr              : myevalptr;
      msptr             :  mysolveptr;
      mieptr            :  myinevalptr;

{$include "ssp44_utilities_z.pas"}

procedure draw;
begin
  if not eof(myrfile) then read(myrfile,u) else writeln('Out of draws from ', ranfile);
end;

function sspqual;
begin with state^, st, vact[aind] do
sspqual := (nw<>W) AND ( ((nf=qualify) AND (nm in fulltime)) OR (nf in [yr1..yr3]) );
end;

function sspplus;
begin with state^, st, problem^.sample do
sspplus := (ng=ssp_plus) AND (nf in [qualify..yr3]);
end;

procedure readopt(const inem : integer);
var
    m1, m2 : compressed_range;
    vfile  : text;
    idstr  : string(2);
begin with emlist[inem]^ do begin
    writestr(idstr,inem);
    if inem < 10 then idstr := '0'+trim(idstr);
    reset(vfile,'paths/opt_'+idstr+'.mat');
    new(optmat);
    for m1 := 1 to n_emmoms do for m2 := m1 to n_emmoms do
        begin readln(vfile,optmat^[m1,m2]); optmat^[m2,m1] := optmat^[m1,m2] end;
    close(vfile);
end; end;

function trans_calc(var sp : state_type; perm : boolean) : statelist_type;
    var
    curs : state_type;
    pjt  : real;
    start,
    nend,
    old   : clock_type;
    ntx   : integer;
    plus,
    sch,
    qual,
    lst   : boolean;
begin
    slinit(slst);
    curs := sp;                       (* tomorrow is like today *)
    with curs, st, problem^, sample, demo, ssp, treat, latent, vact[aind] do
      begin
      if perm then nid := perm_state;
      old := st;
      if nm in athome then nd := One else nd := D;
      lst := nt>=T[nf];
      qual := sspqual(@curs);
      if ng<>control then case nf of
         reality  : ;
         yr1..yr3 : nf:=nf+ord(lst);
         qualify  : if qual then inc(nf) else if lst then nf := reality;
         enter    : if not(aind in onIA) then nf := reality else nf := nf+ord(lst);
         end;
      if (nf<>reality) AND (old.nf=nf) then inc(nt) else nt:=One;
      end;
    with nend, curs, vact[aind] do
      begin
      nu:=Zed; nh := Zed; nz := Zed;
      if (nm in athome) then nx := old.nx-min(old.nx,Two) else nx := pred(old.nx);
      end;
    with start, curs, vact[aind] do
      begin
      nu:=U; nh := H; nz:=Z;
      if (nm in athome) then nx := old.nx else nx := min(succ(old.nx),X);
      end;
    with  curs, st, vact[aind], problem^, latent do
      begin
      nu:=start.nu;
      repeat
       plus := sspplus(@curs);
       if pu[plus,nu,old.nu,nm]>0.0 then
          begin
          sch :=(nm in search) AND (nu>contue);
          if sch then
             begin nend.no := Zed; start.no:=N; end
          else
             begin start.no:=old.no; nend.no:=pred(old.no); end;
           no := start.no;
           repeat nx := start.nx; if sch then pjt := nprob[no,nx] else pjt:=1.0;
               repeat nz := start.nz;
                 repeat nh := start.nh;
                   repeat
                     prob := pjt*px[nx,old.nx,nm]*pu[plus,nu,old.nu,nm]*ph[nh,old.nh]*pz[nz,old.nz];
                     if (prob>0.0) then
                        begin Sset(st); smove(@curs,slst,perm); end;
                     dec(nh);
                   until (nh=nend.nh); dec(nz);
                 until (nz=nend.nz); dec(nx);
               until (nx = nend.nx); dec(no);
           until (no = nend.no);
           end; dec(nu);
         until (nu = nend.nu);
        end;
    trans_calc := slst;
    end;

function trans;
begin with sp^, st,pgmpar^ do
  if (nf=reality) AND (holdreal) then
     begin
     if tlreal[ind,aind].head=nil then tlreal[ind,aind]:=trans_calc(sp^,TRUE);
     trans := tlreal[ind,aind];
     end
   else
     trans:=trans_calc(sp^,FALSE);
end;

  function ev;
  var ns : stateptr;
      sum : real;
      date : boolean;
  begin with state^.problem^, dp^ do begin
    date := today;
    evslst:=trans(state); sum := 0.0; with evslst do ns := head;
    while ns <> nil do with ns^, st, dp^.bellman[ind] do
       begin sum := sum + prob * vmax[date]; ns := next; end;
    sldispose(evslst);
    ev := sum;
  end; end;


  procedure set_utility;
  var onw,trtf,equnder:integer; true_earn,actrept  : real;
  begin with  mom^, money, aux, state^, st, vact[aind], problem^, latent, demo, iav, ssp do
   begin
   if nm > maxM[nu] then
      begin pdv:=-maxreal;utility:=-maxreal; return; end;
   onw     := ord(nw=W);
   trtf    := ord(nf in [qualify..yr3]);
   actrept := report + trtf * (1-report) * sspbeta ;
   true_earn := vearn[nm,no,nx];
   earn    := (1-onw*(1-actrept))*true_earn;                                 { Changed June 2006; fixed August 2006 }
   welfare := onw*( (1-trtf)* iarecd[nm,no,nx]+trtf*iatrtmt[nm,no,nx]);      { Changed Sep 2006 to allow experimental change to IA }
   subsidy := (1-onw)*ord(sspqual(state))*ssprecd[nm,no,nx];
   transfer:= (1-onw)*stigma*iaval*(nz-One) / (Z-One);                         { Changed May 2006 was (nz-One) }
   utility := true_earn + welfare + subsidy + transfer - disutil[nh,nm];
   leakage := 0.0;
   if integrate then
     pdv := utility+beta*ev(state)
   else
     with lforce, dp^, bellman[ind] do begin
     pdv    := vmax[today];
     earnsq := sqr(earn);
     welfsq := sqr(welfare);
     onwelf := onw;
     equnder:= max(succ(N DIV 2)-nx+One,One);
     minwg  := ord( not(nm in athome) AND (no <=equnder));
     fulltm := ord(nm in fulltime);
     parttm := ord(nm in parttime);
     onXem  := onw *(fulltm+parttm);
     lostjb := ord(nu=laidoff);
     leftjb := ord((nu<>laidoff)AND(nd=Two)AND(nm in athome));
     end;
  end; end;

  procedure incrmom;
  begin
    with accmoms.money,  newmom do
         begin
         earn   :=    earn    + prob*money.earn;
         earnsq :=    earnsq  + prob*money.earnsq;
         subsidy:=    subsidy + prob*money.subsidy;
         welfare:=    welfare + prob*money.welfare;
         welfsq:=     welfsq  + prob*money.welfsq;
         end;
    with accmoms.lforce, newmom do
         begin
         onwelf :=  onwelf     + prob*lforce.onwelf;
         minwg  :=  minwg      + prob*lforce.minwg;
         fulltm :=  fulltm     + prob*lforce.fulltm;
         parttm :=  parttm     + prob*lforce.parttm;
         onXem  :=  onXem      + prob*lforce.onXem;
         leftjb :=  leftjb     + prob*lforce.leftjb;
         lostjb :=  lostjb     + prob*lforce.lostjb;
         end;
    with accmoms.aux,  newmom do
         begin
         transfer:= transfer  + prob*aux.transfer;
         utility := utility   + prob*aux.utility;
         pdv     := pdv       + prob*aux.pdv;
         {leakage}
         end;
  end;

  function cmpmom;
  var df : real;
  begin
    df := 0.0;
    with m1.money,  m2 do
         begin
         dff.money.earn    := earn    - money.earn;
         dff.money.earnsq  := earnsq  - money.earnsq;
         dff.money.subsidy := subsidy - money.subsidy;
         dff.money.welfare := welfare - money.welfare;
         dff.money.welfsq  := welfsq - money.welfsq;
         df :=df +    abs(dff.money.earn   );
         df :=df +    abs(dff.money.earnsq );
         df :=df +    abs(dff.money.subsidy);
         df :=df +    abs(dff.money.welfare);
         df :=df +    abs(dff.money.welfsq );
         end;
    with m1.lforce, m2 do
         begin
         dff.lforce.onwelf :=onwelf     - lforce.onwelf;
         dff.lforce.minwg  :=minwg      - lforce.minwg;
         dff.lforce.fulltm :=fulltm     - lforce.fulltm;
         dff.lforce.parttm :=parttm     - lforce.parttm;
         dff.lforce.onXem  :=onXem      - lforce.onXem;
         dff.lforce.leftjb :=leftjb     - lforce.leftjb;
         dff.lforce.lostjb :=lostjb     - lforce.lostjb;
         df :=df +   abs(dff.lforce.onwelf);
         df :=df +   abs(dff.lforce.minwg );
         df :=df +   abs(dff.lforce.fulltm);
         df :=df +   abs(dff.lforce.parttm);
         df :=df +   abs(dff.lforce.onXem);
         df :=df +   abs(dff.lforce.leftjb);
         df :=df +   abs(dff.lforce.lostjb);
         end;
    with m1.aux,  m2 do
         begin
         dff.aux.transfer:=transfer  - aux.transfer;
         dff.aux.utility :=utility   - aux.utility;
         dff.aux.pdv     :=pdv       - aux.pdv;
         df := df + abs(dff.aux.transfer);
         df := df + abs(dff.aux.utility);
         df := df + abs(dff.aux.pdv);
         end;
    {leakage}
    cmpmom := df > 1E-9;
  end;


  function doit(llc:cond_type; recvia:boolean) : integer;
  begin
  doit := ord((llc=un)OR(recvia AND (llc=on))OR ((not recvia) AND (llc=off)) );
  end;


procedure solveit;
var
  deltmax  : real;
  tmom     : moment_type;

    procedure actloop;
    var vnew : real;
    prtout : boolean;
    begin with state^, st, problem^, dp^, bellman[ind],  latent, sample do begin
       vnew := -maxreal; aind := Asize;
       repeat with vact[aind],tmom.aux do begin
           set_utility(@tmom,state,TRUE);
           pact[aind] := pdv;
           vnew := max(vnew,pdv);
           dec(aind);
           end;
       until aind=Zed;
       if not converged then deltmax:=max(deltmax,abs(vmax[today]-vnew));
       vmax[today]:=vnew;
    end; end;

    procedure probloop;
    var llc    : cond_type;
        prtout,
        recvia : boolean;
        cp     : real;
    begin with state^, st, problem^, latent, dp^, bellman[ind], pgmpar^ do begin
       aind:=Asize;cp := 0.0; for llc := un to on do cprob[llc] := 0.0;
       repeat
         recvia := (aind in onIA);
         if pact[aind]>-maxreal then
            pact[aind] := exp(max(tau*(pact[aind]-vmax[today]),smlog))
         else
            pact[aind] := 0.0;
         for llc:= un to on do cprob[llc] := cprob[llc]+doit(llc,recvia)*pact[aind];
         dec(aind);
       until aind=Zed;
       aind := Asize;
       repeat pact[aind]:=cp+pact[aind]/cprob[un];cp:=pact[aind];dec(aind);until aind=Zed;
       for llc := on downto un do cprob[llc] := min(cprob[llc]/cprob[un],1.0);
       end; end;

     procedure momset;
     var  llc    : cond_type; tt,cp : real;  prtout : boolean;
     begin with state^, problem^, dp^, bellman[st.ind]  do begin
     for llc := un to on do begin                     { loop was added August 2002 because t0 in sample }
       if (cprob[llc]>0.0) then
          begin
          if (mom[llc]=nil) then new(mom[llc]);
          zedmom(mom[llc]);
          cp := 0.0;aind:=Asize;
          repeat
            tt :=  doit(llc,(aind in onIA))*(pact[aind]-cp);
            if tt>0.0 then
               begin
               set_utility(@tmom,state,FALSE);
               incrmom(tmom,mom[llc]^,tt/cprob[llc]);
               end;
            cp := cp+pact[aind];
            dec(aind);
          until aind=Zed;
          end;
       end;
    end; end;

  procedure setopta;
  var  holdmom    : mcond_type;
  begin with state^, st, problem^, sample, dp^, bellman[ind] do begin
  if equiv=ind then                                   (* this state not redundant *)
     begin actloop; if converged then probloop; end
  else                                                (* keep moments *)
     begin holdmom := mom; bellman[ind]:=bellman[equiv];mom := holdmom; end;
  if converged then momset;
  end;end;

  procedure incrnt;
  const mxiter = 75000;
  begin with state^, st, problem^, dp^, pgmpar^ do
  if converged then
    begin
    dec(nt);
    today := FALSE;
    end
  else
    begin
    converged := ((deltmax <= vtol) OR (nid>mxiter));
    if nid>mxiter then writeln('* mxiter reached ',deltmax:13:12);
    deltmax:=0.0; inc(nid);
    today := FALSE;
    end;
  end;

  procedure incrnf;
  begin with state^, st, problem^, sample, dp^ do begin
   do_real := do_real AND (nf<>reality); dec(nf); ny:=ng;  {Added Feb 2006}
  end; end;

  procedure solve_start;
  var ns : real_range; tomor : boolean;
  begin
   stnew(state);
   state^.problem := problems[smp.pbind];
   with smp, state^, st, problem^, dp^, pgmpar^ do
      begin
      deltmax := 0.0;
      today := FALSE;   {tomor := today; today:=not tomor; }
      nid:=Zed;
{      if not holdvalue then with demo, iav do
        for ns := low_real to hi_real do with bellman[ns] do
            vmax[today]:= mininc; }
      if do_real then
         begin nf:=reality;ny := One; end
      else
         begin nf:=treat.maxF;ny:=ng;end;
      converged := nf<>reality;
      if not converged then inittlreal;
      end;
  end;

begin
  solve_start;
  with state^, st, problem^, treat, demo.ssp do
      repeat nt := T[nf];
        repeat nh := H;
          repeat nx := X;
            repeat nz := Z;
              repeat nu := U;
                repeat no := N;
                  repeat nd := D;
                    repeat
                      Sset(st);setopta; dec(nd);
                    until nd=Zed;       dec(no);
                  until no = Zed;       dec(nu);
                until nu = Zed;         dec(nz);
              until nz = Zed;           dec(nx);
            until nx = Zed;             dec(nh);
          until nh = Zed;               incrnt;
        until nt = Zed;                 incrnf;
      until nf = pred(minF);
   stdispose(state);
end;


  procedure unpack;
  var kk          : integer;
      lm          : m_range;
      lx          : x_range;
      llz,lz      : z_range;
      llh,lh      : h_range;
      eqover,equnder,
      lln         : n_range;
      lu,
      llu         : u_range;
      lf          : f_range;
      pmw, lmu, lsigma, plt, pu_t,pzt,alph,texp,pc,
      pjtplus, hgamm, lambda,fstar,
      pht, tmpr, pdt1, pdt2, pjt : real;
      pjt2    : array[boolean] of real;
      plus    : boolean;
      hv      : h_type;      (* value of household time *)
      offer   : of_type;     (* value of wage offers *)
      wrk,
      srch        : m_type;

      procedure readnext(var y : real);
      begin with mymodel, rpars, smp do begin
      y := ecpars[nl][kk];inc(kk);
      end;end;

      procedure readcm(var y : real);
      begin with mymodel, rpars, smp do begin
      y := cmpars[kk];inc(kk);
      end;end;


      procedure readset;
      begin
      kk:=1;
      with smp, problems[pbind]^.latent do
       begin
       readnext(beta);      (* discount delta *)
       readnext(pc);        (* cost of job search kappa*)
       readnext(lmu);       (* mean log offer mu *)
       readnext(lsigma);    (* stdev log offer sigma *)
       readnext(pmw);       (* proportion of job offers that are dead-end MW jobs *)
       readnext(pjtplus);   (*  ssp+ effect psi*)
       readnext(pdt2);      (* skill accum rate a *)
       readnext(pdt1);      (* skill deprec rate d *)
       readnext(pjt);       (* prob. of job offer j*)
       readnext(lambda);    (* layoff l *)
       readnext(stigma);    (* % of IAB that OS *)
       readnext(pu_t);      (* proportion of jobs that are full-time f*)
       readnext(texp);      (* coeff on time cost nu*)
       readnext(alph);      (* skill exponent eta*)
       readnext(tau);       (* smoothing factor rho *)
       readnext(report);    (* % of income reported to IA  beta*)
       kk:=1;
       readcm(pzt);       (* transfer / support change prob s*)
       readcm(pht);       (* prob. of hh change h*)
       readcm(hgamm);     (* hh value exponent zeta*)
       end;
     end;

begin with smp, problems[pbind]^, latent, demo, iav, ssp,pgmpar^ do begin
   readset;
   for lm := One to M do   (* depreciation, srch *)
       if lm in athome then
          begin
          srch[lm]:= pred(lm)/pred(mxhome);
          wrk[lm]:=0.0;
          px[One,One,lm]:=1.0;
          if X>One then px[Two,One,lm]:=0.0;   (* actually handled by trans *)
          for lx := Two to X do
              begin
              if lx<X then px[succ(lx),lx,lm]:=0.0;
              px[pred(lx),lx,lm]:=pdt1;
              px[lx,lx,lm]:=1-px[pred(lx),lx,lm]
              end;
          end
       else
          begin
          wrk[lm]  := (lm-mxhome) / (M-mxhome);
          srch[lm]:= 0.0;
          px[X,X,lm]:=1.0;
          px[pred(X),X,lm]:=0.0;
          for lx := One to pred(X) do
              begin
              if lx>One then px[pred(lx),lx,lm]:=0.0;
              px[succ(lx),lx,lm]:= pdt2*wrk[lm];
              px[lx,lx,lm]:=1-px[succ(lx),lx,lm];
              end;
          end;
   for lz:= One to Z do
       for llz := One to Z do
           if lz=llz then pz[lz,llz]:= 1-pzt+pzt/Z else pz[lz,llz]:= pzt / Z ;
   for lx := X downto One do
      begin
      equnder := max(succ(N DIV 2)-lx+One,One);
      eqover := N-equnder;
      fstar := cdfn((ln(mininc)-alph*ln(lx/X)-lmu)/lsigma);
      for lln := One to equnder do
          begin
          offer[lln,lx]:=mininc;
          if lln=One then nprob[lln,lx]:=pmw else nprob[lln,lx] := (1-pmw)*fstar/pred(equnder);
          end;
      for lln := succ(equnder) to N do
          begin
          offer[lln,lx] := spow(lx/X,alph)*exp(min(lmu+lsigma*invn(fstar+(lln-equnder)*(1-fstar)/succ(eqover)),20.0));
          nprob[lln,lx] := (1-pmw)*(1-ord(equnder>One)*fstar)/eqover;
          end;
      if outpars then
         begin
         writeln("Offers for x=",x:lx," u o",equnder:1," ",eqover:1," ",fstar:8:5);
         for lln := N downto One do write('     ',offer[lln,lx]:5:3,' ',nprob[lln,lx]:-5:4);
         writeln;
         end;
      for lln := One to N do
         for lm := One to M do
             begin
             vearn[lm,lln,lx] := offer[lln,lx]*wrk[lm];
             iarecd[lm,lln,lx] :=max(iaval-report*(vearn[lm,lln,lx]-min(vearn[lm,lln,lx],setaside)),0.0);
             iatrtmt[lm,lln,lx]:=max(sspiapct*iaval-(report+sspbeta*(1-report))*(vearn[lm,lln,lx]-min(vearn[lm,lln,lx],setaside)),0.0);
             ssprecd[lm,lln,lx]:=ord(vearn[lm,lln,lx]>=mininc)*max(ssprate*(ssprange*mininc-vearn[lm,lln,lx]),0.0);
             end;
      end;
   for lh:= One to H do
       begin
       hv[lh]:= -hgamm*ln( 1 - lh/(H+1) );
       for llh := One to H do
           if lh=llh then ph[lh,llh]:= 1-pht+pht/H else ph[lh,llh]:= pht / H ;
       for lm := One to M do
           disutil[lh,lm] := texp*spow(pc*srch[lm]+wrk[lm],hv[lh])*vearn[M,N,X];
       if outpars then
           begin for lm := One to M do write('     ',disutil[lh,lm]:5:3); writeln; end;
       end;
   for lm := One to M do            (* job offer prob *)
       begin
       if lm in athome then
          begin
          pjt2[FALSE] := pjt*srch[lm];
          pjt2[TRUE] := pjt2[FALSE]+pjtplus*(1-pjt2[FALSE]);
          for plus := FALSE to TRUE do
            for lu := One to U do
                begin
                if U>succ(contue) then
                   begin
                   pu[plus,U,lu,lm] := pu_t * pjt2[plus];
                   pu[plus,pred(U),lu,lm]:= (1-pu_t) * pjt2[plus];
                   end
                else
                   pu[plus,U,lu,lm] := pjt2[plus];
                pu[plus,laidoff,lu,lm]:=0.0;
                pu[plus,contue,lu,lm]:=1-pjt2[plus];
                end;
          end
       else
        for plus := FALSE to TRUE do
          begin
          for lu := One to contue do
              begin
              for llu := contue+1 to U do pu[plus,llu,lu,lm]:=0.0;
              pu[plus,laidoff,lu,lm]:=0.0;
              pu[plus,contue,lu,lm]:=1.0;
              end;
          for lu := contue+1 to U do
              begin
              for llu := contue+1 to U do pu[plus,llu,lu,lm]:=0.0;
              pu[plus,lu,lu,lm]:=1-lambda;
              pu[plus,contue,lu,lm]:=0.0;
              pu[plus,laidoff,lu,lm]:=lambda;
              end;
          end;
       end;
   if outpars then writeln;
end; end;



procedure exact_dist;
var
  sproblem : problemptr;
  swap    : distptr;
  cur     : stateptr;
  condp,
  addp,
  lostp,                 (* probability lost last period from conditioning *)
  cumprob                (* used to check that probabilities add to 1 always *)
          : real;
  detsign,
  time    : integer;
  mmp     : momentptr;
  cnd     : cond_type;
  simrecord: simrecord_type;
  simstate: array[sim_range] of state_type;
  i_draw  : array[sim_range] of real;

   procedure expact;
   var
     sprob,
     lprob,
     fprob,
     prevprb,
     actprb : real;
     cs     : stateptr;
   begin with sproblem^, treat, dp^,pgmpar^ do begin
   with cur^, st, bellman[ind], expected[time] do
        begin
        fprob := prob;
        if mmp<>nil then incrmom(mmp^,expected[time],fprob*cprob[cnd]);
        addp := addp + fprob*(1-cprob[cnd]);
        end;
   prevprb:=0.0; cur^.aind := Asize;
   repeat
      with cur^, bellman[st.ind]  do
         begin
         actprb := doit(cnd,aind in onIA)*fprob*(pact[aind]-prevprb); prevprb:=pact[aind];
         end;
      if actprb>0.0 then
         begin
         cslst:=trans(cur); cs := cslst.head;
         while cs<>nil do with cs^,st do
            begin
            sprob := actprb*prob;
            if sprob>0.0 then
               begin
               if fdtomor^[ind]=0.0 then smove(cs,sp1,FALSE);
               sp1.head^.problem:=sproblem;
               fdtomor^[ind] := fdtomor^[ind]+ sprob;
               end;
            cs:=next;
            end;
         sldispose(cslst);
         end;
      with cur^ do dec(aind);
   until cur^.aind=Zed;
   end;end;

   procedure oneperiod;
   var nrep : integer;
   begin with sp0, pgmpar^ do begin
      cur := head;
      cumprob:=0.0;
      while cur<>nil do with cur^, st, problem^, dp^, treat, sample, demo.ssp do
          begin
          prob :=  fdtoday^[ind]*lostp;
          fdtoday^[ind] := 0.0;
          if histptrs[time]<>nil then with histptrs[time]^ do
              begin
              hgo[no] := hgo[no] +prob;
              hgx[nx] := hgx[nx] +prob;
              hgz[nz] := hgz[nz] +prob;
              hgh[nh] := hgh[nh] +prob;
              end;
          trackia := time=Tstart;
          if  (time>=Tmin) AND (time<=Tstart) then
              case xnum of
              0,1,3,4,5: if (ne=entry) AND (time<Tstart) then
                            cnd:=off
                       else begin
                            cnd:=on;
                            if writeoptout then for nrep := 1 to SIMREPS do if (cumprob <= i_draw[nrep]) & (cumprob+prob>=i_draw[nrep]) then  simstate[nrep] := cur^;
                            end;
              2: begin
                 if (ne=entry) then
                     begin if (time<Tstart)AND (time>Tmin) then cnd:=off else cnd:=on; end
                 else
                     begin if time>Tmin then cnd:=on else cnd:=off; end
                 end;
              end
          else
              begin
              cnd := un;
              if time=succ(Tstart) then
                 begin
                 nf := minF; nt := tfirst; ny:=ng; Sset(st);
                 end
              end;
          cumprob:=cumprob+prob;
          with dp^.bellman[ind] do mmp := mom[cnd];
          if prob>0.0 then expact;
          cur := next;
          end;
      sldispose(sp0); sp0 := sp1; slinit(sp1);
      swap := fdtoday; fdtoday := fdtomor; fdtomor:= swap;
      with sproblem^,treat, expected[time] do
           begin
           if addp<1.0 then lostp := 1/(1-addp) else lostp := 1.0;
           scalarmult(@expected[time],lostp);
           if time>=Tmin then
                leakage := (expected[pred(time)].leakage +(1-expected[pred(time)].leakage)*addp)
           else
              leakage := 0.0;
           addp:=0.0;
           end;
   end; end;

   procedure set_dist;
   var tsp : state_type;
       cp  : real;
       ls  : s_range;
   begin with sproblem^.dp^ do begin
   for ls := One to Ssize do fdtoday^[ls]:=0.0;
   fdtomor^ := fdtoday^;
   cp := 0.0;
   with tsp do
     begin
     next := nil;  problem := sproblem;
     for ls := low_real to hi_real do
         if rdist[ls]>0.0 then
            begin
            invSset(st,ls);nid := ls;
            prob := rdist[ls];
            fdtoday^[ls]:=prob;
            smove(@tsp,sp0,FALSE);
            cp := cp+prob;
            end;
     end;
   if abs(cp-1.0)>1E-5 then  writeln('not cp=1 in set_dist ',cp:6:5);
   end; end;

   procedure calc_stationary;
   const itmax = 50;
   var
     ls,lls   : s_range;
     hsave    : rdist_type;
     swap,
     tod,
     tom      : rdistptr;
     rst      : state_type;
     cs       : stateptr;
     cp,
     actprb,
     prevprb  : real;
     offls,
     iter     : integer;
     vmat     : matrix_record;
   begin with sproblem^.dp^, vmat do begin
   mtype := usermat;
   umat := @u_tmat;
   with rst do
     begin next := nil;  problem := sproblem;nid:=0;  prob := 0.0;end;

   for ls := low_real to hi_real do with bellman[ls] do
       begin
       offls := succ(ls-low_real);
       rdist[ls]:=0.0;
       for lls := low_real to hi_real-1 do umat^[succ(lls-low_real),offls] := 0.0;
       umat^[offls,offls]:=-1.0;
       umat^[n_rstates,offls]:=1.0;
       hsave[ls]:=0.0;
       prevprb:=0.0;
       with rst do begin invSset(st,ls);aind:=Asize; end;
       repeat
          with rst do
            begin
            actprb :=(pact[aind]-prevprb);prevprb:=pact[aind];
            end;
          if actprb>0.0 then
             begin
             cslst := trans(@rst); cs:=cslst.head;
             while cs<>nil do with cs^,st do
                  begin
                  if ind=hi_real then
                     hsave[ls]:=hsave[ls]+actprb*prob
                  else
                     umat^[succ(ind-low_real),offls] := umat^[succ(ind-low_real),offls] + actprb*prob;
                  cs:=next;
                  end;
              sldispose(cslst);
              end;
          with rst do dec(aind);
       until rst.aind=Zed;
       end;
   rdist[hi_real]:=1.0;
   mat_solve(@rdist,vmat,n_rstates,detsign);
   if detsign=0 then
      begin
      writeln('fail to solve linear sys for ergodic dist. Now ',itmax,' iterations on transition(corrected)');
      new(tod); new(tom);
      for lls := low_real to hi_real do
          begin umat^[n_rstates,succ(lls-low_real)] := hsave[lls]; tod^[lls]:=1/n_rstates; end;
      for iter := 1 to itmax do
        begin
        for lls := low_real to hi_real do
            begin
            tom^[lls] := 0.0;
            for ls:=low_real to hi_real do tom^[lls]:=tom^[lls]+tod^[ls]*umat^[succ(lls-low_real),succ(ls-low_real)];
            end;
        swap := tod; tod := tom; tom := swap;
        end;
      rdist := tod^;
      dispose(tod); dispose(tom);
      end;
   cp := 0.0;
   for ls := low_real to hi_real do
       if rdist[ls]>0.0 then cp := cp + rdist[ls] else rdist[ls]:=0.0;
   cp :=  1 / cp;
   for ls := low_real to hi_real do rdist[ls]:=cp*rdist[ls];
   end; end;

   procedure preinit;
   var  dd  :  dd_range;
        nrep : integer;
   begin with smp do begin
   sproblem := problems[pbind];
   lostp := 1.0; addp:=0.0; slinit(sp1); slinit(sp0);
   with sproblem^,treat,pgmpar^,em^, simrecord do
      begin
      zedmom(@expected[pred(Tmin)]);
      simsamp  := sample;
      wght := 0.0;
      if writeoptout then for nrep := 1 to SIMREPS do draw(i_draw[nrep]);
      for dd := Tstart to Tstop do
          begin
          zedmom(@expected[dd]);
          if histptrs[dd]<>nil then zedhist(histptrs[dd]^);
          end;
      end;
   end; end;


  procedure simulate_paths(t0,t1:integer);
  var nrep : integer;
      pathf   : file of simrecord_type;
      simexp  : expected_type;
      dd : dd_range;

        procedure onesimulation(simptr:stateptr ;momptr : momentptr);
            var     u_state, u_act, cumprb  :real;
                    cs     : stateptr;
        begin with sproblem^, treat, dp^, pgmpar^ do begin
            draw(u_state);
            with simptr^, st, bellman[ind] do
                begin
                aind := Asize;
                while (pact[aind]<u_state) do dec(aind);
                set_utility(momptr,simptr,FALSE);
                end;
            cslst:=trans(simptr);
            cs := cslst.head;
            with cs^, st do cumprb := prob;
            draw(u_act);
            while (cumprb < u_act) do begin cs:=cs^.next; with cs^,st do cumprb := cumprb + prob;end;
            simptr^ := cs^;
            simptr^.next := nil;
            sldispose(cslst);
        end;end;

  begin with simrecord do begin
   append(pathf,pathfile);
   for nrep := 1 to SIMREPS do
       begin
       for dd := t0 to t1 do onesimulation(@simstate[nrep],@simexp[dd]);
       compact_exp(simrecord,@simexp);
       write(pathf,simrecord);
       end;
   close(pathf);
  end; end;

begin preinit; with sproblem^, treat, dp^, em^, pgmpar^ do begin
   if sp0old then calc_stationary;
   set_dist;
   time := pred(Tmin);  {first period is infinite horizon results}
   repeat oneperiod; inc(time);   until time> Tstop;
   sldispose(sp0);sp0old:=FALSE;
   if writeoptout then simulate_paths(Tobsmin,Tobsmax);
end; end;


  procedure read_moments;
  var smp: sample_type;
      in_id : month_id;
      notfnd : boolean;
      mp     : integer;
      fn     : long_string;
      source : source_type;
      dd     : dd_range;
      momf   : text;

    procedure read_samp;
    begin
    with smp do
        begin
        read(momf,nr,nc,ne,ng,nl);
        nl := max(nl,One);
        end;
    smpset(smp);
    with in_id do read(momf,mth,src,smpa,smpb,mdelt);
    end;

  procedure read_record(mrec : momentptr);
  var inm : momarrayptr; nv : var_range; tt : pointer;
  begin
  tt := mrec; inm:=tt;
  for nv := 1 to Nmoments do read(momf,inm^[nv]);
  if not eoln(momf)then readln(momf);
  end;

  begin with smp, in_id, pgmpar^ do begin
    fn := 'imeans'+vnum+'.raw';
    reset(momf,fn);read_record(@mmeans);close(momf);
    fn := 'empmom'+vnum+'.raw';
    reset(momf,fn);
    totsmpb := 0;
    in_id.nobs:=0;
    while not eof(momf) do
          begin
          read_samp;
          if emlist[emind]=nil then
             begin
             new(emlist[emind]);
             with emlist[emind]^ do
                begin
                Tobsmax:=mth; Tobsmin:=mth;
                new(smpwght);
                new(comp_imean);
                for dd := Dmin to Dsimmax do with moments[dd] do with id do
                    begin mth:=dd;smpa:=0;smpb:=0;nobs:=0;for source := mask to Nmoments do moms[source]:=NIL;end;
                end;
             end;
          with emlist[emind]^, moments[mth], id do
             begin
             id := in_id;
             moms[imeans] := @mmeans;
             if moms[src]= nil then new(moms[src]) else writeln('Error - duplicate input moment');
             read_record(moms[src]);
             if moms[mask]=nil then begin new(moms[mask]); mom_mask(moms); end;
             Tobsmax := max(Tobsmax,mth);
             Tstop:=min(max(Tobsmax,Dsim),Dfit);
             Tobsmin := min(Tobsmin,mth);
             totsmpb := totsmpb+smpb;
             end;
          end;
    close(momf);
  end; end;

    function oprod(m1, m2 : momentptr): moment_type;
    var tmp : moment_type; begin product(m1,m2,@tmp);oprod := tmp;end;

    function cprod(m1, m2 : momentptr):real;var tmp: moment_type;
    begin  tmp:=oprod(m1,m2); cprod := sum(@tmp);end;

    function vmprod(m1 : momentptr; mm : month_type): moment_type;
    var tmp : momarrayptr;nv : var_range; mtmp : momentptr;
    begin with mm, id do begin
    new(tmp);ptrass(tmp,mtmp);
    for nv:= 1 to Nmoments do tmp^[nv]:=cprod(m1,moms[nv]);vmprod := mtmp^;dispose(tmp);
    end; end;

procedure empgap;
const sep = ',';
var
    dd  :  dd_range;
    i   : integer;
    nv,
    source : source_type;
    transfer : pointer;
    mrec   : momarrayptr;
    sr     : simrecord_type;
    dmpf   : text;
begin
sr.simsamp := smp;
with sr, simsamp, pgmpar^ do begin
if outmom then extend(dmpf,momfile);
added := 0;
for i := 1 to max_compressed do simpath[i]:= 0.0;
if problems[pbind]<> nil then with problems[pbind]^, treat, em^ do
   begin
   dd := pred(Tmin);
   repeat with moments[dd], id do
       begin
       if (dd>=Tobsmin) AND (dd<=Tobsmax) AND (inthedata) then difference(moms,sr,dmpf);
       if outmom then for source:=succ(mask) to predicted do if (moms[source]<> nil) AND ( (xnum=0) OR (source=predicted)) then
          begin
          transfer:=moms[source];  mrec := transfer;
          write(dmpf,nr:1,sep,nc:1,sep,ne:1,sep,ng:1,sep,'0',sep,dd:3,sep,xnum:1,sep,source:3,sep,smpa:4,sep,smpb:4,sep,0.0:7:3,sep);
          for nv := 1 to Nmoments do write(dmpf,mrec^[nv]:7:4,sep);
          writeln(dmpf);
          end;
       dd := max(succ(dd),Tstart);
       end;
   until dd> Tstop;
   end;
outvec := simpath;
if outmom then close(dmpf);
end; end;


procedure calc_momdist_new;
var        m1 : compressed_range;
begin with smp, pgmpar^, emlist[emind]^ do begin
    for m1 := 1 to n_emmoms do cumtot := cumtot+smpwght^[m1]*comp_imean^[m1]*sqr(invec[m1]);
end; end;


function calc_quad;
var m1, m2 : compressed_range;
    emdelt : real;
begin with smp, pgmpar^, emlist[emind]^ do begin
    if (optmat=nil) then readopt(emind);
    emdelt := 0.0;
    for m1 := 1 to n_emmoms do
          for m2 := m1 to n_emmoms do
                emdelt := emdelt + 2*smpwght^[m1]*smpwght^[m2]*optmat^[m1,m2]*invec[m1]*invec[m2];
{    if (outmom) then writeln("*** Fit ",emind:3,' ',n_emmoms:5,' ',emdelt);}
    if (emdelt<0) then
        begin
        {writeln("*** ",emind:3,' ',emdelt);}
        emdelt := -emdelt;
        end;

    cumtot := cumtot + emdelt;
end; end;

    procedure compact_exp;
    const half = 0.5;
    var nv       : integer;
        dd       : dd_range;
        ptransfer: pointer;
        ivec,
        maskvec  : momarrayptr;
        momvec   : ^momexp_type;
    begin with sr, simsamp, pgmpar^, emlist[emind]^ do begin
    added := 0; ptransfer := vinptr; momvec := ptransfer;
    for dd := Tobsmin to Tobsmax do with moments[dd], id do
        begin
        ptransfer := moms[mask]; maskvec:= ptransfer;  ptransfer:=moms[imeans]; ivec := ptransfer;
        for nv := 1 to Nmoments do if maskvec^[nv]>half then
            begin
            inc(added);
            if (momvec<>nil) then
               simpath[added] := momvec^[dd][nv]
            else
               begin
               comp_imean^[added] := ivec^[nv];
               smpwght^[added] := smpb/totsmpb;
               end;
            end;
        end;
    end; end;

procedure comp_offsets;
var     insmp   : simrecord_type;
begin with insmp, simsamp, pgmpar^ do begin
  nactivemoments := 0;
  nR := R;nl := 0;
  repeat nC := C;
     repeat nE := E;
        repeat nG := G;
           repeat
              smpset(simsamp);
              if problems[pbind]<> nil then with problems[pbind]^ do
              if inthedata then with em^ do
                  begin
                  offset := nactivemoments;
                  compact_exp(insmp,nil);
                  n_emmoms := added;
                  nactivemoments := offset+added;
                  end;
              dec(nG);
           until nG=Zed; dec(nE);
        until nE=Zed; dec(nC);
     until nC=Zed; dec(nR);
  until nR=Zed;
end; end;

procedure writeoptimal;
var isposdef : boolean;
    summat : matrix_record;
    i,j      : compressed_range;
    nrep,
    node,
    k        : integer;
    pb       : pb_range;
    n_em     : em_range;
    wghts    : array[pb_range] of real;
    node_smp : sample_type;
    wfile    : file of expmatrix_type;
    smpf     : file of sample_type;
    inrec    : simrecord_type;
    pathf    : file of simrecord_type;
    totwghts : real;
    diag     : column_type;
    comppred : array[em_range] of simrecord_type;
    inpred   : expected_type;
    idstr    : string(2);
    emat     : expmat_array;
    ff       : text;

begin with summat, pgmpar^, fmenv^ do begin
  for pb := 1 to PBsize do wghts[pb] := 0.0;
  for n_em := 1 to EMsize do emat[n_em] := nil;

  for node := 0 to pred(ncpus) do
      begin
      writestr(idstr,node:-2);
      if node < 10 then idstr := '0'+trim(idstr);
      reset(smpf,'paths/samples_'+idstr+'.bin');
      while (not eof(smpf)) do
        begin
        read(smpf,node_smp);
        with node_smp do
            begin
            wghts[pbind] := wght;
            if emat[emind]=nil then
               begin
               new(emat[emind]);
               for i := 1 to max_compressed do for j := i to max_compressed do emat[emind]^[i,j] := 0.0;
               writestr(idstr,emind:-2);
               if emind < 10 then idstr := '0'+trim(idstr);
               reset(efile,'paths/prediction_'+idstr+'.bin');
               read(efile,inpred);
               close(efile);
               comppred[emind].simsamp := node_smp;
               compact_exp(comppred[emind],@inpred);
               end;
            end;
        end;

      close(smpf);
      end;

  (* Initialize average of outer product of moment differences *)

  totwghts := 0.0;
  nrep := 0; k:=0;
  for node := 0 to pred(ncpus) do
      begin
      writestr(idstr,node:-2);
      if node < 10 then idstr := '0'+trim(idstr);
      reset(pathf,'paths/path_'+idstr+'.bin');
      while (not eof(pathf)) do
        begin
        read(pathf,inrec);              { Read next simulated path, including sample information }
        with inrec, simsamp, emlist[emind]^ do
            begin
            for i := 1 to added do for j := i to added do
                emat[emind]^[i,j] := emat[emind]^[i,j] + wghts[pbind]*(simpath[i]-comppred[emind].simpath[i])*(simpath[j]-comppred[emind].simpath[j]);
            inc(nrep);
            totwghts := totwghts + wghts[pbind];
            end;
        end;
      close(pathf);
      end;

  writeln('Total replications ',nrep,' total weight ',totwghts);
  new(umat);
  mtype := usermat;
  for n_em := 1 to EMsize do
     if (emat[n_em]<> nil) then with emlist[n_em]^ do
         begin
         writestr(idstr,n_em:-2);
         if n_em < 10 then idstr := '0'+trim(idstr);
         for i := 1 to n_emmoms do for j := i to n_emmoms do mxmat^[i,j] := emat[n_em]^[i,j]/totwghts;
         rewrite(ff,'paths/covariance_'+idstr+'.mat');
         writeln(ff,n_emmoms*succ(n_emmoms) DIV 2,' ',1);
         for i := 1 to n_emmoms do for j := i to n_emmoms do writeln(ff,mxmat^[i,j]);
         close(ff);
         dispose(emat[n_em]);
         end;
  dispose(mxmat);
end; end;

procedure model(call : call_type; msg : pointer);
const sep = ',';
var
    ob      : obvec_ind;
    outscr  : oeval_type;  (* oevalptr; *)
    insmp   : sample_type;
    nev,
    i,
    dd      : integer;
    nv      : var_range;
    fstpass : boolean;
    ompt    : momentptr;
    ntt     : th_range;
    ftmp    : real;
    buffer  : buffer_type;
    dmph,
    dmpf    : text;
    idstr   : string(2);
    modelmom: mysolveptr;
    evpt    : myevalptr;
    evcompressed: myeval_type;
    mrec    : momarrayptr;
    evv     :  ^eval_type;
    ptransfer: pointer;
    selected: array[dd_range] of real;
    sfile   : file of sample_type;

begin with call, buffer, insmp, pgmpar^ do begin
    scratch := msg;
    msptr := generic;
    meptr := generic;
    mieptr:= generic;
    sspdecode(insmp,call);
    mymodel := pars^;
    case task of
    solve :    begin
               if writeoptout then reset(myrfile,ranfile);
               with dplist[dpind]^ do
                    begin sp0old := TRUE;  do_real := TRUE; end;
               nE := E;
               repeat ng := G;
                 repeat
                 smpset(insmp); inc(cnt);
                 if problems[pbind]<>nil then with problems[pbind]^ do
                    begin
                    unpack(insmp);
                    solveit(insmp);
                    exact_dist(insmp);
                    msptr^[thind] := expected;
                    if (outmom) then with treat, em^ do
                        begin
                        extend(dmpf,typefile);
                        extend(dmph,histfile);
                        dd := pred(Tmin);
                        repeat
                          with expected[dd] do
                            begin
                            write(dmpf,nr:1,sep,nc:1,sep,ne:1,sep,ng:1,sep,nl:1,sep);
                            write(dmpf,dd:3,sep,xnum:1,sep,predicted:3,sep,0:4,sep,0:4,sep,0.0:7:3,sep);
                            ptransfer:=@(expected[dd]);  mrec := ptransfer;
                            for nv := 1 to Nmoments do write(dmpf,mrec^[nv]:7:4,sep);
                            writeln(dmpf);
                            end;
                          if histptrs[dd]<> nil then with histptrs[dd]^ do
                             begin
                             write(dmph,nr:1,sep,nc:1,sep,ne:1,sep,ng:1,sep,nl:1,sep,dd:3,sep,xnum:1);
                             for i:= 1 to N do write(dmph,sep,hgo[i]:8:7);
                             for i:= 1 to X do write(dmph,sep,hgx[i]:8:7);
                             for i:= 1 to Z do write(dmph,sep,hgz[i]:8:7);
                             for i:= 1 to H do write(dmph,sep,hgh[i]:8:7);
                             writeln(dmph);
                             end;
                          dd := max(succ(dd),Tstart);
                        until dd> Tstop;
                        close(dmpf); close(dmph);
                        end;
                    end;
                 dec(ng);
                 until ng=Zed; dec(ne);
               until ne=Zed;
               if writeoptout then close(myrfile);
               end;
    evaluate:  begin
               for ntt:= One to Thsize do outscr[ntt]:= 0.0;
               zedall_eval(@evcompressed);
               if writeoptout then new(modelmom) else modelmom:=nil;
               with dplist[dpind]^ do
                begin
                nE := E;
                repeat ng := G;
                  repeat
                    nl := pgmpar^.max_un;
                    smpset(insmp);
                    if (problems[pbind]<>nil) then with problems[pbind]^, treat, em^, mymodel, rpars do
                       begin
                       prop := weights[obind];
                       dd := pred(Tmin);
                       repeat with moments[dd] do
                           begin
                           if moms[predicted]=nil then new(moms[predicted]);
                           zedmom(moms[predicted]);
                           selected[dd] := 0.0;
                           end;
                           inc(dd);      {dd := max(succ(dd),Tstart);}
                       until dd> Tstop;
                       repeat
                           dd:=pred(Tmin);
                           repeat with moments[dd] do
                              begin
                              selprop[nl] := prop[nl]*(1-mieptr^[nl][thind][dd].leakage);
                              selected[dd] := selected[dd]+selprop[nl];
                              incrmom(mieptr^[nl][thind][dd],moms[predicted]^,selprop[nl]);
{                              if outmom AND (dd=Tstart) then 
                              if dd=Tstart then writeln('** ',nr:1,sep,nc:1,sep,ne:1,sep,ng:1,sep,nl:1,sep,dd:3,sep,selprop[nl]:12:11,sep,prop[nl]:12:11,sep,selected[dd]:12:11); }
                              end;
                              dd := max(succ(dd),Tstart);  { leakage already contains attrition }
                            until dd> Tstop;
                         dec(nl);
                         smpset(insmp);
                       until nl=Zed;
                       dd := pred(Tmin);
                       repeat
                         with moments[dd] do begin
                           scalarmult(moms[predicted],1/max(1E-10,selected[dd]));
                           if modelmom<>nil then modelmom^[thind][dd] := moms[predicted]^;
                           dd := max(succ(dd),Tstart);
                         end;
                       until dd> Tstop;

                        if modelmom<>nil then
                            begin
                            writestr(idstr,emind);
                            if emind < 10 then idstr := '0'+trim(idstr);
                            rewrite(efile,'paths/prediction_'+idstr+'.bin');
                            write(efile,modelmom^[thind]);
                            close(efile);
                            append(sfile,sampfile);
                            nl := pgmpar^.max_un;
                            repeat
                                smpset(insmp);
                                wght := selprop[nl]/max(1E-10,selected[succ(Tstart)]);
                                write(sfile,insmp);
                                dec(nl);
                            until nl=Zed;
                            close(sfile);
                            end;
                       empgap(insmp,evcompressed[thind]);
                       end;
                     dec(ng);
                   until ng=Zed; dec(ne);
                until ne=Zed;
                end;
                meptr^:=evcompressed;
                close(dmpf);
                if modelmom<>nil then dispose(modelmom);
                end;
    aggregate: if (xnum=0) then
               begin
               if nactivemoments<0 then comp_offsets;
               if writeoptout then writeoptimal;
                 nR := R;ftmp:=0.0;  nl := 0;
                 repeat nC := C;
                  repeat nE := E;
                    repeat nG := G;
                        repeat
                            smpset(insmp);
                            if (problems[pbind]<>nil) then with problems[pbind]^ do if (inthedata) then
                                begin
                                ptransfer := @(iagp^[obind]);
                                evpt := ptransfer;
                                if (useoptmat) then
                                    calc_quad(insmp,evpt^[thind],ftmp)
                                else
                                    calc_momdist_new(insmp,evpt^[thind],ftmp);
                                end;
                            dec(nG);
                        until nG=Zed; dec(nE);
                    until nE=Zed; dec(nC);
                  until nC=Zed; dec(nR);
                until nR=Zed;
                oagp^ := ftmp;
                end
               else
                 begin
                 oagp^ := 0.0;
                 writeln('Running experiment ... still have not fixed bug in aggregate step');
                 end;

    end;

end;end;

procedure runstuff;
var
   pb       : pb_range;
   fy       : real;
   op       : oprecptr;
   inpgs    : pgmparptr;
   inm       : momarrayptr;
   nv : var_range;
   tt : pointer;
   inf      : text;

  procedure readpgmpar;
  var sepchar : char; optline : long_string; iopt:char;lem    : em_range;
         idstr  : string(2);
         dmpf   : text;
  begin
    reset(inf,pname+'.env');
    new(pgmpar); inpgs := pgmpar;
    repeat with inpgs^ do
       begin
       compvec := nil;
       Dsim := Zed;
       Dfit := Dsimmax;
       vtol := 1E-10;
       xnum := 0;
       repeat
            read(inf,iopt);
            case iopt of
            'd' : read(inf,Dsim);
            'f' : read(inf,Dfit);
            'v' : read(inf,vtol);
            'x' : read(inf,xnum);
            'z' : readln(inf);
            ' ' : ;
            otherwise writeln('invalid option ',iopt);
            end;
       until (iopt='z') OR eoln(inf);
       tt := @bigmask; inm:=tt;
       for nv := 1 to Nmoments do begin read(inf,inm^[nv]); end;
       if not eoln(inf) then readln(inf);
       readln(inf,optline);
       outmom := index(optline,'moment')>0;
       outpars:= index(optline,'param')>0;
       outdist:= index(optline,'dist')>0;
       holdreal:= index(optline,'real')>0;
       holdvalue:= index(optline,'values')>0;
       onlyentry := index(optline,'entry')>0;
       useoptmat := index(optline,'optweight')>0;
       writeoptout := index(optline,'writeopt')>0;
       outgmmvcm := index(optline,'vcm')>0;
       smlog := -200.0;
       smexp := exp(smlog);
       max_un := L;
       next := nil;
       readln(inf,sepchar); if (sepchar<>'!') then begin new(next); inpgs:=next; end;
       end;
    until (sepchar='!');
    close(inf);
    for lem := One to EMsize do emlist[lem]:=nil;
    read_moments;
    writestr(idstr,fmenv^.myid:-2);
    if fmenv^.myid < 10 then idstr := '0'+trim(idstr);
    momfile  := 'moments/'+pname+'moments.csv';
    typefile := 'moments/'+pname+'types'+idstr+'.csv';
    rewrite(dmpf,typefile); close(dmpf);
    histfile := 'moments/'+pname+'hist'+idstr+'.csv';
    rewrite(dmpf,histfile); close(dmpf);
    ranfile := 'random/ranu_'+idstr+'.bin';
    pathfile := 'paths/path_'+idstr+'.bin';
    rewrite(dmpf,pathfile); close(dmpf);
    sampfile := 'paths/samples_'+idstr+'.bin';
    rewrite(dmpf,sampfile); close(dmpf);
    if (fmenv^.role=client) then
        begin
        rewrite(dmpf,momfile); close(dmpf);
        end;
  end;

  procedure newglobals;
  var    ns     : s_range;
         ast     : a_range;
         pbind  : pb_range;
         dpind  : dp_range;
         nrep,
         neqv   : integer;
         cnd    : cond_type;
         insmp  : sample_type;
         itmp   : integer;
         notinthedata : boolean;
         dd     :  dd_range;
         source : source_type;
         rfile  : text;
  begin
  neqv:=0;
  for dpind := 1 to DPsize do
      begin
      new(dplist[dpind]);
      with dplist[dpind]^ do
        begin
        for ns:=One to Ssize do with bellman[ns] do
            begin
            for cnd := un to on do begin mom[cnd]:=nil; end;
            equiv:=equivalent(ns);
            neqv := neqv+ord((equiv=ns)AND(dpind=1));
            vmax[FALSE]:=0; vmax[TRUE]:=0;
            end;
        today := FALSE;
        end;
      end;
  if (fmenv^.role=client) then with pgmpar^ do
     begin
     writeln('# Distinct States   ',Ssize:6);
     writeln('# Real World States ',succ(hi_real-low_real):6);
     writeln('# non-equivalent    ',neqv:6);
     writeln('# solve size        ',solve_sz:6,' in eval size ',sizeof(ieval_type) DIV rword);
     writeln('# eval size         ',eval_sz:6  , ' in agg  size ',sizeof(iagg_type) DIV rword);
     writeln('# mycol             ',my_col:6,'   max_col ',max_col:6,'  mat matrix size   ',sizeof(max_mat_type) DIV rword);
     writeln('# Running Experiment ',' ',xnum:1,' ');
     end;
  pgmpar^.nactivemoments:=-1;
  for ns := low_real to hi_real do for ast := 1 to Asize do slinit(tlreal[ns,ast]);
  for ast := One to Asize do invAset(vact[ast],ast);
  with insmp, pgmpar^ do
    begin
    nr := R;
    repeat nc := C;
      repeat nl := L;
        repeat ng := G;
          repeat ne := E;
            repeat
              smpset(insmp); cnt:=0; problems[pbind]:=nil;
              notinthedata :=
                  ((ng=ssp_plus) AND ((nr=brit_col) OR (ne=entry) ))
                  OR ((ne=entry) AND (nr<>brit_col));
               if (not notinthedata) OR (xnum>0)  then
                  begin
{                  if (fmenv^.role=client) then writeln('Creating problem ',pbind:2,' ',nr:1,ng:1,ne:1,' ',xnum:1);}
                  new(problems[pbind]); with problems[pbind]^ do
                      begin
                      inthedata :=  not notinthedata;
                      sample := insmp;
                      demo := dlist[xnum][obind];
                      treat:= trtlist[xnum][thind];
                      with treat do
                      for dd := Dmin to Dsimmax do if dd >= Tstart then new(histptrs[dd]) else histptrs[dd]:=nil;
                      if emlist[emind]=nil then
                        begin
                        new(emlist[emind]); with emlist[emind]^ do
                           begin
                           optmat := nil;
                           Tobsmax:=Zed; Tobsmin:=One; Tstop:=Dsim;
                           for dd := Dmin to Dsimmax do with moments[dd] do with id do begin
                                mth:=dd;smpa:=0;smpb:=0;nobs:=0;
                                for source := mask to Nmoments do moms[source]:=NIL;
                               end;
                           end;
                         end;
                       dp := dplist[dpind]; em := emlist[emind];
                       end;
                   end; {if}
               dec(ne);
            until ne=Zed; dec(ng);
          until ng=Zed; dec(nl);
        until nl=Zed; dec(nc);
      until nc=Zed; dec(nr);
    until nr=Zed;
    end;
   fdtoday:=@fx0; fdtomor := @fx1;
  end;

  procedure freeglobals;
  var    ns     : s_range;
         ast     : a_range;
         pbind  : pb_range;
         dpind  : dp_range;
         lem    : em_range;
         cnd    : cond_type;
         tmp    : stateptr;
         dd     : dd_range;
         source : source_type;
  begin
  for dpind := 1 to DPsize do with dplist[dpind]^ do
      begin
      dispose(dplist[dpind]);
      for ns := One to Ssize do with bellman[ns] do
          for cnd:= un to on do if (mom[cnd]<>nil) then begin dispose(mom[cnd]); mom[cnd]:=nil;end;
      end;
  for lem := One to Emsize do
      if emlist[lem]<>nil then with emlist[lem]^, pgmpar^ do
         begin
         for dd := Dmin to Dsimmax do with moments[dd] do
            begin for source := mask to Nmoments do if moms[source]<>NIL then dispose(moms[source]); moms[source]:=NIL;end;

         dispose(emlist[lem]);
         emlist[lem]:=nil;
         end;
  inittlreal;
  for pbind := 1 to PBsize do if problems[pbind]<>nil then dispose(problems[pbind]);
  end;

procedure compute_vcm(include_treated, include_entry : boolean);
var h, h_inv : matrix_record;
    n_ob, m1,m2,ncol,nrow,
    emcnt,
    detsign : integer;
    insum,
    lndet   : real;
    hfile   :  text;
    smp     : sample_type;
    coffset : 0..n_allev;
    gblock  : array[opt_ind]  of  compressed_type;
    fname   : string(50);
begin with smp, pgmpar^, fmenv^.evaluation^, h do begin
  if nactivemoments<0 then comp_offsets;
  emcnt:=0;
  mtype := quasimat;
  new(qmat);
  nR := R;nl := 0;
  repeat nC := C;
    repeat nE := E;
        repeat nG := G;
            repeat
                smpset(smp);
                if (emlist[emind]<>nil) AND (include_treated OR (ng=control)) AND (include_entry OR (ne=one_year)) then
                    with emlist[emind]^ do
                    begin
                    if (optmat=nil) then readopt(emind);
                    coffset := (pred(obind)*THsize+pred(thind))*max_compressed;
                    writeln('em ',emind:3,' ',obind:2,' ',thind:2,' ',coffset,' ',n_emmoms);
                    for nrow := 1 to nfree do
                        for m1 := 1 to n_emmoms do
                            gblock[nrow,m1] := smpwght^[m1]*gradient_matrix^[nrow,m1+coffset];
                    for nrow := 1 to nfree do
                        for ncol := 1 to nfree do
                            begin
                            qmat^[nrow,ncol] := 0.0;
                            for m1 := 1 to n_emmoms do
                                begin
                                insum := 0.0;
                                for m2 := 1 to n_emmoms do insum := insum+optmat^[m1,m2]*gblock[nrow,m2];
                                qmat^[nrow,ncol] := qmat^[nrow,ncol] + insum*gblock[ncol,m1] ;
                                end;
                            end;
                    end;
                dec(nG);
            until nG=Zed; dec(nE);
        until nE=Zed; dec(nC);
    until nC=Zed; dec(nR);
  until nR=Zed;

  if include_treated AND include_entry then
    fname := 'paths/vcm_inverse.mat'
  else
    begin
    if include_treated then
        fname := 'paths/vcm_inverse_contols.mat'
    else
        fname := 'paths/vcm_inverse_recipients.mat';
    end;
  rewrite(hfile,fname);
  writeln(hfile,nfree*succ(nfree) DIV 2,' 1 ');
  for nrow := 1 to nfree do  for ncol := nrow to nfree do writeln(hfile,qmat^[nrow,ncol]);
  close(hfile);
  if include_treated AND include_entry then
    fname := 'paths/vcm.mat'
  else
    begin
    if include_treated then
        fname := 'paths/vcm_contols.mat'
    else
        fname := 'paths/vcm_recipients.mat';
    end;
  h_inv.mtype := quasimat;
  if hess_inverse = nil then new(hess_inverse);
  h_inv.qmat := hess_inverse;
  mat_inv(h,h_inv,nfree,detsign,lndet);
  if detsign<>0 then
     begin
     rewrite(hfile,fname);
     writeln(hfile,nfree*succ(nfree) DIV 2,' 1 ');
     for nrow := 1 to nfree do  for ncol := nrow to nfree do writeln(hfile,h_inv.qmat^[nrow,ncol]);
     close(hfile);
     end;
  dispose(qmat);
end; end;

begin

  fm_create(fmenv,model,TRUE,nil,nil,nil,nil,pname);
  readpgmpar;
  inpgs := pgmpar;
  repeat
     newglobals;
     fm_optimize(fmenv,FALSE);
     if(fmenv^.role=client) then
        begin
        if (pgmpar^.outgmmvcm) then
            begin
            compute_vcm(TRUE,TRUE);
            compute_vcm(TRUE,FALSE);
            compute_vcm(FALSE,TRUE);
            end;
        doswitch(fmenv);
        end;
     freeglobals;
     pgmpar := pgmpar^.next;
  until pgmpar=nil;
  fm_destroy(fmenv);

  pgmpar := inpgs;
  repeat inpgs := pgmpar^.next; dispose(pgmpar); pgmpar := inpgs; until pgmpar=nil;

end;

begin
envlet:=ParamStr(1);
pname := 'ssp'+vnum+envlet;
runstuff;
end.
