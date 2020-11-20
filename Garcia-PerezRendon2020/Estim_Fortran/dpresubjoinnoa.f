!**************************************************
!     Constants
!**************************************************
      xle=0.d0
      sigc=1-sig
      
      xdef=-1.d+20           !default constant
      xtolu=1.d-6      


!     Initialize constants      
	mtot=15  !25 or 5 10 160 100

!	VR- constants
	tyret=80
	grcons=(rbet**(1.d0/sig))/(1.d0+r)
	vbgammas=(1.d0-grcons**(tyret+1))/(1.d0-grcons)
	vbgammas=vbgammas**sig
	vbbeta=(1.d0-bet**(tyret+1))/(1.d0-bet)
	vr1=vbgammas
	vr2=vbbeta
!**************************************************
!     Constants end
!**************************************************
        

!*************************
!     Wage-array (W)
!*************************           
      call build_array_exp2(wmn,wmx,nw,w,umn,umx)
	gridu=(umx-umn)/nw      

	wei=0.d0
	cum=0.d0
      do l=1,2
	  xtrun=0.0
       do j=1,nw
	    aux1 = (log(w(j,l))-gridu/2-xm(l))/std(l)
	    aux2 = (log(w(j,l))+gridu/2-xm(l))/std(l)
         wei(j,l)=cumn(aux2)-cumn(aux1) 
          xtrun=xtrun+wei(j,l)
        end do
        cum(1,l)=0.d0
        wei(1,l)=wei(1,l)/xtrun
       do j=2,nw
          wei(j,l)=wei(j,l)/xtrun
          cum(j,l)=cum(j-1,l)+wei(j-1,l)
        end do
  	  w(0,l)=bmin(l)
      enddo
     
     
!*************************
!     Asset-array (AA)
!*************************                 
	a0=max(-spar*(min(bmin(1)+bmin(2),w(1,1)+w(1,2)))*(1.d0+r)/r,amn)
      call build_array(a0,amx,na,aa)      
      
      grida=(amx-a0)/(na-1)
      
      if(iwhat.eq.3)then
      write(*,"(7(a10,f8.0,1x),a10,f5.2)")
     * 'bmin1= ',bmin(1),'bmin2= ',bmin(2),
     * 'Cmin=',a0+(min(bmin(1)+bmin(2),w(1,1)+w(1,2)))-a0/(1.d0+r),
     * 'minwages=',min(bmin(1)+bmin(2),w(1,1)+w(1,2)),
     * 'pvbw=', (min(bmin(1)+bmin(2),w(1,1)+w(1,2)))*(1.d0+r)/r,
     * 'amn=',amn,'a0=',a0,'spar=',100*spar
      endif
      
	tag=3
	indexx(1) = 1                 ! - index(1) is the first person the proc does and index(2) is the last person      
      do j = 1, nproc - 1
      indexx(2) = indexx(1) +1  ! - set last person
!	write(*,*) 'hello master tag rank',tag,j
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=1
	  indexx(1) = indexx(2) + 1         ! - update beginning
      end do !do j = 1, nproc - 1      
      
!**********************************************************
!     initialize. send necessary objects     
!**********************************************************
        call mpi_bcast(wei,2*nw,
     *  mpi_double_precision,0, mpi_comm_world,ier)
!        write(*,*)'wei'
        call mpi_bcast(cum,2*nw,
     *  mpi_double_precision,0, mpi_comm_world,ier)
!        write(*,*)'wei'

        call mpi_bcast(w,2*(nw+1),
     *  mpi_double_precision,0, mpi_comm_world,ier)
!        write(*,*)'wei'
        call mpi_bcast(aa,na,
     *  mpi_double_precision,0, mpi_comm_world,ier)

      xparal(1)=sig            !#

      xparal(2)=bmin(1)
      xparal(3)=bmin(2)

      xparal(4)=xlu(1)

	xparal(5)=xlo(1)
      xparal(6)=xt(1)
      xparal(7)=xm(1)
      xparal(8)=std(1)

      xparal(9)=xlu(2)
      xparal(10)=xlo(2)
      xparal(11)=xt(2)
      xparal(12)=xm(2)
	xparal(13)=std(2)
      
      xparal(14)=spar

	xparal(15)=slei(1)
	xparal(16)=slei(2)
	xparal(17)=slei(3)
      xparal(18)=r
      xparal(19)=bet
      xparal(20)=amx
      xparal(21)=amn
      xparal(22)=a0      
      
      xparal(23)=wmx
      xparal(24)=wmn
	xparal(25)=umx
      xparal(26)=umn
      
      xparal(27)=xcost(1)
      xparal(28)=xcost(2)
      xparal(29)=xcost(3)


      call mpi_bcast(xparal,29,
     *  mpi_double_precision,0,mpi_comm_world,ier)


!*****************************************************************************
!******Solution to DP problem ************************************************
!*****************************************************************************
      itime=0      
	jrv=nw
	v=xdef
      apt=0.d0

	bw=0.d0
      ibw=0
      
	eom=0.d0 !-xdef
	eo=0.d0 !xdef

!            write(*,*) 'itime0'
!****************************************
!******Utility function+Initialize V*****
!****************************************
          i=1
        an=aa(i)
        do 30 k=0,nw
	    ie2=1-min(k,1)
          do 28 j=0,nw
	      ie1=1-min(j,1)
!            con=an+w(j,1)+w(k,2)-a0/(1.d0+r)
            con=w(j,1)+w(k,2)                        
!	write(*,*)an,+w(j,1),w(k,2),con
              if (con.gt.0.d0)then
!            v(j,k,i)=(vr1*con**sigc-vr2)/sigc
            v(j,k,i)=con/(1+r)
!     *  +ie1*slei(1) +ie2*slei(2)+ie1*ie2*slei(3) !u(ib,j,k,i)
          endif
 28       enddo
 30     enddo
      
      
        goto 2800
2700  continue        
      
      itagmax=0
	tag=4
	nitot=nw
      icount=nve      
	eom=-xdef
	eo=xdef

      numsent  = 0                 
	indexx(1) = 0                 ! - index(1) is the first person the proc does and index(2) is the last person
      do j = 1, nproc - 1
      indexx(2) = indexx(1) + icount - 1  ! - set last person
      evv(0:nw,1:indexx(2)-indexx(1)+1,1:na)=
     *      ev(0:nw,indexx(1):indexx(2),1:na)
      
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=2
	call mpi_send(evv,nv*(nw+1)*na,mpi_double_precision,
     *      j,tag,mpi_comm_world,ier) !tag=2      
	  indexx(1) = indexx(2) + 1         ! - update beginning
	numsent = numsent + icount       ! - update number sent
      end do !do j = 1, nproc - 1

!      write(*,*)'tag',tag
      num_received = 0                   ! - number received
	do while (num_received .lt. nitot+1)
c	write(*,*)'num_received',num_received
      call mpi_recv(ixx,2,mpi_integer,mpi_any_source, !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 isender=status(mpi_source)
	 itag= status(mpi_tag) 
	 call mpi_recv(vv,nv*(nw+1)*na,mpi_double_precision,isender,   !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
      itagmax=max(itag,itagmax)
      
      do k=ixx(1),ixx(2)
      do j=0,nw      
      i=1
      vm=v(j,k,i)
      vn=vv(j,k+1-ixx(1),i)+bw                     
        v(j,k,i)=vn
            eo=max(eo,vn-vm)
            eom=min(eom,vn-vm)    
      enddo                  
      enddo      
      num_received = num_received + ixx(2)-ixx(1)+1
      
       if ( numsent .lt. nitot+1)then
          indexx(2) = min(indexx(1) + icount - 1,nitot)
!          k1=indexx(2)-indexx(1)+1          
           evv(0:nw,1:indexx(2)-indexx(1)+1,1:na)=
     *      ev(0:nw,indexx(1):indexx(2),1:na)      
	call mpi_send(indexx,2,mpi_integer,isender,tag,mpi_comm_world,ier) !tag=2
	 isender=status(mpi_source)      
	call mpi_send(evv,nv*(nw+1)*na,mpi_double_precision,isender,
     *      tag,mpi_comm_world,ier) !tag=2      
      
             numsent = numsent + indexx(2)-indexx(1)+1
             indexx(1) = indexx(2) + 1
           endif
      end do !number_received
      
      if(itagmax.eq.15)then
	write(*,*) ' '
        write(*,*) 'rent c<0'
       func=10000000000.d0
       write(*,*)func,'exit'
       goto 1801
      endif !con0
          


2800    continue

      eot=max(abs(eom),abs(eo))
      bw=0.5*bet*(eom+eo)/(1-bet)      
       write(*,"(2(1x,i3),1x,9(f15.4,1x))") itime,types,eot,eo,eom,
     *      eo-eom,bw,
     *   v(1,1,1),v(nw/2,nw/2,1),v(nw,nw,na)      

 715  format(5(f15.7,1x),3(i4,1x))
	if((eo-eom)/eot.le.0.8d0.and.ibw.eq.0.and.itime.ge.5)      
     * then
      bw=0.5*bet*(eom+eo)/(1-bet)
	ibw=1
	else
	bw=0.d0
      endif
	itime=itime+1
      if (itime.gt.mtot.or.(itime.gt.2.and.eot.le.xtolu)) go to 166      

****************************************
**********INTEGRATION*******************
****************************************
c	   print*,'Empiezo a calcular la funcion V'	

	ew=0.d0
	ewj=0.d0
	ewk=0.d0
c	solo tres integraciones
	do 2350 i = 1,na
	 u0u0=v(0,0,i)
	 j=nw
	 k=nw
	 vmax=max(v(j,k,i),v(j,0,i),v(0,k,i),u0u0)

	 ewj(j,k)=wei(j,1)*vmax
	 ewk(j,k)=wei(k,2)*vmax
	 ew(j,k)=ewj(j,k)*wei(k,2)

	 do j = nw-1,1,-1
	  vmax=max(v(j,k,i),v(j,0,i),v(0,k,i),u0u0)


	  ewj(j,k)=ewj(j+1,k)+wei(j,1)*vmax
	  ewk(j,k)=wei(k,2)*vmax
	  ew(j,k)=ewj(j,k)*wei(k,2)

	 enddo
	 j=nw
	 do k = nw-1,1,-1
	  vmax=max(v(j,k,i),v(j,0,i),v(0,k,i),u0u0)

	  ewj(j,k)=wei(j,1)*vmax
	  ewk(j,k)=ewk(j,k+1)+wei(k,2)*vmax
	  ew(j,k)=ew(j,k+1)+ewj(j,k)*wei(k,2)
         
 	 enddo
	 do k = nw-1,1,-1
	  do j = nw-1,1,-1
	   vmax=max(v(j,k,i),v(j,0,i),v(0,k,i),u0u0)

	   ewj(j,k)=ewj(j+1,k)+wei(j,1)*vmax
	   ewk(j,k)=ewk(j,k+1)+wei(k,2)*vmax
	   ew(j,k)=ew(j,k+1)+ewj(j,k)*wei(k,2)

	  enddo
	 enddo
	 u1u1=ew(1,1)
	 u1u0=ewj(1,1)
	 u0u1=ewk(1,1)

!******************************************************
      
       y1=bet*xlub(1)*(u1u0-u0u0)+
     * bet*xlub(1)*xlu(2)*(u1u1-u1u0-u0u1-u0u0)
       y2=bet*xlub(2)*(u0u1-u0u0)+
     *  bet*xlu(1)*xlub(2)*(u1u1-u1u0-u0u1-u0u0)
       xad=2*c1
       xbd=c3-bet*xlub(1)*xlub(2)*(u1u1-u1u0-u0u1-u0u0)
       xcd=xbd
       xdd=2*c2
       s1=((xdd*y1-xcd*y2)/(xad*xdd-xbd*xcd))
       s2=((xad*y2-xbd*y1)/(xad*xdd-xbd*xcd))
!       s2=y2/xdd -(xbd/xdd)*s1
!       s1=y1/xad -(xcd/xad)*s2
       s1=min(max(s1,0.d0),1.d0)
       s2=min(max(s2,0.d0),1.d0)       
       s1=0.d0
       s2=0.d0
       sinte(0,1,i)=s1
       sinte(0,2,i)=s2
       
       xlu1=xlu(1)+xlub(1)*s1
       xlu2=xlu(2)+xlub(2)*s2
       
       xlu1=xlu(1)
       xlu2=xlu(2)
!******************************************************       
       ev(0,0,i)=xlu1*(xlu2*u1u1+(1-xlu2)*u1u0)
     *             +(1-xlu1)*(xlu2*u0u1+(1-xlu2)*u0u0)
     *  +(slei(1)-c1*s1*s1+slei(2)-c2*s2*s2+slei(3)-c3*s1*s2)/bet !+bw       

	 do 2358 k=1,nw
	  vmaxj=max(v(k,0,i),u0u0)
	  vmaxk=max(v(0,k,i),u0u0)

!******************************************************
       s2=(bet/(2*c2))*(
     * (1-xt(1))*xlo(1)*xlub(2)    * 
     *  ((ew(k,1)+ewk(k,1)*cum(k,1))-(ewj(k,1)+cum(k,1)*vmaxj))  +
     * xt(1)*xle(1)*xlub(2)        * (u1u1 - u1u0)     +
     * (1-xt(1))*(1-xlo(1))*xlub(2)* (ewk(k,1) -vmaxj) +
     * xt(1)*(1-xle(1))*xlub(2)    * (u0u1 - u0u0)     )

       s1=(bet/(2*c1))*(
     * (1-xt(2))*xlo(2)*xlub(1)    * 
     *  ((ew(1,k)+ewj(1,k)*cum(k,2))-(ewk(1,k)+cum(k,2)*vmaxk))  +
     * xt(2)*xle(2)*xlub(1)        * (u1u1 - u0u1)     +
     * (1-xt(2))*(1-xlo(2))*xlub(1)* (ewj(1,k) -vmaxk) +
     * xt(2)*(1-xle(2))*xlub(1)    * (u1u0 - u0u0)     )

       s1=min(max(s1,0.d0),1.d0)
       s2=min(max(s2,0.d0),1.d0)       
       s1=0.d0
       s2=0.d0
       
       sinte(k,1,i)=s1
       sinte(k,2,i)=s2
       
       
       xlu1=xlu(1)+xlub(1)*s1
       xlu2=xlu(2)+xlub(2)*s2
        
       xlu1=xlu(1)
       xlu2=xlu(2)
!******************************************************       

	  ev(k,0,i)=                                ! hombre trabaja
     *  (1-xt(1))*xlo(1)*xlu2        *(ew(k,1)+ewk(k,1)*cum(k,1))    !e1u1
     *+xt(1)*xle(1)*xlu2            *u1u1                           !u1u1
     *+(1-xt(1))*xlo(1)*(1-xlu2)    *(ewj(k,1)+cum(k,1)*vmaxj)      !e1u0
     *+xt(1)*xle(1)*(1-xlu2)        *u1u0                           !u1u0
     *+(1-xt(1))*(1-xlo(1))*xlu2    *ewk(k,1)                       !e0u1
     *+xt(1)*(1-xle(1))*xlu2        *u0u1                           !u0u1
     *+(1-xt(1))*(1-xlo(1))*(1-xlu2)*vmaxj 			                !e0u0
     *+xt(1)*(1-xle(1))*(1-xlu2)    *u0u0                           !u0u0 
     *  +(slei(2)-c2*s2*s2)/bet        
        

        
	  ev(0,k,i)=                                ! mujer trabaja
     * (1-xt(2))*xlo(2)*xlu1        *(ew(1,k)+ewj(1,k)*cum(k,2))   !u1e1
     *+xt(2)*xle(2)*xlu1            *u1u1                          !u1u1
     *+(1-xt(2))*xlo(2)*(1-xlu1)    *(ewk(1,k)+cum(k,2)*vmaxk)     !u0e1
     *+xt(2)*xle(2)*(1-xlu1)        *u0u1                          !u0u1
     *+(1-xt(2))*(1-xlo(2))*xlu1    *ewj(1,k)                      !u1e0
     *+xt(2)*(1-xle(2))*xlu1        *u1u0                          !u1u0
     *+(1-xt(2))*(1-xlo(2))*(1-xlu1)*vmaxk                         !u0e0
     *+xt(2)*(1-xle(2))*(1-xlu1)    *u0u0                          !u0u0 
     *  +(slei(1)-c1*s1*s1)/bet                

************************************************

	  do 2356 j = 1,nw
	   vmaxj=max(v(j,0,i),u0u0)
	   vmaxk=max(v(0,k,i),u0u0)
	   vmax=max(v(j,k,i),v(j,0,i),v(0,k,i),u0u0)

	   ev(j,k,i)= 
     * (1-xt(1))*xlo(1)*(1-xt(2))*xlo(2)*(ew(j,k)
     *+ewj(j,k)*cum(k,2)+ewk(j,k)*cum(j,1)+cum(j,1)*cum(k,2)*vmax)   !e1e1
     *+(1-xt(1))*xlo(1)*xt(2)*xle(2)    *(ew(j,1)+ewk(j,1)*cum(j,1)) !e1u1
     *+xt(1)*xle(1)*(1-xt(2))*xlo(2)    *(ew(1,k)+ewj(1,k)*cum(k,2)) !u1e1
     *+xt(1)*xle(1)*xt(2)*xle(2)        *u1u1                        !u1u1 
     *+(1-xt(1))*xlo(1)*(1-xt(2))*(1-xlo(2))*(ewj(j,k)+cum(j,1)*vmax)!e1e0
     *+(1-xt(1))*xlo(1)*xt(2)*(1-xle(2))   *(ewj(j,1)+cum(j,1)*vmaxj)!e1u0          
     *+xt(1)*xle(1)*(1-xt(2))*(1-xlo(2))   *ewj(1,k)                 !u1e0 
     *+xt(1)*xle(1)*xt(2)*(1-xle(2))        *u1u0                    !u1u0 
     *+(1-xt(1))*(1-xlo(1))*(1-xt(2))*xlo(2)*(ewk(j,k)+cum(k,2)*vmax)!e0e1  
     *+(1-xt(1))*(1-xlo(1))*xt(2)*xle(2)    *ewk(j,1)                !e0u1 
     *+xt(1)*(1-xle(1))*(1-xt(2))*xlo(2)  *(ewk(1,k)+cum(k,2)*vmaxk) !u0e1
     *+xt(1)*(1-xle(1))*xt(2)*xle(2)        *u0u1                    !u0u1 
     *+(1-xt(1))*(1-xlo(1))*(1-xt(2))*(1-xlo(2))*vmax                !e0e0
     *+(1-xt(1))*(1-xlo(1))*xt(2)*(1-xle(2))    *vmaxj		       !e0u0
     *+xt(1)*(1-xle(1))*(1-xt(2))*(1-xlo(2))    *vmaxk               !u0e0
     *+xt(1)*(1-xle(1))*xt(2)*(1-xle(2))        *u0u0                !u0u0		


2356  enddo
2358  enddo

2350  enddo

      
      go to 2700
   

166   continue

      
!********Export reservation wage
      if (iwhat.eq.3)then      

	do i=1,na
	  do k=nw,1,-1
           if(v(0,k,i).ge.v(0,0,i)) jrv(0,i,2)=k             
          do j=nw,1,-1
            vm=max(v(j,k,i),v(j,0,i))
           if(vm.ge.max(v(0,k,i),v(0,0,i))) jrv(k,i,1)=j 
	enddo               !end of k-loop
       enddo                 !end of j-loop
	
	  do j=nw,1,-1
           if(v(j,0,i).ge.v(0,0,i)) jrv(0,i,1)=j            
          do k=nw,1,-1
            vm=max(v(j,k,i),v(0,k,i))
            if(vm.ge.max(v(j,0,i),v(0,0,i)))  jrv(j,i,2)=k   
           enddo               !end of k-loop
          enddo                 !end of j-loop
      enddo                  !end of i-loop


 531    format(5(2x,i4))
 532    format(1x,i4,3(1x,f9.2))
      endif
!********Export reservation wage      
!      write(1,*)u0u0,u0u0P,'u0u0'
!      write(*,*)V1(23,4,6),V(23,4,6),ap(23,4),'ap'
      
      
      
	tag=6
	indexx(1) = 1                 ! - index(1) is the first person the proc does and index(2) is the last person      
      do j = 1, nproc - 1
      indexx(2) = indexx(1) +1  ! - set last person
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=1
	  indexx(1) = indexx(2) + 1         ! - update beginning
      end do !do j = 1, nproc - 1      
      
        call mpi_bcast(v,na*(1+nw)*(1+nw),
     *  mpi_double_precision,0, mpi_comm_world,ier)
        call mpi_bcast(sint,na*(nw+1)*2,       
     *  mpi_double_precision,0, mpi_comm_world,ier)

      
!**************************************************************************
!     DP-PROBLEM SOLVED
!**************************************************************************

!************************************
!     Simulations-->Moments
!************************************      
!      write(*,*) 'Run Simulation',nmquest,nmquests      
!**************************************************************     
      tag=7
      icount=nmquests/(nproc-1)      
	nitot=nmquests
      numsent  = 0                 
	indexx(1) =1                  ! - index(1) is the first person the proc does and index(2) is the last person
      do j = 1, nproc - 1
      indexx(2) = indexx(1) + icount - 1  ! - set last person
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) 
	  indexx(1) = indexx(2) + 1         ! - update beginning
	numsent = numsent + icount       ! - update number sent
      end do !do j = 1, nproc - 1

!         write(*,*)'compute simulated moments'      
      xmoments=0.d0                      
      num_received = 0                   ! - number received
	do while (num_received .lt. nitot)
      call mpi_recv(ixx,2,mpi_integer,mpi_any_source, !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 isender=status(mpi_source)      
	 itag= status(mpi_tag)        
       ndata=ixx(2)-ixx(1)+1
       call mpi_recv(xmomentz,maxmom,
     *	mpi_double_precision,isender,
     *    mpi_any_tag,mpi_comm_world,status,ier)
       
!     Create Moments      
       do m=1,nmoment
        xmoments(m)=xmoments(m)+xmomentz(m)
       enddo
!         write(*,*)num_received,'num_received,tag=',tag
      num_received = num_received + ixx(2)-ixx(1)+1
       if ( numsent .lt. nitot)then
          indexx(2) = min(indexx(1) + icount - 1,nitot)
	call mpi_send(indexx,2,mpi_integer,isender,tag,mpi_comm_world,ier) !
             numsent = numsent + indexx(2)-indexx(1)+1
             indexx(1) = indexx(2) + 1
       endif
      end do !number_received
!************************************
!     Moments done
!************************************ 
