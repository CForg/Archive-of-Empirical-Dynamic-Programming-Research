C ====================================================================
C This function generates uniform random number between (0,1)
C ====================================================================
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

            k = 1

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


C ===================================================================
C This subroutine calculates the value function for entry-exit
C decisions. 
C ===================================================================
	  subroutine value(par,ipar,ivalue,rvalue,sh,wgrid
     +		,vsim,vsimn)
          implicit double precision (a-h,o-z), integer (i-n)
             parameter (npar   = 40)
             parameter (nvalue = 40)
             parameter (niw    = 200)
             parameter (nsim   = 1000)

             dimension par(npar)
             dimension ipar(npar)
             dimension ivalue(nvalue)
             dimension rvalue(nvalue)
             dimension emax(-1:niw)
             dimension emaxn(-1:niw)
             dimension sh(nsim,2)
             dimension wgrid(0:niw)
	     dimension vsim(-1:niw)
	     dimension vsimn(-1:niw)
	     dimension ffm(-1:niw)

	     open (unit = 500, file = 'check.out')

             a      = par(1)
             enter  = par(2)
             sigma1 = par(3)
             sigma2 = par(4)
	     sigmaw = par(5)
             beta0  = par(6)
	     beta1  = par(7)
	     beta2  = par(8)
             beta1e = par(10)

C             print *, 'a      = ', a
C             print *, 'enter  = ', enter
C             print *, 'sigma1 = ', sigma1
C             print *, 'sigma2 = ', sigma2
C             print *, 'sigmaw = ', sigmaw
C             print *, 'beta0  = ', beta0
C             print *, 'beta1  = ', beta1
C             print *, 'beta2  = ', beta2
C             print *, 'beta1e = ', beta1e

C	     write (500,*) a, enter, exit
C	     write (500,*) sigma1, sigma2, sigmaw
C	     write (500,*) beta0, beta1, beta2

C	      write (500,*) '---grid points---'
C	     do iw = 0, niw
C	      write (500,*) iw,wgrid(iw)
C	     end do

C	       write (500,*) '-----shocks---'
C	     do isim = 1, nsim
C	       write (500,*) isim,sh(isim,1),sh(isim,2)
C	     end do

C	     write (500,*) '------------------------'
C ================================================================
C We calculate the value function. 
C ================================================================
C ===============================================================
C Derive the transition probability. The transition occurs
C as follows.
C  w(t+1) = beta1+beta2*w(t)+epsilon
C ===============================================================
C            write (500,*) '--- distribution ----'
C            write (500,*) 'beta1 beta2 sigmaw = ', beta1, beta2, sigmaw   
          do iw = 1, niw
               fsum = 0.0D0
                do iwf = 1, niw
                  ff = dlog(wgrid(iwf))-beta1-beta2*dlog(wgrid(iw))
                  ff1 = ff
                  ff = dlog(wgrid(iwf))+ff*ff/(2.0D0*sigmaw*sigmaw)
                  ff2 = ff
                  fsum = fsum+dexp(-ff)
                  ffm(iwf) = dexp(-ff)          
                end do

                   fsum1 = 0.0D0
                   emax(iw) = 0.0D0
                do iwf = 1, niw
                   ff = ffm(iwf)/fsum
                   emax(iw) = emax(iw)+vsim(iwf)*ff
                   fsum1 = fsum1+ff
                end do
          end do                                         
		   emax(0) = vsim(0)
C ----------------------------------------------------------------
C This is the case when the firm is an incumbent. 
C That is, iw > 0
C ----------------------------------------------------------------
	     do iw = 1, niw
	       vsimn(iw) = 0.0D0
	     do isim = 1, nsim
	       val1 = a*wgrid(iw)+sigma1*sh(isim,1)+beta0*emax(iw) 
               val2 = sigma2*sh(isim,2)+beta0*emax(0)
	       vsimn(iw) = vsimn(iw)+max(val1,val2)
	     end do
	       vsimn(iw) = vsimn(iw)/dble(nsim)
	     end do
             
C ----------------------------------------------------------------
C This is the case when the firm is an outsider.
C That is, iw = 0
C ----------------------------------------------------------------
          if (ipar(1) .eq. 1) then
	     write (500,*) ' ---- outsider ---- '
          end if
               fsum = 0.0D0
            do iwf = 1, niw
                  ff = dlog(wgrid(iwf))-beta1e
                  ff1 = ff
                  ff = dlog(wgrid(iwf))+ff*ff/(2.0D0*sigmaw*sigmaw)
                  ff2 = ff
                  fsum = fsum+dexp(-ff)
                  ffm(iwf) = dexp(-ff)
                  if (ipar(1) .eq. 1) then
                   write (500,*) iw,iwf,wgrid(iwf),beta1e,sigmaw
                   write (500,*) ff1,ff2,ffm(iwf) 
                  end if
             end do

                   fsum1 = 0.0D0
                   emaxe = 0.0D0
                do iwf = 1, niw
                   ff = ffm(iwf)/fsum
                   emaxe = emaxe+vsim(iwf)*ff
                   fsum1 = fsum1+ff
                end do

  
	       vsimn(0) = 0.0D0
	     do isim = 1, nsim
               val1 = sigma1*sh(isim,1)-enter+beta0*emaxe
               val2 = sigma2*sh(isim,2)+beta0*vsim(0)
C	       write (500,'(1(I5,1X),6(F9.5,1X))') isim
C     +		 ,sh(isim,1),sh(isim,2),val1,val2,max(val1,val2)
	       vsimn(0) = vsimn(0)+max(val1,val2)  
	     end do
	       vsimn(0) = vsimn(0)/dble(nsim)
C	       write (500,*) vsimn(0)

C ----------------------------------------------------------------
C This is the case when the firm is an outsider. 
C ----------------------------------------------------------------

C		   write (500,*) '--- emax ---'

C		 do iw = 0, niw
C		   write (500,*) iw,vsimn(iw)
C		 end do

	    close (500)

	    return
	    end



C          Use numerical_libraries
C ==============================================================
C This is the main part of the dynamic program.
C ==============================================================
	    implicit double precision (a-h,o-z), integer (i-n)
	    parameter (npar   = 40)
	    parameter (np1    = 10)
	    parameter (nvalue = 40)
	    parameter (niw    = 200)
	    parameter (riw    = 5.0D0)
	    parameter (nsim   = 1000)
	    parameter (nsim1  = 200)
	    parameter (nrand = 200)
	    dimension par(npar)
	    dimension ipar(npar)
	    dimension ivalue(nvalue)
	    dimension rvalue(nvalue)
            dimension wgrid(0:niw)
	    dimension emax(-1:niw)
	    dimension emaxn(-1:niw)
	    dimension vsim(-1:niw)
	    dimension vsimn(-1:niw)
	    dimension ffm(-1:niw)
	    dimension sh(nsim,2)
	    dimension sha(nrand)
	    dimension shx(nrand)

	    real cpsec, time0, time1, dtime

	    iseed = -1283

            open (unit = 50, file = 'inputr.dat')
              do ip1 = 1, np1
                read (50,*)
                read (50,*)
                read (50,*)
                read (50,*) par(ip1)
                print *, 'par ip1 = ', ip1, par(ip1)
              end do
            close (50)        

             amean  = par(1)
             enter  = par(2)
             sigma1 = par(3)
             sigma2 = par(4)
             sigmaw = par(5)
             beta0  = par(6)
             b1coef = par(7)
             beta2  = par(8)        
	     ast    = par(9)
             beta1e = par(10)

	     print *, 'amean =  ', amean
	     print *, 'enter =  ', enter
	     print *, 'sigma1 = ', sigma1
	     print *, 'sigma2 = ', sigma2
	     print *, 'sigmaw = ', sigmaw
	     print *, 'beta   = ', beta0
	     print *, 'b1coef = ', b1coef
	     print *, 'beta2  = ', beta2
	     print *, 'ast    = ', ast
             print *, 'beta1e = ', beta1e
C -----------------------------------------------------------
C Derive the shocks.
C -----------------------------------------------------------
                nhalf = nint(5.0D-1*dble(nsim))
             do isim = 1, nhalf
                sh(isim,1) = gasdev(iseed)
                sh(isim,2) = gasdev(iseed)
             end do  
             do isim = 1, nhalf
                sh(isim+nhalf,1) = -sh(isim,1)
                sh(isim+nhalf,2) = -sh(isim,2)
             end do

             open (unit = 710, file = 'sh.out')
              do isim = 1, nsim
                write (710,'(I6,1X,2(F20.16,1X))')
     +              isim,sh(isim,1),sh(isim,2)
              end do
             close (710)

	     do irand = 1, nrand
	        sha(irand) = gasdev(iseed)
                shx(irand) = gasdev(iseed)
	     end do

C -----------------------------------------------------------
C Derive the grid points for the random grids.
C -----------------------------------------------------------
             do iw = 1, niw
              wgrid(iw) = riw*dble(iw)/dble(niw)
             end do  

           open (unit = 650, file = 'value.out')
           open (unit = 700, file = 'sim.out')
C -----------------------------------------------------------
C Derive the simulation for each person. 
C do irand = 1, nrand
C -----------------------------------------------------------
	   do irand = 1, nrand
C --------------------------------------------------------
C We let the profit coefficient have an random effect
C error term with mean a and std. error ast
C --------------------------------------------------------
	    par(1) = amean+ast*sha(irand)
	    a      = par(1)
	    x      = shx(irand)
	    par(7) = b1coef*x
	    beta1  = par(7)
C --------------------------------------------------------
C We let the intercept for the capital transition function
C depend on x, which is different for each firm. 
C --------------------------------------------------------


	    dconv = 1.0D3
	    print *, 'irand = ', irand, a, par(1), ast
     +			,sha(irand), amean
	    print *, x, b1coef, beta1

C	    open (unit = 600, file = 'check1.out')

	     iter = 1

	    do while (dconv .ge. 1.0D-4)

                ipar(1) = 0
                 call value(par,ipar,ivalue,rvalue,sh,wgrid
     +              ,vsim,vsimn)

	         dconv1 = 0.0D0
	       do iw = 0, niw
	          dconv1 = max(dconv1,dabs(vsim(iw)-vsimn(iw)))
	       end do	    
	          dconv = dconv1
C	          print *, 'dconv = ', dconv

C		  write (600,*) '----iteration:',iter,'----'
	       do iw = 0, niw
	          vsim(iw) = vsimn(iw)
C		  write (600,*) iw,vsim(iw)
	       end do
	       
	       iter = iter+1
	    end do

C	       close (600)

	        write (650,'(I5,1X,4(F14.10,1X) )')
     +		   0, vsim(0), a, x, beta1
	       do iw = 1, niw
		write (650,'(I5,1X,2(F14.10,1X))')
     +		 iw, wgrid(iw),vsim(iw)
	       end do

C ===================================================================
C Now, simulate the data. 
C ===================================================================
	      rk1 = 1.0D0
	      iw1 = 1
	      itin  = 0
	      itout = 0
	    do isim = 1, nsim1

		if (iw1 .eq. 1) itin  = itin+1
		if (iw1 .eq. 0) itout = itout+1

	        if (iw1 .eq. 1) then
C ----------------------------------------------------------------
C Derive the emax function. 
C ----------------------------------------------------------------	      
		   fsum = 0.0D0
	          do iwf = 1, niw
		     ff = dlog(wgrid(iwf))-beta1-beta2*dlog(rk1)
		     ff = dlog(wgrid(iwf))+ff*ff/(2.0*sigmaw*sigmaw)
		     ffm(iwf) = dexp(-ff)
		     fsum = fsum+ffm(iwf) 
		  end do
		
		     emax1 = 0.0D0
		  do iwf = 1, niw
		     ff = ffm(iwf)/fsum
		     emax1 = emax1+vsim(iwf)*ff
		  end do

		     emax0 = vsim(0)
	        end if
C ---------------------------------------------------------------
C This is the case when the firm is an incumbent. 
C ---------------------------------------------------------------
		if (iw1 .eq. 1) then
		     profit = a*rk1+sigma1*gasdev(iseed)
		     val1 = profit+beta0*emax1
		     val2 = sigma2*gasdev(iseed)+beta0*emax0

		     rthout   = beta0*emax0
		     rthin    = a*rk1+beta0*emax1
		     rthresh0 = rthout-rthin

		     if (val2 .ge. val1) then
		        rkf1 = 0.0D0
		        iwf1 = 0
		     else
			rkf1 = beta1+beta2*dlog(rk1)+sigmaw*gasdev(iseed)
			rkf1 = dexp(rkf1)
			iwf1 = 1
		     end if
C -------------------------------------------------------------------
C This is the case when the firm is an outsider. 
C -------------------------------------------------------------------
		else if (iw1 .eq. 0) then

                     fsum = 0.0D0
                   do iwf = 1, niw
                     ff = dlog(wgrid(iwf))-beta1e
                     ff1 = ff
                     ff = dlog(wgrid(iwf))
     +                  +ff*ff/(2.0D0*sigmaw*sigmaw)
                     ff2 = ff
                     fsum = fsum+dexp(-ff)
                     ffm(iwf) = ff
                   end do

                     fsum1 = 0.0D0
                     emaxe = 0.0D0
                   do iwf = 1, niw
                     ff = dexp(-ffm(iwf))/fsum
                     emaxe = emaxe+vsim(iwf)*ff
                     fsum1 = fsum1+ff
                   end do

		     profit = 0.0D0
		     emax1 = emaxe
		     emax0 = vsim(0)
		     val1 = sigma1*gasdev(iseed)-enter+beta0*emax1
		     val2 = sigma2*gasdev(iseed)+beta0*emax0

                     rthout   = beta0*emax0
                     rthin    = -enter+beta0*emax1
                     rthresh0 = rthout-rthin      

		     if (val2 .ge. val1) then
		        iwf1 = 0
		     else
                        rkf1 = beta1e+sigmaw*gasdev(iseed)
                        rkf1 = dexp(rkf1)
                        iwf1 = 1
		     end if
		end if
                if (isim .gt. 100) then
		   write (700,'(3(I5,1X),6(F12.8,1X))')
     +			 isim,iw1,iwf1,rk1,rkf1,profit,x,emax1,emax0
                end if
		        rk1 = rkf1
			iw1  = iwf1
	    end do

C -----------------------------------------------------------------
C end do of do irand = 1, nrand
C -----------------------------------------------------------------
	  end do
	      close (700)
	      close (650)


	      print *, 'in out = ', itin, itout

 


	    end 
