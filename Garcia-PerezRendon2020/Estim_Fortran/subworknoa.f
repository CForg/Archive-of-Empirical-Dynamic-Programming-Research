      
      subroutine subwork
	implicit none
!*******************************************************************************
!***** Declaration of variables(Separated for each part of the program )   *****
!*******************************************************************************
!*	Input Arguments
	integer	na,nw,mtot,nc,nic,niw,nn,tbig
	integer	nmquest,nmobs,nre,nmquests,l,k,j,maxmom,npeople
	parameter(na=1,nw=101,nc=251,maxmom=20000,
     *	tbig=8,nmobs=48,
     *    npeople=140000)            
	real*8 amx,amn,wmx,wmn,umx,umn,grida,at1
	real*8	xdef,xtolu,bet,r,rbet
      
	common /bounds/ umn,umx,wmn,wmx,amn,amx,gridu
      character*30 filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes, 
     *     filehaz1,filehaz2,fileorp,
     *    filetexr,filetexa,filetex,filemomx
      character*100 xtitlef(30)
      character*4 heq,heq2
      common /files/ filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes,filehaz1,filehaz2,fileorp,
     *    filetexr,filetexa,filetex,filemomx,xtitlef,heq,heq2
	common /pars/ sig,bmin,xlu,xle,xlo,xt,xm,std,
     *        slei,spar,slow,shigh,a0,splow,sphigh
	intrinsic max,min,abs
!*	output arguments
	real*8  opcion
      integer kp,jp,kq,jq,iia,jja,kw,jw,ndata
!*	getting parameters
	real*8  sig,sigc,bmin(2),xlu(2),xle(2),xt(2),xm(2),std(2),
     * xlo(2),slei(3),spar,slow,shigh,a0,ap0,apx,ap1,vnap,vnaph,splow,
     * sphigh
      integer ifault
!*	wage-array (w)
	real*8  gridu,uw,uw1,uw2,xtrun,w(0:nw,2),aux1,aux2,wei(nw,2)

	real*8  cum(nw,2),cumn
	external cumn,desmoment

!*	Initialize
      integer nve,nv,kv
      parameter (nve=7,nv=7)
      real*8	evv(0:nw,nv,na),eve(0:nw,0:nw,nve)      
      real*8	vv(0:nw,nv,na),ve(0:nw,0:nw,nve)      
!	real*8  ap(0:nw,0:nw), apt(0:nw,0:nw,na)        !,u(na,0:nw,0:nw,na)
	real*8  apv(0:nw,nv), aptv(0:nw,nv,na)        !,u(na,0:nw,0:nw,na)            
	real*8  ag(na),vx1(na),conv(na),convh(na),vx,yd,x1,x2,sumx1,
     * sumx1x2,
     *   sumx2,sumx22,sumy,sumx1y,sumx2y,sumx12,det,b1,b2,b0,alow,con0
	integer j1,j2,itime,i,i0,nto
	integer he1,we1,iassi,init      
!******
!* Solucion to DP problem
!******
!*	Utility function + Initialize V	
	real*8  an,earn,con,wp,wpa,aw1,awn,aw2(na),a,aprime,da,da1,
     *	ds,dv,aam,bbm,ccm,ddm,evder
	integer ii,jo,ilow,m,n,klo,khi,ki,jj,kmlag,lu
!*	integration
	real*8	vuu,vee,u11,u10,u01,u0u0,u0u1,u1u0
	real*8  u1u1,vmaxj,vmaxk,ew(nw,nw),ewj(nw,nw),ewk(nw,nw),evn
!*	integration marginal
	real*8	u11p,u10p,u01p,u0u0p,u0u1p,u1u0p
	real*8  u1u1p,vmaxjp,vmaxkp,ewp(nw,nw),ewjp(nw,nw),ewkp(nw,nw)
!*	dp-compsumption
	real*8  eom,eo,vn,vm,eot,vue,veu,vm1,vm2,eotx,eox,eomx
     *,vmax,vmax1,vmax2,vmaxj1,vmaxj2,vmaxp
!*	policy rules: assets tomorrow / reservation wages
!	integer ia(0:nw,0:nw,na)
	integer j1r,j2r,jrv(0:nw,na,2)
!	integer ind(0:nw,0:nw,na) 
!*	dp-problem solved
!**
!**	This part only writes the results in the file: 'resultados.out'
!**
!******
!* Added for the likelihood function
!******
!*	Transition probabilities when 4 options are available
	integer	i1!,npy
!c     read the data from the sample
!	real*8	at(nn),ylh(nn),ylw(nn),yt(nn)
      real*8 aa(na)!,aa1(na)
!*	likelihood function
	real*8	atruesim
	integer t,tt
	integer io,ie1,ie2,io1,ited,nmo,itel,
     * iq1,iq2,ip1,ip2,nmoment,nmoments
	integer itrue,j1true,j2true,icollapse,irepa
	integer ifecha(8)
	integer jres,j1n,j2n,itip,jre1,jre2,jre1m,jre2m,ivalid,ivalid00
	integer ivalid01,ivalid10,ivalid1,ivalid2
      real*8 rdraw(3,2,nmobs,npeople)
	common /randmatrix/ rdraw
	real*8 a1!,a2,a3,a4,w1,w2,w3,w4
	integer !i1s(npeople,nmobs),
     * k1,k2,ll,jsim,j1d,j2d,o1,o2,il
	real*8 xoffer1, xoffer2,rs,wmig !,amas(npeople,nmobs)
	real*8 chi2,xvar,xvars,xfit1,xfit1a,xfit1b,xfit23,
     *  xfit4,xfit5,xfit6,xfit8,xfit910,xfit11,xfit14h,xfit14w,
     * dchi,xelse,xvarsx,xweight,xweight0,xvarw
	real*8 den,xzah
	integer isel,integ,thazts
!*	Brackets
	real*8 	wagmat(2,2),asse(3)
	character*10 xlabel(0:37)
!	real*8 a1,a2,a3,a4,w1,w2,w3,w4,gridu
	real*8 dw(2,2),dcm(3)
	integer ienow,ielag,irep,ibra,ielaga,ktrue
	integer lmg,tyret
	real*8 grcons,vbgammas,vbbeta,vr1,vr2,uti,xrbet!,beto
      real*8 ulo1,ulo2,uhi1,uhi2,uloa,uhia
!*	Initialize
	real*8  v(0:nw,0:nw,na),ap(0:nw,0:nw),
     *  apt(0:nw,0:nw,na)        !,u(na,0:nw,0:nw,na)
        
        
      integer thaz,isi,ise,isx,itoti,ihazs(nmobs,4,4,4),
     * thazt,inch,iass!,ihazz(nmobs,4,4,4)
      real*8 chi2m(maxmom),xmoel(maxmom),xmoelt(maxmom)      
      common /migra4/ chi2m,xmoel,xmoelt
      include 'mpif.h'               ! must include MPI fortran header
      integer status(mpi_status_size)
      integer nproc,yam,icount(13),indexx(2),ixx(2),ier,tag,isender
      real*8 xparal(29)
      common /mpiobjects/ nproc,yam

!     True data
      integer	i1m(npeople,nmobs),i2m(npeople,nmobs)
      integer	ip1m(npeople,nmobs),ip2m(npeople,nmobs)    
      integer	iq1m(npeople,nmobs),iq2m(npeople,nmobs)
!      integer	j1m(npeople,nmobs),j2m(npeople,nmobs)
      real*8 ama(npeople,nmobs),w1m(npeople,nmobs),w2m(npeople,nmobs)
	integer ts(npeople),tl(npeople),ta(npeople)      
      
!     Outsourced data      
 	integer	iamz(npeople,nmobs),i1mz(npeople,nmobs),i2mz(npeople,nmobs)
      integer	ip1mz(npeople,nmobs),ip2mz(npeople,nmobs)    
      integer	iq1mz(npeople,nmobs),iq2mz(npeople,nmobs)
      integer	j1mz(npeople,nmobs),j2mz(npeople,nmobs)
      real*8 amaz(npeople,nmobs),w1mz(npeople,nmobs),
     * w2mz(npeople,nmobs)
	integer tsz(npeople),tlz(npeople),taz(npeople)
      character*80 xlmoment(maxmom)
      real*8 xmoment(maxmom),xmomentvz(maxmom,2)
      real*8 xmomentz(maxmom),xmomentx(maxmom)
      integer istanda(maxmom),ichimo(maxmom),iproba(maxmom)
      integer nboot
      character*12 xac      

!***************************************************************************      
      real*8  y1,y2,xad,c1,xbd,c3,xcd,xdd,c2,s1,s2,xlu1,xlu2
      real*8  xlub(2),xcost(3)
      real*8  sint(0:nw,2,na),sinte(0:nw,2,nve)
!***************************************************************************      

      
      save apv,aptv,w,wei,cum,grida,aa
      save ts,tl,ta
      save ama,w1m,w2m
      save i1m,i2m,ip1m,ip2m,iq1m,iq2m
      save nmoment

      xdef=-1.d+20           !Default constant
      
1900   call mpi_recv(indexx,2,mpi_integer,0,mpi_any_tag, 
     *	mpi_comm_world,status, ier)
      tag = status(mpi_tag)          
!      write(*,*) 'worker',yam,tag,indexx(1),indexx(2)
      if(tag.eq.1)then        
	nre=indexx(1)                 ! - index(1) is the first person the proc does and index(2) is the last person      
      nmquest=indexx(2)        
      nmquests=nmquest*nre
       
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
        
        
        call mpi_bcast(rdraw,npeople*nmobs*2*3,
     *  mpi_double_precision,0, mpi_comm_world,ier)
      
      goto 1900            
      elseif(tag.eq.2)then

      call mpi_recv(iass,1,mpi_integer,0,mpi_any_tag, 
     *	mpi_comm_world,status, ier)
      !      tag = status(mpi_tag)          

       
      xmomentvz=0.d0 
      nboot=indexx(2)
      write(*,*)yam,indexx(1),indexx(2),'yam i iass nmquest'      

      do i=indexx(1),indexx(2)   
      write(*,*)yam,i,'yam i'                
	call desmoment(nmquest,ts,tl,
     * ama,w1m,w2m,i1m,i2m,ip1m,ip2m,iq1m,iq2m,
     *thazt,xmomentx,xlmoment,nmoment,4,filetex,xac,0,nboot,iass,
     * istanda,ichimo,iproba,1) !produce tables for bootstrap

!     Create Moments      
        do m=1,nmoment
        xmomentvz(m,1)=xmomentvz(m,1)+xmomentx(m)
        xmomentvz(m,2)=
     *  xmomentvz(m,2)+xmomentx(m)*xmomentx(m)
        enddo
      enddo 
	ixx=indexx
	call mpi_send(ixx,2,mpi_integer,0,tag,mpi_comm_world,ier) !send signal
      
      call mpi_send(xmomentvz,maxmom*2,
     *	mpi_double_precision,0,tag,mpi_comm_world,ier)
      
      goto 1900                      
      elseif (tag.eq.3) then                  ! integration

        call mpi_bcast(wei,2*nw,
     *  mpi_double_precision,0, mpi_comm_world,ier)

        call mpi_bcast(cum,2*nw,
     *  mpi_double_precision,0, mpi_comm_world,ier)


        call mpi_bcast(w,2*(nw+1),
     *  mpi_double_precision,0, mpi_comm_world,ier)


        call mpi_bcast(aa,na,
     *  mpi_double_precision,0, mpi_comm_world,ier)

      call mpi_bcast(xparal,29,
     *  mpi_double_precision,0,mpi_comm_world,ier)

     
	sig=xparal(1)

      bmin(1)=xparal(2)
      bmin(2)=xparal(3)

      xlu(1)=xparal(4)

	xlo(1)=xparal(5)
      xt(1)=xparal(6)
      xm(1)=xparal(7)
      std(1)=xparal(8)

      xlu(2)=xparal(9)
      xlo(2)=xparal(10)
      xt(2)=xparal(11)
      xm(2)=xparal(12)
	std(2)=xparal(13)
      
      spar=xparal(14)

	slei(1)=xparal(15)
	slei(2)=xparal(16)
	slei(3)=xparal(17)
      r=xparal(18)
      bet=xparal(19)
      
      amx=xparal(20)
      amn=xparal(21)
      a0=xparal(22)      
      
      wmx=xparal(23)
      wmn=xparal(24)
      umx=xparal(25)
      umn=xparal(26)      
      
      
      xcost(1)=xparal(27)
      xcost(2)=xparal(28)
      xcost(3)=xparal(29)      

	gridu=(umx-umn)/nw
      grida=(amx-a0)/(na-1)      
      
      
      rbet=(1.d0+r)*bet      
      sigc=1-sig      
	vv=xdef
      aptv=0.d0
      eve=0.d0
      ve=0.d0

      xle=0.d0

!*****************************      

!      xcost(1)=10000000000000.d0
!      xcost(2)=10000000000000.d0
!      xcost(3)=10000000000000.d0
      
      xlub=1.d0-xlu
       c1=slei(1)*xcost(1)
       c2=slei(2)*xcost(2)
       c3=slei(3)*xcost(3)
!*****************************       

      
      goto 1900          
      elseif (tag.eq.4) then                  ! Integration
      call mpi_recv(evv,nv*(nw+1)*na,mpi_double_precision,0,   !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
!****************************************
!**********DP-CONSUMPTION****************
!****************************************
      i=1      
      do kv=indexx(1),indexx(2)
       k=kv-indexx(1)+1
	    ie2=1-min(kv,1)
          do j=0,nw !,3
	    ie1=1-min(j,1)
	wp=w(j,1)+w(kv,2)
        vv(j,k,1)=((wp**sigc)-1.d0)/sigc       
     *	+bet*evv(j,k,1) 

	enddo               !end of j-loop
	  enddo               !end of k-loop
        
!**************************************************2
!*	choosing assets done
!**************************************************
1801  continue        
	ixx=indexx
	call mpi_send(ixx,2,mpi_integer,0,tag,mpi_comm_world,ier) !send signal
        call mpi_send(vv,nv*(nw+1)*na,
     *	mpi_double_precision,0,tag,mpi_comm_world,ier)
      
      goto 1900        
        
      elseif(tag.eq.6)then      
        call mpi_bcast(v,na*(1+nw)*(1+nw),
     *  mpi_double_precision,0, mpi_comm_world,ier)
        call mpi_bcast(sint,na*(nw+1)*2,       
     *  mpi_double_precision,0, mpi_comm_world,ier)
        
      goto 1900      

      elseif(tag.eq.7)then            

	do ll=1,indexx(2)-indexx(1)+1     !simulated individuals                           

      il=indexx(1)+ll-1
       i=int(real(il-1)/nre)+1
        t = ta(i)        !First observation with assets for individuum
        taz(ll)=ta(i)
        tlz(ll)=tl(i)
        tsz(ll)=ts(i)
!        write(*,*)i,ll,t,"i ll t"

      atruesim=ama(i,t)
      k=1
	amaz(ll,t)=atruesim !Wealth              
      
	ie1=i1m(i,t)
	ie2=i2m(i,t)
      i1mz(ll,t)=ie1        !Employment Status
	i2mz(ll,t)=ie2        !Employment Status
      
      j1=0
      j2=0
      if(ie1.eq.1) j1=min(max(1+int((log(w1m(i,t))-umn)/gridu),1),nw)  !Wage 1
      if(ie2.eq.1) j2=min(max(1+int((log(w2m(i,t))-umn)/gridu),1),nw)  !Wage 2

	j1mz(ll,t)=j1        !Wage 1
	j2mz(ll,t)=j2       !Wage 2
	iamz(ll,t)=k !Wealth
!	w1mz(ll,t)=w(j1,1)        !Wage 1
!	w2mz(ll,t)=w(j2,2)       !Wage 2
      w1mz(ll,t)=w1m(i,t)       !Wage 1
	w2mz(ll,t)=w2m(i,t)       !Wage 2

      
      ip1mz(ll,t)=ip1m(i,t)
	ip2mz(ll,t)=ip2m(i,t)
	iq1mz(ll,t)=iq1m(i,t)
	iq2mz(ll,t)=iq1m(i,t)
      
!*************************************************************
!*******************
!Subsequent observations
!*******************
      
!************************      
	do t=t+1,tl(i)		!Subsequent observations
       xlu1=xlu(1)+xlub(1)*sint(j2,1,k)
       xlu2=xlu(2)+xlub(2)*sint(j1,2,k)
!      xlu1=xlu(1)
!      xlu2=xlu(2)

! *******************
!*	Taking draws.
!*******************
!*	Unvoluntary component
!*	Respective markets
!*	Husband
!*	Fired?
	if(rdraw(1,1,t,ll).le.1.d0-xt(1).and.ie1.eq.1)then
	k1=1
	else
	k1=0
	endif
	if(ie1.eq.0)k1=1 !!!!!
!*	arrival rate
	if(ie1.eq.0)then
	xoffer1=xlu1
	elseif(ie1.eq.1)then
	xoffer1=(1-k1)*xle(1)+k1*xlo(1)
	endif
!*	offer
	if (rdraw(2,1,t,ll).le.xoffer1) then
	o1=1
!*	wagedraw
	rs=rdraw(3,1,t,ll)    
	j1d=1
      xtrun=wei(j1d,1)
      do while (rs.ge.xtrun.and.j1d.le.nw)
       xtrun=xtrun+wei(j1d,1)
       j1d=j1d+1
      end do
      j1d=max(min(j1d-1,nw),1)
	else
	o1=0
	j1d=0
	endif
!*	wife
!*	fired?
	if(rdraw(1,2,t,ll).le.1.d0-xt(2).and.ie2.eq.1)then
	k2=1
	else
	k2=0
	endif
	if(ie2.eq.0)k2=1 !!!!!
!*	Arrival rate
	if(ie2.eq.0)then
	xoffer2=xlu2
	elseif(ie2.eq.1)then
	xoffer2=(1-k2)*xle(2)+k2*xlo(2)
	endif
!*	Offer
	if (rdraw(2,2,t,ll).le.xoffer2) then
	o2=1
!*	wagedraw
	rs=rdraw(3,2,t,ll)    
	j2d=1
      xtrun=wei(j2d,2)
      do while (rs.ge.xtrun.and.j2d.le.nw)
       xtrun=xtrun+wei(j2d,2)
       j2d=j2d+1
      end do
      j2d=max(min(j2d-1,nw),1)
	else
	o2=0
	j2d=0
	endif
      
!*	Voluntary component
!*	Decide together
	vmax=max(v(0,0,k),
     * 	k1*v(j1,0,k)+(1-k1)*xdef,
     *    k2*v(0,j2,k)+(1-k2)*xdef,
     *    k1*o1*v(j1d,0,k)+(1-k1*o1)*xdef,
     *    k2*o2*v(0,j2d,k)+(1-k2*o2)*xdef,
     *    k1*k2*v(j1,j2,k)+(1-k1*k2)*xdef,
     *    k1*o1*k2*v(j1d,j2,k)+(1-k1*o1*k2)*xdef,
     *    k1*k2*o2*v(j1,j2d,k)+(1-k1*k2*o2)*xdef,
     *    k1*o1*k2*o2*v(j1d,j2d,k)+(1-k1*o1*k2*o2)*xdef)

	if(v(0,0,k).eq.vmax)then        
	 j1=0
	 j2=0
	elseif(v(j1,0,k).eq.vmax.and.k1.eq.1)then 
c	 j1=j1
	 j2=0
	elseif(v(0,j2,k).eq.vmax.and.k2.eq.1)then
	 j1=0
!c	 j2=j2
	elseif(v(j1d,0,k).eq.vmax.and.k1*o1.eq.1)then
	 j1=j1d
	 j2=0
	elseif(v(0,j2d,k).eq.vmax.and.k2*o2.eq.1)then
	 j1=0
	 j2=j2d
!c	elseif(k1*k2*v(j1,j2,k).eq.vmax)then
!c	 j1=j1
!c	 j2=j2
	elseif(v(j1d,j2,k).eq.vmax.and.k1*o1*k2.eq.1)then
	 j1=j1d
!c	 j2=j2
	elseif(v(j1,j2d,k).eq.vmax.and.k1*k2*o2.eq.1)then
!c	 j1=j1
	 j2=j2d
	elseif(v(j1d,j2d,k).eq.vmax.and.k1*o1*k2*o2.eq.1)then
	 j1=j1d
	 j2=j2d
	endif

	ie1=min(max(j1,0),1)
	ie2=min(max(j2,0),1)
      iq1=1-k1
      iq2=1-k2
      ip1=0
      ip2=0
      if(j1.eq.j1d.and.o1.eq.1)ip1=1
      if(j2.eq.j2d.and.o2.eq.1)ip2=1

	amaz(ll,t)=atruesim !Wealth      
	w1mz(ll,t)=w(j1,1)        !Wage 1
	w2mz(ll,t)=w(j2,2)       !Wage 2
	i1mz(ll,t)=ie1        !Employment Status
	i2mz(ll,t)=ie2        !Employment Status
	ip1mz(ll,t)=ip1        !Employment Status
	ip2mz(ll,t)=ip2        !Employment Status
	iq1mz(ll,t)=iq1        !Employment Status
	iq2mz(ll,t)=iq2        !Employment Status     
      enddo        !Subsequent observations
      enddo        !Simulations per individual       
!*************************************
!     Compute moments
!*************************************
      ndata=indexx(2)-indexx(1)+1  
      
	call desmoment(ndata,taz,tlz,
     * amaz,w1mz,w2mz,i1mz,i2mz,ip1mz,ip2mz,iq1mz,iq2mz,
     * thazts,xmomentz,xlmoment,nmoments,4,filetex,xac,0,0,iass,istanda,
     * ichimo,iproba,0) !0 do not produce tables for aggregation
      
      ixx=indexx
	call mpi_send(ixx,2,mpi_integer,0,tag,mpi_comm_world,ier) !send signal
      
      call mpi_send(xmomentz,maxmom,
     *	mpi_double_precision,0,tag,mpi_comm_world,ier)
      
      goto 1900                      
       
      endif
      
      return
      end
