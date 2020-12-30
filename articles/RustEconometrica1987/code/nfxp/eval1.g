/*EVAL1.G: evaluation of likelihood function and its derivatives
           EVAL1 differs from EVAL by the inclusion of the lagged
           dependent variable i(t-1)

  Version 4, October 2000. By John Rust, Yale University  */

proc (0)=eval1;

     local g,lp1;

   /*
     EVALUATE PROBABILITY OF KEEPING BUS ENGINE AT EACH SAMPLE POINT
   */

     if bet > 0;
         lp1=submat(1/(1+exp(c-bet*ev-tr-c[1,1]+
             bet*ev[1,1]+q[dm,1])),dt[.,2],0);
     else;
         lp1=submat(1/(1+exp(c-tr-c[1,1]+q[dm,1])),dt[.,2],0);
     endif;

     lp=submat(pk,dt[.,2],0);

     if i < 0; goto loglik; endif;

   /*
     COMPUTE DERIVATIVES OF LOGLIKELIHOOD FUNCTION

     *** CASE 1: ESTIMATE FULL LIKELIHOOD BUT NOT bet
   */

     if modnum[1,3:4] == 2~0;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0)~zeros(nt,modnum[1,5]);

   /*
     *** CASE 2: ESTIMATE FULL LIKELIHOOD AND bet
   */

     elseif modnum[1,3:4] == 2~1;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0)~
            (-bet*(1-bet)*(ev[1,1]-submat(ev,dt[.,2],0)))~
            zeros(nt,modnum[1,5]);

  /*
    *** CASE 3: ESTIMATE NEITHER PARTIAL LIKELIHOOD NOR bet
  */

     elseif modnum[1,3:4] == 1~0;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0);

  /*
    *** CASE 4: ESTIMATE PARTIAL LIKELIHOOD AND bet
  */

     elseif modnum[1,3:4] == 1~1;

        d1v=(-ones(nt,1))~submat(dc,dt[.,2],0)~
            (-bet*(1-bet)*(ev[1,1]-submat(ev,dt[.,2],0)));

     endif;

  /*
    CUMULATE LOGLIKELIHOOD FUNCTION

    *** FULL LOGLIKELIHOOD FUNCTION
  */

loglik:

    if modnum[1,3] == 2;

        ll=ll+sumc(ln((lp+(1-2*lp).*dt[.,1]).*dt[.,4]+
           (lp1+(1-2*lp1).*dt[.,1]).*
           (1-dt[.,4]))+submat(lnp,(1+dt[.,3]),0));

  /*
    *** PARTIAL LOGLIKELIHOOD FUNCTION
  */

    else;

        ll=ll+sumc(ln((lp+(1-2*lp).*dt[.,1]).*dt[.,4]+
           (lp1+(1-2*lp1).*dt[.,1]).*(1-dt[.,4])));

    endif;

    if i < 0; goto bypass; endif;

    lp1=((lp-1+dt[.,1]).*dt[.,4]+(lp1-1+dt[.,1]).*(1-dt[.,4]));

  /*
    ADD ON DERIVATIVES OF EXPECTED VALUE FUNCTION, BYPASS IF bet=0
  */

    if bet == 0;

        d1v=d1v.*lp1;

        if modnum[1,3] == 2;

            g=dm-modnum[1,5];
            d1v[.,g:dm-1]=submat(invp,(1+dt[.,3]),0);

        endif;

        goto cumulate;

    endif;

  /*
    FIRST TWO DERIVATIVES (tr,c1) ARE SAME FOR ALL MODELS
  */

    d1v[.,1:2]=(d1v[.,1:2]+dev[1,1:2].*ones(nt,1)-
               submat(dev[.,1:2],dt[.,2],0)).*lp1;

  /*
    DERIVATIVES FOR SUMMANDS OF PARTIAL LOGLIKELIHOOD FUNCTION
  */

    if modnum[1,3] == 1;

        g=3; do while g < dm;

             d1v[.,g]=(d1v[.,g]+dev[1,g].*ones(nt,1)-
                      submat(dev[.,g],dt[.,2],0)).*lp1;

        g=g+1; endo;

  /*
    DERIVATIVES FOR SUMMANDS OF FULL LOGLIKELIHOOD FUNCTION
  */

    elseif modnum[1,3] == 2;

        g=3; do while g < dm-modnum[1,5];

             d1v[.,g]=(d1v[.,g]+dev[1,g].*ones(nt,1)-
                      submat(dev[.,g],dt[.,2],0)).*lp1;

        g=g+1; endo;

        g=dm-modnum[1,5];

        d1v[.,g:dm-1]=(dev[1,g:dm-1].*ones(nt,1)-
                      submat(dev[.,g:dm-1],dt[.,2],0)).*lp1+
                      submat(invp,(1+dt[.,3]),0);

    endif;

  /*
    CUMULATE DERIVATIVES OF LOGLIKELIHOOD FUNCTION
  */

cumulate:

    d1v=d1v~((1-dt[.,4]).*lp1);
    dll=dll+sumc(d1v);

bypass:

endp;
