segment extern_procs;
const

  %include ./sport11.con

type
  
  %include ./sport11.typ

ref 
  %include ./sport11.var

%include ./sport11.def

 procedure init;
 var
    rseed      : real;
    g, resid, sa,
    i,j        : integer;
    sp         : sports;
    mgpow,
    s,
    yr         : integer;
    t_file     : text;
    pathno     : path_ind;
  begin

  readln(in_file,i);
  case i of 
     0: simorest:=estimate; 1:simorest:=simulate;2:simorest:=monte;
     3:  simorest := boot; 4: simorest := mboot;
  end;
  readln(in_file,i);
  case i of 0: dist:=normal; 1: dist:=logit; 2: dist:=uniform; end;
  readln(in_file,i);
  case i of 0: estmeth := structure; 1: estmeth := reduced; 2:estmeth:=minchi;end;
  for sp := baseball to hockey do readln(in_file,maxsprt[sp]);
  readln(in_file,i);
  if (simorest in [estimate,boot,mboot]) then i := 7;
  ngames := i;
  readln(in_file,nrepl1);
  readln(in_file,nrepl2);
  readln(in_file,contchar);

  ntowin := (ngames DIV 2) + 1;

  i := 0;
  nobs := 1;
  if (simorest in [estimate,boot]) then
     begin
     reset(t_file,'NAME=sport.raw');
     while not eof(t_file) do
           begin
           i := succ(i);
           readln(t_file,sport[i],year[i],gnum[i],
                  hdf[i],rdf[i],edf[i],last[i],
                  awns[i],bwns[i],rwin[i]);
           winner[i] := round(rwin[i]);
           end;
     close(t_file);
     nobs := i;
     end;

         (* set pointers into data array & count nseries by sport *)
  nserstot := 0;
  i := 1;
  for sp := baseball to hockey do
      begin
      endpt[sp,lo] := i;
      yr := year[i];
      nseries[sp]:=0;
      while (i < nobs) AND (sport[i] = sport[endpt[sp,lo]]) do
            begin
            i := succ(i);
            if year[i]>yr then
               begin
               nseries[sp] := succ(nseries[sp]);
               nserstot := succ(nserstot);
               bootn[nserstot] := nserstot;
               yr := year[i];
               end;
             end;
      endpt[sp,hi] := i-1;
      end;
  endpt[hockey,hi] := nobs;

          (* count frequency of paths *)
    for sp := baseball to hockey do
        begin
        for pathno := 0 to mxpaths do freq[sp,pathno] := 0;
        i := endpt[sp,lo];
        repeat
          yr := year[i];
          mgpow := 1;
          pathno := 0;
          repeat
            pathno := pathno + mgpow*winner[i];
            mgpow := mgpow*2;
            i := succ(i);
          until (i>endpt[sp,hi]) OR (yr <> year[i]);
          freq[sp,pathno] := freq[sp,pathno]+1.0;
        until (i>endpt[sp,hi]);
        end;

           (* mark feasible paths *)
      for pathno := 0 to mxpaths do
          begin
          resid := pathno;
          g := 0;
          sa := 0;   
          repeat
            g := succ(g);
            sa := sa + (resid MOD 2);
            resid := resid DIV 2;
          until (sa=4) OR (g-sa=4);
          feas[pathno] := (resid=0);
          end;

(*
      for pathno := 0 to mxpaths do
          begin
          write(pathno:3,' ');
          for sp:=baseball to hockey do write(freq[sp,pathno]:2,' ');
          if feas[pathno] then writeln('Feasible') else writeln('Not'); 
          end;
*)
      if simorest in [monte,mboot] then reset(t_file,'NAME=mcestpar.raw')
      else                   reset(t_file,'NAME=estpar.raw');
      for i := 1 to np do 
              begin readln(t_file,pars[i]); writeln(i:2,' ',pars[i]);
              end;
      close(t_file);

      reset(t_file,'NAME=vr5.raw');
      for i := 1 to npts do readln(t_file,wts[i]);
      close(t_file);
      for i := 1 to npts do 
          pts[i] := -mxalph + 2*(i-1)*mxalph/(npts-1);

      cdmin := cdfn(-mxalph);
      cdmax := cdfn(mxalph);
      totwt := cdmax-cdmin;

      rseed := random(initseed);
      sdrec[baseball] := 4.62;
      sdrec[basketball] := 13.46;
      sdrec[hockey] := 12.17;
      mnexp1[baseball] := 0.311;
      mnexp0[baseball] := 0.594;
      mnexp1[basketball] := 0.279;
      mnexp0[basketball] := 0.614;
      mnexp1[hockey] := 0.31;
      mnexp0[hockey] := 0.528;

      imboot := 0;

end;

function zcdfn(x:real): real;
begin
  case dist of
  normal : zcdfn:=cdfn(x);
  logit  : zcdfn := 1-1/(1+exp(x*l_co));
  uniform: begin
           if abs(x) < u_co then zcdfn := (x+u_co)/2
           else
              begin
              if x < 0 then zcdfn := mn_mz else zcdfn := 1.0-mn_mz;
              end;
           end;
  end;
end;

function zfdens(x:real): real;
var tmp : real;
begin
  case dist of
  normal :     zfdens:=fdens(x);
  logit  : begin
           tmp := exp(x*l_co);
           zfdens := l_co*tmp/( (1+tmp)*(1+tmp) );
           end;
  uniform: if abs(x) < u_co then zfdens:=1/(2*u_co) else zfdens:= 0.0;
  end;
end;

function zfprime(x: real): real;
begin
  case dist of
  normal :  zfprime := -x*zfdens(x);
  logit :   zfprime := l_co*zfdens(x)*(2*zcdfn(x)-1) ;
  uniform : zfprime := 0.0;
  end;
end;

function zinvn(x:real): real;
begin
  case dist of
  normal : zinvn := invn(x);
  logit  : zinvn := (1/l_co)*ln(x/(1-x));
  uniform: zinvn := 2*x - u_co;
  end;
end;

procedure doyear;
(*  if estimate, then calculate likelihood contribution for that year's
    if simulate, then solve and simulate the series for the -i simulation
*)
var ghi,       (* index in data of last game in the series *)
    glo,
    mg1,
    mg,         (* number of games *)
    yr,        (* year of series *)
    k,
    m,
    mgpow,
    sima,      (* simulated wins by a and b *)
    simb
                   : integer;
    awlo,
    awhi  : awn_type;
    deltv,
    netv,
    sgn,
    dv    : team_type;
      n :                   teami_type;
      xx,
      gam
                  :        team_type;

      ddelts,
      gama,
      gamb,
      rprba,
      prba,
      va,
      vb           :            state_type;
      fd,                       (* derivative of density at Delta *)
      fv,                       (* density evaluated at Delta *)  
      cdfv,                     (* cumulative distn evaluated at Delta *)
      cdelt,                    (* cost of effort differential *)
      ddelt,                    (* Delta (net value of winning game diff *)
    lkalph,
    aadv,
    lkyr,rflk     : real;
    smpath        : integer;

   procedure yearinit;
    var j : awn_type;
   begin
    sgn[a] := 1.0; sgn[b] := -1.0;
        (* initialize final payoffs *)
    for j := 0 to ntowin-1 do
      begin
      va[ntowin,j] := 1.0 + v1*(ntowin-j-1);      va[j,ntowin] := -va[ntowin,j];
      vb[j,ntowin] := va[ntowin,j];               vb[ntowin,j] := -vb[j,ntowin];
      end;
    end;

      procedure netcalc;
           begin
           deltv[a] := gam[b]*dv[a];
           deltv[b] := gam[a]*dv[b];
           if (deltv[a]>mn_par) AND (deltv[b]>mn_par) then
             ddelt := r*(ln(deltv[a]/deltv[b]) + cdelt)
           else
             ddelt := r*(ln((deltv[a]+mn_par)/(deltv[b]+mn_par)) + cdelt);
(* put () around cdelt on 11/19/96 *)
           cdfv := zcdfn(ddelt);
           fv := zfdens(ddelt);
           fd := zfprime(ddelt);
           xx[a] := cdfv-r*fv;
           xx[b] := 1-cdfv-r*fv;
           netv[a] := deltv[a]*xx[a];
           netv[b] := deltv[b]*xx[b];
           end;


      procedure vsolve;
      const
           vtol = 1E-8;
           itmax = 20;
      var
           awn   : awn_type;
           g     : g_type;
           s,so     : teams;
           gamhi, gamlo,
           dff,
           nets  : real;
           it    : integer;


      begin    (* dosolve *)
           for g := ngames downto 1 do
               begin
               homedf  := hadv[g];
               if g > ntowin then begin awlo := g-ntowin; awhi  := ntowin-1; end
               else            begin awlo := 0; awhi  := g-1; end;

               for awn := awlo to awhi do
                   begin
                   n[a] := awn;   n[b] := g-n[a]-1;
                   cdelt := alpha+ beta[home]*hadv[g] +
                            beta[season]*recdf + beta[exper]*expdf;
                   if (n[a]=3) OR (n[b]=3) then cdelt := cdelt +
                            stbeta[sp,n[a],n[b]];
                   rprba[n[a],n[b]] := zcdfn(cdelt);
                   gam[a] := 1.0; gam[b] := 1.0;
                   dv[a] := (va[n[a]+1,n[b]]-va[n[a],n[b]+1]);
                   dv[b] := (vb[n[a],n[b]+1]-vb[n[a]+1,n[b]]);
                   netcalc;

                   if (netv[a]<0.0) OR (netv[b] < 0.0) then
                      begin         (* one team or the other randomizes *)
                      it := 1;
                      s := a; so := b;
                      if netv[b] < 0.0 then begin s := b; so := a; end;
                      repeat
                           gam[s] := 1.0 - it/itmax;
                           netcalc;
                           nets := netv[s];
                           it := succ(it);
                      until (it>itmax) OR ( (netv[s]>0.0) 
                              AND (netv[so]<0.0) ); 

                      gamhi := 1.0 - (it-2)/itmax;
                      gamlo := 1.0 - (it-1)/itmax;
                      repeat
                        gam[s] := 0.5*gamhi + 0.5*gamlo;
                        netcalc;
                        if (netv[s]>0.0) then gamlo := gam[s]
                        else gamhi := gam[s];
                      until (abs(netv[s])<vtol) OR (gamhi-gamlo < vtol);
                      gam[s] := gamlo;  (* guarantee netv>= 0 *)
                      netcalc;
                      end;

               (* These are the value functions for each team *)
              va[n[a],n[b]] := gam[a]*(netv[a]-gam[b]*dv[a]+va[n[a]+1,n[b]])
                            +(1-gam[a])*(gam[b]*va[n[a],n[b]+1]
                              +0.5*(1-gam[b])*(va[n[a]+1,n[b]]+va[n[a],n[b]+1])
                              );
              vb[n[a],n[b]] := gam[b]*(netv[b] - gam[a]*dv[b]+vb[n[a],n[b]+1])
                             +(1-gam[b])*(gam[a]*vb[n[a]+1,n[b]]
                            +0.5*(1-gam[a])*(vb[n[a],n[b]+1]+vb[n[a]+1,n[b]]));
               (* This is the probability that team a wins this game *)
              prba[n[a],n[b]] := gam[a]*gam[b]*cdfv
                          +gam[a]*(1-gam[b])+(1-gam[a])*(1-gam[b])/2;
              gama[n[a],n[b]]:= gam[a];
              gamb[n[a],n[b]]:= gam[b];
              ddelts[n[a],n[b]] := ddelt;

              if lst_call then
                 begin      
                 write(ord(sp):1,' ',cdelt:8:4,' ',n[a]:1,' ',n[b]:1,' ');
                 if nptsdo > 1 then
                    write(sqrt(2/pi)*mxalph*
                    (1/totwt)*exp(-0.5*(alpha/sigma)*(alpha/sigma)):8:4,' ')
                 else
                    write(1.0,' ');
                 if estmeth=structure then
                    writeln(prba[n[a],n[b]]:5:4)
                 else
                    writeln(rprba[n[a],n[b]]:5:4);
                 end;

              end;
           end;
      end;

    procedure bothlk;
    var m : integer;
    begin 
            lkalph := 1.0;
            rflk := 1.0;
            for m := glo to ghi do
              begin
              if winner[m]=1 then 
                 begin
                 lkalph := lkalph*prba[awns[m],bwns[m]];
                 rflk := rflk*rprba[awns[m],bwns[m]];
                 end
              else 
                 begin               
                 lkalph := lkalph*(1-prba[awns[m],bwns[m]]);
                 rflk := rflk*(1-rprba[awns[m],bwns[m]]);
                 end;
              if (gama[awns[m],bwns[m]]<1.0)OR(gamb[awns[m],bwns[m]]<1.0) then
                 gams := succ(gams);
              end;
           if nptsdo > 1 then
                begin
                if estmeth=structure then
                   lkyr := lkyr + lkalph*wts[k]*sqrt(2/pi)*mxalph*
                   (1/totwt)*exp(-0.5*(alpha/sigma)*(alpha/sigma))
                else
                  lkyr := lkyr + rflk*wts[k]*sqrt(2/pi)*mxalph*
                  (1/totwt)*exp(-0.5*(alpha/sigma)*(alpha/sigma));
                end
           else
                begin
                if estmeth=structure then
                  lkyr := lkalph
                else
                  lkyr := rflk;
                end;
    end;

   procedure pathprob;
   var g, sa, resid, s1 : integer;
       pred1 : path_type;
       pathno        : path_ind;
  begin
       for pathno := 0 to mxpaths do
           if feas[pathno] then 
             begin
             resid := pathno;
             g := 0;
             sa := 0;
             pred1[pathno] := 1.0;
             repeat
               g := succ(g);
               s1 := resid MOD 2;
               if s1 = 1 then 
                  pred1[pathno]:=pred1[pathno]
                                 *prba[sa,g-sa-1]
               else
                  pred1[pathno]:=pred1[pathno]
                                 *(1-prba[sa,g-sa-1]);
               sa := sa + s1;
               resid := resid DIV 2;
             until (sa=4) OR (g-sa=4);
             if nptsdo > 1 then
               pred[pathno] := pred[pathno] + pred1[pathno]*wts[k]*
                                           sqrt(2/pi)*mxalph*
                   (1/totwt)*exp(-0.5*(alpha/sigma)*(alpha/sigma))
             else 
               pred[pathno] := pred[pathno] + pred1[pathno];
             end;
         
     end;

  begin  (* doyear *)
  
  yearinit;

  if runopt = estimate then
     begin
     glo := yind;
     yr := year[yind];
     ghi := glo;
     mg := 0;
     while (ghi <=nobs) AND (year[ghi]=yr) do
         begin  mg := succ(mg);hadv[mg] := hdf[ghi]; ghi := succ(ghi); end;
     recdf := rdf[glo];
     expdf := edf[glo];
     yind := ghi;
     ghi := ghi-1;
     case sp of
          baseball:
             case yr of
                  61,23 :  hadv[ngames] := hadv[1];
                  43    :  begin hadv[ngames] := -hadv[1];
                                    hadv[ngames]:=-hadv[1]; end;
                  44    :  hadv[ngames] := hadv[2];
                  otherwise    begin
                               if mg < ngames then hadv[ngames] := hadv[1];
                               if mg < ngames-1 then hadv[ngames-1] := -hadv[1];
                       	       if mg < ngames-2 then hadv[ngames-2] := -hadv[1];
                               end;
             end;
          basketball: begin
               if mg < ngames   then hadv[ngames] := hadv[1];
               if yr < 85 then
                  begin
                  if mg < ngames-1 then hadv[ngames-1] := -hadv[1];
                  if mg < ngames-2 then hadv[ngames-2] := hadv[1];
                  end
               else
                  begin
                  if mg < ngames-1 then hadv[ngames-1] := -hadv[1];
                  if mg < ngames-2 then hadv[ngames-2] := -hadv[1];
                  end;
               end;
          hockey: begin
               if mg < ngames   then hadv[ngames] := hadv[1];
               if mg < ngames-1 then hadv[ngames-1] := -hadv[ngames];
               if mg < ngames-2 then hadv[ngames-2] := hadv[ngames];
               end;
      end;

        lkyr := 0.0;
        for k := 1 to nptsdo do
            begin
            alpha := pts[k]*sigma;
            vsolve;
            if estmeth = minchi then pathprob
                                else  bothlk;
           end;

       if lkyr>mn_ln then lyear := ln(lkyr) else lyear := ln(mn_ln);
    
       end                  (* end likelihood calculation*)

 else     (* monte carlo or simulation *)

    begin
    recdf := zinvn(random(0))*sdrec[sp];
    if sp in [basketball,hockey] then recdf := abs(recdf);
    if recdf >= 0 then aadv := 1.0 else aadv := -1.0;
    mg := round((ngames-(ntowin-1)) / 2.0);
    for m := 1 to mg do hadv[m] := 1*aadv;
    mg1 := mg+(ntowin-1);
    for m := mg+1 to mg1 do hadv[m] := -1*aadv;
    for m := mg1+1 to ngames do hadv[m] := 1*aadv;
     expdf := random(0);
     if expdf < mnexp1[sp] then expdf := 1
     else begin if expdf < mnexp1[sp]+mnexp0[sp] then expdf:=0 else expdf:=-1;
          end;
    alpha := invn(cdmin+random(0)*totwt)*sigma;
    vsolve;
    sima := 0;
    simb := 0;
    mg := 0;
    mgpow := 1;

    smpath := 0;
    while (sima<ntowin) & (simb<ntowin) do
          begin
          mg := succ(mg);
          sport[nobs] := ord(sp);
          year[nobs]  := yind;
          hdf[nobs] := hadv[mg];
          rdf[nobs] := recdf;
          edf[nobs] := expdf;
          last[nobs] := 0.0;
          gnum[nobs] := mg;
          awns[nobs] := sima;
          bwns[nobs] := simb;
          if prba[sima,simb] > random(0) then
             begin
             sima := succ(sima);
             winner[nobs] := 1;
             smpath := smpath + mgpow;
             end
          else
             begin
             simb := succ(simb);
             winner[nobs] := 0;
             end;
          nobs := succ(nobs);          
          mgpow := mgpow * 2;
          end;
    yind := succ(yind);

    if estmeth = minchi then freq[sp,smpath] := freq[sp,smpath]+1;

    if simorest=simulate then
       begin
       writeln(out_file,'Parameters Used in Simulation');
       write(out_file,'Distribution of luck   = ');
       case dist of
       normal : writeln(out_file,'normal (unit variance)');
       logit  : writeln(out_file,'logit (unit variance)');
       uniform: writeln(out_file,'uniform (unit variance)');
       end;
       writeln(out_file,'   beta coefficent                       Value of Variable');
       writeln(out_file,'home       advantage   = ',beta[home]:10:7);
       writeln(out_file,'season     advantage   = ',beta[season]:10:7,
                      '      ',recdf:10:7);
       writeln(out_file,'experience advantage   = ',beta[exper]:10:7,
                      '      ',expdf:10:7);
       writeln(out_file,'st.dev.   of alpha     = ',sigma:10:7,
                      ' alpha = ',alpha:10:7);
       writeln(out_file,'cost param r           = ',r:10:7);
       writeln(out_file,'winning margin v1      = ',v1:10:7);
       writeln(out_file);
       writeln(out_file,'Home Field Advantage sequence:');
       for mg := 1 to ngames do
           if hadv[mg]>0 then write(out_file,'H') else write(out_file,'A');
       writeln(out_file);
       writeln(out_file,
       'sport  game  na  nb     va        vb        gama     gamb        prba ');
       mg := 1;
       repeat
         if mg > ntowin then begin awlo := mg-ntowin; awhi  := ntowin-1; end
         else                begin awlo := 0; awhi  := mg-1; end;
         for sima := awlo to awhi do
             begin
             simb := mg-sima-1;
             writeln(out_file,'   ',ord(sp):1,'   ',mg:1,'    ',sima:2,'  '
               ,simb:2,'  ',va[sima,simb]:8:3,'  ',vb[sima,simb]:8:3,
               '  ',gama[sima,simb]:8:6,'  ',gamb[sima,simb]:8:6,  
               '  ',prba[sima,simb]:8:6);
             end;
         mg := succ(mg);
       until mg > ngames;
   end;

    end;                   (* simulation of one year *)
end;                       (* end doyear *)
     
procedure setpars(var inx: param_type);
var ss    : sports;
    c     : controls;
    f0    : real;
    na    : integer;
begin
  f0 := 1/(fdens(0.0)*2.0);
  for c := home to exper do
     for ss := baseball to hockey do
        vbeta[ss,c] := inx[3*ord(c)+ord(ss)+1];
  for ss := baseball to hockey do vsigma[ss] := exp(inx[9+ord(ss)+1]);
  for ss := baseball to hockey do 
       begin
       vr[ss] := exp(inx[12+ord(ss)+1]);  (* changed 5/16/96 *)
       vr[ss] := vr[ss]*f0/(1+vr[ss]);
       end;

  for na := 0 to 2 do
     for ss := baseball to hockey do
         begin
         stbeta[ss,na,3] := inx[15+3*na+ord(ss)+1];
         stbeta[ss,3,na] := -inx[15+3*na+ord(ss)+1];
         end;
   stbeta[basketball,3,0] := stbeta[basketball,3,1];
   stbeta[basketball,0,3] := stbeta[basketball,1,3];
(*  for ss := baseball to hockey do vv1[ss]    := inx[15+ord(ss)+1]; *)
  for ss := baseball to hockey do vv1[ss]    := 0.0; 
  
end;

procedure payoffs( ss : sports);
var 
    c : controls;
    pn : path_ind;
begin
  r := vr[ss]; sigma:= vsigma[ss]; v1 := vv1[ss];
  for c := home to exper do beta[c] := vbeta[ss,c];
  if sigma > mn_par then nptsdo := npts else nptsdo := 1;
  if estmeth = minchi then for pn := 0 to mxpaths do pred[pn] := 0.0;
end;

function like;
var   lktmp : real;
      j     : awn_type;
      ss    : sports;
      tots,
      yind,
      i     : integer;
      n     : par_ind;
      pathno : path_ind;
      lkv    : like_type;
begin

  setpars(inx);
  lktmp := 0.0;
  tots := 0;
  gams := 0;
  for ss := baseball to hockey do
     if maxsprt[ss]>0 then
      begin
      payoffs(ss);

      ilo := endpt[ss,lo];
      ihi := endpt[ss,hi];

      yind  := ilo;
      for i := 1 to nseries[ss] do
        begin
        tots := succ(tots);
        doyear(yind,lkv[tots],estimate,ss);
        if estmeth <> minchi then lkv[tots] := -lkv[tots];
        end;
     if estmeth = minchi then
        for pathno := 0 to mxpaths do
             if feas[pathno] then
               begin
               lktmp := lktmp + 
                 (freq[ss,pathno]-pred[pathno])*(freq[ss,pathno]-pred[pathno])/
                 pred[pathno];
               if lst_call then
                 writeln(pathno:3,' ',freq[ss,pathno]:3,' ',pred[pathno]:5:2);
               end;
     end;
   

   if lst_call then writeln('Likelihood after ',ord(ss):1,' ',lktmp,
          ' Number of Gammas<0 ',gams);

 (* bootstrapping *)
   for i := 1 to tots do       
       begin 
       lkvals[i] := lkv[bootn[i]];
       lktmp := lktmp + lkvals[i];
       end;
   for i := tots+1 to max_obs do lkvals[i] := 0.0;
   like := lktmp;

end;


function vlike;
var i : obs_ind;
begin
 vlike := like(inx);
 for i := 1 to max_obs do lkval[i] := lkvals[i];
end;

procedure run_simul (inx : param_type; sp : sports);
var
      j     : awn_type;
      yind,i     : integer;
      n     : par_ind;
      stmp  : real;
      pn    : path_ind;
begin
  setpars(inx);
  payoffs(sp);
  stmp := 0.0;
  yind := 1;
  if estmeth = minchi then for pn := 0 to mxpaths do freq[sp,pn] := 0;
  for i := 1 to maxsprt[sp] do doyear(yind,stmp,simulate,sp);
  nobs := nobs - 1;  (* doyear modifies nobs - should be passed *) 
end;


procedure dosport;   
var
  sp : sports;
  j1,
  j : par_ind;
  minrep,
  k,
  i : integer;
  outstr : string(50);

begin

  case runopt of
    estimate : begin
               if (simorest = estimate) or (simorest=boot) then
                  begin
                  reset(x_file,'NAME=estpar.raw');
                  reset(opt_file,'NAME=optpar.raw');
                  end
               else
                  begin
                  reset(x_file,'NAME=mcestpar.raw');
                  reset(opt_file,'NAME=mcoptpar.raw');
                  end;
               lst_call := FALSE;
               h := nil;
               optsp2(fy,outx);
               if simorest=estimate then
                  begin
                  lst_call := TRUE;
                  fy:=like(outx);
                  end;
              end;
  simulate :  begin    (* simulate data place in sim file *)
              ilo := 1;
              nserstot := 0;
              nobs := 1;
              if maxsprt[baseball] > 1 then 
                begin
                for sp := baseball to hockey do
                    begin
                    run_simul(pars,sp);
                    endpt[sp,lo] := ilo;
                    endpt[sp,hi] := nobs-1;
                    nseries[sp] := maxsprt[sp];
                    nserstot := nserstot + nseries[sp];
                    ilo := endpt[sp,hi]+1;
                    end;
                  end
                else
                  begin
                  writeln('enter value of home advantage, (-1 to quit)');
                  readln(pars[1]);
                  while pars[1]>= 0 do
                      begin
                      writeln(' enter season record difference');
                      readln(pars[4]);
                      writeln(' enter experience advantage ');
                      readln(pars[7]);
                      writeln(' enter st. dev. of alpha');
                      readln(pars[10]);
                      writeln(' enter cost param r ');
                      readln(pars[13]);
                      run_simul(pars,baseball);
                      writeln('enter value of home advantage, (-1 to quit)');
                      readln(pars[1]);
                      end;
                  end;
               (* close(sm_file); *)
               close(out_file);
               end;
  monte : begin
         outstr := 'NAME=out_mc.raw'||pstr;
         rewrite(mc_file,outstr);
         writeln(mc_file,'! Monte Carlo Experiment Output ');
         write(mc_file,'! Number of Series: ');
         for sp := baseball to hockey do write(mc_file,maxsprt[sp]:3,' ');
         writeln(mc_file);
         writeln(mc_file,'Number of Games in Series: ',ngames:2);
         close(mc_file);
         for i := 1 to nrepl1 do 
             begin
             dosport(simulate);
             dosport(estimate);
             rewrite(mc_file,outstr||',DISP=MOD');
             write(mc_file,i:4,' ',pstr,' ',nobs:4,' ',fy:8:2);
             for j := 1 to np do write(mc_file,' ',outx[j]:14:12);
             writeln(mc_file);
             close(mc_file);
            end;
         end;
  boot  : begin
          minrep := 0;
          if simorest=boot then
             begin
             outstr := 'NAME=out_boot.raw'||pstr;
             reset(mc_file,outstr);
             while not eof(mc_file) do readln(mc_file,minrep);
             close(mc_file);
             end;
          outstr := 'NAME=out_boot.raw'||pstr||', DISP=MOD';
          rewrite(mc_file,outstr);
          close(mc_file);
          for i := 1 to nrepl2 do
             begin
             for k := 1 to nserstot do
                begin 
                bootn[k] := trunc( (nserstot)*random(0) )+1;
                end;
             if i > minrep then
                begin
                dosport(estimate);
                rewrite(mc_file,outstr||',DISP=MOD');
                write(mc_file,i:4,' ',pstr,' ',nobs:4,' ',imboot:3,' ',fy:8:2);
                for j := 1 to np do write(mc_file,' ',outx[j]:14:12);
                for j := 1 to np do write(mc_file,' ',sqrt(abs(h^[j,j])):6:4);
                writeln(mc_file);
                close(mc_file);
                end;
             end;
          end;
  mboot : begin
          imboot := 1;
          repeat
             dosport(simulate);
             dosport(boot);
             imboot := succ(imboot);
         until imboot > nrepl1;
         end;
     end;   (*case *)
end;

.
