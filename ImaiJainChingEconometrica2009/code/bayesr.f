C ==================================================================
C This function generates uniform random number from (0,1)
C ==================================================================
        function ran1(idum)
        INTEGER idum,IA,IM,IQ,IR,NTAB,NDIV, ii
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
	   parameter (ngibb   = 10000)
	   parameter (niw     = 200)
	   parameter (riw     = 5.0D0)
           parameter (nt      = 100)
           parameter (nperson = 100)
           parameter (ndata   = nperson*(nt+1))
           parameter (nini    = 100)
	   parameter (npar    = 20)
	   parameter (nvprior = 10)
	   parameter (np1     = 10)
           parameter (nsim1   = 10)
           parameter (naugm   = 100000)
           parameter (nord    = 1000)
           parameter (nperm   = 300)
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
           parameter (sigasd    = 1.0D-3)
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
	   dimension iw(0:nt,nperson)
	   dimension iwf(0:nt,nperson)
	   dimension rk(0:nt,nperson)
	   dimension rkf(0:nt,nperson)
	   dimension profit(0:nt,nperson)
           dimension z(nperson)
           dimension am(nperson)
           dimension astm(nperson)
	   dimension remax(0:niw,nperson)
           dimension remaxst(0:niw,nperson)
	   dimension remaxo(0:niw,nperson)
           dimension remaxold(0:niw,nperson)
           dimension emaxm(0:niw,nperson)
           dimension ra(nord)
           dimension iperm(nord)
           dimension icheck(0:nord)
	   dimension ftranm(niw,niw)
	   dimension ftranem(niw)
	   dimension wgrid(niw)
	   dimension ffm(niw)
C	   dimension rthreshm(ndata)
C	   dimension rthreshmold(ndata)
	   dimension yy(0:ndata,3)
	   dimension xx(0:ndata)
	   dimension yyp(0:ndata)
	   dimension xxp(0:ndata)
	   dimension yyk(0:ndata)
	   dimension xxk(0:ndata,2)
	   dimension yye(ndata)
	   dimension xxe(ndata)
           dimension xpx(2,2)
           dimension xpy(2)
           dimension xpxa(2,2)
           dimension xpxinva(2,2)
           dimension xpxinv(2,2)
           dimension coef(2)
           dimension ch(2,2)
           dimension vm0(2)
           dimension vm(2)
	   dimension param(nord,npar)
           dimension pam(nord,nperson)
           dimension rdkerna(nord)
	   dimension rdkern(nord)
           dimension rdkernst(nord)
	   dimension value(0:niw,nord,nperson)
           dimension valuen(0:niw,nperson)
           dimension fsumm(0:niw)

           integer, dimension(1) :: old, seed

           dimension sh(nsim1,2)

           iseed = -1283

	   do iw1 = 1, niw
		wgrid(iw1) = riw*dble(iw1)/dble(niw)
	   end do
C ========================================================
C Read in the data. 
C ========================================================

	  open (unit = 500, file = 'bcheck.out')
	  open (unit = 600, file = 'bvalue.out')
	  open (unit = 100, file = 'sim.out')

              itin  = 0
              itout = 0
	   do ip1 = 1, nperson
           do it  = 1, nt
	      read (100,*) idata1,iw1,iwf1,rk1,rkf1,profit1,z1
	      iw(it,ip1)     = iw1
	      iwf(it,ip1)    = iwf1
	      rk(it,ip1)     = min(rk1,riw)
	      rkf(it,ip1)    = min(rkf1,riw)
	      profit(it,ip1) = profit1
              z(ip1)      = z1
              if (iw1 .eq. 0) then
                itout = itout+1
              else
                itin  = itin+1
              end if
           end do
	   end do
	  close (100)

                print *, 'itout itin = ', itout, itin

C          open (unit = 101, file = 'csim.out')
C           do ip1 = 1, nperson
C           do it  = 1, nt
C            write (101,'(4(I5,1X),4(F12.6,1X))')
C     +      ip1,it,iw(it,ip1),iwf(it,ip1),rk(it,ip1),rkf(it,ip1)
C     +     ,profit(it,ip1),z(ip1)
C           end do
C           end do
C          close (101)

C -----------------------------------------------------------
C Read in the emax function. 
C -----------------------------------------------------------
	  open (unit = 102, file = 'value.out')
             do ip1 = 1, nperson
	       read (102,*) inum,remax(0,ip1),am(ip1)
	     do iw1 = 1, niw
	       read (102,*) inum,rnum,remax(iw1,ip1)
	     end do
             end do
	  close (102)


          do ip1 = 1, nperson
	  do iw1 = 0, niw
	    remaxo(iw1,ip1) = 1.0D0*remax(iw1,ip1)
	    remax(iw1,ip1)  = 0.0D0*remaxo(iw1,ip1)
            remaxst(iw1,ip1) = 0.0D0*remaxo(iw1,ip1)
	  end do
          end do

	  open (unit = 50, file = 'input.dat')
	    do ip1 = 1, np1
	      read (50,*) 
	      read (50,*) 
	      read (50,*)
	      read (50,*) par(ip1)
	    end do
	  close (50)

             atrue     = par(1)
             entrue    = par(2)
             s1true    = par(3)
             s2true    = par(4)
             swtrue    = par(5)
             beta0     = par(6)
             b1true    = par(7)
             b2true    = par(8)       
             asdtrue   = par(9)
	     betrue    = par(10)

              scale = 1.0D0

	       ameanst  = scale*atrue
	       entst    = scale*entrue  
	       beta1st  = scale*b1true
	       beta2st  = scale*b2true
	       sigma1st = scale*s1true
	       sigma2st = scale*s2true
	       sigmawst = scale*swtrue
               asdst    = scale*asdtrue 
	       betaest  = scale*betrue

	     print *, 'amst     = ', amst
             print *, 'entst    = ', entst
	     print *, 'sigma1st = ', sigma1st
             print *, 'sigma2st = ', sigma2st
             print *, 'sigmawst = ', sigmawst
	     print *, 'beta0    = ', beta0
             print *, 'beta1st  = ', beta1st
             print *, 'beta2st  = ', beta2st
	     print *, 'asdst    = ', asdst
             print *, 'betaest  = ', betaest

	     amean   = ameanst
	     enter   = entst
	     beta1   = beta1st
	     beta2   = beta2st
	     betae   = betaest
	     sigma1  = sigma1st
	     sigma2  = sigma2st
	     sigmaw  = sigmawst
             asd     = asdst

C	     a      = 5.0D-1*a
C	     enter  = 5.0D-1*enter
C	     sigma1 = 5.0D-1*sigma1
C	     sigma2 = 5.0D-1*sigma2
C	     sigmaw = 5.0D-1*sigmaw
C	     beta1  = 5.0D-1*beta1
C	     beta2  = 5.0D-1*beta2
C	     betae  = 5.0D-1*betae

             param(nord,1) = entst
             param(nord,2) = beta1st
             param(nord,3) = beta2st
             param(nord,4) = sigmawst
             param(nord,5) = sigma1st
             param(nord,6) = sigma2st
	     param(nord,7) = betaest
             param(nord,8) = ameanst
             param(nord,9) = asdst

             do ip1 = 1, nperson
                pam(nord,ip1) = am(ip1)
             end do


	 sigmatst = dsqrt(sigma1st*sigma1st+sigma2st*sigma2st)
         sigmat = sigmatst

	  open (unit = 302, file = 'bayes1283.out')

          total = etime(elapsed)
          time0 = elapsed(1)
C	  time0 = cpsec()

	  print *, 'time0 = ',time0

	  do 1000 igibb = 1, ngibb

             print *,'igibb = ', igibb

C                enter     = param(nord,1)
C                beta1     = param(nord,2)
C                beta2     = param(nord,3)
C                sigmaw    = param(nord,4)
C                sigma1    = param(nord,5)
C                sigma2    = param(nord,6)
C 		 betae     = param(nord,7)
C                amean     = param(nord,8)
C                asd       = param(nord,9)
     
C                write (500,*) entst
C                write (500,*) ast
C                write (500,*) beta1st
C                write (500,*) beta2st
C                write (500,*) sigmawst
C                write (500,*) sigma1st
C                write (500,*) sigma2st
C                write (500,*) betaest
C                write (500,*) asdst

C                do ip1    = 1, nperson
C                   am(ip1) = pam(nord,ip1)
C                end do

C                do ip1 = 1, nperson
C                   write (500,*) ip1, am(ip1)
C                end do

	        sigmat = dsqrt(sigma1*sigma1+sigma2*sigma2)
                sigmatst = dsqrt(sigma1st*sigma1st+sigma2st*sigma2st)

C ==============================================================
C This is the data augmentation step for profit equation.
C using the candidate parameter thetast. 
C ==============================================================
	      adeps   = 0.0D0
	      ideps   = 0
	      nwd     = 0
              plike   = 0.0D0
C ----------------------------------------------------
C Derive the emax function. 
C ----------------------------------------------------
            if (igibb .gt. 1) then
              int0 = max(nord+1-igibb,1)
            do iord1 = nord-1, int0, -1
              if (iord1 .ge. nord+1-igibb) then
                    enter1  = param(iord1,1)
                    beta21  = param(iord1,3)
                    sigmaw1 = param(iord1,4)
                    sigma11 = param(iord1,5)
                    sigma12 = param(iord1,6)
                    betae1  = param(iord1,7)
              else
                    enter1  = entrue
                    beta21  = b2true
                    sigmaw1 = swtrue
                    sigma11 = s1true
                    sigma12 = s2true
                    betae1  = betrue
              end if
C ----------------------------------------------------------
C This is the kernel for the part common to all individuals.
C ----------------------------------------------------------
          rkern11 = (enter-enter1)*(enter-enter1)/hkern1
          rkern31 = (beta2-beta21)*(beta2-beta21)/hkern3
          rkern41 = (sigmaw-sigmaw1)*(sigmaw-sigmaw1)/hkern4
          rkern51 = (sigma1-sigma11)*(sigma1-sigma11)/hkern5
          rkern61 = (sigma2-sigma12)*(sigma2-sigma12)/hkern6
          rkern71 = (betae-betae1)*(betae-betae1)/hkern7
          rdkerna(iord1) = -rkern11-rkern31
     +                    -rkern41-rkern51
     +                    -rkern61-rkern71
          end do
          end if

          if (igibb .gt. nperm) then
            do iord1 = 1, nord
              iperm(iord1) = iord1
            end do
            do iord1 = 1, nord
              ra(iord1) = -1.0D4-dble(iord1)
            end do
            do iord1 = int0, nord
              ra(iord1) = rdkerna(iord1)
            end do

C            do iord1 = 1, nord
C            write (501,'(2(I5,1X),2(1X,F15.7))') 
C     +       iord1, iperm(iord1),rdkerna(iord1), ra(iord1)
C            end do

            call sortrx(nord,ra,iperm)

            do iord1 = 1, nord
               ip1 = iperm(iord1)
               icheck(ip1) = 0
            end do
            do iord1 = nord-nperm+1, nord
               ip1 = iperm(iord1)
               icheck(ip1) = 1
            end do

C            write (501,*) '----- reordering -----'
C            do iord1 = 1, nord
C              iordr = iperm(iord1)
C            write (501,'(2(I5,1X),2(1X,F15.7))')
C     +       iord1, iperm(iord1),rdkerna(iord1), ra(iordr)
C            end do

C           if (igibb .eq. 210000) then
C           open (unit = 501, file = 'bch1.out')

C            write (501,*) '----- parameters -----'
C            do iord1 = 1, nord
C              iordr = iperm(iord1)
C              write (501,'(2(I5,1X),2(1X,F20.7))')
C     +       iord1, iperm(iord1),param(iord1,1),value(1,iord1,1)
C            end do

C            write (501,*) '----- reordering -----'
C            do iord1 = 1, nord
C              iordr = iperm(iord1)
C            write (501,'(3(I5,1X),(1X,F15.7))')
C     +       iord1, iperm(iord1),icheck(iordr),ra(iordr)
C            end do

C            close (501)
C            pause
C           end if
         end if

             tchange = 0.0D0
           do ip1 = 1, nperson
C ---------------------------------------------------
C Draw new ast.
C ---------------------------------------------------
          ast = amean+asd*gasdev(iseed)
C ----------------------------------------------------
C Derive the emax function.
C ----------------------------------------------------
            if (igibb .gt. 1) then
            do iord1 = nord-1, int0, -1
              if (icheck(iord1) .eq. 1) then
                if (iord1 .ge. nord+1-igibb) then 
                  beta11 = param(iord1,2)
                  a1     = pam(iord1,ip1)
                else
                  beta11 = b1true
                  a1     = atrue
                end if
                  rkern21 = (beta1-beta11)*z(ip1)
     +                   *(beta1-beta11)*z(ip1)/hkern2
                  rkern81 = (am(ip1)-a1)*(am(ip1)-a1)/hkern8
                  rkernst81 = (ast-a1)*(ast-a1)/hkern8
                  rdkern(iord1) = rdkerna(iord1)-rkern21-rkern81
                  rdkernst(iord1) 
     +                        = rdkerna(iord1)-rkern21-rkernst81
              end if
            end do
          
               rdmax = -1.0D10
               rdmaxst = -1.0D10
            do iord1 = nord-1, int0, -1
              if (icheck(iord1) .eq. 1) then
               rdmax = max(rdmax, rdkern(iord1))
               rdmaxst = max(rdmaxst,rdkernst(iord1))
              end if
            end do
      
          end if

C --------------------------------------------------------
C Now, recalculate the Emax function. 
C --------------------------------------------------------
          if (igibb .gt. 1) then
            do irk = 0, niw
                remax(irk,ip1)   = 0.0D0
                remaxst(irk,ip1) = 0.0D0
                rtkern1          = 0.0D0
                rtkernst1        = 0.0D0
             do iord1 = nord-1,int0,-1
               if (icheck(iord1) .eq. 1) then
                if (iord1 .ge. nord+1-igibb) then
                  value1 = value(irk,iord1,ip1)
                else
                  value1 = remaxo(irk,ip1)
                end if

                       radd = dexp(rdkern(iord1)-rdmax)
                       raddst = dexp(rdkernst(iord1)-rdmaxst)

                  rtkern1 = rtkern1+radd

                  rtkernst1 = rtkernst1+raddst

                  remax(irk,ip1) = remax(irk,ip1)
     +                    +radd*value1

                  remaxst(irk,ip1) = remaxst(irk,ip1)
     +                    +raddst*value1
              end if
C ---------------------------------------------
C end do of do int1 = igibb-1,int0,-1
C ---------------------------------------------
              end do 
                if (rtkern1 .gt. 0.0D0) then
                  remax(irk,ip1) = remax(irk,ip1)/rtkern1
                else
                  remax(irk,ip1) = remaxo(irk,ip1)
                end if

                if (rtkernst1 .gt. 0.0D0) then
                  remaxst(irk,ip1) = remaxst(irk,ip1)/rtkernst1
                else
                  remaxst(irk,ip1) = remaxo(irk,ip1)
                end if
            end do	
          end if

                  fsum = 0.0D0
                  do iwf1 = 1, niw
                    ff  = dlog(wgrid(iwf1))-betae
                    ff  = dlog(wgrid(iwf1))
     +                    +ff*ff/(2.0D0*sigmaw*sigmaw)
                    ffm(iwf1) = dexp(-ff)
                    fsum      = fsum+ffm(iwf1)
                  end do

                    emaxe   = 0.0D0
                    emaxste = 0.0D0
                  do iwf1 = 1, niw
                    ff = ffm(iwf1)/fsum
                    emaxe   = emaxe+remax(iwf1,ip1)*ff
                    emaxste = emaxste+remax(iwf1,ip1)*ff
                  end do

C ----------------------------------------------------
C Construct likelihood for each firm. 
C ----------------------------------------------------
                pnew  = 0.0D0
                pold  = 0.0D0
                padd1 = 0.0D0
                iwd = 0
                rkd = 0.0D0
             do it1 = 1, nini+nt+1
               if (it1 .le. nini) then
                  int = it1
                  it  = -1
               else
                  it = it1-nini-1
               end if

               if (it .ge. 0) then
                 idata = nt*(ip1-1)+it
	         iwd     = iw(it,ip1)
	         iwfd    = iwf(it,ip1)
	         rkd     = rk(it,ip1)
	         rkfd    = rkf(it,ip1)
	         profitd = profit(it,ip1)
               end if
C                write (500,'(4(I5,1X),3(F12.7))')
C     +           ip1,it,iwd,iwfd,rkd,rkfd,profitd

C ------------------------------------------------------------
C For the incumbent firm, that is, for firms that
C  iw => 0, 
C either it stays in business (iwf =>0) or exits (iwf=-1).
C ------------------------------------------------------------
	     if (iwd .eq. 1) then

	          fsum = 0.0D0
	        do iwf1 = 1, niw
		       ff   = dlog(wgrid(iwf1))
     +			     -beta1*z(ip1)-beta2*dlog(rkd)
		       ff   = dlog(wgrid(iwf1))
     +			      +ff*ff/(2.0D0*sigmaw*sigmaw)
	           ffm(iwf1) = dexp(-ff)
		       fsum = fsum+ffm(iwf1)
	        end do

	            emax1   = 0.0D0
                    emaxst1 = 0.0D0
	        do iwf1 = 1, niw
		    ff      = ffm(iwf1)/fsum
		    emax1   = emax1  +remax(iwf1,ip1)*ff
                    emaxst1 = emaxst1+remaxst(iwf1,ip1)*ff
	        end do
		    emax0   = remax(0,ip1)
                    emaxst0 = remaxst(0,ip1)

             if (iwfd .eq. 1) then
	        rthin    = profitd+beta0*emax1
                rthinst  = profitd+beta0*emaxst1
	        sigm   = sigma2
	       else if (iwfd .eq. 0) then
	        rthin    = am(ip1)*rkd+beta0*emax1
                rthinst  = ast*rkd+beta0*emaxst1
	        sigm   = sigmat
	       end if

	        rthout   = beta0*emax0
                rthoutst = beta0*emaxst0

	        rthresh0 = rthout-rthin
                rthreshst0 = rthoutst-rthinst

C		write (500,'(I5,1X,6(F10.6,1X))')
C     +		 idata,rkd,emax1,emax0,rthin,rthout,rthresh0

	      else if (iwd .eq. 0) then

		    emax1    = emaxe
                    emaxst1  = emaxste
		    emax0    = remax(0,ip1)
                    emaxst0  = remaxst(0,ip1)                   

		    rthin      = -enter+beta0*emax1
                    rthinst    = -enter+beta0*emaxst1
	            sigm       = sigmat
		    rthout     = beta0*emax0
                    rthoutst   = beta0*emaxst0
		    rthresh0   = rthout-rthin
                    rthreshst0 = rthoutst-rthinst
C		    rthreshm(idata) = rthresh0


C               write (500,'(I5,1X,6(F10.6,1X))') 
C     +		  idata,rkd,emax1,emax0,rthin,rthout,rthresh0

	      end if

C                if (it .eq. 10) then
C                  write (500,*) 'rthin rthinst = ',
C     +              iwd,iwfd, rthin, rthinst, emax1-emaxst1
C                end if

C ------------------------------------------------------------
C rthresh(theta(m))  : normalized threshold
C rpthresh(theta(m)) : probability of the threshold.
C                      Prob[r <= rthresh(theta(m))]
C ------------------------------------------------------------

	          rthresh = rthresh0/sigm
                  call dnormp(rthresh,pl,pr,pdf)
	          rpthresh = pl

                  rthreshst = rthreshst0/sigm
                  call dnormp(rthreshst,pstl,pr,pdf)
                  rpthreshst = pstl

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


           if (it .eq. -1) then
                 rprob = rpthresh
                 epsilon1 = ran1(iseed)
                 if (epsilon1 .le. rprob) then
                   iwfd = 0
                   rkfd = 0.0D0
                 else
                   iwfd = 1
                   if (iwd .eq. 0) then
                     rkfd = gasdev(iseed)*sigmaw+betae
                     rkfd = dexp(rkfd)
                   else
                     rkfd = beta1*z(ip1)+beta2*dlog(rkd)
     +                     +gasdev(iseed)*sigmaw
                     rkfd = dexp(rkfd)
                   end if
                 end if
                   iwd = iwfd
                   rkd = rkfd
                   iw(0,ip1) = iwd
                   rk(0,ip1) = rkd
                   iwf(0,ip1) = iw(1,ip1)
                   rkf(0,ip1) = rk(1,ip1)
                   profit(0,ip1) = am(ip1)*rkd+gasdev(iseed)*sigma1
           else
C ---------------------------------------------------------------
C Data augmentation on profits. Use the old parameters. 
C  profit(theta(m)) = a(m)*k + eps1(theta(m)) 
C ---------------------------------------------------------------
             if (iwd .eq. 1 .and. iwfd .eq. 1) then
                     yyp(idata) = profitd
		     xxp(idata) = rkd
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

		 padd = dlog(rprob)

               if (it .ge. 1) then
	       if (iwd .eq. 1 .and. iwfd .eq. 1) then
                 yy(idata,2) = yyp(idata)-am(ip1)*xxp(idata)
	         padd = padd
     +             -5.0D-1*dlog(2.0D0*dpi)-dlog(sigma1)
     +             -5.0D-1*yy(idata,2)*yy(idata,2)/(sigma1*sigma1)
	       end if
               end if

                 pold = pold+padd

                 padd = dlog(rprobst)
               if (it .ge. 1) then
               if (iwd .eq. 1 .and. iwfd .eq. 1) then
                 yy(idata,2) = yyp(idata)-ast*xxp(idata)
                 padd = padd
     +             -5.0D-1*dlog(2.0D0*dpi)-dlog(sigma1)
     +             -5.0D-1*yy(idata,2)*yy(idata,2)/(sigma1*sigma1)
               end if
               end if
                 pnew = pnew+padd

               if (iwd .eq. 0 .and. iwfd. eq. 1) then
                 yy(idata,3) = dlog(rkfd) - betae
               else if (iwd .eq. 1 .and. iwfd .eq. 1) then
                 yy(idata,3) = dlog(rkfd) - beta1*z(ip1)
     +                         - beta2*dlog(rkd)
               end if

               if (iwfd .eq. 1) then
                 padd1 = padd1-dlog(rkfd)
     +              +5.0D-1*dlog(2.0D0*dpi)-dlog(sigmaw)
     +              -5.0D-1*yy(idata,3)*yy(idata,3)/(sigmaw*sigmaw)
               end if

             end if
C -------------------------------------------------------------
C end do of    do it = 1, nini+nt
C -------------------------------------------------------------
	   end do
C -------------------------------------------------------------
C Calculate the next iteration parameters and the likelihood
C increment of the Metropolis-Hastings algorithm.
C -------------------------------------------------------------
                pchange = 1.0D0
                change  = ran1(iseed)
           if (igibb .ge. 1) then
                phast = dexp(min(pnew-pold,1.0D0))
                hast = ran1(iseed)
              if (hast .le. phast .and. change .le. pchange) then
                 tchange = tchange+1.0D0
                 a        = ast
                 plike = plike+pnew
                 remaxold(:,ip1) = remaxst(:,ip1)
              else
                 plike = plike+pold
                 a        = am(ip1)
                 remaxold(:,ip1) = remax(:,ip1)
              end if
                 plike = plike+padd1
            end if

C           write (500,'(I5,7(1X,F12.7))')
C     +        ip1,pold,pnew,phast,hast,am(ip1),ast, a

                 am(ip1) = a
C -------------------------------------------------------------
C end do of    do ip1 = 1, nperson
C -------------------------------------------------------------
           end do
               tchange = tchange/dble(nperson)
              close (500)

C -------------------------------------------------------------
C Calculate the next iteration amean and asd
C -------------------------------------------------------------
             avhat = 0.0D0
           do ip1 = 1, nperson
             avhat = avhat+am(ip1)
           end do
             aden  = dble(nperson)+aprec
             anum  = avhat+aprec*aprior
             amean = anum/aden+asd*gasdev(iseed)/dsqrt(aden)
             ameanst = amean

             sse = 0.0D0
           do ip1 = 1, nperson
             sse = sse+(am(ip1)-amean)*(am(ip1)-amean)
           end do

                vtilda1 = 0.0D0
             do idata = 1, nperson+nvprior
                eps1    = gasdev(iseed)
                vtilda1 = vtilda1+eps1*eps1
             end do

             asd = dsqrt( (asdtrue*asdtrue*dble(nvprior)+sse)
     +                       /vtilda1)
             asdst = asd

C             amean   = atrue
C             ameanst = atrue
C             asd     = asdtrue
C             asdst   = asdtrue
C --------------------------------------------------------------
C Derive the candidate distribution for Metropolis Hastings
C algorithm.
C --------------------------------------------------------------
                pchange = 1.0D0
                pchange1 = 1.0D0
              if (ran1(iseed) .le. pchange) then
                entst     = enter  +sigent*gasdev(iseed)
              else
                entst     = enter
              end if

              if (ran1(iseed) .le. pchange1) then
                beta1st   = beta1  +sigb1*gasdev(iseed)
              else
                beta1st   = beta1
              end if

              if (ran1(iseed) .le. pchange1) then
                beta2st   = beta2  +sigb2*gasdev(iseed)
              else
                beta2st   = beta2
              end if

              if (ran1(iseed) .le. pchange1) then
                betaest   = betae  +sigbe*gasdev(iseed)
              else
                betaest   = betae
              end if

              if (ran1(iseed) .le. pchange1) then
                sigma1st  = dlog(sigma1) +sigsigma1*gasdev(iseed)
                sigma1st  = dexp(sigma1st)
              else
                sigma1st  = sigma1
              end if

              if (ran1(iseed) .le. pchange1) then
                sigma2st  = dlog(sigma2) +sigsigma2*gasdev(iseed)
                sigma2st  = dexp(sigma2st)
              else
                sigma2st  = sigma2
              end if

                sigmatst = dsqrt(sigma1st*sigma1st+sigma2st*sigma2st)

              if (ran1(iseed) .le. pchange1) then
                sigmawst  = dlog(sigmaw) +sigsigmaw*gasdev(iseed)
                sigmawst  = dexp(sigmawst)
              else
                sigmawst  = sigmaw
              end if

              open (unit = 500, file = 'bcheck.out')
C -------------------------------------------------------------
C Calculate the next iteration parameters of the Metropolis-
C Hastings algorithm. 
C -------------------------------------------------------------
             pliken = 0.0D0
C ----------------------------------------------------
C Derive the emax function.
C ----------------------------------------------------
            if (igibb .gt. 1) then
              int0 = max(nord+1-igibb,1)
            do iord1 = nord-1, int0, -1
              if (iord1 .gt. nord+1-igibb) then
                    enter1  = param(iord1,1)
                    beta21  = param(iord1,3)
                    sigmaw1 = param(iord1,4)
                    sigma11 = param(iord1,5)
                    sigma12 = param(iord1,6)
                    betae1  = param(iord1,7)
              else
                    enter1  = entrue
                    beta21  = b2true
                    sigmaw1 = swtrue
                    sigma11 = s1true
                    sigma12 = s2true
                    betae1  = betrue
              end if
C ----------------------------------------------------------
C This is the kernel for the part common to all individuals.
C ----------------------------------------------------------
          rkern11 = (entst-enter1)*(entst-enter1)/hkern1
          rkern31 = (beta2st-beta21)
     +             *(beta2st-beta21)/hkern3
          rkern41 = (sigmawst-sigmaw1)
     +             *(sigmawst-sigmaw1)/hkern4
          rkern51 = (sigma1st-sigma11)
     +             *(sigma1st-sigma11)/hkern5
          rkern61 = (sigma2st-sigma12)
     +             *(sigma2st-sigma12)/hkern6
          rkern71 = (betaest-betae1)
     +             *(betaest-betae1)/hkern7
          rdkerna(iord1) = -rkern11-rkern31
     +                    -rkern41-rkern51
     +                    -rkern61-rkern71
          end do
          end if

          if (igibb .gt. nperm) then
            open (unit = 501, file = 'bch1.out')
            do iord1 = 1, nord
              iperm(iord1) = iord1
            end do
            do iord1 = 1, nord
              ra(iord1) = -1.0D4-dble(iord1)
            end do
            do iord1 = int0, nord
              ra(iord1) = rdkerna(iord1)
            end do

            call sortrx(nord,ra,iperm)

            do iord1 = 1, nord
               ip1 = iperm(iord1)
               icheck(ip1) = 0
            end do
            do iord1 = nord-nperm+1, nord
               ip1 = iperm(iord1)
               icheck(ip1) = 1
            end do
          end if


           do ip1 = 1, nperson
C ----------------------------------------------------
C Derive the emax function.
C ----------------------------------------------------
            if (igibb .gt. 1) then
            do iord1 = nord-1, int0, -1
             if (icheck(iord1) .eq. 1) then
              if (iord1 .ge. nord+1-igibb) then
                beta11 = param(iord1,2)
                a1     = pam(iord1,ip1)
              else
                beta11 = b1true
                a1     = atrue
              end if
                rkern21 = (beta1st-beta11)*z(ip1)
     +                   *(beta1st-beta11)*z(ip1)/hkern2
                rkern81 = (am(ip1)-a1)*(am(ip1)-a1)/hkern8
                rdkern(iord1) = rdkerna(iord1)-rkern21-rkern81
              end if
             end do

               rdmax = -1.0D10
             do iord1 = nord-1, int0, -1
              if (icheck(iord1) .eq. 1) then
               rdmax = max(rdmax, rdkern(iord1))
              end if
             end do
            end if

C --------------------------------------------------------
C Now, recalculate the Emax function.
C --------------------------------------------------------
            if (igibb .gt. 1) then
            do irk = 0, niw
                remax(irk,ip1) = 0.0D0
                rtkern1        = 0.0D0
              do iord1 = nord-1,int0,-1
               if (icheck(iord1) .eq. 1) then
                if (iord1 .ge. nord+1-igibb) then
                  value1 = value(irk,iord1,ip1)
                else
                  value1 = remaxo(irk,ip1)
                end if

                  rtkern1 = rtkern1
     +                 +dexp(rdkern(iord1)-rdmax)

                  remax(irk,ip1) = remax(irk,ip1)
     +                    +dexp(rdkern(iord1)-rdmax)
     +                    *value1
                end if
C ---------------------------------------------
C end do of do int1 = igibb-1,int0,-1
C ---------------------------------------------
              end do
                if (rtkern1 .gt. 0.0D0) then
                  remax(irk,ip1) = remax(irk,ip1)/rtkern1
                else
                  remax(irk,ip1) = remaxo(irk,ip1)
                end if
             end do
             end if

                  fsum = 0.0D0
                  do iwf1 = 1, niw
                    ff  = dlog(wgrid(iwf1))-betaest
                    ff  = dlog(wgrid(iwf1))
     +                    +ff*ff/(2.0D0*sigmawst*sigmawst)
                    ffm(iwf1) = dexp(-ff)
                    fsum      = fsum+ffm(iwf1)
                  end do

                    emaxe   = 0.0D0
                  do iwf1 = 1, niw
                    ff = ffm(iwf1)/fsum
                    emaxe   = emaxe+remax(iwf1,ip1)*ff
                  end do

                pnew = 0.0D0
C ----------------------------------------------------
C Construct likelihood for each firm.
C ----------------------------------------------------
             do it = 0, nt
                idata = nt*(ip1-1)+it
                iwd     = iw(it,ip1)
                iwfd    = iwf(it,ip1)
                rkd     = rk(it,ip1)
                rkfd    = rkf(it,ip1)
                profitd = profit(it,ip1)

C              write (500,'(4(I4,1X),3(F10.5,1X))')
C     +         ip1,it,iwd,iwfd,rkd,rkfd,profitd
C ------------------------------------------------------------
C For the incumbent firm, that is, for firms that
C  iw => 0,
C either it stays in business (iwf =>0) or exits (iwf=-1).
C ------------------------------------------------------------
             if (iwd .eq. 1) then

                  fsum = 0.0D0
                do iwf1 = 1, niw
                       ff   = dlog(wgrid(iwf1))
     +                       -beta1st*z(ip1)-beta2st*dlog(rkd)
                       ff   = dlog(wgrid(iwf1))
     +                        +ff*ff/(2.0D0*sigmawst*sigmawst)
                  ffm(iwf1) = dexp(-ff)
                       fsum = fsum+ffm(iwf1)
                end do

                    emax1   = 0.0D0
                do iwf1 = 1, niw
                    ff      = ffm(iwf1)/fsum
                    emax1   = emax1  +remax(iwf1,ip1)*ff
                end do
                    emax0   = remax(0,ip1)

               if (iwfd .eq. 1) then
                rthin  = profitd+beta0*emax1
                sigm   = sigma2st
               else if (iwfd .eq. 0) then
                rthin  = am(ip1)*rkd+beta0*emax1
                sigm   = sigmatst
               end if

                rthout   = beta0*emax0
                rthresh0 = rthout-rthin
C                rthreshm(idata) = rthresh0

C               write (500,'(I5,1X,6(F12.8,1X))')
C     +          idata,rkd,emax1,emax0,rthin,rthout,rthresh0

              else if (iwd .eq. 0) then

                    emax1    = emaxe
                    emax0    = remax(0,ip1)

                    rthin      = -entst+beta0*emax1
                    sigm       = sigmatst
                    rthout     = beta0*emax0
                    rthresh0   = rthout-rthin
C                    rthreshm(idata) = rthresh0

C               write (500,'(I5,1X,6(F12.8,1X))')
C     +           idata,rkd,emax1,emax0,rthin,rthout,rthresh0


              end if
C ------------------------------------------------------------
C rthresh(theta(m))  : normalized threshold
C rpthresh(theta(m)) : probability of the threshold.
C                      Prob[r <= rthresh(theta(m))]
C ------------------------------------------------------------
                  rthresh = rthresh0/sigm
                  call dnormp(rthresh,pl,pr,pdf)
                  rpthresh = pl

               if (iwfd .eq. 1) then
                  rprob   = 1.0D0-rpthresh
               else if (iwfd .eq. 0) then
                  rprob   = rpthresh
               end if

C ---------------------------------------------------------------
C Data augmentation on profits. Use the old parameters.
C  profit(theta(m)) = a(m)*k + eps1(theta(m))
C ---------------------------------------------------------------
               if (iwd .eq. 1 .and. iwfd .eq. 1) then
                     yyp(idata) = profitd
                     xxp(idata) = rkd
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
                 padd = dlog(rprob)

               if (it .ge. 1) then
               if (iwd .eq. 1 .and. iwfd .eq. 1) then
                 yy(idata,2) = yyp(idata)-am(ip1)*xxp(idata)
                 padd = padd
     +             -5.0D-1*dlog(2.0D0*dpi)-dlog(sigma1st)
     +             -5.0D-1*yy(idata,2)*yy(idata,2)/(sigma1st*sigma1st)
               end if
               end if

               if (iwd .eq. 0 .and. iwfd. eq. 1) then
                 yy(idata,3) = dlog(rkfd) - betaest
               else if (iwd .eq. 1 .and. iwfd .eq. 1) then
                 yy(idata,3) = dlog(rkfd) - beta1st*z(ip1)
     +                         - beta2st*dlog(rkd)
               end if

               if (iwfd .eq. 1) then
                 padd = padd-dlog(rkfd)
     +              +5.0D-1*dlog(2.0D0*dpi)-dlog(sigmawst)
     +              -5.0D-1*yy(idata,3)*yy(idata,3)/(sigmawst*sigmawst)
               end if

                 pnew = pnew+padd
C ------------------------------------------------
C end do of do it = 1, nt
C ------------------------------------------------
             end do

                 pliken = pliken+pnew
C -----------------------------------------------------------
C end do of do ip1 = 1, nperson
C -----------------------------------------------------------
           end do 

                close (500)

                print *, 'plike pliken = ', plike, pliken

           if (igibb .ge. 2) then
	         phast = dexp(min(pliken-plike,1.0D0))
                   hast = ran1(iseed)

                print *,'phast hast =', phast, hast
 
              if (hast .le. phast .or. igibb .le. 2
     +           .or. irep .gt. 20) then
                 irep     = 0
	         enter    = entst
	         amean    = ameanst
	         beta1    = beta1st
	         beta2    = beta2st
	         betae    = betaest
	         sigma1   = sigma1st
	         sigma2   = sigma2st
	         sigmaw   = sigmawst
                 asd      = asdst
              else
                 irep = irep+1 
	      end if
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

C	     print *, 'sigma = ', sigma1, sigma12, sigma2
C	     print *, 'enter = ', enter, a
C	     print *, 'beta = ', beta1, beta2,betae,sigmaw


C             open (unit = 500, file = 'bcheck.out')
C           do iord = 1, nord
C               write (500,*) '---------------'
C              do ip1 = 1, 9
C               write (500,'(2(I5,1X),F15.8)') iord,ip1,param(iord,ip1)
C              end do
C               write (500,*) '- - - - - - - - '
C              do irk = 1, 10
C               write (500,'(I5,1X,F15.8)') irk,value(irk,iord,1)
C              end do
C           end do
C              close (500)


             time1 = time0
             total = etime(elapsed)
             time0 = elapsed(1)
C             time0 = cpsec()

             ddtime = time0-time1
             timem  = time0/6.0D1


C	   write (302,'(1(I6,1X),10(F12.8,1X),2(1X,F9.4))')
C     +		igibb,tchange,enter,amean,sigma1,sigma2
C     +		,beta1,beta2,betae,sigmaw,asd,timem,ddtime

          write (302,'(1(I6,1X),9(F12.8,1X),2(1X,F9.4))')
     +         igibb,enter,amean,sigma1,sigma2
     +         ,beta1,beta2,betae,sigmaw,asd,timem,ddtime

C ================================================================
C This part derives the Emax functions using the simulated data.
C ================================================================
C ----------------------------------------------------------------
C Derive the transition probabilities.
C ----------------------------------------------------------------
                  fsum = 0.0D0
            do iwfd = 1, niw
                  ff = dlog(wgrid(iwfd))-betaest
                  ff = dlog(wgrid(iwfd))
     +              +ff*ff/(2.0D0*sigmawst*sigmawst)
                  ffm(iwfd) = ff
                  fsum = fsum+dexp(-ffm(iwfd))
             end do
            
             do iwfd = 1, niw
                  ftranem(iwfd) = dexp(-ffm(iwfd))/fsum
             end do

C             open (unit = 710, file = 'bch.out')
C             do iwfd = 1, niw
C              write (710,*)
C     +         iwfd,betaest,sigmawst,wgrid(iwfd)
C     +         ,ftranem(iwfd)
C             end do
C             close (710)

             nhalf = nint(5.0D-1*dble(nsim1))
             do isim = 1, nhalf
                sh(isim,1) = gasdev(iseed)
                sh(isim,2) = gasdev(iseed)
             end do

             do isim = nhalf+1, nsim1
                sh(isim,1) = -sh(isim-nhalf,1)
                sh(isim,2) = -sh(isim-nhalf,2)
             end do

C             open (unit = 710, file = 'sh.out')
C               do isim = 1, nsim1
C                 read (710,*) isim1, sh(isim,1), sh(isim,2)
C               end do
C             close (710)

          do ip1 = 1, nperson
            do iwk = 1, niw
            do iwfd = 1, niw
              ftranm(iwk,iwfd) = 0.0D0
            end do
            end do

            do irk = 1, niw
                  fsum = 0.0D0
                do iwfd = 1, niw
                  ff = dlog(wgrid(iwfd))
     +                -beta1st*z(ip1)-beta2st*dlog(wgrid(irk))
                  ff = dlog(wgrid(iwfd))+ff*ff/(2.0D0*sigmawst*sigmawst)
                  ffm(iwfd) = dexp(-ff)
                  fsum = fsum+ffm(iwfd)
                end do
                  fsumm(irk) = beta1st*z(ip1)+beta2st*dlog(wgrid(irk))

                do iwfd = 1, niw
                  ftranm(irk,iwfd) = ffm(iwfd)/fsum
                end do
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
                  emax1 = emax1+remax(iwfd,ip1)*ftranm(irk,iwfd)
                end do
                  emax0 = remax(0,ip1)
                  emaxm(irk,ip1) = emax1
	     else
                  emax1 = 0.0D0
                do iwfd = 1, niw  
                  emax1 = emax1+remax(iwfd,ip1)*ftranem(iwfd)
                end do

                  if (ip1 .eq. 1) emaxe1 = emax1
		  emaxe = emax1
                  emaxm(0,ip1) = emaxe
		  emax0 = remax(0,ip1)
             end if         

             valuen(irk,ip1) = 0.0D0
	    do isim = 1, nsim1

             if (irk .gt. 0) then
                  val1 = am(ip1)*wgrid(irk)+sigma1st*sh(isim,1)
     +                  +beta0*emax1
                  val2 = sigma2st*sh(isim,2)+beta0*emax0
             else if (irk .eq. 0) then
                  val1 = sigma1st*sh(isim,1)-entst+beta0*emax1
                  val2 = sigma2st*sh(isim,2)+beta0*remax(0,ip1)
             end if
                                                 
C ------------------------------------------------------------------
C Derive the average value function for
C future calculation of the Emax function.
C ------------------------------------------------------------------
                valuen(irk,ip1) = valuen(irk,ip1)
     +                +max(val1,val2)
	    end do

          end do

           do irk = 0, niw
                if (nsim1 .gt. 0) then
                  valuen(irk,ip1)=valuen(irk,ip1)
     +                  /dble(nsim1)
                else
                  valuen(irk,ip1) = remaxo(irk,ip1)
                end if                            
           end do    

         end do

C ==============================================================
C Reorder value functions and parameters.
C ==============================================================
          do iord = 1, nord-1
C -----------------------------------------
C Reorder the parameters.
C -----------------------------------------
            do ipar1 = 1, 9
              param(iord,ipar1) = param(iord+1,ipar1)
            end do
            do ip1 = 1, nperson
              pam(iord,ip1)     = pam(iord+1,ip1)
            end do
            do irk = 0, niw
            do ip1 = 1, nperson
              value(irk,iord,ip1) = value(irk,iord+1,ip1)
            end do
            end do
          end do

           if (igibb .le. 0) then

             param(nord,1) = entrue
             param(nord,2) = b1true
             param(nord,3) = b2true
             param(nord,4) = swtrue
             param(nord,5) = s1true
             param(nord,6) = s2true
             param(nord,7) = betrue
             param(nord,8) = atrue
             param(nord,9) = asdtrue

             enter  = entrue
             a      = atrue
             beta1  = b1true
             beta2  = b2true
             sigmaw = swtrue
             sigma1 = s1true
             sigma2 = s2true
             betae  = betrue
             asd    = asdtrue
           else
             param(nord,1) = entst
             param(nord,2) = beta1st
             param(nord,3) = beta2st
             param(nord,4) = sigmawst
             param(nord,5) = sigma1st
             param(nord,6) = sigma2st
             param(nord,7) = betaest
             param(nord,8) = ameanst
             param(nord,9) = asdst
           end if

            do irk = 0, niw
            do ip1 = 1, nperson
              value(irk,nord,ip1) = valuen(irk,ip1)
            end do
            end do

C ==========================================================
C Now, generate nsim new data.
C ==========================================================

	  if (igibb .eq. 100000) then
            open (unit = 610, file = 'bch.out')
                 do iparam1 = 1, 9
                   write (610,'(I5,1X,F12.7)')
     +             iparam1, param(nord,iparam1)
                 end do
                    ip1 = 1
	         do iwd = 0, niw
	            write (610,'(I5,1X,4(F12.8,1X))')
     +			 iwd,emaxe1
     +			,value(iwd,nord,ip1)
     +                  ,remaxo(iwd,ip1)
     +			,remaxo(iwd,ip1)-value(iwd,nord,ip1)
	         end do
            close (610)
	  end if

          if (igibb .eq. 100000) then
                pause
          end if


C	    print *, 'itcheck', itcheck
 1000	  continue

	   close (203)
	   close (202)

	   end
