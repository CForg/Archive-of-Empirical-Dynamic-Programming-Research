!**********************************************************************
!****Family Job Search and Wealth  ***********************
!**********************************************************************
	program resubjoinhetnoa
	implicit none
	integer iyear,imonth,iday,ihour,iminute,isecond,ihund,ix
	integer ifecha(8)
      integer np,isel,k
	parameter (np=29)
	real*8  xpari(np),xpari1(np)

      real*8	xbmin,r,bet
	real*8  sig,bmin(2),xlu(2),xle(2),xlo(2),xt(2),xm(2)
     *        ,std(2),slei(3),spar,slow,shigh,a0,splow,sphigh
	real*8  xlik,func,x1,xftol,xfret,p0(np),xi(np,np),xcost(3)
      character*100 xtitlef(30)
      character*4 hep(20),heq,heq2
      character*30 filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes, 
     *     fileorp,
     *    filetexr,filetexa,filetex,filemomx
      common /files/ filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes,fileorp,
     *    filetexr,filetexa,filetex,filemomx,xtitlef,heq,heq2
	common /pars/ sig,bmin,xlu,xle,xlo,xt,xm,std,
     *        slei,spar,slow,shigh,a0,splow,sphigh,xcost
      external func

	integer  i,j,iter,npy,iorp(np),numquest,inu,fin,iran,iwhat,ipar
      integer nchimo,ierror,ierr,nchi,nmoment
      integer nproc,yam,ier,indexx(2)
      
      common /quehacer/ iorp,nmoment
      common /index/ iwhat,inu,npy,ix,fin,ipar

      include 'mpif.h'               ! must include mpi fortran header            
	integer status(mpi_status_size)

      common /mpiobjects/ nproc,yam
!     Heterogeneity      
      integer types,indi_type(2,4)
      real*8 xptypes(4),xm_types(2,2),slei_types(2,2)
	common /types/ xm_types,slei_types,xptypes
      common /itypes/ indi_type

      call mpi_init(ier)
	call mpi_comm_size(mpi_comm_world,nproc,ier)
	call mpi_comm_rank(mpi_comm_world,yam,ier)
      
	write(*,*) nproc,yam,'start'
      
!***************1. What do do  **********************************    
!	iwhat=0                !Compute moments and bootstrap variances
!	iwhat=1                !estimate and transform parameters smm
!	iwhat=2                !standard deviations
!	iwhat=3                !simulations and reporting. One
!	iwhat=4                !Policy experiments
!********************************************************************
!***************2. Parameters  **********************************    
!	ipar=0                !All parameters estimated
!	ipar=1                !Pr(types) estimated
!	ipar=2                !Specific parameters of types estimated
!********************************************************************
      
      if (yam.eq.0) then      !!!Master Master Master Master Master Master Master Master Master Master Master       


      hep(1)='1hc'            !0-1 children high school
      hep(2)='2hc'            !2+ children high school
      hep(3)='1uc'            !0-1 children Univ
      hep(4)='2uc'            !2+ children Univ


      isel=1 
       open (33,file='isel.out')
      read(33,*)  isel
	close(33)


      heq=hep(isel)
      heq2=trim(heq)//'a'

!     File names
      filedata ='jsdata_'//trim(heq)//'.out'      
      filemomx='sippmomx_'//trim(heq) //'.out'            
      
	fileorp='orpar_'//trim(heq2)//'.out'                   
	filepara ='para_'//trim(heq2)//'.out' 
	filetests ='pruebas_'//trim(heq2)//'.out' 
	fileresults ='results_'//trim(heq2)//'.out'
	fileresome ='resact_'//trim(heq2)//'.out'
	fileresomedes ='respred_'//trim(heq2)//'.out'      

      filetexr ='actual_' //trim(heq2) //'.tex'
      filetexa ='actualpred_'//trim(heq2) //'.tex'      
      filetex ='predict_'//trim(heq2)
     * //'.tex'            


      open (1,file=fileresults)
      xcost(1)=10000000000000.d0
      xcost(2)=10000000000000.d0
      xcost(3)=10000000000000.d0

	
!**********************************************************************
!*	Initial Parameters                                           
!**********************************************************************
      open (5,file=filepara)
      read(5,*)  xptypes(1),xptypes(2),xptypes(3),
     * xm_types(1,1),xm_types(2,1),xm_types(1,2),xm_types(2,2),
     * slei_types(1,1),slei_types(2,1),slei_types(1,2),slei_types(2,2),
     *     bmin(1),bmin(2),
     *     xlu(1),xle(1),xlo(1),xt(1),std(1),
     *     xlu(2),xle(2),xlo(2),xt(2),std(2),sig,spar,slei(3),
     *    xcost(1), xcost(2),xcost(3),                
     *      xlik,iyear,imonth,iday,ihour,iminute,isecond,ihund,
     *    inu,iwhat,ipar
      write(*,*) "read parameters", iwhat
      write(*,1919)  xptypes(1),xptypes(2),xptypes(3),
     * xm_types(1,1),xm_types(2,1),xm_types(1,2),xm_types(2,2),
     * slei_types(1,1),slei_types(2,1),slei_types(1,2),slei_types(2,2),
     *     bmin(1),bmin(2),
     *     xlu(1),xle(1),xlo(1),xt(1),std(1),
     *     xlu(2),xle(2),xlo(2),xt(2),std(2),sig,spar,slei(3),
     *    xcost(1), xcost(2),xcost(3),
     *      xlik,iyear,imonth,iday,ihour,iminute,isecond,ihund,
     *    inu,iwhat,ipar
!      read(*,*)
1919  format(26(1x,f30.25),4(1x,f26.8),1x,i4,5(1x,i2),2(1x,i4),2(1x,i2))    !Parameter file     
      indi_type(1,1)=1
      indi_type(1,2)=1
      indi_type(1,3)=2
      indi_type(1,4)=2

      indi_type(2,1)=1
      indi_type(2,2)=2
      indi_type(2,3)=1
      indi_type(2,4)=2  
      xptypes(4)=1.d0-xptypes(1)-xptypes(2)-xptypes(3)      

!     File names and counters          
	inu=1
      ix=1
      fin=0
      p0=0.d0
      
      if (iwhat.eq.0)then                !Compute moments and bootstrap variances
      	x1=func(p0)
          write(*,*) 'function done'
          goto 173
      endif
      
!     Initialize parameters.      
      p0=0.d0
      xle=0.d0      
      
	if(iwhat.eq.1)then !maximization


	open (7,file=fileorp)
      read (7,*) npy,(iorp(k),k=1,np)
!      write (*,*) npy,(iorp(k),k=1,np)
      close (7)

      if(iorp(1).le.npy)p0(iorp(1))=log(xptypes(1)/(1-xptypes(1)))
      if(iorp(2).le.npy)p0(iorp(2))=log(xptypes(2)/(1-xptypes(2)))
      if(iorp(3).le.npy)p0(iorp(3))=log(xptypes(3)/(1-xptypes(3)))      
      

      if(iorp(4).le.npy)p0(iorp(4))=
     * log(xm_types(1,1)/(10.d0-xm_types(1,1)))
      if(iorp(5).le.npy)p0(iorp(5))=
     * log(xm_types(2,1)/(10.d0-xm_types(2,1)))
      if(iorp(6).le.npy)p0(iorp(6))=
     * log(xm_types(1,2)/(10.d0-xm_types(1,2)))
      if(iorp(7).le.npy)p0(iorp(7))=
     * log(xm_types(2,2)/(10.d0-xm_types(2,2)))

      slow=-3000.40d0
	shigh=3000.40d0

      if(iorp(8).le.npy)
     * p0(iorp(8))=log((slei_types(1,1)-slow)/(shigh-slei_types(1,1)))
      if(iorp(9).le.npy)
     * p0(iorp(9))=log((slei_types(2,1)-slow)/(shigh-slei_types(2,1)))
      if(iorp(10).le.npy)
     * p0(iorp(10))=log((slei_types(1,2)-slow)/(shigh-slei_types(1,2)))
      if(iorp(11).le.npy)
     * p0(iorp(11))=log((slei_types(2,2)-slow)/(shigh-slei_types(2,2)))

      if(iorp(12).le.npy)p0(iorp(12))=log(bmin(1))
      if(iorp(13).le.npy)p0(iorp(13))=log(bmin(2))

      if(iorp(14).le.npy)p0(iorp(14))=log(xlu(1)/(1-xlu(1)))
      if(iorp(15).le.npy)p0(iorp(15))=log(xle(1)/(1-xle(1)))

      if(iorp(16).le.npy)p0(iorp(16))=log(xlo(1)/(1-xlo(1)))
      if(iorp(17).le.npy)p0(iorp(17))=log(xt(1)/(1-xt(1)))

      if(iorp(18).le.npy)p0(iorp(18))=log(std(1)/(4.d0-std(1)))

      if(iorp(19).le.npy)p0(iorp(19))=log(xlu(2)/(1-xlu(2)))
      if(iorp(20).le.npy)p0(iorp(20))=log(xle(2)/(1-xle(2)))

      if(iorp(21).le.npy)p0(iorp(21))=log(xlo(2)/(1-xlo(2)))
      if(iorp(22).le.npy)p0(iorp(22))=log(xt(2)/(1-xt(2)))

      if(iorp(23).le.npy)p0(iorp(23))=log(std(2)/(4.d0-std(2)))

      if(iorp(24).le.npy)p0(iorp(24))=log(sig/(5.d0-sig))      
     	splow=0.00000000001d0
	sphigh=0.10d0
      if(iorp(25).le.npy)p0(iorp(25))=log((spar-splow)/(sphigh-spar))
      if(iorp(26).le.npy)
     * p0(iorp(26))=log((slei(3)-slow)/(shigh-slei(3)))

      
      if(iorp(27).le.npy)p0(iorp(27))=log(xcost(1))
      if(iorp(28).le.npy)p0(iorp(28))=log(xcost(2))
      if(iorp(29).le.npy)p0(iorp(29))=log(xcost(3))      


!**********************************************************************
!	Add in order to use Powell
!!**********************************************************************
!100	continue
      xi=0.d0
	do j=1,np
      xi(j,j)=1.d0
      enddo

	xftol=1.0e-15
	write(*,*) "start powell"
	call powell(p0,xi,npy,np,xftol,iter,xfret)

	if (iter.ge.np) then
		iter=0
      xi=0.d0
	do j=1,np
      xi(j,j)=1.d0
      enddo
		call powell(p0,xi,np,np,xftol,iter,xfret)
      endif
       write(1,*) "Done"
      
      
      call date_and_time(values=ifecha)

		write(1,1919) xptypes(1),xptypes(2),xptypes(3),
     * xm_types(1,1),xm_types(2,1),xm_types(1,2),xm_types(2,2),
     * slei_types(1,1),slei_types(2,1),slei_types(1,2),slei_types(2,2),
     *     bmin(1),bmin(2),
     *     xlu(1),xle(1),xlo(1),xt(1),std(1),
     *     xlu(2),xle(2),xlo(2),xt(2),std(2),sig,spar,slei(3),
     *    xcost(1), xcost(2),xcost(3),          
     *      xfret,ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8),  
     *    inu,iwhat,ipar
!     rewind 5       
      close(5)      
      
      elseif(iwhat.eq.2)then ! compute standard errors, do not transform !#
         
      call standev(nmoment)
      
      elseif(iwhat.eq.3)then ! just simulations
      
      open (13,file='jrv.out')      
      xtitlef(ix)="Baseline parameters"
      npy=0 !pass parameter directly      
	x1=func(p0)
      close (13)

      elseif(iwhat.eq.4)then ! just simulations
      npy=0 !pass parameter directly
	x1=func(p0)


!*******************************************
!     1 Labor market environment      
!*******************************************
!     Increase        
        ix=2
        xpari(1)=xt(1)
        xt(1)=xt(1)+0.01
        xpari1(1)=xt(1)        

        write(1,*) 'Policy Experiment  ', ix        
        xtitlef(ix)="Increase men's layoff rate"
        write(1,*) xtitlef(ix),xt(1)
        x1=func(p0)
 	  xt(1)=xpari(1)        
        
        
        ix=3
        xpari(1)=xt(2)
        xt(2)=xt(2)+0.01
        xpari1(1)=xt(2)        

        write(1,*) 'Policy Experiment  ', ix        
        xtitlef(ix)="Increase women's layoff rate"
        write(1,*) xtitlef(ix),xt(2)
        x1=func(p0)
 	  xt(2)=xpari(1)        
        

!*******************************************
!     3 Unemployment Transfers      
!*******************************************
        xbmin=100.d0      
        ix=5
        xpari(1)=bmin(1)
        bmin(1)=bmin(1)+xbmin
        xpari1(1)=bmin(1)

        write(1,*) 'Policy Experiment  ', ix        
        xtitlef(ix)="Increase men's UI"
        write(1,*) xtitlef(ix),bmin(1)
        
        x1=func(p0)
 	  bmin(1)=xpari(1)        

        ix=6
        xpari(1)=bmin(2)
        bmin(2)=bmin(2)+xbmin
        xpari1(1)=bmin(2)        

        write(1,*) 'Policy Experiment  ', ix        
        xtitlef(ix)="Increase women's UI"
        write(1,*) xtitlef(ix),bmin(2)
        x1=func(p0)
 	  bmin(2)=xpari(1)        
        
      
        ix=7
        fin=ix                
        xpari(1)=bmin(1)
        xpari(2)=bmin(2)        
        bmin(1)=bmin(1)+xbmin/2.d0
        bmin(2)=bmin(2)+xbmin/2.d0
        xpari1(1)=bmin(1)
        xpari1(2)=bmin(2)
        
        write(1,*) 'Policy Experiment  ', ix        
        xtitlef(ix)='Increase in both UI Transfers'
        write(1,*) xtitlef(ix), bmin(1),bmin(2)
        x1=func(p0)
	bmin(1)=xpari(1)
	bmin(2)=xpari(2)      

	endif      !Iwhat. Parameter reading

	write(*,*) xlik

      close (1)
!      close (2)      
!      close (3)      
!      close (31)            

      indexx=0
         do j = 1, nproc - 1    ! - if we are finished, send message with 
	call mpi_send(indexx,2,mpi_integer,j,0,mpi_comm_world,ier)
         end do !do j = 1, nproc - 1

         
      else        !workers workers workers workers workers workersworkers workers workers workers workers workers

      call subwork
      endif !end mpi assignment
      
173   continue    
!      write(*,*) 'finished all',yam
	call mpi_finalize(ier)

      stop
	end
	




 	function func(x0)
! 	real*8 function func(x0)
	implicit none
      real*8 func      
!*	Input Arguments
	integer	np,na,nw,mtot,nc,nic,niw,nn,tbig,ix,maxmom
      integer thazt,nboot
	integer	nmquest,nmobs,nre,nmquests,l,k,j,npeople
	parameter(na=1,nw=101,nc=251,np=29,
     *	tbig=8,nmobs=48,maxmom=20000,
     *    npeople=140000)            
	real*8 amx,amn,wmx,wmn,umx,umn,grida,at1
	real*8	x0(np),xdef,xtolu,bet,r,rbet
      
      character*100 xtitlef(30)
      character*4  heq,heq2
	common /bounds/ umn,umx,wmn,wmx,amn,amx,gridu
      character*30 filetexer,filehaz1er,filehaz2er
      character*2 ixlabel
      character*30 filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes, 
     *     fileorp,
     *    filetexr,filetexa,filetex,filemomx
      common /files/ filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes,fileorp,
     *    filetexr,filetexa,filetex,filemomx,xtitlef,heq,heq2
	common /pars/ sig,bmin,xlu,xle,xlo,xt,xm,std,
     *        slei,spar,slow,shigh,a0,splow,sphigh,xcost
	common /params/ xdef,xtolu,bet,r,mtot      
	intrinsic max,min,abs,sqrt
!*	Output Arguments
!*	Getting Parameters
	real*8  sig,sigc,bmin(2),xlu(2),xle(2),xt(2),xm(2),std(2),
     * xlo(2),slei(3),spar,slow,shigh,a0,ap0,apx,ap1,vnap,vnaph,splow,
     * sphigh
      integer ifault
!*	Wage-Array (W)
	real*8  gridu,uw,uw1,uw2,xtrun,w(0:nw,2),aux1,aux2,wei(nw,2)
	real*8  cum(nw,2),cumn
	external cumn

!*	Initialize
	real*8  v(0:nw,0:nw,na),ap(0:nw,0:nw),
     *  apt(0:nw,0:nw,na)        
      integer j1,j2,itime,i,i0,nto
!	integer he1,we1,iassi,init,hemp,wemp,hleft,wleft, holf,wolf    
!******
!* Solucion to DP problem
!******
!*	Utility function + Initialize V	
	real*8  an,earn,con,wp,wpa,aw1,awn,aw2(na),a,aprime,da,da1,
     *	ds,dv,aam,bbm,ccm,ddm,evder
	integer ii,jo,ilow,m,n,klo,khi,ki,jj,kmlag,lu
!*	Integration
      integer nve,nv,kp,jp,kq,jq
      parameter (nve=7,nv=7)
      real*8	ev(0:nw,0:nw,na)
      real*8  vv(0:nw,nv,na),ve(0:nw,0:nw,nve)
      real*8	evv(0:nw,nv,na),eve(0:nw,0:nw,nve)
	real*8  apv(0:nw,nv), aptv(0:nw,nv,na)        !,u(na,0:nw,0:nw,na)                         
!*	integration
	real*8	vuu,vee,u11,u10,u01,u0u0,u0u1,u1u0
	real*8  u1u1,vmaxj,vmaxk,ew(nw,nw),ewj(nw,nw),ewk(nw,nw),evn
!*	integration marginal
	real*8	u11p,u10p,u01p,u0u0p,u0u1p,u1u0p
	real*8  u1u1p,vmaxjp,vmaxkp,ewp(nw,nw),ewjp(nw,nw),ewkp(nw,nw)
!*	dp-compsumption
	real*8  eom,eo,vn,vm,eot,vue,veu,vm1,vm2,eotx,eox,eomx
     *,vmax,vmax1,vmax2,vmaxj1,vmaxj2,vmaxp
!*	Policy Rules: Assets tomorrow / Reservation wages
	integer j1r,j2r,jrv(0:nw,na,2)
!*	Transition probabilities when 4 options are available
	integer	i1,npy

      real*8 aa(na)
	integer t,tt
	integer io,ie1,ie2,io1,ited,nmo,itel
	
	integer	inu,fin
	integer itrue,j1true,j2true,icollapse
	integer ifecha(8)
	integer iorp(np),numquest      

	integer iwhat,ipar
      common /quehacer/ iorp,nmoment
      common /index/ iwhat,inu,npy,ix,fin,ipar

	real*8 zpuu(na),zpew(0:nw,na,2),summ,ztran,xg
	integer jres,j1n,j2n,itip,jre1,jre2,jre1m,jre2m,ivalid,ivalid00
	integer ivalid01,ivalid10,ivalid1,ivalid2

      real*8 valee(0:nw,0:nw),valeu(0:nw,0:nw),value(0:nw,0:nw),
     *	valuu(0:nw,0:nw),valtot(0:nw,0:nw),
     *   wman(0:nw,na),wwoman(0:nw,na),
     *   wman1(na),wwoman1(na),
     *   awman(0:nw,na),awwoman(0:nw,na),
     *   awman1(na),awwoman1(na),
     *   cwman(0:nw,na),cwwoman(0:nw,na),aiasse(0:nw,0:nw),
     *	cicons(nw,nw),airn1(0:nw,na),airn2(0:nw,na),
     *    wiw1(0:nw,na),wiw2(0:nw,na),adifa(0:nw,0:nw),bw
	integer ival(0:nw,0:nw),ival1(0:nw,0:nw),ival2(0:nw,0:nw),
     *	ivalidx,ibw,ibrap,iass
!     Inputs of desmoment
!     True data
      integer	i1m(npeople,nmobs),i2m(npeople,nmobs)
      integer	ip1m(npeople,nmobs),ip2m(npeople,nmobs)    
      integer	iq1m(npeople,nmobs),iq2m(npeople,nmobs)
      real*8 ama(npeople,nmobs),w1m(npeople,nmobs),w2m(npeople,nmobs)
	integer ts(npeople),tl(npeople),ta(npeople)      
!     Simulated data      
! 	integer	iams(npeople,nmobs),i1ms(npeople,nmobs),i2ms(npeople,nmobs)
      integer	ip1ms(npeople,nmobs),ip2ms(npeople,nmobs)    
      integer	iq1ms(npeople,nmobs),iq2ms(npeople,nmobs)
      integer	j1ms(npeople,nmobs),j2ms(npeople,nmobs)
      real*8 amas(npeople,nmobs),
     *  w1ms(npeople,nmobs),w2ms(npeople,nmobs)
	integer tss(npeople),tls(npeople),tas(npeople)            

      character*4 hep

	real*8 rdraw(3,2,nmobs,npeople)
	common /randmatrix/ rdraw
	real*8 a1,a2,a3,a4,w1,w2,w3,w4
	integer k1,k2,ll,jsim,j1d,j2d,o1,o2
	real*8 xoffer1, xoffer2,rs,wmig !,amas(npeople,nmobs)
	double precision chi2,xvar,xvars,
     * dchi,xelse,xvarsx,xweight,xweight0,xvarw
	real*8 den,xzah
	integer isel,integ
!*	Brackets
	real*8 	wagmat(2,2),asse(3)
      real*8 xa2as,xa2bs      
	character*50 xlabel(0:37)
	real*8 dw(2,2),dcm(3),ran1
	integer ienow,ielag,irep,ibra,ielaga,ktrue,
     * irepa,iran
	integer lmg,tyret
	real*8 grcons,vbgammas,vbbeta,vr1,vr2,uti,xrbet!,beto
	real*8 ylhmn,ylwmn,ytmn,ylh1,ylw1
      real*8 ulo1,ulo2,uhi1,uhi2,uloa,uhia
      character*12 xac
      character*10 xgender(2)
      integer itable
      integer thaz,isi,ise,isx,itoti,
     * inch,ihazz(nmobs,4,4,4)
      real*8 ehazs(nmobs,0:4,4,-1:4,6),
     * ehazis(nmobs,-1:2,0:1,-3:2,6,2)     
      real*8 ehazz(nmobs,0:4,4,-1:4,6),
     * ehaziz(nmobs,-1:2,0:1,-3:2,6,2)     
      
      real*8 xtoti,xtoti1,xtotij,xhazts(nmobs,4,16),!exhazs(nmobs,4,4,2),
     * exhazs2(nmobs,4,4),exhazs3(nmobs,4,4),exhazs0(4,4)
      real*8 chi2m(maxmom),xmoel(maxmom)
      real*8 xexercise(30,30,5)
      common /migra4/ chi2m,xexercise!,xmoel,xmoelt
      include 'mpif.h'               ! must include MPI fortran header
      integer status(mpi_status_size)
      integer nproc,yam,icount,indexx(2),ixx(2),ier,tag,nitot,
     *      numsent,num_received,isender,itag,itagmax
      real*8 xparal(29)
      double precision weight1,weight2,weight1c,weight2c
      common /mpiobjects/ nproc,yam
      save v,ap,apt,w,wei,cum,grida
      save ts,ta,tl
      integer nmoment,thazts,nmoments,ndata
      integer istanda(maxmom),ichimo(maxmom),iproba(maxmom)
      double precision xmoment(maxmom),xmomentv(maxmom,2),
     * xmomentvz(maxmom,2)
      double precision xxx
      character*80 xlmoment(maxmom),xaaa
      double precision xmoments(maxmom),xmomentvs(maxmom,2)
      double precision xmomentz(maxmom),xmomentypes(maxmom)
      character*80 xlmoments(maxmom)
!     Heterogeneity      
      integer types,ntypes,indi_type(2,4),iskip,types1,ltypes
      real*8 xptypes(4),xmoments_types(maxmom,4),xm_types(2,2),
     *  slei_types(2,2),xm_types1(2,2),slei_types1(2,2)
	common /types/ xm_types,slei_types,xptypes
	common /itypes/ indi_type,ntypes,ltypes,types

      real*8  y1,y2,xad,c1,xbd,c3,xcd,xdd,c2,s1,s2,xlu1,xlu2
      real*8  xlub(2),xcost(3)
      real*8  sint(0:nw,2,na),sinte(0:nw,2,nve)
!**********************************************************************
      character*1 ntypel,ixl
      character*30 filetextype


      save xmoment,xmomentv !xmoments_types
!        save nmoment
      save nmquest,nmquests,thazt

          
	func = 0.d0
!**********************************************************************
!     Get the data or moments      
!**********************************************************************
      
      
	nre=100
      
	if(inu.eq.1)then
      
!**********************************************************************
!     Bounds
!**********************************************************************
      amx=500000.d0
	amn=-30000.d0
      
      wmx=10000.d0
	wmn=300.d0

!**********************************************************************
!     Read the data from the sample
!**********************************************************************
      call read_data(filedata,nmquest,ts,tl,ta,
     * ama,w1m,w2m,i1m,i2m,ip1m,ip2m,iq1m,iq2m)   
      
      write(*,*)yam, ta(1),"ta yam 0000"
      nmquests=nmquest*nre
!**********************************************************************
      xac='Actual '        
	call desmoment(nmquest,ts,tl,
     * ama,w1m,w2m,i1m,i2m,ip1m,ip2m,iq1m,iq2m,
     *  thazt,xmoment,xlmoment,nmoment,4,filetexr,xac,1,0,iass,istanda
     * ,ichimo,iproba,1)             !iproduce=1: produce tables
      write(*,*)ts(381),'ts'
         write(*,*)'done desmoment ',nmoment
!**********************************************************************
 	tag=1
	indexx(1) = nre                 ! - index(1) is the first person the proc does and index(2) is the last person      
      indexx(2) = nmquest      
      do j = 1, nproc - 1
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=1
      end do !do j = 1, nproc - 1      
      
!**********************************************************************
!     Sending data
!**********************************************************************
        call mpi_bcast(w1m,npeople*nmobs,
     *  mpi_double_precision,0, mpi_comm_world,ier)
        call mpi_bcast(w2m,npeople*nmobs,
     *  mpi_double_precision,0, mpi_comm_world,ier)
        call mpi_bcast(ama,npeople*nmobs,
     *  mpi_double_precision,0, mpi_comm_world,ier)

        call mpi_bcast(i1m,npeople*nmobs,
     *  mpi_integer,0, mpi_comm_world,ier)
        call mpi_bcast(i2m,npeople*nmobs,
     *  mpi_integer,0, mpi_comm_world,ier)
        
        call mpi_bcast(ip1m,npeople*nmobs,
     *  mpi_integer,0, mpi_comm_world,ier)
       call mpi_bcast(ip2m,npeople*nmobs,
     *  mpi_integer,0, mpi_comm_world,ier)       
       call mpi_bcast(iq1m,npeople*nmobs,
     *  mpi_integer,0, mpi_comm_world,ier)
       call mpi_bcast(iq2m,npeople*nmobs,
     *  mpi_integer,0, mpi_comm_world,ier)
        
        call mpi_bcast(ts,npeople,
     *  mpi_integer,0, mpi_comm_world,ier)
        call mpi_bcast(tl,npeople,
     *  mpi_integer,0, mpi_comm_world,ier)
        call mpi_bcast(ta,npeople,
     *  mpi_integer,0, mpi_comm_world,ier)

        write(*,*)yam, ta(1),ts(1), tl(1),"ta send"        
!        write(*,*)yam, w1m(1,1),jw1m(1,1),"ta w send"        
!      if (iwhat.ge.3)then !random
      iran=1
	do l=1,nmquests !Individuals
	do k=1,nmobs	   !Observations
	do i=1,2           !Gender
	do j=1,3           !fired, offer, and wage draw
	rdraw(j,i,k,l)=ran1(iran)
!c	write(*,*) rdraw(j,i,k,l)
	enddo
	enddo
	enddo
	enddo
        call mpi_bcast(rdraw,npeople*nmobs*2*3,
     *  mpi_double_precision,0, mpi_comm_world,ier)
        
****** Bootstrap Moments
!**********************************************************************
	open (35,file=filemomx)   !tex            
      nboot=0      
        nboot=10000
      if (nboot.gt.0.and.iwhat.eq.0)then

      iass=1
 
      tag=2      
	nitot=nboot
      icount=nitot/(nproc-1)      
      numsent  = 0                 
	indexx(1) =1                  ! - index(1) is the first person the proc does and index(2) is the last person
      do j = 1, nproc - 1
      rs=ran1(iass)
      iass=int(100*rs)
      
      indexx(2) = indexx(1) + icount - 1  ! - set last person
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) 

      call mpi_send(iass,1,mpi_integer,j,tag,mpi_comm_world,ier)       
	  indexx(1) = indexx(2) + 1         ! - update beginning
	numsent = numsent + icount       ! - update number sent

      end do !do j = 1, nproc - 1

      write(*,*)'desmoment boot',nboot,icount
      xmomentv=0.d0                      
      num_received = 0                   ! - number received
	do while (num_received .lt. nitot)
	write(*,*)'num_received',num_received
      call mpi_recv(ixx,2,mpi_integer,mpi_any_source, !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 isender=status(mpi_source)      
	 itag= status(mpi_tag)        
       
       call mpi_recv(xmomentvz,maxmom*2,
     *	mpi_double_precision,isender,
     *    itag,mpi_comm_world,status,ier)
       
!     Create Moments      

        xmomentv(1:nmoment,1:2)=xmomentv(1:nmoment,1:2)
     *   +xmomentvz(1:nmoment,1:2)
        
!         write(*,*)num_received,'num_received,tag=',tag
      num_received = num_received + ixx(2)-ixx(1)+1
       if ( numsent .lt. nitot)then
          indexx(2) = min(indexx(1) + icount - 1,nitot)
	call mpi_send(indexx,2,mpi_integer,isender,tag,mpi_comm_world,ier) !

        rs=ran1(iass)
        iass=int(100*rs)

      call mpi_send(iass,1,mpi_integer,isender,tag,mpi_comm_world,ier)       
     
             numsent = numsent + indexx(2)-indexx(1)+1
             indexx(1) = indexx(2) + 1
       endif
      end do !number_received
!      write(*,*)num_received,'num_received,tag=',tag,nboot,nmoment,thazt
          



!!****** Bootstrap Moments done
!      write(35,*) nmoment,thazt                   
      xmomentv=xmomentv/nboot
      do m=1,nmoment
      xmomentv(m,2)=max(xmomentv(m,2)-xmomentv(m,1)*xmomentv(m,1),0.d0)
      enddo

!**********************************************************************
!     Export Moments      
!**********************************************************************
      write(35,*) nmoment,thazt
      do m=1,nmoment
      write(35,125)m,xlmoment(m),xmoment(m),xmomentv(m,1),xmomentv(m,2)
      enddo
!**********************************************************************
      else
!*******************************************************************     
!     Import Moments      
!*******************************************************************           
      read(35,*) nmoment,thazt      
      do m=1,nmoment
      read(35,125) ll,xaaa,xxx,xmomentv(m,1),xmomentv(m,2)
      enddo
!*******************************************************************           
      endif      
      close (35)
!**********************************************************************
      endif
      do m=1,nmoment
      if(xmoment(m).ne.0.d0.and.xmomentv(m,2).eq.0.d0)then
          if(xmoment(m).lt.1.d0.and.xmoment(m).gt.0.d0)then
              xmomentv(m,2)=(1-xmoment(m))*xmoment(m)
          else
              xmomentv(m,2)=xmoment(m)*xmoment(m)
              endif
      endif
      if(xmoment(m).ne.0.d0.and.xmomentv(m,1).eq.0.d0)then     
              xmomentv(m,1)=xmoment(m)          
          endif
      if(xmoment(m).eq.0.d0.or.xmomentv(m,2).eq.0.d0)ichimo(m)=0
      enddo

!*******************************************************************     
!     Finish actual moments
!*******************************************************************           
      if(iwhat.eq.0)then
         do j = 1, nproc - 1    ! - if we are finished, send message with 
	call mpi_send(indexx,2,mpi_integer,j,0,mpi_comm_world,ier)
         end do !do j = 1, nproc - 1
!          write(*,*) 'subfunction done'
          goto 1351      
      endif
!*******************************************************************     
!     Finish actual moments end
!*******************************************************************           
      
!**********************************************************************
!     Getting parameters
!**********************************************************************
      xrbet=1.d0/12.d0

!     Annual interest rate and discount factor      
      r=0.05d0
      bet=1.d0/(1.d0+r) !aaaa
!      bet=0.95d0 !1.d0/(1.d0+r)! 0.95d0   !	bet=0.98d0                   
      rbet=(1.d0+r)*bet
      write(*,"(' Annual r b b(1+r) ',3(f10.5,1x))")r,bet,rbet
!     Monthly interest rate and discount factor      
      r= (1.d0+r)**xrbet-1.d0
      bet=(bet)**xrbet
      rbet=(1.d0+r)*bet
      write(*,"('Monthly r b b(1+r) ',3(f10.5,1x))")r,bet,rbet
     
      
	if(iwhat.eq.1)then !maximization
          
      if(iorp(1).le.npy) xptypes(1)=1/(1+exp(-x0(iorp(1))))          
      if(iorp(2).le.npy) xptypes(2)=1/(1+exp(-x0(iorp(2))))          
      if(iorp(3).le.npy) xptypes(3)=1/(1+exp(-x0(iorp(3))))          
          

	if(iorp(4).le.npy) xm_types(1,1)=10.d0/(1+exp(-x0(iorp(4))))
	if(iorp(5).le.npy) xm_types(2,1)=10.d0/(1+exp(-x0(iorp(5))))
	if(iorp(6).le.npy) xm_types(1,2)=10.d0/(1+exp(-x0(iorp(6))))
	if(iorp(7).le.npy) xm_types(2,2)=10.d0/(1+exp(-x0(iorp(7))))      
      
      if(iorp(8).le.npy)slei_types(1,1)=
     *	slow+(shigh-slow)/(1+exp(-x0(iorp(8))))
      if(iorp(9).le.npy)slei_types(2,1)=
     *	slow+(shigh-slow)/(1+exp(-x0(iorp(9))))
      if(iorp(10).le.npy)slei_types(1,2)=
     *	slow+(shigh-slow)/(1+exp(-x0(iorp(10))))
      if(iorp(11).le.npy)slei_types(2,2)=
     *	slow+(shigh-slow)/(1+exp(-x0(iorp(11))))
      

	if(iorp(12).le.npy) bmin(1)=exp(x0(iorp(12)))
      if(iorp(13).le.npy) bmin(2)=exp(x0(iorp(13)))

      if(iorp(14).le.npy) xlu(1)=1/(1+exp(-x0(iorp(14))))
      if(iorp(15).le.npy) xle(1)=1/(1+exp(-x0(iorp(15))))
      if(iorp(16).le.npy) xlo(1)=1/(1+exp(-x0(iorp(16))))
      if(iorp(17).le.npy) xt(1)=1/(1+exp(-x0(iorp(17))))

	if(iorp(18).le.npy) std(1)=4.d0/(1+exp(-x0(iorp(18))))

      if(iorp(19).le.npy) xlu(2)=1/(1+exp(-x0(iorp(19))))
      if(iorp(20).le.npy) xle(2)=1/(1+exp(-x0(iorp(20))))

      if(iorp(21).le.npy) xlo(2)=1/(1+exp(-x0(iorp(21))))
      if(iorp(22).le.npy) xt(2)=1/(1+exp(-x0(iorp(22))))

	if(iorp(23).le.npy) std(2)=4.d0/(1+exp(-x0(iorp(23))))

	if(iorp(24).le.npy) sig=5.d0/(1+exp(-x0(iorp(24))))
      if(iorp(25).le.npy) spar=
     *	splow+(sphigh-splow)/(1+exp(-x0(iorp(25))))      
      
      if(iorp(26).le.npy)slei(3)=
     *	slow+(shigh-slow)/(1+exp(-x0(iorp(26))))


      
      if(iorp(27).le.npy)xcost(1)=exp(x0(iorp(27)))
      if(iorp(28).le.npy)xcost(2)=exp(x0(iorp(28)))
      if(iorp(29).le.npy)xcost(3)=exp(x0(iorp(29)))
      
      
      elseif(iwhat.eq.2)then

        xm_types(1,1)=x0(1)
	xm_types(2,1)=x0(2)
	xm_types(1,2)=x0(3)
	xm_types(2,2)=x0(4)

      bmin(1)=x0(5)
      bmin(2)=x0(6)

      xlu(1)=x0(7)
	xlo(1)=x0(8)
      xt(1)=x0(9)
      std(1)=x0(10)

      xlu(2)=x0(11)
	xlo(2)=x0(12)
      xt(2)=x0(13)
	std(2)=x0(14)

      sig=x0(15)         

	j=15
	do i=1,3
	if(xptypes(i).ne.0.d0)then
	j=j+1
	xptypes(i)=x0(j)
	endif
	enddo



      endif                  !#

      xptypes(4)=1.d0-xptypes(1)-xptypes(2)-xptypes(3)
      
      xac=' Predicted. '
      
      if(inu.eq.1)then
      xm_types1=0.d0
      slei_types1=0.d0
      endif
      
      ltypes=1
      ntypes=4

      if(ipar.eq.1.and.inu.gt.1.and.iwhat.eq.1)goto 5467  

      do types=ltypes,ntypes
	if(xptypes(types).eq.0.d0)goto 5466
      if(ipar.eq.2.and.inu.gt.1.and.iwhat.eq.1)then
      iskip=0
      do i=1,2          
      if(xm_types(i,indi_type(i,types)).
     *  ne.xm_types1(i,indi_type(i,types)))iskip=1
      enddo
      if(iskip.eq.0)goto 5466            
      endif
      
      do i=1,2
        xm(i)=xm_types(i,indi_type(i,types))
      enddo   
      
      write(*,"(1(1x,i4,a10),1x,4(f15.4,1x))") types,'xm, sleis',
     *      xm(1),xm(2),slei(1),slei(2)


      include 'dpresubjoinnoa.f'      
      
       xmoments_types(1:nmoment,types)=xmoments(1:nmoment)
5466   continue        
       enddo      !types
       
      if(inu.gt.1)then
      xm_types1=xm_types
      slei_types1=slei_types
      endif
       

5467   continue 
      
      if (ntypes.gt.ltypes) then 
!     Create Moments  
      xmoments=0.d0
       do m=1,nmoment
            do types=1,4
       xmoments(m)=xmoments(m)
     *  +xptypes(types)*xmoments_types(m,types)
            enddo
!	write(1,"(4(i5,1x),a80,1x,9(f30.8,1x))")m,
!     * ichimo(m),istanda(m),iproba(m),xlmoment(m),xmoments(m),
!     * (xptypes(types),xmoments_types(m,types),types=1,ntypes)
            enddo

      if (iwhat.ge.3) then 
            do types=ltypes,ntypes          
      xmomentypes(1:nmoment)=xmoments_types(1:nmoment,types)      
      write(ntypel,'(i1)') types
	write(ixl,'(i1)') ix
      filetextype ='prtyp_'//trim(heq2)//trim(ixl)//'_'//trim(ntypel)//
     * '.tex'
      call momentdes(fileresults,
     *  thazt,xmomentypes,xlmoment,nmoment,filetextype,xac,1,1) !no report: itex=1, produce table, iproduce=1
      enddo
      endif
      
      endif

	types=5       
!*******************************************Producing Tables       
      call momentdes(fileresults,
     *  thazt,xmoments,xlmoment,nmoment,filetex,xac,0,1) !no report: itex=0, produce table, iproduce=1
       
       
!******************************************************************************************************************************************************
!*	Measure distance between actual and predicted data
!*********************************************************************
      if(iwhat.le.4)then     
****************************************
*    Criterion Function
****************************************
      chi2m=0.d0
      func=0.d0
      ll=0
	do m=1,nmoment
      if(xmoment(m).eq.0.d0.or.xmomentv(m,2).eq.0.d0)ichimo(m)=0          

	xvar=xmoment(m)
!	xvars=min(xmoments(m),1000*xmoment(m))
!	xvars=min(xmoments(m),100000.d0)
	xvars=xmoments(m)      
      xvarw=xmomentv(m,2)

      if(ichimo(m).eq.1) then       
      chi2m(m)=(xvars-xvar)*(xvars-xvar)/xvarw 
      func=func+chi2m(m)
      endif
      if(iwhat.eq.3.and.chi2m(m).ne.0.d0.and.ichimo(m).ne.0)then
          ll=ll+1          
	write(1,"(5(i5,1x),a80,1x,5(f30.8,1x))")ll,m,
     * ichimo(m),istanda(m),iproba(m),xlmoment(m),xvar,xvars,
     *  xvarw,chi2m(m),func
      endif      
      enddo
!      func=min(func,10000000000.d0)
      func=min(func,100000000.d0)      
!		write(*,*)'at it ',inu, ' loglik= ',func
          endif
!************************************
!     Function done
!************************************      
          
      write(*,*) 'Done Simulation, Moments and Function', iwhat
       
*************************************
*     Reporting Descriptive stats 
*************************************
      if(iwhat.ge.3)then
      xac="Prediction "
       if(ix.eq.1)then          
      call momentdes(fileresomedes,
     *  thazt,xmoments,xlmoment,nmoment,filetex,xac,1,0)   !report: itex=1,no produce table, iproduce=0
      
      call des_fit(ichimo,iproba,nmoment,thazt,
     * xmoment,xmoments,xmomentv,xlmoment,filetexa)

       else
      write(ixlabel,4416),ix
4416  format(i2)         
      filetexer='exercise' // ixlabel // '_'// trim(heq2)// '.tex'

      call momentdes(fileresomedes,
     *  thazt,xmoments,xlmoment,nmoment,filetexer,xac,1,0)  !report: itex=1,no produce table, iproduce=0
      
      if(ix.eq.fin)then      
      call report_exercises
      endif         
      
       endif         !   ix      
       endif !iwhat
!      write(*,*)'reached here',iwhat
!************************************
!*     Reporting Descriptive stats done
!*************************************
 1801 continue      
          
          
          
       call date_and_time(values=ifecha)
		write(1,1919) xptypes(1),xptypes(2),xptypes(3),
     * xm_types(1,1),xm_types(2,1),xm_types(1,2),xm_types(2,2),
     * slei_types(1,1),slei_types(2,1),slei_types(1,2),slei_types(2,2),
     *     bmin(1),bmin(2),
     *     xlu(1),xle(1),xlo(1),xt(1),std(1),
     *     xlu(2),xle(2),xlo(2),xt(2),std(2),sig,spar,slei(3),
     *    xcost(1), xcost(2),xcost(3),          
     *      func,ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8),  
     *    inu,iwhat,ipar
		write(*,1919) xptypes(1),xptypes(2),xptypes(3),
     * xm_types(1,1),xm_types(2,1),xm_types(1,2),xm_types(2,2),
     * slei_types(1,1),slei_types(2,1),slei_types(1,2),slei_types(2,2),
     *     bmin(1),bmin(2),
     *     xlu(1),xle(1),xlo(1),xt(1),std(1),
     *     xlu(2),xle(2),xlo(2),xt(2),std(2),sig,spar,slei(3),
     *    xcost(1), xcost(2),xcost(3),          
     *      func,ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8),  
     *    inu,iwhat,ipar

1919  format(26(1x,f30.25),4(1x,f26.8),1x,i4,5(1x,i2),2(1x,i4),2(1x,i2))    !Parameter file   125   format(1x,i5,1x,a80,5(1x,f25.10))         
125   format(1x,i5,1x,a80,5(1x,f25.10))               
	inu=inu+1
1351  return
      end

      

      include 'subworknoa.f'

      include 'severalsubnoa.f'      

      include 'des_fit.f'
      
      include 'standevhetnoa.f'      
      

