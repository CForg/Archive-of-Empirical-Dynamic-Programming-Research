C ==================================================================
C This function generates uniform random number from (0,1)
C ==================================================================
        function ran1(idum)
        INTEGER idum,IA,IM,IQ,IR,NTAB,NDIV
        DOUBLE PRECISION ran1,AM,EPS,RNMX
        PARAMETER (IA=16807,IM=2147483647,AM=1.0D0/DBLE(IM))
        PARAMETER (IQ=127773,IR=2836,NTAB=32,NDIV=1+(IM-1)/NTAB)
        PARAMETER (EPS = 1.0D-12, RNMX=1.0D0-EPS)

        INTEGER j,k,iv(NTAB),iy
        SAVE    iv,iy
        DATA    iv /NTAB*0/, iy /0/

        if (idum .le. 0 .or. iy .eq. 0) then
          idum = max(-idum,1)
           do j = NTAB+8,1,-1
            k = idum/IQ
            idum=IA*(idum-k*IQ)-IR*k
            if (idum .lt. 0) idum=idum+IM
            if (j .le. NTAB) iv(j) = idum
           end do
           iy = iv(1)
        end if
           k = idum/IQ
           idum = IA*(idum-k*IQ)-IR*k
           if (idum .lt. 0) idum=idum+IM
           j = 1+iy/NDIV
           iy = iv(j)
           iv(j) = idum
           ran1 = min(AM*iy,RNMX)

           return
           end



C From Leonard J. Moss of SLAC:

C Here's a hybrid QuickSort I wrote a number of years ago.  It's
C based on suggestions in Knuth, Volume 3, and performs much better
C than a pure QuickSort on short or partially ordered input arrays.

      SUBROUTINE sortrx(N,DATA,INDEX)
C===================================================================
C
C     SORTRX -- SORT, Real input, indeX output
C
C
C     Input:  N     INTEGER
C             DATA  REAL
C
C     Output: INDEX INTEGER (DIMENSION N)
C
C This routine performs an in-memory sort of the first N elements of
C array DATA, returning into array INDEX the indices of elements of
C DATA arranged in ascending order.  Thus,
C
C    DATA(INDEX(1)) will be the smallest number in array DATA;
C    DATA(INDEX(N)) will be the largest number in DATA.
C
C The original data is not physically rearranged.  The original order
C of equal input values is not necessarily preserved.
C
C===================================================================
C
C===================================================================
C
C SORTRX uses a hybrid QuickSort algorithm, based on several
C suggestions in Knuth, Volume 3, Section 5.2.2.  In particular, the
C "pivot key" [my term] for dividing each subsequence is chosen to be
C the median of the first, last, and middle values of the subsequence;
C and the QuickSort is cut off when a subsequence has 9 or fewer
C elements, and a straight insertion sort of the entire array is done
C at the end.  The result is comparable to a pure insertion sort for
C very short arrays, and very fast for very large arrays (of order 12
C micro-sec/element on the 3081K for arrays of 10K elements).  It is
C also not subject to the poor performance of the pure QuickSort on
C partially ordered data.
C
C Created:  15 Jul 1986  Len Moss
C
C===================================================================

      INTEGER   N,INDEX(N)
      double precision      DATA(N)

      INTEGER   LSTK(31),RSTK(31),ISTK
      INTEGER   L,R,I,J,P,INDEXP,INDEXT
      double precision      DATAP

C     QuickSort Cutoff
C
C     Quit QuickSort-ing when a subsequence contains M or fewer
C     elements and finish off at end with straight insertion sort.
C     According to Knuth, V.3, the optimum value of M is around 9.

      INTEGER   M
      PARAMETER (M=9)


C===================================================================
C
C     Make initial guess for INDEX

      DO 50 I=1,N
         INDEX(I)=I
   50    CONTINUE

C     If array is short, skip QuickSort and go directly to
C     the straight insertion sort.

      IF (N.LE.M) GOTO 900

C===================================================================
C
C     QuickSort
C
C     The "Qn:"s correspond roughly to steps in Algorithm Q,
C     Knuth, V.3, PP.116-117, modified to select the median
C     of the first, last, and middle elements as the "pivot
C     key" (in Knuth's notation, "K").  Also modified to leave
C     data in place and produce an INDEX array.  To simplify
C     comments, let DATA[I]=DATA(INDEX(I)).

C Q1: Initialize
      ISTK=0
      L=1
      R=N
  200 CONTINUE

C Q2: Sort the subsequence DATA[L]..DATA[R].
C
C     At this point, DATA[l] <= DATA[m] <= DATA[r] for all l < L,
C     r > R, and L <= m <= R.  (First time through, there is no
C     DATA for l < L or r > R.)

      I=L
      J=R

C Q2.5: Select pivot key
C
C     Let the pivot, P, be the midpoint of this subsequence,
C     P=(L+R)/2; then rearrange INDEX(L), INDEX(P), and INDEX(R)
C     so the corresponding DATA values are in increasing order.
C     The pivot key, DATAP, is then DATA[P].

      P=(L+R)/2
      INDEXP=INDEX(P)
      DATAP=DATA(INDEXP)

      IF (DATA(INDEX(L)) .GT. DATAP) THEN
         INDEX(P)=INDEX(L)
         INDEX(L)=INDEXP
         INDEXP=INDEX(P)
         DATAP=DATA(INDEXP)
      ENDIF
      IF (DATAP .GT. DATA(INDEX(R))) THEN
         IF (DATA(INDEX(L)) .GT. DATA(INDEX(R))) THEN
            INDEX(P)=INDEX(L)
            INDEX(L)=INDEX(R)
         ELSE
            INDEX(P)=INDEX(R)
         ENDIF
         INDEX(R)=INDEXP
         INDEXP=INDEX(P)
         DATAP=DATA(INDEXP)
      ENDIF

C     Now we swap values between the right and left sides and/or
C     move DATAP until all smaller values are on the left and all
C     larger values are on the right.  Neither the left or right
C     side will be internally ordered yet; however, DATAP will be
C     in its final position.

  300 CONTINUE

C Q3: Search for datum on left >= DATAP
C
C     At this point, DATA[L] <= DATAP.  We can therefore start scanning
C     up from L, looking for a value >= DATAP (this scan is guaranteed
C     to terminate since we initially placed DATAP near the middle of
C     the subsequence).

         I=I+1
         IF (DATA(INDEX(I)).LT.DATAP) GOTO 300

  400 CONTINUE

C Q4: Search for datum on right <= DATAP
C
C     At this point, DATA[R] >= DATAP.  We can therefore start scanning
C     down from R, looking for a value <= DATAP (this scan is guaranteed
C     to terminate since we initially placed DATAP near the middle of
C     the subsequence).

         J=J-1
         IF (DATA(INDEX(J)).GT.DATAP) GOTO 400

C Q5: Have the two scans collided?

      IF (I.LT.J) THEN

C Q6: No, interchange DATA[I] <--> DATA[J] and continue

         INDEXT=INDEX(I)
         INDEX(I)=INDEX(J)
         INDEX(J)=INDEXT
         GOTO 300
      ELSE

C Q7: Yes, select next subsequence to sort
C
C     At this point, I >= J and DATA[l] <= DATA[I] == DATAP <= DATA[r],
C     for all L <= l < I and J < r <= R.  If both subsequences are
C     more than M elements long, push the longer one on the stack and
C     go back to QuickSort the shorter; if only one is more than M
C     elements long, go back and QuickSort it; otherwise, pop a
C     subsequence off the stack and QuickSort it.
         IF (R-J .GE. I-L .AND. I-L .GT. M) THEN
            ISTK=ISTK+1
            LSTK(ISTK)=J+1
            RSTK(ISTK)=R
            R=I-1
         ELSE IF (I-L .GT. R-J .AND. R-J .GT. M) THEN
            ISTK=ISTK+1
            LSTK(ISTK)=L
            RSTK(ISTK)=I-1
            L=J+1
         ELSE IF (R-J .GT. M) THEN
            L=J+1
         ELSE IF (I-L .GT. M) THEN
            R=I-1
         ELSE
C Q8: Pop the stack, or terminate QuickSort if empty
            IF (ISTK.LT.1) GOTO 900
            L=LSTK(ISTK)
            R=RSTK(ISTK)
            ISTK=ISTK-1
         ENDIF
         GOTO 200
      ENDIF

  900 CONTINUE
C===================================================================
C
C Q9: Straight Insertion sort

      DO 950 I=2,N
         IF (DATA(INDEX(I-1)) .GT. DATA(INDEX(I))) THEN
            INDEXP=INDEX(I)
            DATAP=DATA(INDEXP)
            P=I-1
  920       CONTINUE
               INDEX(P+1) = INDEX(P)
               P=P-1
               IF (P.GT.0) THEN
                  IF (DATA(INDEX(P)).GT.DATAP) GOTO 920
               ENDIF
            INDEX(P+1) = INDEXP
         ENDIF
  950    CONTINUE
C===================================================================
C
C     All done

      END


C =====================================================================
C This function generates the standard normal variable.
C =====================================================================
           function gasdev(idum)
           integer idum
           double precision gasdev
           integer, dimension(1) :: old, seed
           integer :: i,k
           integer iset
           double precision fac, gest, rsq, rsq1
           double precision v1, v2, ran1
           save iset, gset
           data iset/0/

           if (iset .eq. 0) then
 1          v1 = 2.0D0*ran1(idum)-1.0D0
            v2 = 2.0D0*ran1(idum)-1.0D0
            rsq = v1*v1+v2*v2
            if (rsq .ge. 1.0D0 .or. rsq .eq. 0.0D0) goto 1
            fac = dsqrt(-2.0D0*dlog(rsq)/rsq)
            gset = v1*fac
            gasdev = v2*fac
            iset = 1
           else
            gasdev = gset
            iset = 0
           end if
           return
           end

C =====================================================================
C This subroutine computes the distribution probabilities of
C standard normal.
C =====================================================================
        SUBROUTINE dnormp(Z, P, Q, PDF)
C
C       Normal distribution probabilities accurate to 1.e-15.
C       Z = no. of standard deviations from the mean.
C       P, Q = probabilities to the left & right of Z.   P + Q = 1.
C       PDF = the probability density.
C
C       Based upon algorithm 5666 for the error function, from:
C       Hart, J.F. et al, 'Computer Approximations', Wiley 1968
C
C       Programmer: Alan Miller
C
C       Latest revision - 30 March 1986
C
        IMPLICIT DOUBLE PRECISION (A-H, O-Z)
        DATA P0, P1, P2, P3, P4, P5, P6/220.20 68679 12376 1D0,
     *    221.21 35961 69931 1D0, 112.07 92914 97870 9D0,
     *    33.912 86607 83830 0D0, 6.3739 62203 53165 0D0,
     *    .70038 30644 43688 1D0, .35262 49659 98910 9D-01/,
     *    Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7/440.41 37358 24752 2D0,
     *    793.82 65125 19948 4D0, 637.33 36333 78831 1D0,
     *    296.56 42487 79673 7D0, 86.780 73220 29460 8D0,
     *    16.064 17757 92069 5D0, 1.7556 67163 18264 2D0,
     *    .88388 34764 83184 4D-1/,
     *    CUTOFF/7.071D0/, ROOT2PI/2.5066 28274 63100 1D0/
C
C
        ZABS = ABS(Z)
C
C       |Z| > 37.
C
        IF (ZABS .GT. 37.D0) THEN
          PDF = 0.D0
          IF (Z .GT. 0.D0) THEN
            P = 1.D0
            Q = 0.D0
          ELSE
            P = 0.D0
            Q = 1.D0
          END IF
          RETURN
        END IF
C
C       |Z| <= 37.
C
        EXPNTL = EXP(-0.5D0*ZABS**2)
        PDF = EXPNTL/ROOT2PI
C
C       |Z| < CUTOFF = 10/sqrt(2).
C
        IF (ZABS .LT. CUTOFF) THEN
          P = EXPNTL*((((((P6*ZABS + P5)*ZABS + P4)*ZABS + P3)*ZABS +
     *          P2)*ZABS + P1)*ZABS + P0)/(((((((Q7*ZABS + Q6)*ZABS +
     *          Q5)*ZABS + Q4)*ZABS + Q3)*ZABS + Q2)*ZABS + Q1)*ZABS +
     *          Q0)
C
C       |Z| >= CUTOFF.
C
        ELSE
          P = PDF/(ZABS + 1.D0/(ZABS + 2.D0/(ZABS + 3.D0/(ZABS + 4.D0/
     *          (ZABS + 0.65D0)))))
        END IF
C
        IF (Z .LT. 0.D0) THEN
          Q = 1.D0 - P
        ELSE
          Q = P
          P = 1.D0 - Q
        END IF
        RETURN
        END


C		    Use numerical_libraries
C =======================================================================
C This program estimates the Dynamic Programming model of one firm
C entry and exit model using the Bayesian Markov Chain Monte Carlo
C Method. 
C =======================================================================
	  implicit double precision (a-h,o-z), integer (i-n)
	   parameter (ndata   = 10000)
	   parameter (ngibb   = 10000)
	   parameter (niw     = 200)
	   parameter (riw     = 5.0D0)
	   parameter (npar    = 20)
	   parameter (nvprior = 10)
	   parameter (np1     = 9)
           parameter (nsim1   = 10)
           parameter (nperm   = 2000)
           parameter (nperm1  = 2000)
           parameter (nperm2  = 2000)
           parameter (ntperm1 = 3000)
           parameter (ntperm2 = 5000)
	   parameter (dpi     = 3.14159265D0)
           parameter (hkern1 = 4.0D-4)
           parameter (hkern2 = 4.0D-4)
           parameter (hkern3 = 4.0D-4)
	   parameter (hkern4 = 4.0D-4)
	   parameter (hkern5 = 4.0D-4)
	   parameter (hkern6 = 4.0D-4)
           parameter (hkern7 = 4.0D-4)
	   parameter (hkern8 = 4.0D-4)
	   parameter (hkern9 = 4.0D-4)
	   parameter (enprior = 4.0D-1)
	   parameter (enprec  = 0.0D-1 )
	   parameter (exprior = 4.0D-1)
	   parameter (exprec  = 0.0D-1 )
	   parameter (b1prior = 1.0D-1)
	   parameter (b1prec  = 5.0D-1)
	   parameter (b2prior = 1.0D-1)
	   parameter (b2prec  = 5.0D-1)

	   parameter (sigent    = 4.0D-3)
	   parameter (siga      = 4.0D-3)
	   parameter (sigb1     = 4.0D-3)
	   parameter (sigb2     = 4.0D-3)
	   parameter (sigbe     = 4.0D-3)
	   parameter (sigsigma1 = 4.0D-3)
	   parameter (sigsigma2 = 4.0D-3)
	   parameter (sigsigmaw = 4.0D-3)

           real time0, time1, ddtime, timem
           real etime, elapsed(2), total

	   dimension par(npar)      
           dimension aparam(npar)
           dimension bparam(npar)
           dimension sparam(npar)
	   dimension iw(ndata)
	   dimension iwf(ndata)
	   dimension rk(ndata)
	   dimension rkf(ndata)
	   dimension profit(ndata)
	   dimension remax(0:niw)
	   dimension remaxo(0:niw)
           dimension emaxm(0:niw)
           dimension icheck(0:ngibb)
	   dimension ftranm(niw,niw)
	   dimension ftranem(niw)
	   dimension wgrid(niw)
	   dimension ffm(niw)
	   dimension rthreshm(ndata)
	   dimension rthreshmold(ndata)
	   dimension yy(ndata,3)
	   dimension xx(ndata)
	   dimension yyp(ndata)
	   dimension xxp(ndata)
	   dimension yyk(ndata)
	   dimension xxk(ndata,2)
	   dimension yye(ndata)
	   dimension xxe(ndata)
	   dimension param(0:ngibb,npar)
	   dimension rdkern(0:ngibb)
	   dimension value(0:niw,0:ngibb)
           dimension fsumm(0:niw)

           integer, dimension(1) :: old, seed

           dimension sh(nsim1,2)
           dimension ra(nperm)
           dimension rb(nperm)
           dimension iperm(nperm)
           dimension ra1(nperm1)
           dimension rb1(nperm1)
           dimension iperm1(nperm1)
           dimension ra2(nperm2)
           dimension rb2(nperm2)
           dimension iperm2(nperm2)
	   dimension dvnew(ndata)
	   dimension dvold(ndata)
	   dimension depsm(ndata)
	   dimension depsold(ndata)

           iseed = -1283
           vv = rand(iseed)

	   do iw1 = 1, niw
		wgrid(iw1) = riw*dble(iw1)/dble(niw)
	   end do
C ========================================================
C Read in the data. 
C ========================================================

	  open (unit = 500, file = 'bcheck.out')
	  open (unit = 600, file = 'bvalue.out')

	  open (unit = 100, file = 'sim.out')
	   do idata = 1, 2000
	     read (100,*) 
	   end do
	   do idata = 1, ndata
	      read (100,*) idata1,iw1,iwf1,rk1,rkf1,profit1
	      iw(idata)     = iw1
	      iwf(idata)    = iwf1
	      rk(idata)     = min(rk1,riw)
	      rkf(idata)    = min(rkf1,riw)
	      profit(idata) = profit1
	   end do
	  close (100)

C	   do idata = 1, ndata
C	      write (500,*) iw(idata),iwf(idata)
C     +			   ,rk(idata),rkf(idata)
C	   end do

C -----------------------------------------------------------
C Read in the emax function. 
C -----------------------------------------------------------
	  open (unit = 102, file = 'value.out')
	       read (102,*) inum,remax(0)
	     do iw1 = 1, niw
	       read (102,*) inum,rnum,remax(iw1)
	     end do
	  close (102)

	     write (500,*) '--- value functions ---'
	       do iw1 = 0, niw
		write (500,*) iw1, remax(iw1)
	       end do

	  do iw1 = 0, niw
	    remaxo(iw1) = 1.0D0*remax(iw1)
	    remax(iw1)  = 0.0D0*remax(iw1)
	  end do

	  open (unit = 50, file = 'input.dat')
	    do ip1 = 1, np1
	      read (50,*) 
	      read (50,*) 
	      read (50,*)
	      read (50,*) par(ip1)
	    end do
	  close (50)

             atrue    = par(1)
             entrue   = par(2)
             s1true   = par(3)
             s2true   = par(4)
             swtrue   = par(5)
             beta0    = par(6)
             b1true   = par(7)
             b2true   = par(8)       
	     betrue   = par(9)

              scale = 5.0D-1

	       ast      = scale*atrue
	       entst    = scale*entrue  
	       beta1st  = scale*b1true
	       beta2st  = scale*b2true
	       sigma1st = scale*s1true
	       sigma2st = scale*s2true
	       sigmawst = scale*swtrue
	       betaest  = scale*betrue

	     print *, ast, entst
	     print *, sigma1st,sigma2st,sigmawst
	     print *, beta0, beta1st, beta2st
	     print *, betaest

	     a       = ast
	     enter   = entst
	     beta1   = beta1st
	     beta2   = beta2st
	     betae   = betaest
	     sigma1  = sigma1st
	     sigma2  = sigma2st
	     sigmaw  = sigmawst

             param(0,1) = entst
             param(0,2) = ast
             param(0,3) = beta1st
             param(0,4) = beta2st
             param(0,5) = sigmawst
             param(0,6) = sigma1st
             param(0,7) = sigma2st
	     param(0,8) = betaest


	 sigmatst = dsqrt(sigma1st*sigma1st+sigma2st*sigma2st)
     

	  open (unit = 302, file = 'bayes1283.out')

          total = etime(elapsed)
          time0 = elapsed(1)
C	  time0 = cpsec()

	  print *, 'time0 = ',time0

	  do 1000 igibb = 1, ngibb

             print *,'igibb = ', igibb

                entst     = param(igibb-1,1)
                ast       = param(igibb-1,2)
                beta1st   = param(igibb-1,3)
                beta2st   = param(igibb-1,4)
                sigmawst  = param(igibb-1,5)
                sigma1st  = param(igibb-1,6)
                sigma2st  = param(igibb-1,7)
		betaest   = param(igibb-1,8)

C --------------------------------------------------------------
C Derive expected value function for entrant. 
C   emaxe(thetast)
C --------------------------------------------------------------
		        fsum = 0.0D0
                do iwf1 = 1, niw
                  ff        = dlog(wgrid(iwf1))-betaest
                  ff        = dlog(wgrid(iwf1))
     +                        +ff*ff/(2.0D0*sigmawst*sigmawst)
                  ffm(iwf1) = dexp(-ff)
                  fsum      = fsum+ffm(iwf1)
                end do

                  emaxe = 0.0D0
                do iwf1 = 1, niw
                  ff = ffm(iwf1)/fsum
                  emaxe = emaxe+remax(iwf1)*ff
                end do

                
	        sigmat = dsqrt(sigma1*sigma1+sigma2*sigma2)
                sigmatst = dsqrt(sigma1st*sigma1st+sigma2st*sigma2st)
C ==============================================================
C This is the data augmentation step for profit equation.
C using the candidate parameter thetast. 
C ==============================================================
	      adeps   = 0.0D0
	      ideps   = 0
	      nwd     = 0
	      pnew    = 0.0D0
	      pold    = 0.0D0
	   do idata = 1, ndata
C             if (igibb .ge. 1984) print *, 'idata = ', idata
	        iwd     = iw(idata)
	        iwfd    = iwf(idata)
	        rkd     = rk(idata)
	        rkfd    = rkf(idata)
	        profitd = profit(idata)

		 if (iwd .eq. 1 .and. iwfd .eq. 1) then
		   nwd = nwd+1
		 end if
C ------------------------------------------------------------
C For the incumbent firm, that is, for firms that
C  iw => 0, 
C either it stays in business (iwf =>0) or exits (iwf=-1).
C ------------------------------------------------------------
	     if (iwd .eq. 1) then

	          fsum = 0.0D0
	        do iwf1 = 1, niw
		       ff   = dlog(wgrid(iwf1))
     +			     -beta1st-beta2st*dlog(rkd)
		       ff   = dlog(wgrid(iwf1))
     +			      +ff*ff/(2.0D0*sigmawst*sigmawst)
	           ffm(iwf1) = dexp(-ff)
		       fsum = fsum+ffm(iwf1)
	        end do

	          emax1 = 0.0D0
	        do iwf1 = 1, niw
		      ff = ffm(iwf1)/fsum
		      emax1 = emax1+remax(iwf1)*ff
	        end do
		      emax0 = remax(0)

             if (iwfd .eq. 1) then
	        rthin    = profitd+beta0*emax1
	        sigm     = sigma2
	        sigmst   = sigma2st
	       else if (iwfd .eq. 0) then
	        rthin    = ast*rkd+beta0*emax1
	        sigm     = sigmat
	        sigmst   = sigmatst
	       end if

	        rthout   = beta0*emax0
	        rthresh0 = rthout-rthin
		rthreshm(idata) = rthresh0



C		write (500,'(I5,1X,6(F10.6,1X))')
C     +		 idata,rkd,emax1,emax0,rthin,rthout,rthresh0

	      else if (iwd .eq. 0) then

		    emax1    = emaxe
		    emax0    = remax(0)
		    rthin    = -entst+beta0*emax1
	            sigm     = sigmat
	            sigmst   = sigmatst
		    rthout   = beta0*emax0
		    rthresh0 = rthout-rthin
		    rthreshm(idata) = rthresh0


C               write (500,'(I5,1X,6(F10.6,1X))') 
C     +		  idata,rkd,emax1,emax0,rthin,rthout,rthresh0

	      end if
C ------------------------------------------------------------
C rthresh(theta(m))  : normalized threshold
C rpthresh(theta(m)) : probability of the threshold.
C                      Prob[r <= rthresh(theta(m))]
C ------------------------------------------------------------
                if (igibb .eq. 1) then
	            rthreshmold(idata) = rthreshm(idata)
	          end if
	          rthresh  = rthreshmold(idata)/sigm

	          rthreshst = rthreshm(idata)/sigmst

                  call dnormp(rthresh,pl,pr,pdf)
	          rpthresh = pl
                  call dnormp(rthreshst,pl,pr,pdf)
	          rpthreshst = pl
C -------------------------------------------------------------
C draw deps = epsilon1 - epsilon2
C -------------------------------------------------------------

C		  write (500,*) rthresh0, rthresh, rpthresh

	       if (iwfd .eq. 1) then
	          rprob   = 1.0D0-rpthresh
	          rprobst = 1.0D0-rpthreshst
	       else if (iwfd .eq. 0) then
	          rprob   = rpthresh
	          rprobst = rpthreshst
	       end if

C -------------------------------------------------------------------
C Data augmented differenced value function. 
C   dvnew(theta(m)) = valuein(theta(m))-valueout(theta(m))
C -------------------------------------------------------------------

C ---------------------------------------------------------------
C Data augmentation on profits. Use the old parameters. 
C  profit(theta(m)) = a(m)*k + eps1(theta(m)) 
C ---------------------------------------------------------------
           if (iwd .eq. 1) then
		   if (iwfd .eq. 1) then
		     yyp(idata) = profitd
		     xxp(idata) = rkd
		   end if
	     end if

	       if (iwd .eq. 1 .and. iwfd .eq. 1) then
	         yyk(idata)   = dlog(rkfd)
		     xxk(idata,1) = 1.0D0
		     xxk(idata,2) = dlog(rkd)
	       else
                 yyk(idata)   = 0.0D0
                 xxk(idata,1) = 0.0D0
                 xxk(idata,2) = 0.0D0   
	       end if

C -----------------------------------------------------------
C Now,we estimate parameters based on the Random walk
C Metropolis-Hastings. f(thetast) 
C -----------------------------------------------------------

	       if (iwd .eq. 0) then
	         yy(idata,2) = 0.0D0
	        if (iwfd .eq. 1) then
	         yy(idata,3) = dlog(rkfd) - betaest
	        end if
	       else if (iwd .eq. 1) then
	         yy(idata,2) = yyp(idata) - ast*xxp(idata)
	        if (iwfd .eq. 1) then
	         yy(idata,3) = dlog(rkfd) - beta1st - beta2st*dlog(rkd)
	        end if
	       end if

		     padd = dlog(rprobst) 
	       if (iwd .eq. 1 .and. iwfd .eq. 1) then
	         padd = padd
     +             -5.0D-1*dlog(2.0D0*dpi)-dlog(sigma1st)
     +             -5.0D-1*yy(idata,2)*yy(idata,2)/(sigma1st*sigma1st)
	       end if

             if (iwfd .eq. 1) then
               padd = padd-dlog(rkfd)
     +              +5.0D-1*dlog(2.0D0*dpi)-dlog(sigmawst)
     +			  -5.0D-1*yy(idata,3)*yy(idata,3)/(sigmawst*sigmawst)  
             end if

               pnew = pnew+padd


	       if (iwd .eq. 0) then
	         yy(idata,2) = 0.0D0
	       if (iwfd .eq. 1) then
	         yy(idata,3) = dlog(rkfd) - betae
	       end if
	       else if (iwd .eq. 1) then
	         yy(idata,2) = yyp(idata) - a*xxp(idata)
		   if (iwfd .eq. 1) then
	         yy(idata,3) = dlog(rkfd) - beta1 - beta2*dlog(rkd)
	       end if
	       end if


		     padd = dlog(rprob) 
	       if (iwd .eq. 1 .and. iwfd .eq. 1) then
	         padd = padd
     +             -5.0D-1*dlog(2.0D0*dpi)-dlog(sigma1)
     +             -5.0D-1*yy(idata,2)*yy(idata,2)/(sigma1*sigma1)
	       end if

             if (iwfd .eq. 1) then
               padd = padd-dlog(rkfd)
     +              +5.0D-1*dlog(2.0D0*dpi)-dlog(sigmaw)
     +			  -5.0D-1*yy(idata,3)*yy(idata,3)/(sigmaw*sigmaw)  
             end if

               pold = pold+padd
C -------------------------------------------------------------
C end do of    do idata = 1, ndata
C -------------------------------------------------------------
	   end do
             
C	   close (500)
C	   pause
C -------------------------------------------------------------
C Calculate the next iteration parameters of the Metropolis-
C Hastings algorithm. 
C ------------------------------------------------------------- 
           if (igibb .gt. 1) then
	         phast = dexp(min(pnew-pold,1.0D0))
                   hast = ran1(iseed)
              if (hast .le. phast .or. igibb .le. 2
     +           .or. irep .gt. 200) then
                 irep     = 0
	         enter    = entst
	         a        = ast
	         beta1    = beta1st
	         beta2    = beta2st
	         betae    = betaest
	         sigma1   = sigma1st
	         sigma2   = sigma2st
	         sigmaw   = sigmawst
	         dvold    = dvnew
	         depsold  = depsm
	         rthreshmold = rthreshm
              else
                 irep = irep+1 
	      end if
	    end if

C --------------------------------------------------------------
C Derive the candidate distribution for Metropolis Hastings
C algorithm. 
C --------------------------------------------------------------
                pchange = 1.0D0
              if (ran1(iseed) .le. pchange) then 
                entst     = enter  +sigent*gasdev(iseed)
              else
                entst     = enter
              end if

              if (ran1(iseed) .le. pchange) then
	        ast       = a      +siga*gasdev(iseed)
              else
                ast       = a
              end if

              if (ran1(iseed) .le. pchange) then
	        beta1st   = beta1  +sigb1*gasdev(iseed)
              else
                beta1st   = beta1
              end if

              if (ran1(iseed) .le. pchange) then
	        beta2st   = beta2  +sigb2*gasdev(iseed)
              else
                beta2st   = beta2
              end if

              if (ran1(iseed) .le. pchange) then
	        betaest   = betae  +sigbe*gasdev(iseed)
              else
                betaest   = betae
              end if

              if (ran1(iseed) .le. pchange) then
	        sigma1st  = dlog(sigma1) +sigsigma1*gasdev(iseed)
	        sigma1st  = dexp(sigma1st)
              else
                sigma1st  = sigma1
              end if

              if (ran1(iseed) .le. pchange) then
	        sigma2st  = dlog(sigma2) +sigsigma2*gasdev(iseed)
	        sigma2st  = dexp(sigma2st)
              else
                sigma2st  = sigma2
              end if

              if (ran1(iseed) .le. pchange) then
	        sigmawst  = dlog(sigmaw) +sigsigmaw*gasdev(iseed)
	        sigmawst  = dexp(sigmawst)
              else
                sigmawst  = sigmaw
              end if

C             print *, 'entst    = ', enter, entst, entrue
C	      print *, 'ast      = ', a, ast, atrue
C	      print *, 'beta1    = ', beta1, beta1st, b1true
C	      print *, 'beta2    = ', beta2, beta2st, b2true
C             print *, 'betae    = ', betae, betaest, betrue
C	      print *, 'sigma1st = ', sigma1, sigma1st, s1true
C             print *, 'sigma2st = ', sigma2, sigma2st, s2true
C	      print *, 'sigmatst = ', sigmat, sigmatst
C	      print *, 'sigmawst = ', sigmaw, sigmawst, swtrue
C	      print *, 'pnew     = ', pnew
C	      print *, 'pold     = ', pold
           
C	     enter  = entrue
C	     a      = atrue
C	     b1     = b1true
C	     b2     = b2true
C	     sigma1 = s1true
C          sigma2 = s2true 
C		 sigmaw = swtrue
C		 betae  = betrue       

	     print *, 'igibb 1 = ', igibb
C	     print *, 'sigma = ', sigma1, sigma12, sigma2
C	     print *, 'enter = ', enter, a
C	     print *, 'beta = ', beta1, beta2,betae,sigmaw


	   if (igibb .le. 0) then

	     param(igibb,1) = entrue	
	     param(igibb,2) = atrue
	     param(igibb,3) = b1true
	     param(igibb,4) = b2true
	     param(igibb,5) = swtrue
	     param(igibb,6) = s1true
             param(igibb,7) = s2true 
	     param(igibb,8) = betrue

             enter  = entrue
             a      = atrue
             beta1  = b1true
             beta2  = b2true
             sigmaw = swtrue
             sigma1 = s1true
             sigma2 = s2true
             betae  = betrue
	   else

             param(igibb,1) = entst
             param(igibb,2) = ast
             param(igibb,3) = beta1st
             param(igibb,4) = beta2st
	     param(igibb,5) = sigmawst
	     param(igibb,6) = sigma1st
	     param(igibb,7) = sigma2st
	     param(igibb,8) = betaest

	   end if

             time1 = time0
             total = etime(elapsed)
             time0 = elapsed(1)
C             time0 = cpsec()

             ddtime = time0-time1
             timem  = time0/6.0D1


	   write (302,'(1(I6,1X),8(F12.8,1X),2(1X,F9.4))')
     +		igibb,enter,a,sigma1,sigma2
     +		,beta1,beta2,betae,sigmaw,timem,ddtime

          do int2 = 1, nperm
            ra(int2) = -1.0D4-dble(int2)
          end do
          do int2 = 1, nperm1
            ra1(int2) = -1.0D4-dble(int2)
          end do
          do int2 = 1, nperm2
            ra2(int2) = -1.0D4-dble(int2)
          end do

          do int2 = 1, nperm
            iperm(int2) = int2
          end do

          do int2 = 1, nperm1
            iperm1(int2) = int2
          end do

          do int2 = 1, nperm2
            iperm2(int2) = int2
          end do

          if (igibb .le. nperm+1) then
             nint0 = igibb-1
          else if (igibb .le. ntperm1) then
             nint0 = nperm
          else if (igibb .le. ntperm2) then
             nint0 = nperm1
          else
             nint0 = nperm2
          end if

	  if (igibb .gt. 1) then
              int0        = max(igibb-nint0,1)
	  do int1 = igibb-1, int0, -1
                  icheck(int1) = 1
                  if (igibb .le. 3000) then
                     weight0 = 1.0D0
                  else
                     weight0 = 1.0D0
                  end if       
                  if (int1 .gt. 0) then
                    enter1  = param(int1,1)
                    a1      = param(int1,2)
                    beta11  = param(int1,3)
                    beta21  = param(int1,4)
                    sigmaw1 = param(int1,5)
                    sigma11 = param(int1,6)
                    sigma12 = param(int1,7)
		    betae1  = param(int1,8)      
                  else
                    enter1  = entrue
                    a1      = atrue
                    beta11  = b1true
                    beta21  = b2true
                    sigmaw1 = swtrue
                    sigma11 = s1true
                    sigma12 = s2true
		    betae1  = betrue
                  end if            

C ----------------------------------------------------------
C Derive the weighted average value function to get the
C Emax function.
C ----------------------------------------------------------
C		weight  = 2.0D1/( 2.0D1+dlog(dble(nint0)) )
                weight  = 1.0D0
		hkerns1 = hkern1*weight
		hkerns2 = hkern2*weight
		hkerns3 = hkern3*weight
		hkerns4 = hkern4*weight
		hkerns5 = hkern5*weight
		hkerns6 = hkern6*weight
		hkerns7 = hkern7*weight
		hkerns8 = hkern8*weight
          rkern11 = (entst-enter1)*(entst-enter1)/hkerns1
          rkern21 = (ast - a1)*(ast - a1)/hkerns2
          rkern31 = (beta1st-beta11)*(beta1st-beta11)/hkerns3
          rkern41 = (beta2st-beta21)*(beta2st-beta21)/hkerns4
          rkern51 = (sigmawst-sigmaw1)*(sigmawst-sigmaw1)/hkerns5
          rkern61 = (sigma1st-sigma11)*(sigma1st-sigma11)/hkerns6
          rkern71 = (sigma2st-sigma12)*(sigma2st-sigma12)/hkerns7
          rkern81 = (betaest-betae1)*(betaest-betae1)/hkerns8

                rdkern(int1) = -rkern11-rkern21-rkern31
     +                          -rkern41-rkern51-rkern61
     +                          -rkern71-rkern81

                if (int1 .ge. max(igibb-nint0,1)) then
                  int2 = int1+1-max(igibb-nint0,1)
                  if (igibb .le. ntperm1) then
                    ra(int2) = rdkern(int1)
                  else if (igibb .le. ntperm2) then
                    ra1(int2) = rdkern(int1)
                  else
                    ra2(int2) = rdkern(int1)
                  end if
                end if
	  end do
	  end if

             if (igibb .gt. nperm+1 .and. igibb .le. ntperm1) then
                call sortrx(nperm,ra,iperm)
C                call dsvrgp(nperm,ra,rb,iperm)

                do ip1 = 1, nperm
                  ip2 = iperm(ip1)-1+max(igibb-nint0,1)
                  icheck(ip2) = 0
                end do
                do ip1 = 1001, nperm
                  ip2 = iperm(ip1)-1+max(igibb-nint0,1)
                  icheck(ip2) = 1
                end do

C             if (igibb .gt. 500) then
C             do ip1 = 1, nperm
C               ip2 = iperm(ip1)-1+max(igibb-nint0,1)
C               print *, ip1, ip2,icheck(ip2),iperm(ip1),ra(ip1)
C     +                 ,rdkern(ip2)
C             end do
C              pause
C             end if

             else if (igibb .gt. ntperm1) then
                call sortrx(nperm1,ra1,iperm1)
C               call dsvrgp(nperm1,ra1,rb1,iperm1)

               do ip1 = 1, nperm1
                 ip2 = iperm1(ip1)-1+max(igibb-nint0,1)
                 icheck(ip2) = 0
               end do
               do ip1 = 1001, nperm1
                 ip2 = iperm1(ip1)-1+max(igibb-nint0,1)
                 icheck(ip2) = 1
               end do
             else if (igibb .gt. ntperm2) then
                call sortrx(nperm2,ra2,iperm2)
C               call dsvrgp(nperm2,ra2,rb2,iperm2)
               
               do ip1 = 1, nperm2
                 ip2 = iperm2(ip1)-1+max(igibb-nint0,1)
                 icheck(ip2) = 0
               end do
               do ip1 = 1001, nperm2
                 ip2 = iperm2(ip1)-1+max(igibb-nint0,1)
                 icheck(ip2) = 1
               end do
             end if

               rdmax = -1.0D10
           if (igibb .le. nperm1+1) then
            nint0 = igibb-1
           else if (igibb .gt. nperm+1 .and. igibb .le. ntperm1) then
            nint0 = nperm
           else if (igibb .gt. ntperm1) then
            nint0 = nperm1
           else if (igibb .gt. ntperm2) then
            nint0 = nperm2
           end if

          if (igibb .gt. 1) then
           if (igibb .gt. 20) then
            int0        = max(igibb-nint0,5)
           else
            int0        = max(igibb-nint0,1)
           end if

          do int1 = igibb-1,int0,-1
             if (icheck(int1) .eq. 1) then
                rdmax = max(rdmax,rdkern(int1))
             end if
C -----------------------------------------------------
C end do int1 = igibb,0,-1
C -----------------------------------------------------
          end do
          end if

C =================================================================
C Now, recalculate the Emax function.
C =================================================================
           if (igibb .le. ntperm1) then
             nint0 = igibb-1
           else if (igibb .gt. nperm+1 .and. igibb .le. ntperm1) then
             nint0 = nperm
           else if (igibb .gt. ntperm1) then
             nint0 = nperm1
           else if (igibb .gt. ntperm2) then
             nint0 = nperm2
           end if


C           print *, 'igibb 2 = ', igibb

	  if (igibb .gt. 1) then
	  do irk = 0, niw
            int0        = max(igibb-nint0,0)

            remax(irk)  = 0.0D0
            rtkern1      = 0.0D0

	  do int1 = igibb-1,int0,-1

C            if (igibb .eq. 2002)
C     +           print *, igibb,int0,int1, icheck(int1)

	     if (icheck(int1) .eq. 1) then
                  if (int1 .gt. 0) then
                    value1  = value(irk,int1)
		  else
                    value1  = remaxo(irk)
                  end if        

                rtkern1 = rtkern1+dexp(rdkern(int1)-rdmax)

                remaxold = remax(irk)
                remax(irk) = remax(irk)
     +          +dexp(rdkern(int1)-rdmax)*value1
C               if (igibb .ge. 2002)
C    +            print *, 'rtkern1 = ', rtkern1
	     end if
C -----------------------------------------------------
C end do int1 = igibb,0,-1
C -----------------------------------------------------                        
	  end do
                if (rtkern1 .gt. 0.0D0) then
                  remax(irk) = remax(irk)/rtkern1
C                  remax(irk) = remaxo(irk)
		else
		  remax(irk) = remaxo(irk)
                end if                                
C -----------------------------------------------------
C            end do it1 = 0, nemax
C -----------------------------------------------------
            end do
	    end if

            print *, 'igibb 3 = ', igibb
C ================================================================
C This part derives the Emax functions using the simulated data.
C ================================================================
C ----------------------------------------------------------------
C Derive the transition probabilities.
C ----------------------------------------------------------------
            do iwk = 1, niw
            do iwfd = 1, niw
              ftranm(iwk,iwfd) = 0.0D0
            end do
            end do   

            do irk = 1, niw
                  fsum = 0.0D0
                do iwfd = 1, niw
                  ff = dlog(wgrid(iwfd))
     +                -beta1st-beta2st*dlog(wgrid(irk))
                  ff = dlog(wgrid(iwfd))+ff*ff/(2.0D0*sigmawst*sigmawst)
                  ffm(iwfd) = dexp(-ff)
                  fsum = fsum+ffm(iwfd)
                end do
                  fsumm(irk) = beta1st+beta2st*dlog(wgrid(irk))

                do iwfd = 1, niw
                  ftranm(irk,iwfd) = ffm(iwfd)/fsum
                end do
            end do                    

                  fsum = 0.0D0
            do iwfd = 1, niw
                  ff = dlog(wgrid(iwfd))-betaest
                  ff = dlog(wgrid(iwfd))+ff*ff/(2.0D0*sigmawst*sigmawst)
                  ffm(iwfd) = dexp(-ff)
                  fsum = fsum+ffm(iwfd)
             end do
            
             do iwfd = 1, niw
                  ftranem(iwfd) = ffm(iwfd)/fsum
             end do

             nhalf = nint(5.0D-1*dble(nsim1))
             do isim = 1, nhalf
                sh(isim,1) = gasdev(iseed)
                sh(isim,2) = gasdev(iseed)
             end do

             do isim = nhalf+1, nsim1
                sh(isim,1) = -sh(isim-nhalf,1)
                sh(isim,2) = -sh(isim-nhalf,2)
             end do


	    do irk = 0, niw
             if (irk .gt. 0) then
               iwd = 1
               rkd = wgrid(irk)
             else
               iwd = 0
               rkd = 0.0D0
             end if                    

C ---------------------------------------------------
C value1 : value of staying in the industry.
C value2 : value of exiting from the industry.
C ---------------------------------------------------
	     if (irk .gt. 0) then
                  emax1 = 0.0D0
                do iwfd = 1, niw
                  emax1 = emax1+remax(iwfd)*ftranm(irk,iwfd)
                end do
                  emax0 = remax(0)
                  emaxm(irk) = emax1
	     else
                  emax1 = 0.0D0
                do iwfd = 1, niw  
                  emax1 = emax1+remax(iwfd)*ftranem(iwfd)
                end do
		        emaxe = emax1
                  emaxm(0) = emaxe
		        emax0 = remax(0)
             end if         

	    do isim = 1, nsim1

             if (irk .gt. 0) then
                  val1 = ast*wgrid(irk)+sigma1st*sh(isim,1)+beta0*emax1
                  val2 = sigma2st*sh(isim,2)+beta0*emax0
             else if (irk .eq. 0) then
                  val1 = sigma1st*sh(isim,1)-entst+beta0*emax1
                  val2 = sigma2st*sh(isim,2)+beta0*remax(0)
             end if
                                                 
C ------------------------------------------------------------------
C Derive the average value function for
C future calculation of the Emax function.
C ------------------------------------------------------------------
                value(irk,igibb) = value(irk,igibb)+max(val1,val2)
	    end do
           end do

           do irk = 0, niw
                if (nsim1 .gt. 0) then
                  value(irk,igibb)=value(irk,igibb)
     +                  /dble(nsim1)
                else
                  value(irk,igibb) = remaxo(irk)
                end if                            
           end do    

C ==========================================================
C Now, generate nsim new data.
C ==========================================================

	  if (mod(igibb,100) .eq. 1) then
            open (unit = 610, file = 'bch.out')
	         do iwd = 0, niw
	            write (610,'(I5,1X,4(F12.8,1X))')
     +			 iwd,remax(iwd)
     +			,value(iwd,igibb), remaxo(iwd)
     +			,remaxo(iwd)-value(iwd,igibb)
	         end do
            close (610)
	  end if

          if (mod (igibb,1000) .eq. 100000) then
                close (600)
                pause
          end if


C	    print *, 'itcheck', itcheck
 1000	  continue

	   close (203)
	   close (202)

	   end
