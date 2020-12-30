
       
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


          (* index types for various arrays *)
      teams        =        (a,b);
      controls     =        (home,season,exper);
      sports       =        (baseball,basketball,hockey);
      ends         =        (lo,hi);
      dist_type    =        (normal,logit,uniform);
      run_option   =        (estimate,simulate,monte,boot,mboot);
      est_option   =        (structure,reduced,minchi);
      awn_type     =        0..mxawin;
      g_type       =        1..mxgames;
      alph_ind     =        1..npts;

      path_ind     =        0..mxpaths;
      
                         (* types for arrays *)


      game_type    =     array[g_type] of real;       (* games in series *)
      gamei_type   =     array[g_type] of integer;     (* integer values *)
      team_type    =     array[teams] of real;
      teami_type   =     array[teams] of awn_type;
      state_type   =     array[awn_type,awn_type] of real;  (* state space type *)
      sp_state_type=     array[sports] of state_type;

      beta_type    =     array[controls] of real;    (* control vector *)
      vbeta_type   =     array[sports] of beta_type;
      vparam_type  =     array[sports] of param_type;  (* parameters in all sports *)

            (*  data arrays *)
      rdata_type   =      array[obs_ind] of real;       (* real valued data *)
       
      idata_type   =      array[obs_ind] of integer;    (* integer valued data *)
      endpt_type   =      array[sports,ends] of integer;(* pointers to each sport *)
      isport_type  =     array[sports] of integer;
      rsport_type  =     array[sports] of real;

      grad_type = array[1..np] of rdata_type;

            (* quadrature types *)
      alph_type    =       array[alph_ind] of real;


            (* file names *)

      tsport_type = array[sports] of string(40);

      feas_type = packed array[path_ind] of boolean;
      path_type = array[path_ind] of real;
      allpath_type = array[sports] of path_type;

