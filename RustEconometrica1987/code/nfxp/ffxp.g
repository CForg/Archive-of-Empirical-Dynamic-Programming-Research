/* FFXP.G: contraction mapping fixed point polyalgorithm
   Uses fast block elimination to perform Newton-Kantorovich iteration
   Version 3, October 2000. By John Rust, Yale University */

proc (0)=ffxp;

     local j,tt,nwt,tol,tol1,mm;

/* PHASE 1: CONTRACTION ITERATIONS */

      if pr;
      "   begin contraction iterations";
      endif;

      tt=hsec;
      nwt=0;
      j=0;
      tol1=1;

begin:
      j=j+2;

      ev1=contract(ev);
      ev=contract(ev1);

      tol=maxc(abs(ev-ev1));
      mm=tol/tol1;
      tol1=tol;

      if pr == 1;
         tol;; mm;; j;
      endif;

      if j >= cstp and nstep == 1;
         swj=j;
         nwt=0;
         if pr == 0;
               tol;; mm;; j;
         endif;

	 if pr;
         "   begin Newton-Kantorovich iterations at time";; hsec-tt;
	 endif;

         ev1=contract(ev);
         goto fin;

      endif;

      if tol < .1 or j >= cstp;
         goto newt;
      endif;

      if j >= mincstp and mm > bet*bet-rtol;
         goto newt;
      endif;

      goto begin;

/* PHASE 2: NEWTON-KANTOROVICH ITERATIONS */

newt:
      if pr == 2;
           tol;; mm;; j;
      endif;
      nwt=1;
      swj=j;

      if pr;
      "   begin Newton-Kantorovich iterations at time";; hsec-tt;
      endif;

      ev1=contract(ev);

qmat:
      pk=1/(1+exp(c-bet*(d*ev+(1-d)*ev1)-tr-c[1,1]+
      bet*(d*ev[1,1]+(1-d)*ev1[1,1])));
      ev1=ev-partsolv((ev-ev1));
      tol=maxc(abs(ev-ev1));

      ev=contract(ev1);

      if pr; tol;; endif;
      tol=maxc(abs(ev-ev1)); 
      if pr; tol;; endif;

      if tol < ltol or nwt > nstep;
           goto fin1;
      endif;

      nwt=nwt+1;

      pk=1/(1+exp(c-bet*(d*ev1+(1-d)*ev)-tr-c[1,1]+
      bet*(d*ev1[1,1]+(1-d)*ev[1,1])));
      ev=ev1-partsolv((ev1-ev));
      tol=maxc(abs(ev-ev1));

      ev1=contract(ev);

      if pr; tol;;  endif;
      tol=maxc(abs(ev-ev1)); 
      if pr; tol;;  endif;

      if tol < ltol or nwt > nstep;
            goto fin;
      else;
            nwt=nwt+1;
            goto qmat;
      endif;

/* PHASE 3: FINAL N-K STEP AND CALCULATION OF DERIVATIVES OF EV */

fin:
      nwt=nwt+1;
      pk=1/(1+exp(c-bet*(d*ev+(1-d)*ev1)-tr-c[1,1]+
      bet*(d*ev[1,1]+(1-d)*ev1[1,1])));

      if modnum[3] == 1;
           goto dv;
      endif;

      cdtp(ev);
dv:
      dev=(e(pk)-1)~(e(((dc[1,.]-dc).*pk))-dc[1,.]);
      if modnum[3:4] == 2|1;
           dev=dev~(-bet*(1-bet)*(ev[1,1]+e(((ev-ev[1,1]).*pk))))~
           dtp~(ev-ev1);
      elseif modnum[3:4] == 2|0;
           dev=dev~dtp~(ev-ev1);
      elseif modnum[3:4] == 1|0;
           dev=dev~(ev-ev1);
      elseif modnum[3:4] == 1|1;
           dev=dev~(-bet*(1-bet)*(ev[1,1]+e(((ev-ev[1,1]).*pk))))~
               (ev-ev1);
      endif;

      dev=partsolv(dev);
      ev1=ev-dev[.,dm-modnum[7]+1];
      tol=maxc(abs(ev-ev1));
      dev[.,1:dm-modnum[7]]=bet*dev[.,1:dm-modnum[7]];

      ev=contract(ev1);

      pk=1/(1+exp(c-bet*ev-tr-c[1,1]+bet*ev[1,1]));
      tol;; tol=maxc(abs(ev-ev1)); tol;

      goto term;

fin1:
      nwt=nwt+1;
      pk=1/(1+exp(c-bet*(d*ev1+(1-d)*ev)-tr-c[1,1]+
      bet*(d*ev1[1,1]+(1-d)*ev[1,1])));

      if modnum[3] == 1;
           goto dv1;
      endif;

      cdtp(ev1);
dv1:
      dev=(e(pk)-1)~(e(((dc[1,.]-dc).*pk))-dc[1,.]);

      if modnum[3:4] == 2|1;
            dev=dev~(-bet*(1-bet)*(ev1[1,1]+e(((ev1-ev1[1,1]).*pk))))~
                dtp~(ev1-ev);
      elseif modnum[3:4] == 2|0;
            dev=dev~dtp~(ev1-ev);
      elseif modnum[3:4] == 1|0;
            dev=dev~(ev1-ev);
      elseif modnum[3:4] == 1|1;
            dev=dev~(-bet*(1-bet)*(ev1[1,1]+e(((ev1-ev1[1,1]).*pk))))~
                (ev1-ev);
      endif;

      dev=partsolv(dev);
      ev=ev1-dev[.,dm-modnum[7]+1];
      tol=maxc(abs(ev-ev1));
      dev[.,1:dm-modnum[7]]=bet*dev[.,1:dm-modnum[7]];

      ev1=contract(ev);

      pk=1/(1+exp(c-bet*ev1-tr-c[1,1]+bet*ev1[1,1]));
      if pr; tol;; endif;
      tol=maxc(abs(ev-ev1)); 
      if pr; tol; endif;

      ev=ev1;
term:
      if pr; "   Fixed point time";; hsec-tt; endif;
endp;
