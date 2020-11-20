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
!      write(*,*)xdef
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
      do 40 i=1,na
        an=aa(i)
        do 30 k=0,nw
	    ie2=1-min(k,1)
          do 28 j=0,nw
	      ie1=1-min(j,1)
            con=an+w(j,1)+w(k,2)-a0/(1.d0+r)
!	write(*,*)an,+w(j,1),w(k,2),con
              if (con.gt.0.d0)then
            v(j,k,i)=(vr1*con**sigc-vr2)/sigc
!     *  +ie1*slei(1) +ie2*slei(2)+ie1*ie2*slei(3) !u(ib,j,k,i)
          endif
 28       enddo
 30     enddo
 40   enddo
      
      
!            read(*,*)
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
!	write(*,*) 'hello master tag rank',tag,j
!          k1=indexx(2)-indexx(1)+1                
      evv(0:nw,1:indexx(2)-indexx(1)+1,1:na)=
     *      ev(0:nw,indexx(1):indexx(2),1:na)
      
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=2
	call mpi_send(evv,nv*(nw+1)*na,mpi_double_precision,
     *      j,tag,mpi_comm_world,ier) !tag=2      
!	call mpi_send(bw,1,mpi_double_precision,
!     *      j,tag,mpi_comm_world,ier) !tag=2      
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
       call mpi_recv(aptv,nv*(nw+1)*na,mpi_double_precision,isender,   !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 call mpi_recv(apv,nv*(nw+1),mpi_double_precision,isender,   !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
      itagmax=max(itag,itagmax)
      
      do k=ixx(1),ixx(2)
      do j=0,nw          
      do i=1,na                
      vm=v(j,k,i)
      vn=vv(j,k+1-ixx(1),i)+bw                     
        v(j,k,i)=vn
            eo=max(eo,vn-vm)
            eom=min(eom,vn-vm)    
      apt(j,k,i)=aptv(j,k+1-ixx(1),i)
      ap(j,k)=apv(j,k+1-ixx(1))
      enddo                  
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
c	write(*,*)isender,numsent,num_received,'isender numsent
c     *   num_received'
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
 !     write(*,*) "report begins"            
      write(*,"(2(1x,i3),1x,19(f15.4,1x))") itime,types,eot,eo,eom,
     *      eo-eom,bw,
     *   v(1,1,1),v(nw/2,nw/2,na/2),v(nw,nw,na)
     *   ,sint(nw/2,na/2,1),sint(nw/2,na/2,2)
     *   ,sint(1,na/2,1),sint(1,na/2,2)
     *   ,sint(1,na,1),sint(1,na,2)
!      write(*,*)aa(1),aa(na/2),aa(na)
!      write(*,*)apt(1,1,1),apt(nw/2,nw/2,na/2),apt(nw,nw,na)      
!      write(*,*) " "

 715  format(5(f15.7,1x),3(i4,1x))
!	if(itime.eq.int(real(mtot)/3).or.itime.eq.int(2*real(mtot)/3))
!	if((itime.gt.mtot/3).and.ibw.eq.0)
!	if((itime.gt.mtot/2.or.0.5*(eo-eom).le.xtolu).and.ibw.eq.0)
!	if((itime.gt.mtot/2.or.0.5*(eox-eomx).le.xtolu).and.ibw.eq.0)
	if((eo-eom)/eot.le.0.8d0.and.ibw.eq.0.and.itime.ge.5)      
     * then
      bw=0.5*bet*(eom+eo)/(1-bet)
!	bw=0.d0
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

      
	tag=5
      icount=nv      
	nitot=na
      numsent  = 0                 
	indexx(1) =1                  ! - index(1) is the first person the proc does and index(2) is the last person
      do j = 1, nproc - 1
      indexx(2) = indexx(1) + icount - 1  ! - set last person
!	write(*,*) 'Hello master tag rank 3',tag,j,indexx(1),indexx(2)
!      ve(0:nw,0:nw,1:icount)=v(0:nw,0:nw,indexx(1):indexx(2))
      ve(0:nw,0:nw,1:indexx(2)-indexx(1)+1)=
     *      v(0:nw,0:nw,indexx(1):indexx(2))      
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=2
	call mpi_send(ve,nve*(nw+1)*(nw+1),mpi_double_precision,j,tag,
     *      mpi_comm_world,ier) !tag=2      
	  indexx(1) = indexx(2) + 1         ! - update beginning
	numsent = numsent + icount       ! - update number sent
      end do !do j = 1, nproc - 1

      ev=0.d0
      
!      write(*,*)'tag',tag
      num_received = 0                   ! - number received
	do while (num_received .lt. nitot)
c	write(*,*)'num_received',num_received
      call mpi_recv(ixx,2,mpi_integer,mpi_any_source, !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 isender=status(mpi_source)      
	 call mpi_recv(eve,nve*(nw+1)*(nw+1),mpi_double_precision,isender,   !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 call mpi_recv(sinte,nve*(nw+1)*2,mpi_double_precision,isender,   !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)

       itag= status(mpi_tag) 
      ev(0:nw,0:nw,ixx(1):ixx(2))=eve(0:nw,0:nw,1:ixx(2)-ixx(1)+1)
      sint(0:nw,ixx(1):ixx(2),1:2)=sinte(0:nw,1:ixx(2)-ixx(1)+1,1:2)      
      num_received = num_received + ixx(2)-ixx(1)+1
      
       if ( numsent .lt. nitot)then
          indexx(2) = min(indexx(1) + icount - 1,nitot)
      ve(0:nw,0:nw,1:indexx(2)-indexx(1)+1)=
     *      v(0:nw,0:nw,indexx(1):indexx(2))      
!	write(*,*) 'hello master tag rank 3',tag,isender,indexx(1),indexx(2)
	call mpi_send(indexx,2,mpi_integer,isender,tag,mpi_comm_world,ier) !tag=2
	call mpi_send(ve,nve*(nw+1)*(nw+1),mpi_double_precision,isender,
     *      tag,mpi_comm_world,ier) !tag=2      
             numsent = numsent + indexx(2)-indexx(1)+1
             indexx(1) = indexx(2) + 1
           endif
c	write(*,*)isender,numsent,num_received,'isender numsent
c     *   num_received'
      end do !number_received
!      write(*,*) ' '
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


	do i=1,na
	do k=0,nw
	write(13,531)types,i,k,jrv(k,i,1),jrv(k,i,2),
     * aa(i),w(k,1),w(jrv(k,i,1),1),w(jrv(k,i,2),2)
	enddo
	enddo
	do i=1,na
	do k=0,nw
	write(14,532) types,i,k,aa(i),w(k,1),sint(k,i,1),sint(k,i,2)
	enddo
	enddo



 531    format(5(2x,i4),5(1x,f20.5))
 532    format(3(1x,i4),5(1x,f20.5))
      endif
!********Export reservation wage      
!      write(1,*)u0u0,u0u0P,'u0u0'
!      write(*,*)V1(23,4,6),V(23,4,6),ap(23,4),'ap'
      
      
      
	tag=6
	indexx(1) = iwhat                 ! - index(1) is the first person the proc does and index(2) is the last person      
      indexx(2) = iwhat ! - set last person
      do j = 1, nproc - 1
!	write(*,*) 'Hello master tag rank',tag,j
	call mpi_send(indexx,2,mpi_integer,j,tag,mpi_comm_world,ier) !tag=1
      end do !do j = 1, nproc - 1      
      
        call mpi_bcast(v,na*(1+nw)*(1+nw),
     *  mpi_double_precision,0, mpi_comm_world,ier)
        call mpi_bcast(apt,na*(1+nw)*(1+nw),
     *  mpi_double_precision,0, mpi_comm_world,ier)
        call mpi_bcast(ap,(1+nw)*(1+nw),
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
!	write(*,*)'num_received',num_received
      call mpi_recv(ixx,2,mpi_integer,mpi_any_source, !receive
     &       mpi_any_tag,mpi_comm_world,status,ier)
	 isender=status(mpi_source)      
	 itag= status(mpi_tag)        
       ndata=ixx(2)-ixx(1)+1
       call mpi_recv(xmomentz,maxmom,
     *	mpi_double_precision,isender,
     *    mpi_any_tag,mpi_comm_world,status,ier)
!          ndata= status(mpi_tag)       
       
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
!      write(*,*)num_received,'num_received,tag=',tag, nmoment,nmquest,
!     *  nmquests
!      write(*,*) "simulation done"
!************************************
!     Moments done
!************************************ 
