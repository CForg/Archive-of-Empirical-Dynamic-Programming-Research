/*EVAL.G: evaluation of likelihood function and its derivatives
  Version 4, October 2000. By John Rust, Yale University */

proc (0)=eval;

   local g;

  /* EVALUATE PROBABILITY OF KEEPING BUS ENGINE AT EACH SAMPLE POINT */

     lp=submat(pk,dt[.,2],0); if i < 0; goto bypass; endif;

  /* COMPUTE DERIVATIVES OF LOGLIKELIHOOD FUNCTION

      CASE 1: ESTIMATE FULL LIKELIHOOD BUT NOT bet */

     if modnum[3:4] == 2|0;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0)~zeros(nt,modnum[5]);

  /* CASE 2: ESTIMATE FULL LIKELIHOOD AND bet */

     elseif modnum[3:4] == 2|1;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0)~
            (-bet*(1-bet)*(ev[1,1]-submat(ev,dt[.,2],0)))~
            zeros(nt,modnum[5]);

  /* CASE 3: ESTIMATE PARTIAL LIKELIHOOD BUT NOT bet */

     elseif modnum[3:4] == 1|0;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0);

  /* CASE 4: ESTIMATE PARTIAL LIKELIHOOD AND bet */

     elseif modnum[3:4] == 1|1;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0)~
        (-bet*(1-bet)*(ev[1,1]-submat(ev,dt[.,2],0)));

     endif;

  /* ADD ON DERIVATIVES OF EXPECTED VALUE FUNCTION, BYPASS IF bet=0 */

     if bet == 0;

        d1v=d1v.*(lp-1+dt[.,1]);

        if modnum[3] == 2;
             g=dm-modnum[5]+1;
             d1v[.,g:dm]=submat(invp,(1+dt[.,3]),0);
        endif;

        goto cumulate;

     endif;

  /* FIRST TWO DERIVATIVES (tr,c1) ARE SAME FOR ALL MODELS */

     d1v[.,1:2]=(d1v[.,1:2]+dev[1,1:2].*ones(nt,1)-
                submat(dev[.,1:2],dt[.,2],0)).*(lp-1+dt[.,1]);

  /* DERIVATIVES FOR SUMMANDS OF PARTIAL LOGLIKELIHOOD FUNCTION */

     if modnum[3] == 1;

         g=3; do while g < dm+1;

            d1v[.,g]=((d1v[.,g]+dev[1,g].*ones(nt,1)-
                      submat(dev[.,g],dt[.,2],0)).*(lp-1+dt[.,1]));

         g=g+1; endo;

  /* DERIVATIVES FOR SUMMANDS OF FULL LOGLIKELIHOOD FUNCTION */

     elseif modnum[3] == 2;

         g=3; do while g < dm-modnum[5]+1;

            d1v[.,g]=((d1v[.,g]+dev[1,g].*ones(nt,1)-
                     submat(dev[.,g],dt[.,2],0)).*(lp-1+dt[.,1]));

         g=g+1; endo;

         g=dm-modnum[5]+1;

         d1v[.,g:dm]=((dev[1,g:dm].*ones(nt,1)-
                     submat(dev[.,g:dm],dt[.,2],0)).*(lp-1+dt[.,1]))+
                     submat(invp,(1+dt[.,3]),0);

     endif;

  /* CUMULATE DERIVATIVES AND LOGLIKELIHOOD VALUES OVER SAMPLE POINTS

     CUMULATE DERIVATIVES OF LOGLIKELIHOOD, dll */

cumulate:

     dll=dll+sumc(d1v);

  /* FULL LOGLIKELIHOOD CUMULATION */

bypass:

     if modnum[3] == 2;

        ll=ll+sumc(ln(lp+(1-2*lp).*dt[.,1])+
           submat(lnp,(1+dt[.,3]),0));

  /* PARTIAL LOGLIKELIHOOD CUMULATION */

     elseif modnum[3] == 1;

        ll=ll+sumc(ln(lp+(1-2*lp).*dt[.,1]));

     endif;

endp;
