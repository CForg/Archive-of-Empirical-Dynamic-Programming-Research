program solve22x(input,output);
(*  This program computes sample statistics and APPENDS them to
    out_file2.  *)
const

     (* constants shared with optmize *)
  %include /u/ferrall/lib/lmas.const

      (* Tolerance, Limit and Distribution Constants *)
  mx_exp = 89;               (* limit to exp(-x) *)
  mx_exp2 = 30;
  mn_log = 1E-20;            (* limit to ln(x) *)
  mn_lk =  1E5;              (* lowest likelihood value (abs value) *)
  pi = 3.141592653589793;

      (* Unemployment System Constants *)
  tm_base = 40; (* basic benefit period *)
  tm_ext  = 52; (* extended benefits *)
  trange = tm_ext+3;
  twait = 2;
  wmax_ui = 530.0;
  b_rate = 0.60; 
  b_max = b_rate*wmax_ui;    (* 318.0; *) 
  w_min = 0.2*wmax_ui;       (*wmax_ui;  80.0; *)
  ui_smth = 10.0;

      (* Data Constants *)
  (* n_max = 10000; *)
  n_max = 726;            (* all observ,USA is less *)

      (*  Integration and Estimation Constants  *)
  mxn_romb = 33;

type

             (* nmsimp and UMINF definitions *)
  %include /u/ferrall/lib/lmas.type

  ui_spell_type = array[1..trange] of real;
  vromb_type = array[1..mxn_romb] of real;
  data_r_type = array[1..n_max] of real;
  data_d_type = array[1..n_max] of real;
  data_i_type = array[1..n_max] of integer;
  obs_i_type   = array[1..obs_typ] of integer;
  obs_r_type   = array[1..obs_typ] of real;
  obs_par_type = array[1..obs_cat] of real;
  save_type = array[1..2,1..3,1..obs_typ] of real;

  umpar_iv = array[1..7] of integer;
  umpar_rv = array[1..7] of real;

  tm_type = array[0..1] of integer;


var
  mx_file,
  out_file,
  out_file2,
  data_file: text;
  name_str4,
  name_str3,
  name_str2,
  name_str1  : string;
  wsave     : save_type;
  (* name_str1 : packed array[1..17] of char; *)
  
  
  fw,
  wt,    
  evs, 
  evt  : ui_spell_type;
  deltr,
  romb : vromb_type;
  lk_mix : data_d_type;
  w,
  wk,     
  u    : data_r_type;
  sex,
  reg,
  educ,
  lv_a1,
  sf,
  uf,
  wf   : data_i_type;
  sca_x,
  sca,
  init_x : param_type;
  costs,
  gams,
  lays, 
  offs   : obs_par_type;
  tents,
  tmins,
  tmaxs    : tm_type;
  sc_acc : real;
  i,   
  tmax, 
  tmax1,
  tmin, 
  tent2,


         (*  Array Limits *)
  n_samp,              (* number of observations in sample *)
  do_sch,
  do_cost,
  do_off,
  do_lay,
  do_scale,
  country,
  which_est,
  extended,
  tent1,
  n1_obs,              (* index into big array for observation group *)
  use_typ,            (* number of types actually used *)
  optmize,             (* run nmsimp or note *)
  do_ui,               (* include UI benefits in value of a job *)
  nskills,
  only_skill,
  in_logs,
  algr,
  it_tol,
  romb_lev,
  n_romb,
  n_tot                (* total number of observations *)
             : integer;
  vn_obs     : obs_i_type;

  phi_co,     (* 1/sqrt(2*pi); *)

              (*  Probabilities and Wage Parameters *)
  lay1,  lay2,  
  gam1,  gam2,  gam,
  p_lay, p_off, poff1, poff2,
  sig,   sig2,  sig_inv, wbar,

                (*  beta and c related  *)
  c, c1, c2, cbar1, cbar2,
  bet_inv,  gam_inv,
  bet_lay,  bl_inv,
  z1, beta,
  lw_min, lw_max, ln_smth,

      (* Calculated Values *)
  f_no,
  w_no,
  w_sch,
  f_sch,
  f_sch2,
  psch, 
  v_sch, ev_no,
  v_no
        : real;
  betas,
  pi_1,
  p_sch : array[0..1] of real;

       (*  NMSIMP and Time Variables *)
   nm_pars  : optpar_type;
   msk,
   fout,
   ff       : param_type;
   mx_obj,
   wr_tol,
   wr_tol1,
   fy       : real;
   use_err,       (* include measurement error in wages *)
   use_dens,      (*  include observed wage density in likelihood *)

   fst_call,
   conv2,
   conv     : boolean;
   fi_pars  : umpar_iv;
   fr_pars  : umpar_rv;
   htmp,
   h        : hess_type;
   g        : param_type;

(*            Functions and Procedure Declarations         *)

function like(inx : param_type): real; External;

        function fexp(w:real): real; (* exponential distribution of w *)
        var
           ff : real;
        begin
             ff := gam*(w-wbar);
             if ff < 0.0 then ff := 0.0;
             fexp := 1.0;
             if ff<mx_exp then fexp := 1-exp(-ff);
        end;

        function sexp(x:real): real;
        begin
          if x > mx_exp2 then sexp := exp(mx_exp2)
                        else sexp := exp(x);
        end;

        function  pow(a,b : real): real;
        begin
             if a > mn_log then pow := exp( b*ln(a) )
                           else pow := 0.0;
        end;

         function phi(x:real): real;   (* standard normal density function *)
         var z : real;
         begin
           z := x*x/2;
           if z < mx_exp then phi := phi_co * exp( -z )
                         else phi := 0.0;
         end;

         function cdfn(w: real): real; External;


procedure startup;
var
  delt : real;
  i : integer;
begin

     rewrite(out_file2,'NAME=table6_34.dmp,DISP=MOD');

       (* Read in Program parameters *)

     reset(data_file,'NAME=nm34.raw');
     for i:=1 to nopt_par do readln(data_file,nm_pars[i]);
     optmize := trunc(nm_pars[5]);
     for i := 1 to np do readln(data_file,msk[i]);
     use_dens := TRUE;
     use_err := TRUE;

     reset(data_file,'NAME=est_par35x.raw');
     readln(data_file,country);
     readln(data_file,do_ui);
     readln(data_file,use_typ);
     readln(data_file,nskills);
     readln(data_file,only_skill);
     readln(data_file,do_sch);
     readln(data_file,do_off);
     readln(data_file,do_lay);
     readln(data_file,do_cost);
     readln(data_file,in_logs);
     readln(data_file,wr_tol);
     readln(data_file,wr_tol1);
     readln(data_file,it_tol);
     readln(data_file,wbar);
     readln(data_file,romb_lev);
     readln(data_file,do_scale);
     readln(data_file,which_est);
     readln(data_file,extended);
     readln(data_file,tent1);

     if in_logs = 1 then
        begin
        if (country = 1) then
           begin
           lw_min := ln(w_min*.69345112);
           lw_max := ln(wmax_ui*.69345112);
           ln_smth := ln((w_min-ui_smth)*.69345112);
           end
        else
           begin
           lw_min := ln(w_min);
           lw_max := ln(wmax_ui);
           ln_smth := ln(w_min-ui_smth);
           end;
        end
      else
        begin
        lw_min := w_min;
        lw_max := wmax_ui;
        ln_smth := w_min-ui_smth;
        end;

          (*  Read in Romberg Weights *)
     case romb_lev of
       4:  begin reset(data_file,'NAME=/u/ferrall/gauss/vr4.raw'); n_romb := 9; end;
       5:  begin reset(data_file,'NAME=/u/ferrall/gauss/vr5.raw'); n_romb := 17; end;
       6:  begin reset(data_file,'NAME=/u/ferrall/gauss/vr6.raw'); n_romb := 33; end;
       end;
     for i := 1 to n_romb do
         readln(data_file,romb[i]);
     delt := 1/(n_romb-1);
     for i := 1 to n_romb do
         deltr[i] := (i-1)*delt;

     case country of
     0: begin
        n_samp := 726;
        if do_ui = 1 then
           begin
           name_str1 := 'NAME=cdn_smp3.raw';
           end
        else
           begin
           name_str1 := 'NAME=cdn_smp3.raw';  
           end
        end;
     1: begin
        n_samp := 439;
        name_str1 := 'NAME=usa_smp3.raw';
	end;
        end;

    case which_est of
    0 : name_str2 := 'NAME=cdn34no.raw';  
    1 : name_str2 := 'NAME=cdn34ui.raw';
    2 : name_str2 := 'NAME=usa34.raw';
    end;

         (*  set benefit periods *)
     tmaxs[0] := 38;
     tmaxs[1] := 50;
     tmins[0] := 20;
     tmins[1] := 20;
     tents[0] := 52;
     tents[1] := 20;

         (* Read in Data *)
    reset(data_file,name_str1);
     readln(data_file);
     for i := 1 to obs_typ do
         readln(data_file,vn_obs[i]);

     for i:= 1 to n_samp do
         begin
         readln(data_file,sex[i],educ[i],reg[i],lv_a1[i],
                          sf[i],u[i],uf[i],wk[i],wf[i],w[i]);
         if (in_logs=1) AND (w[i] > 0) then w[i] := ln(w[i]);
         end;

     writeln(out_file2,'country ',country:1,' ui ',do_ui:1,
                 ' in_logs ',in_logs:1,
             ' which ',which_est:1,' extended ',extended:1,' tent ',
             tent1:2);

         (* Read in Starting Values *)
     reset(data_file,name_str2);
     for i := 1 to np do
         readln(data_file,init_x[i]);

     phi_co := 1/sqrt(2*pi);

     mx_obj := -1E15;

    fst_call := TRUE;
end;


procedure scale(var x,y : param_type);
var
  i: integer;
begin
    if do_scale = 1 then
       begin
       y[1] := ln( x[1]/(1-x[1]) );
       for i := 2 to 8 do
           y[i] := x[i];
       for i := 9 to 9 do
           y[i] := ln( x[i]/(1-x[i]) );
       for i := 10 to np do
          y[i] := x[i];
       end
    else
       begin
       if do_scale=0 then
         for i := 1 to np do y[i] := x[i]
       else
         for i := 1 to np do y[i] := 1.0;
       end;
end;

procedure unscale(x : param_type);
var
   i : integer;
   tmp : param_type;
begin
  if do_scale = 1 then
     begin
     if abs(sca[1]*x[1])< mx_exp then
        tmp[1] := exp(sca[1]*x[1])
     else
        tmp[1] := exp( mx_exp*(sca[1]*x[1])/abs(sca[1]*x[1]) );
     for i := 2 to 8 do
         tmp[i] := sca[i]*x[i];
     for i := 9 to 9 do 
         if abs(sca[i]*x[i])< mx_exp then
            tmp[i] := exp(sca[i]*x[i])  
         else
            tmp[i] := exp( mx_exp*(sca[i]*x[i])/abs(sca[i]*x[i]) );
     for i := 10 to np do
          tmp[i] := sca[i]*x[i];
     end
  else
     for i := 1 to np do tmp[i] := sca[i]*x[i];
  
  if do_scale=1 then
    pi_1[0] := tmp[1]/(1+tmp[1])
  else
    pi_1[0] := tmp[1];
  lay1 := tmp[2];
  if do_lay=1 then 
    lay2 := tmp[3]
  else
    lay2 := lay1;
  gam1 := tmp[4];
  gam2 := tmp[5];
  sig :=  tmp[6];

  p_sch[0] := 1.0;
  p_sch[1] := 1.0;

  betas[0] := tmp[7];
  betas[1] := tmp[8];

  if do_scale=1 then
    pi_1[1] := tmp[9]/(1+tmp[9])
  else
    pi_1[1] := tmp[9];

  poff1 := tmp[10];
  if do_off = 1 then
     poff2 := tmp[11]
  else
     poff2 := poff1;
  cbar1 := tmp[12];
  if do_cost = 1 then
     cbar2 := tmp[13]
  else
     cbar2 := cbar1;
  for i := 1 to obs_cat do
      begin
      gams[i] :=   tmp[nbase+          i];
      lays[i] :=   tmp[nbase+  obs_cat+i];
      offs[i] :=   tmp[nbase+2*obs_cat+i];
      costs[i] :=  tmp[nbase+3*obs_cat+i];
      end;
end;

procedure init;
begin
  if p_lay >= 1.0-mn_log then p_lay := 1.0-mn_log;
  if p_lay <= mn_log then p_lay := mn_log;
  if p_off >= 1.0-mn_log then p_off := 1.0-mn_log;
  if p_off <= mn_log then p_off := mn_log;
  if gam <= mn_log then gam := mn_log;
  bet_inv := 1/(1-beta);
  gam_inv := 1/gam;
  bet_lay := beta*p_lay;
  z1 := beta*(1-p_lay);
  bl_inv := 1/(1-z1);
  sig2 := sig*sig;
  sig_inv := 1/sig;
end;

procedure solve_all(new_pars,typ_ind : integer);
(*  Compute solution to search problem through backward
    recursion.  Values computed:
                evt, wt, fw, w_no, ev_no, f_no, w_sch, f_sch,
*)
var
   t,
  iter : integer;
  w1,
  w_sch1,
  w_sch2,
  wold : real;

         procedure vt(w1: real);
         (*  Solve stationary problem after UI benefits have
             run out in second spell *)
         var
            its : integer;
            tpt,
            wrn,
            wr  : real;
         begin

              wrn := w1;
              its := 0;
              repeat
                    its := succ(its);
                    wr := wrn;
                    tpt := wr;
                    if tpt < wbar then
                       tpt := wbar;
                    wrn := (1-z1)*c + beta*(1-z1-p_lay)*bet_inv
                      *(tpt + p_off*(1-fexp(wr))*gam_inv);
              until (abs(wrn-wr) < wr_tol1) ;
              wt[tmax1] := wrn;
              if wt[tmax1] < wbar then
                 begin
                 fw[tmax1] := 0.0;
                 evt[tmax1] := bet_inv*( wt[tmax1]*(1-p_off) + p_off*(wbar+gam_inv) );
                 end
              else
                 begin
                 fw[tmax1] := fexp(wt[tmax1]);
                 evt[tmax1] := bet_inv*(wt[tmax1] + gam_inv*p_off*(1-fw[tmax1]) );
                 end;
         end; (* vt *)

         function vjob_ui(w:real): real;
            (*Call v_ui for previous wage w and return
              component of value of a job that depends on unemployment
              spell and UI benefits*)
         var
            vtmp,
            ew,
            pow2,
            pow1 : real;
	    i : integer;
                     (*  procedure v_ui *)
                procedure v_ui(b_pot:real);
                     (* Solve non-stationary problem as a function of
                        benefit level b_pot *)
                var
                   t : integer;
                   rhs,
                   ff,
                   f1,
                   w1,
                   ev1,
                   b : real;
                begin
                 if (do_ui = 1) AND (b_pot > 0.0) then
                   begin
                   b := b_pot;
                   if b > b_max then b:=b_max;
                   for t := tmax+twait downto 1  do
                       begin
                       if t > twait then
                          begin
                          if in_logs = 1 then
                             rhs := (1-z1)*(ln(b+sexp(c))+beta*evt[t+1])
                          else
                             rhs := (1-z1)*(b+c+beta*evt[t+1])
                          end
                       else
                          rhs := (1-z1)*(c+beta*evt[t+1]);
                       wt[t] := rhs - beta*p_lay*evt[tmax1];
                       if wt[t] < wbar then
                           begin
                           fw[t] := 0.0;
                           evt[t] := bl_inv*( (1-p_off)*wt[t] + p_off*(wbar+gam_inv)
                                              + bet_lay*evt[tmax1] );
                           end
                       else
                           begin
                           fw[t] := fexp(wt[t]);
                           evt[t] := bl_inv*( wt[t] + p_off*(1-fw[t])*gam_inv +
                                    bet_lay*evt[tmax1] );
                           end;
(*
Calculate sliding benefits
*)
                       if tmax+twait-t+1 >= tmin then
                          begin
                          rhs := (1-z1)*c + beta*(1-z1)*evt[t];
                          w1 := rhs - beta*p_lay*evt[tmax1];
                          if w1 < wbar then
                             begin
                             f1  := 0.0;
                             ev1 := bl_inv*( (1-p_off)*w1 + p_off*(wbar+gam_inv)
                                             + bet_lay*evt[tmax1] );
                             end
                          else
                             begin
                             f1 := fexp(w1);
                             ev1 := bl_inv*( w1 + p_off*(1-f1)*gam_inv +
                                 bet_lay*evt[tmax1] );
                             end;

                          rhs := (1-z1)*c + beta*(1-z1)*ev1;
                          w1 := rhs - beta*p_lay*evt[tmax1];
                          if w1 < wbar then
                             begin
                             f1 := 0.0;
                             evs[tmax+twait-t-tmin+2] := bl_inv*( (1-p_off)*w1 +
                                   p_off*(wbar+gam_inv) + bet_lay*evt[tmax1] );
                             end
                          else
                             begin
                             f1  := fexp(w1);
                             evs[tmax+twait-t-tmin+2] := bl_inv*(w1 +
                                                 p_off*(1-f1)*gam_inv
                                              + beta*p_lay*evt[tmax1] );
                             end;
                          end;
                       end;
                   end
                 else
                   for t := tmax+twait downto 1  do
                       begin
                       wt[t] := wt[tmax1];
                       fw[t] := fw[tmax1];
                       evt[t] := evt[tmax1];
                       if tmax+twait-t+1 >= tmin then
                          evs[tmax+twait-t-tmin+2] := evt[tmax1];
                       end;
                end;  (* v_ui *)

         begin  (* vjob_ui *)
             ew := exp(w);
             if ew >= w_min then
                v_ui(b_rate*ew)
             else
                begin     
                if ew >= w_min-ui_smth then
                   v_ui( (ew-(w_min-ui_smth))*b_rate*w_min/ui_smth ) 
                else  
                   v_ui(0.0); 
                end;

             pow1 := bet_lay*pow( z1, tent1-1 );
             pow2 := bet_lay*pow( z1, tent2-1 );
             vtmp := bl_inv*( evt[tmax1]*(bet_lay-pow1) + evt[1]*pow2 );
             if tent1 < tent2 then
                begin
                for i := 1 to 25-tmin do
                    begin
                    vtmp := vtmp + pow1*evs[i];
                    pow1 := pow1*z1;
                    end;
                for i := 25-tmin+1 to tmax-tmin do
                    begin
                    vtmp := vtmp + pow1*(1+z1)*evs[i];
                    pow1 := pow1*z1*z1;
                    end;
                end;
         vjob_ui := vtmp;
         end;

         function vjob(w: real): real;
         (*  Return full value of the job *)
         begin  vjob := vjob_ui(w) + bl_inv*w; end;

         procedure v_no_ui(w_no:real);
           (* Compute ev for reservation wage w_no during first spell*)
         var
           i    : integer;
           v_lo, z_max, z_min,
           ev1, ev_ui, f_max, z, wl
                : real;
           intg,
           v    : vromb_type;
         begin
            f_no := fexp(w_no);
            if w_no >= lw_min then
               begin z_min := w_no; v_lo := 0.0; end
            else
               begin z_min := lw_min; v_lo := vjob_ui(0.0)*(fexp(lw_min)-f_no); end;
            z_max := lw_max;
            ev_ui := 0.0;
            if w_no < lw_max then
               begin
               for i := 1 to n_romb do
                   begin
                   z := z_min+deltr[i]*(z_max-z_min);
                   v[i] := vjob_ui(z);
                   intg[i] := v[i]*gam*(1-fexp(z));
                   ev_ui := ev_ui + romb[i]*intg[i];
                   end;
               ev_ui := v_lo + (z_max-z_min)*ev_ui;
               f_max := 1-fexp(lw_max);
               end
            else
               begin
               v[1] := vjob_ui(lw_max);
               v[n_romb] := v[1];
               f_max := 1-f_no;
               end;
            if w_no < wbar then
               ev_no := (1-p_off)*(bl_inv*w_no+v[1])
                        + p_off*( bl_inv*(gam_inv+wbar) + ev_ui + f_max*v[n_romb])
            else
               ev_no := bl_inv*w_no + v[1]*( 1-p_off*(1-f_no) ) +
                        p_off*( gam_inv*bl_inv*(1-f_no) + ev_ui + f_max*v[n_romb]);
            v_no := v[1];
            end;


(*************************************************************************)
begin   (* solve_all *)
   init;

       (*  Solve stationary problem: exhausted UI benefits search *)
   if fst_call then
      w1 := gam_inv
   else
      w1 := wsave[typ_ind,1,new_pars];

       (*  Solve stationary problem:  post-school search
           Iterate on w_no, calling non-stationary problem *)
   vt(w1);

   if do_ui= 0 then
      begin
      ev_no := evt[tmax1];
      f_no := fw[tmax1];
      w_no := wt[tmax1];
      end
   else
      begin
      if fst_call then
         w_no := wt[tmax1]
      else
         w_no := wsave[typ_ind,2,new_pars];
      iter := 0;
      repeat
        iter := succ(iter);
        wold := w_no;
        v_no_ui(w_no);
        w_no := (1-z1)*(c + beta*ev_no - v_no);
      until ( abs(w_no-wold) < wr_tol ) OR (iter > it_tol);
      if iter >it_tol then
         begin
         writeln('no convergence',(wold-w_no):8:5,' ',w_no:8:5,' ',lw_min:8:5);
                writeln(sex[n1_obs]:1,' ',educ[n1_obs]:1,' ',
                         reg[n1_obs]:1,' ',lv_a1[n1_obs]:1,' 0 ',
                         p_lay:5:4,' ',gam:5:3,' ',p_off:4:3,' ',
                         c:4:2,' ',w_no:4:2);
         w_no := 0.5*(w_no + wold);
         end;
       v_no_ui(w_no);
       f_no := fexp(w_no);
     end;

     w_sch := w_no;
     f_sch := f_no;


end;

function like;
(*
    Compute likelihood for sample by calling solve_all for
    different types of searchers and calling clike to sum up
    likelihood of observations
*)
var
   i,
   j1,
   k,
   j : integer;
   elaps,
   lk_tmp : real;
   pt1,pt2,pt3,pt4,pt5,pt6,pt7 : real;
   new_mx : param_type;
   lk  : array[1..2] of data_d_type;

         function w_cum(w:real): real;
         var z1,z2,z3 : real;
         begin
                  z1 := cdfn(w*sig_inv);
                  z2 := sexp(-gam*w + sig2*gam*gam/2);
                  z3 := cdfn(sig_inv*(w-sig2*gam));
                  w_cum := z1 - z2*z3;
         end;
         procedure clike(j:integer);
                  var
                    i  : integer;
                    no_acc,
                    f1,
                    tlk : real;


           function w_dens(w:real):  real;  (* density of observed wage*)
            var z1,z2,z3,z4,z2a,z3a,z4a : real;
            begin
                  z1 := phi(w*sig_inv);
                  z2 := sexp(-gam*w + sig2*gam*gam/2);
                  z3 := cdfn(sig_inv*(w-sig2*gam));
                  z4 := phi(sig_inv*(w-sig2*gam));
                  w_dens := sig_inv*z1 + z2*(gam*z3-sig_inv*z4);
            end;


            function wsch_dens(w:real; typ:integer):  real;
            var z1,z2,z3,z4,z1a,z2a,z3a,z4a,z2aa,aa,wt : real; 
             begin

                  z1 := sexp(-gam*(w_sch-wbar))*
                        phi((w-w_sch)*sig_inv)*sig_inv;  
                  z2 := sexp(-gam*(w-wbar) + sig2*gam*gam/2);  
                  z3 := cdfn(sig_inv*(w-w_sch-sig2*gam));
                  z4 := sig_inv*phi(sig_inv*(w-w_sch-sig2*gam));
                  z1a :=(2*sexp(-gam*(w_sch-wbar))-sexp(-2*gam*(w_sch-wbar)))
                        *phi(sig_inv*(w-w_sch))*sig_inv;
                  z2a := 2*z2;
                  z2aa := sexp(-2*gam*(w-wbar) + 2*sig2*gam*gam);
                  z3a := cdfn(sig_inv*(w-w_sch-2*sig2*gam));
                  z4a := sig_inv*phi(sig_inv*(w-w_sch-2*sig2*gam));
                  if typ = 1 then
                      wsch_dens := ( pow(1-psch,2)*(z1 + z2*(gam*z3-z4) )
                                  +  (2*psch*(1-psch)+psch*psch)
                                          * (z1a +z2a*(gam*z3-z4)
                                         - z2aa*(2*gam*z3a-z4a) ) )
                                  /(
     (1-psch)*(1-psch)*(1-f_sch)+(2*psch*(1-psch)+psch*psch)*(1-f_sch*f_sch) )
                  else
                     wsch_dens := ( 3*psch*pow(1-psch,2)*(z1 +
                                         z2*(gam*z3-z4) )  
                                     + (1-3*psch*pow(1-psch,2)-pow(1-psch,3))
                                        *(z1a +
                                          z2a*(gam*z3-z4)
                                         - z2aa*(2*gam*z3a-z4a) ) )/sc_acc; 
             end;

         begin
              no_acc := 1-p_off*(1-f_no);
              i := n1_obs;
              if lv_a1[i] = 1 then
                   sc_acc := 1.0
              else
                 sc_acc := 3*psch*pow(1-psch,2)*(1-f_sch) +
                            (1-3*psch*pow(1-psch,2)-pow(1-psch,3))*
                                (1-f_sch*f_sch); 

              (* Accept in School Observations - incomplete job*)

              while (sf[i]=0)AND(wf[i]=0) AND (i<=n_tot) do
                  begin
                  lk[j,i] :=  sc_acc*pow(1-p_lay,wk[i]-1);
                  if w[i]>=0.0 then lk[j,i] :=lk[j,i]*wsch_dens(w[i],lv_a1[i]);
                  i := succ(i);
                  end;
            
              (*  Job Before School - complete*)
              while (sf[i]= 0) AND (i<=n_tot) do
                  begin
                  lk[j,i] := sc_acc
                             *pow(1-p_lay,wk[i]-1)*p_lay;
                  if w[i]>=0.0 then lk[j,i] := lk[j,i]*wsch_dens(w[i],lv_a1[i]);
                  i := succ(i);
                  end;

              if lv_a1[i] = 1 then
                   sc_acc := 0.0;

              (*  Incomplete Unemployment Spells *)
              while (uf[i]=0) AND (i<=n_tot) do
                     begin
                     lk[j,i] := (1-sc_acc)*pow(no_acc,u[i]);
                     i := succ(i);
                     end;

              (*  Complete Unemployment - Incomplete Employment *)
              while (i<=n_tot) AND (wf[i]=0) do
                 begin
                 lk[j,i] := (1-sc_acc)
                          *pow(no_acc,u[i])*p_off*(1-f_no)
                          *pow(1-p_lay,wk[i]-1);
                  if w[i]>=0.0 then lk[j,i] := lk[j,i]*w_dens(w[i]-w_no);
                  i := succ(i);
                 end;

              (* Complete Employment *)
              while i <= n_tot do
                 begin
                 lk[j,i] := (1-sc_acc)
                            *pow(no_acc,u[i])*p_off*(1-f_no)
                            *pow(1-p_lay,wk[i]-1)*p_lay;
                  if w[i]>=0.0 then lk[j,i] := lk[j,i]*w_dens(w[i]-w_no);
                 i := succ(i);
                 end;

         end;  (* clike *)

(***************************************************************************)
begin   (* like *)
   unscale(inx);
   n1_obs := 1;
   lk_tmp := 0.0;
   conv := TRUE;

   for j := 1 to use_typ  do
       begin
                   (*  Solve for Type 1 skills *)

       n_tot := n1_obs+vn_obs[j]-1;
       case 2*country+educ[n1_obs] of   
       0 : wbar := ln(55);
       1 : wbar := ln(65);
       2 : wbar := ln(40);
       3 : wbar := ln(55);
       end;
       if  ((reg[n1_obs] = 0.0) AND (country=0) AND (extended=2) ) 
         OR ((do_ui=1) AND (extended=0))  then
             begin
             tmax := tmaxs[0];
             tmax1 := tmax+3;
             tmin := tmins[0];
             tent2 := tents[0];
             end
       else
             begin
             tmax := tmaxs[1];
             tmax1 := tmax+3;
             tmin := tmins[1];
             tent2 := tents[1];
             end;
       if (nskills > 1) OR (only_skill = 1) then
          begin
          n_tot := n1_obs+vn_obs[j]-1;
          c := cbar1 + costs[1]*sex[n1_obs] + costs[2]*educ[n1_obs];
          if c > 6.0 then c := 6.0;
          p_lay := exp(lay1 + lays[1]*educ[n1_obs] + lays[2]*reg[n1_obs]);
          p_lay := p_lay/(1+p_lay);
          gam   := exp(gam1 + gams[1]*sex[n1_obs] +gams[2]*educ[n1_obs]);
          p_off := exp(poff1 + offs[1]*educ[n1_obs] + offs[2]*reg[n1_obs]);
          p_off := p_off/(1+p_off);
          beta := exp(betas[0]+betas[1]*educ[n1_obs]);
          beta := beta/(1+beta);
          psch := 1.0;
            

          solve_all(j,1);
          wsave[1,1,j] := wt[tmax1];
          wsave[1,2,j] := w_no;
          wsave[1,3,j] := w_sch;

          clike(1);
               pt1 := pi_1[lv_a1[n1_obs]]*(1/gam+wbar);
               pt2 := pi_1[lv_a1[n1_obs]]*p_lay;
               pt3 := pi_1[lv_a1[n1_obs]]*p_off;
               pt4 := pi_1[lv_a1[n1_obs]]*c;
               pt5 := pi_1[lv_a1[n1_obs]]*w_no;
               pt6 := pi_1[lv_a1[n1_obs]]*f_no;
               pt7 := pi_1[lv_a1[n1_obs]]*(1-beta)*ev_no;
          end; 

        (*  Solve for Type 2 skills *)
        if (nskills > 1) OR (only_skill = 2) then
          begin
          c := cbar2 + costs[1]*sex[n1_obs] + costs[2]*educ[n1_obs];
          if c > 6.0 then c := 6.0;
          p_lay := exp(lay2 + lays[1]*educ[n1_obs] + lays[2]*reg[n1_obs]);
          p_lay := p_lay/(1+p_lay);
          gam   := exp(gam2 + gams[1]*sex[n1_obs] +gams[2]*educ[n1_obs]);
          p_off := exp(poff2 + offs[1]*educ[n1_obs] + offs[2]*reg[n1_obs]);
          p_off := p_off/(1+p_off);
          beta := exp(betas[0]+betas[1]*educ[n1_obs]);
          beta := beta/(1+beta);   
          
          solve_all(j,2);
          wsave[2,1,j] := wt[tmax1];
          wsave[2,2,j] := w_no;
          wsave[2,3,j] := w_sch;
          clike(2);
              writeln(out_file2,country:1,' ',do_ui:1,' ',
                         which_est:1,' ',extended:1,' ',
                         sex[n1_obs]:1,' ',
                         educ[n1_obs]:1,' ',reg[n1_obs]:1,' ',
                         lv_a1[n1_obs]:1,' ',
                         (1-pi_1[lv_a1[n1_obs]])*(1/gam+wbar)+pt1:5:3,' ',
                         (1-pi_1[lv_a1[n1_obs]])*p_lay+pt2:5:3,' ',
                         (1-pi_1[lv_a1[n1_obs]])*p_off+pt3:5:3,' ',
                         (1-pi_1[lv_a1[n1_obs]])*c+pt4:5:3,' ',
                         (1-pi_1[lv_a1[n1_obs]])*w_no+pt5:5:3,' ',
                         (1-pi_1[lv_a1[n1_obs]])*f_no+pt6:5:3,' ',
                         (1-pi_1[lv_a1[n1_obs]])*(1-beta)*ev_no+pt7:5:3,' ',
                         pi_1[lv_a1[n1_obs]]:5:3,' ',beta:5:3);
           end; 
        n1_obs := n1_obs+ vn_obs[j];
       end;

   fst_call := FALSE;
   lk_tmp := 0.0;
   for i := 1 to n_tot do
       begin
        if nskills > 1 then
           lk_mix[i] := pi_1[lv_a1[i]]*lk[1,i] + (1-pi_1[lv_a1[i]])*lk[2,i]
        else
           case only_skill of
           1: lk_mix[i] := lk[1,i];
           2: lk_mix[i] := lk[2,i];
           end;
        if lk_mix[i] > mn_log then
           lk_tmp := lk_tmp + ln(lk_mix[i])
        else
            lk_tmp := lk_tmp + ln(mn_log);
        end;
      like := -lk_tmp;
end;

begin  
     startup;
     scale(init_x,sca);
     if do_scale<>2 then
       for i := 1 to np do sca_x[i] := 1.0
     else
       for i := 1 to np do sca_x[i] := init_x[i];
     fy := like(sca_x);
     writeln(out_file2,' likelihood ',fy:8:2);
end.
