        
                        (************  OPTSP2 TYPE LIST **************)
  par_ind           = 1..np;
  obs_ind           = 1..max_obs;
  msg_ind           = 1..msg_size;

  param_type        = array[par_ind] of        real;   
  free_type         = param_type;
  int_np            = array[par_ind] of        integer;
  hess_type         = array[par_ind] of        param_type;
  like_type         = array[obs_ind] of        real;
  vlike_type        = array[par_ind] of        like_type;
  msg_type          = array[msg_ind] of        real;  

  likeptr           = ^like_type;
  vlikeptr          = ^vlike_type;
  hessptr           = ^hess_type;

  fname_type        = packed array[1..20] of char;


m_type = 0..1;
k_type = 1..max_nw;
t1_type = 0..yrwk;
alpn_type = -1..1;
time_type = (thisper,nextper);
nwk_type = 1..yrwk;


  
  stt_ind_type = -1..1;
  eps_ind_type = 1..max_neps;
  m_ind_type   = 0..1;



 StateArray = array[stt_ind_type] of real;
 TransArray = array[stt_ind_type] of StateArray;
 val_type =
  array[m_ind_type,stt_ind_type,k_type,eps_ind_type,stt_ind_type] of real;
 
 epsArray = array[eps_ind_type] of real;
   


vwk_type = array[time_type,k_type,t1_type,nwk_type,alpn_type] of real;
vnwk_type = array[time_type,k_type,t1_type,t1_type,alpn_type] of real;

indx_type =  array[k_type,t1_type,t1_type,alpn_type] of m_type;
resk0_type =  array[m_type,k_type,t1_type,t1_type,alpn_type] of k_type;

eps_type = 1..max_neps;
dec_type =  array[alpn_type,k_type,eps_type,alpn_type] of 0..3;
dectime_type = array[m_ind_type] of dec_type;
palp_type = array[alpn_type,alpn_type] of real;
 (* for infinite solution only *)
tresk_type = array[time_type] of resk0_type; 
(* if have tresk, do not want res_array_type *)
(* this is for writing all periods to file *)
            


(* param_type take out by CF, 12/95 *)

moment_type = array[1..n_moments] of real;
opt_type = array[1..50] of real;
file_type = (option_fname,  (* filenames containing information for this run *)
momwgt_fname,
oldoff_fname,
newoff_fname,
oldacc_fname,
newacc_fname,
resk_fname,
indx_fname,
vwk_fname,
vnwk_fname,
checkvk_fname,
workopt_fname,
uiw_fname,
dec_fname,
perstat_fname,
genpers_fname,
rates_fname,
dump_fname,
lamprob_fname,
accprob_fname,
simopt_fname,
momout_fname);
fname_vec_type = array[file_type] of string(65);

m2_type = 0..3;
nnwk_type = 0..yrwk;

prob_type = array[1..12] of real;

am_type = array[alpn_type] of m_type;
aint_type = array[alpn_type] of integer;
areal_type = array[alpn_type] of real;
aalp_type = array[alpn_type] of alpn_type;
ak_type = array[alpn_type] of k_type;
 
belief_rec = record
    lamo, laml, lamj, lamr, lo, lr, lq, uew: areal_type;
end;

simrec= record
        m0: m_type;
        k: k_type;
        t: t1_type;
        n: t1_type;
        fn: 0..obs;
        end;   

firmrec= record
         m: alpn_type;
         k: k_type;
         e: eps_type;
         wn: 1..obs; (* worker number *)
         end;
        
         
firmnowrec = record
             num: 1..obs;
             end;
             
avail_type = array[1..obs] of 1..obs;
fstat_type = array[time_type,1..obs] of firmrec;
(* decstate_type = array[m_type,1..obs] of decnowrec;*)
state_type = array[time_type,1..obs] of simrec;
eco_type = array[1..mxperiod] of alpn_type;
emp_type = array[time_type,1..obs] of m2_type;
warr_type = array[time_type,1..obs] of real;  
rate_type = array[1..mxperiod] of real;
wage_type = array[k_type] of real;   
eparr_type = array[eps_type] of real;
corr_type = array[m2_type,m2_type] of real;
  (* ST ? t2_type = 0..yrwk2; *)(* this can be changed to 24 when n is
26 *)
      (* (n1max|m=0)=26 *)
      


dist_type = array[1..max_nw] of real;
dens_type = array[1..max_nw] of real;

job_type=array[1..obs] of integer;
dur_type=array[1..obs,1..4, 0..3] of integer;



