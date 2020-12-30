program structural_estimation (input,output);
(*  Solve the subgame perfect equilibrium of the tournament model
    with the possibility of mixed strategy equilibria.
         main routines:
              dosport      - process one sport
                maxlike    - maximize likelihood function for sport
                  like       - calculate likelihood
                    doyear   - solve for one series over random effects
                      vsolve - solve equilibria in game.
              init           - read in data and initialize values
*)
const
      % include /u/ferrall/lib/sport.const

      ng = 7;              (* number of games *)
      nb = 4;              (* number to win *)
      nser = 168;          (* number of series *)
      nobs = 953;          (* total observations *)
      npts   = 21;         (* number of points for quadrature *)

               (* constants for cumulative normal functions *)
      mx_exp = 110.0;
      mn_par = 1.0E-20;
      pi = 3.141592653589793;
type
          (* index types for various arrays *)
      teams =           (a,b);
      controls =        (home,season,exper);
      sports   =        (baseball,basketball,hockey);
      ends     =        (lo,hi);
      awn_type =        0..nb;
      g_type =          1..ng;
      par_ind =         1..np;
      alph_ind =        1..npts;
      obs_ind =         1..nobs;

                         (* types for arrays *)

      %include /u/ferrall/lib/sport.type
      %include /u/ferrall/lib/matrix2.type

      game_type =       array[g_type] of real;       (* games in series *)
      gamei_type =      array[1..ng] of integer;     (* integer values *)
      team_type =       array[teams] of real;
      teami_type =      array[teams] of awn_type;
      state_type =      array[awn_type,awn_type] of real;  (* state space type *)

      beta_type  =      array[controls] of real;    (* control vector *)

      vparam_type =     array[sports] of param_type;  (* parameters in all sports *)

            (*  data arrays *)
      rdata_type =      array[obs_ind] of real;       (* real valued data *)
      idata_type =      array[obs_ind] of integer;    (* integer valued data *)
      endpt_type =      array[sports,ends] of integer;(* pointers to each sport *)
      isport_type =     array[sports] of integer;
      rsport_type =     array[sports] of real;

            (* quadrature types *)
      alph_type =       array[alph_ind] of real;

var
      vpars :           vparam_type;
      pars :            param_type;
      sca,
      g,
      outx,
      msk   :           param_type;
      opt   :           optpar_type;
      h     :           hess_type;
      flg   :           boolean;
      mxobj :           real;
      sp    :           sports;
      maxsprt :         isport_type;
      fy     :          rsport_type;

      n :               teami_type;
      seas,
      pexp,
      gam,
      netv,
      deltv :           team_type;
      prba,
      va,
      vb   :            state_type;
      hadv :            game_type;
      beta :            beta_type;
      wts,
      pts  :            alph_type;
      fv,                       (* density evaluated at Delta *)
      cdfv,                     (* cumulative distn evaluated at Delta *)
      cdelt,                    (* cost of effort differential *)
      ddelt,                    (* Delta (net value of winning game differential *)

      alpha,                    (* random effect *)
      sigma,                    (* standard deviation of random effect *)
      r,                        (* cost of effort parameter *)
      v1,                       (* marginal value of final score difference *)

      homedf,                   (* difference in home records in series *)
      recdf,                    (* difference in season records *)
      expdf                     (* difference in series experience *)
                    : real;

      sport,                    (* sports index *)
      year,                     (* year of series *)
      gnum,                     (* game number *)
      awns,                     (* number of wins by team a *)
      bwns                      (* number of wins by team b *)
         :            idata_type;

      winner,                    (* winner of game *)
      hdf,                       (* home difference *)
      rdf,                       (* season difference *)
      edf,                       (* experience difference *)
      last                       (* who won last game index *)
              :       rdata_type;
      nseries :       isport_type;
      endpt   :       endpt_type;
      nsersp,
      yind,
      ilo,
      ihi     :       integer;
      mx_file,
      in_file :       text;

            (*  Integration Variables *)
    p_g,                             (* continuing-fraction  vectors *)
    q_g : array[1..6] of real;
    a_g,
    b_g : array[1..9] of real;
    c_g,
    d_g : array[1..5] of real;


procedure optmum(x, msk : param_type; params : optpar_type;        
                  var xo : param_type; var fy : real;
                   var h : hess_type;  var g : param_type;
                  var flg : boolean);  external;
function like(inx : param_type): real; External;                   
procedure f_grad(xin : param_type; var g : param_type; nfree : integer; 
                geps,mneps : real);
                  External;
procedure f_hess(xin : param_type; var hin : hess_type;var g :param_type;
                 nfree : integer;geps,mneps:real); External;
procedure fcd_hess(x : param_type; var hess : hess_type); External;
function cdfn(x:real): real; External;                             
function fdens(x:real): real;  External;                           

%include /u/ferrall/lib/cma_matrix.proc    (* matrix handling routines *)
                  

procedure init;
var i          : integer;
    sp         : sports;
    yr         : integer;
begin

      (* read in data *)
  reset(in_file,'NAME=/u/ferrall/sports/sport.raw');  
  for i := 1 to nobs do
      begin 
      readln(in_file,sport[i],year[i],gnum[i],
            hdf[i],rdf[i],edf[i],last[i],
            awns[i],bwns[i],winner[i]);
      end;
  close(in_file);
  i := 0;
         (* set pointers into data array & count nseries by sport *)
  for sp := baseball to hockey do
      begin
      i := succ(i);
      endpt[sp,lo] := i;
      yr := year[i];
      nseries[sp]:=1;
      while (i < nobs) AND (sport[i] = sport[endpt[sp,lo]]) do
            begin
            i := succ(i);
            if year[i]>yr then
               begin
               nseries[sp] := succ(nseries[sp]);
               yr := year[i];
               end;
            end;
      endpt[sp,hi] := i;
      end;
  endpt[hockey,hi] := nobs;

       (* read in estimated parameters *)
  reset(in_file,'NAME=/u/ferrall/sports/params.raw');
  for i := 1 to np do
      begin
      for sp := baseball to hockey do
         read(in_file,vpars[sp,i]);
      readln(in_file);
      end;
  for sp := baseball to hockey do
      read(in_file,maxsprt[sp]);
  close(in_file);


       (* read in optimization parameters *)
  reset(in_file,'NAME=/u/ferrall/sports/optmum.raw');
  for i := 1 to nopt_par do
      readln(in_file,opt[i]);
  for i := 1 to np do
      readln(in_file,msk[i]);

      wts[1] := 0.37203650701360E-13;
      wts[2] := 0.88186112420500E-10;      
      wts[3] := 0.25712301800593E-07;
      wts[4] := 0.21718848980567E-05;
      wts[5] := 0.74783988673101E-04;
      wts[6] := 0.12549820417264E-02;
      wts[7] := 0.11414065837434E-01 ;
      wts[8] := 0.60179646658912E-01 ;
      wts[9] := 0.19212032406700E+00 ;
      wts[10] := 0.38166907361350E+00;
      wts[11] := 0.47902370312018E+00;
      wts[13] := wts[9] ;
      wts[12] := wts[10];
      wts[14] := wts[8] ;
      wts[15] := wts[7] ;
      wts[16] := wts[6] ;
      wts[17] := wts[5]  ;
      wts[18] := wts[4]  ;
      wts[19] := wts[3]  ;
      wts[20] := wts[2]  ;
      wts[21] := wts[1]  ;

      pts[1] := 0.55503518732647E+01;
      pts[2] := 0.47739923434112E+01;
      pts[3] := 0.41219955474918E+01;
      pts[4] := 0.35319728771377E+01;
      pts[5] := 0.29799912077046E+01;
      pts[6] := 0.24535521245128E+01;
      pts[7] := 0.19449629491863E+01;
      pts[8] := 0.14489342506507E+01;
      pts[9] := 0.96149963441837E+00;
      pts[10] := 0.47945070707911E+00;
      pts[11] := 0.00000000000000E+00;
      pts[12] := -pts[10];
      pts[13] := -pts[9] ;
      pts[14] := -pts[8] ;
      pts[15] := -pts[7] ;
      pts[16] := -pts[6] ;
      pts[17] := -pts[5] ;
      pts[18] := -pts[4] ;
      pts[19] := -pts[3] ;
      pts[20] := -pts[2] ;
      pts[21] := -pts[1] ;

end;

procedure outit;
var
s  : sports;
j  : par_ind;
outf : text;
begin
   rewrite(outf,'NAME=/u/ferrall/sports/outpar.raw');
   for j := 1 to np do
       begin
       for s := baseball to hockey do
           write(outf,vpars[s,j]:12:9,'    ');
       writeln(outf);
       end;
   for s := baseball to hockey do
       write(outf,maxsprt[s]:12,'    ');
   writeln(outf);
   for s := baseball to hockey do
       write(outf,fy[s]:12,'    ');
   close(outf);
end;

function doyear(i : integer): real;
var ghi,       (* index in data of last game in the series *)
    glo,
    mg,         (* number of games *)
    yr,        (* year of series *)
    k,
    m
                   : integer;
    dv    : team_type;
    lkalph,
    lkyr     : real;

       procedure netcalc;
           begin
           deltv[a] := gam[b]*dv[a];
           deltv[b] := gam[a]*dv[b];
           ddelt := (ln(deltv[a]/deltv[b]) + cdelt)/r;
           cdfv := cdfn(ddelt);
           fv := fdens(ddelt);
           netv[a] := deltv[a]*(cdfv-fv/r);
           netv[b] := deltv[b]*(1-cdfv-fv/r);
           end;

      procedure vsolve;
      const
           vtol = 1E-10;
           itmax = 50;
      var
           awlo,
           awn,
           awhi  : awn_type;
           g     : g_type;
           s     : teams;
           dff,
           sgn,
           nets  : real;
           it    : integer;

    
      begin    (* dosolve *)
           for g := ng downto 1 do
               begin
               homedf  := hadv[g];
               if g > 4 then begin awlo := g-4; awhi  := 3; end
               else            begin awlo := 0; awhi  := g-1; end;
              
               for awn := awlo to awhi do
                   begin
                   n[a] := awn;   n[b] := g-n[a]-1;
                   cdelt := alpha+ beta[home]*hadv[g] +
                            beta[season]*recdf + beta[exper]*expdf;
                   gam[a] := 1.0; gam[b] := 1.0;
                   dv[a] := (va[n[a]+1,n[b]]-va[n[a],n[b]+1]);
                   dv[b] := (vb[n[a],n[b]+1]-vb[n[a]+1,n[b]]);
                   netcalc;

                   it := 0;
                   if (netv[a]<0.0) OR (netv[b] < 0.0) then
                      begin         (* one team or the other randomizes *)
                      
                      sgn := 1.0; s := a;
                      if netv[b] < 0.0 then           (* is it team b? *)
                         begin s := b; sgn := -1.0; end;
                      gam[s] := exp(sgn*ddelt);       (* gamma w/ netv>0*)
                      netcalc;
                      nets := netv[s];
                      repeat                          (* Newton's method *)
                           gam[s] := gam[s]*(1+netv[s]*sgn*r/
                                           (deltv[s]*fv*(sgn+ddelt/r)) );
                           netcalc;
                           nets := netv[s];
                           it := succ(it);
                      until (abs(nets)<vtol) OR (it>itmax);
                 
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
(*if g>5 then
writeln(ord(sp):1,' ',yr:2,' ',k:1,' ',homedf:3:1,' ',n[a]:1,' ',n[b]:1,
' ',gam[a]:5:4,' ' ,gam[b]:5:4,' ',
it:3,' ', netv[a]:4:2,' ',netv[b]:4:2,' ',
prba[n[a],n[b]]:5:4,' ',winner[glo+g-1]:3:1); *)
              end;
           end;
      end;
  begin

  recdf := rdf[yind];
  expdf := edf[yind];
  glo := yind;
  yr := year[yind];
  ghi := glo;
  mg := 0;
  while (ghi <=nobs) AND (year[ghi]=yr) do
         begin  mg := succ(mg);hadv[mg] := hdf[ghi]; ghi := succ(ghi); end;
  yind := ghi;
  ghi := ghi-1;
      case sp of 
         baseball: 
                   case yr of
                     61,23 :  hadv[ng] := hadv[1];
                     43    :  begin hadv[ng] := -hadv[1]; 
                                    hadv[ng]:=-hadv[1]; end;
                     44    :  hadv[ng] := hadv[2];
                 otherwise    begin
                              if mg < ng then hadv[ng] := hadv[1];
                       	      if mg < ng-1 then hadv[ng-1] := -hadv[1];
                       	      if mg < ng-2 then hadv[ng-2] := -hadv[1];
                              end;
                   end;
          basketball: begin
                      if mg < ng   then hadv[ng] := hadv[1];
                      if yr < 85 then
                         begin
                         if mg < ng-1 then hadv[ng-1] := -hadv[1];
                         if mg < ng-2 then hadv[ng-2] := hadv[1];
                        end
                      else
                        begin
                        if mg < ng-1 then hadv[ng-1] := -hadv[1];
                        if mg < ng-2 then hadv[ng-2] := -hadv[1];
                        end;
                     end;
          hockey: begin
                  if mg < ng   then hadv[ng] := hadv[1];
                  if mg < ng-1 then hadv[ng-1] := -hadv[ng];
                  if mg < ng-2 then hadv[ng-2] := hadv[ng];
                  end;
      end; 


      lkyr := 0.0;
      for k := 1 to npts do
          begin
          alpha := pts[k]*sqrt(2)*sigma;
          vsolve;
          lkalph := 1.0;
          for m := glo to ghi do
              if winner[m]=1 then lkalph := lkalph*prba[awns[m],bwns[m]]
              else                lkalph := lkalph*(1-prba[awns[m],bwns[m]]);
          lkyr := lkyr + lkalph*wts[k]/sqrt(pi);
          end;
(*      writeln('lk contribution = ',lkyr:6:5); *)
      doyear := lkyr;
      end;

function like;
var   lktmp : real;
      j     : awn_type;
      i     : integer;
      c     : controls;
      n     : par_ind;
begin
  for c := home to exper do 
      beta[c] := inx[ord(c)+1] ;
  sigma := exp(inx[4]);
  r     := exp(inx[5]);
  v1    := exp(inx[6]); 
(*  v1    := 0.0; *)
        (* initialize final payoffs *)
  for j := 0 to 3 do
      begin
      va[4,j] := 1.0 + v1*(4-j-1);      va[j,4] := -va[4,j];
      vb[j,4] := va[4,j];               vb[4,j] := -vb[j,4];
      (*writeln(va[4,j]:6:3,' ',va[j,4]:6:3,' ',vb[j,4]:6:3,' ',vb[4,j]:6:3); *)
      end;

  lktmp := 0.0;
  yind  := ilo;
  
  for i := 1 to nsersp do
    begin
    writeln(year[ilo]);
    if year[ilo] < 1993 then lktmp := lktmp + ln(doyear(i));
    end;

   lktmp := -lktmp;                (* minimizing not maximizing objective *)
   if lktmp < mxobj then          (* write vector out to file *)
      begin
      (*writeln(lktmp);*) 
      rewrite(mx_file,'NAME=mxobj.raw');
      for c := home to exper do
          writeln(mx_file,beta[c]:15:10);
      writeln(mx_file,sigma:15:10);
      writeln(mx_file,r:15:10);
      writeln(mx_file,v1:15:10);
      mxobj := lktmp;
      writeln(mx_file,'sport = ',ord(sp),' likelihood= ',mxobj:10:8);
      close(mx_file);     
      end;
(*      for c := home to exper do
          write(beta[c]:7:4,' ');
      write(sigma:7:4,' ',r:7:4,' ',v1:7:4);
      writeln(' ',lktmp:7:3);*)

  like := lktmp;

end;

procedure f_hess;
begin
end;

procedure f_grad;
begin
end;

procedure dosport;
var
   j1,
  j : par_ind;
  c : controls;
  i : integer;
  l : real;


begin
      (* initialize parameters for sport *)
  for j := 1 to np do         pars[j] := vpars[sp,j];
  for j := 4 to np do 
      if pars[j] > mn_par then
         pars[j] := ln(pars[j])
      else
         pars[j] := ln(mn_par);
  ilo := endpt[sp,lo];
  ihi := endpt[sp,hi];
  nsersp := nseries[sp];
  mxobj := 1E10;
  optmum(pars,msk,opt,outx,fy[sp],h,g,flg);
  for j := 4 to np do outx[j] := exp(outx[j]);
  for j := 1 to np do
      vpars[sp,j] := outx[j];
    for j :=1 to np do
     begin
        for j1 := 1 to np do write(h[j,j1]:8:6,' ');
         writeln;
        end;
  writeln('done with sport ',fy[sp]);
end;

begin
  init;
  for sp := baseball to hockey do
      if maxsprt[sp] = 1 then
          dosport;
  outit;
end.


