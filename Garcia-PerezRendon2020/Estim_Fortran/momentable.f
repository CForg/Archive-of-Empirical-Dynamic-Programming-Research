      
!************************************
!     Moments
!************************************      
      m=1
*************************************
*     Table 1
*************************************
      xenum=0.d0
	do k=0,1	
	do j=0,1	
      xenum(j,k)=xmoment(m)
      m=m+1
      enddo
      enddo      
      do k=0,1	      
	do j=0,1	
      xenum(2,k)=xenum(2,k)+xenum(j,k)
      xenum(j,2)=xenum(j,2)+xenum(j,k)
      xenum(2,2)=xenum(2,2)+xenum(j,k)
      enddo
      enddo            
      
      
*************************************
*     Table 2
*************************************
      j=1
	do k=0,1	
      xewag(j,k,1,1)=xmoment(m)
      m=m+1      
      xewag(j,k,1,2)=xmoment(m)
      m=m+1
      enddo
      
*************************************
*     Table 3
*************************************
      k=1
	do j=0,1	
      xewag(j,k,2,1)=xmoment(m)
      m=m+1
      xewag(j,k,2,2)=xmoment(m)
      m=m+1
      enddo      
      
*************************************
*     Table 4
*************************************
      do k=0,1	
	do j=0,1	
      xeass(j,k,1)=xmoment(m)
      m=m+1
      xeass(j,k,2)=xmoment(m)
      m=m+1
      xeass(j,k,3)=xmoment(m)
      m=m+1
      
      enddo      
      enddo      
      
      
      
      

!     Table N 1
	do k=0,6	      
	do j=0,6	
	xwnum(j,k)=xmoment(m)
        m=m+1                          
      enddo
      enddo
	do j=0,6
	xwnub(j,1,2)=xmoment(m)
        m=m+1                          
	xwnub(j,1,1)=xmoment(m)
        m=m+1                          
      enddo
	do j=0,6
	xwnub(j,2,2)=xmoment(m)
        m=m+1                          
	xwnub(j,2,1)=xmoment(m)
        m=m+1                          
      enddo
      
      
	do k=0,6
	do j=0,6
      do i=1,3
	xwass(j,k,i)=xmoment(m)
        m=m+1                      
	enddo
	enddo
	enddo
      

*************************************
*     Table 8
*************************************
      do k=1,5
	do j=1,5	
      xetnum(j,k)=xmoment(m)
      m=m+1
      enddo      
      enddo      


*************************************
*     Table 8a
*************************************
      do k=1,5
      do j=1,5	
      xetnumr(j,k)=xmoment(m)          
      m=m+1
      enddo      
      enddo      
      
!************************************
!     Table 90t
!************************************
      
      do i=1,2
      do k=1,2	
      xetnumc(5,k,i)=xmoment(m)
      m=m+1      
	do j=1,4
      xetnumc(j,k,i)=xmoment(m)
      m=m+1
      enddo      
      enddo      
      enddo         
      
     
*************************************
*     Table 9
*************************************
      i=1
      do ll=1,2
          
      do k=1,2	
	do j=3,5	
      xetwag(j,k,i,ll)=xmoment(m)
      m=m+1
      enddo      
      enddo      
      do k=3,5	
	do j=1,5	
      xetwag(j,k,i,ll)=xmoment(m)
      m=m+1
      enddo      
      enddo      

      enddo      
*************************************
*     Table 10
*************************************
      i=2
      do ll=1,2

      do k=1,3,2
	do j=2,4,2
      xetwag(j,k,i,ll)=xmoment(m)
      m=m+1
      enddo  
      j=5
      xetwag(j,k,i,ll)=xmoment(m)
      m=m+1
      enddo      
      do k=2,4,2
	do j=1,5
      if(k.eq.2.and.j.eq.3)goto 458
      xetwag(j,k,i,ll)=xmoment(m)
      m=m+1
458   continue   
      enddo      
      enddo      
      k=5
	do j=1,5
      xetwag(j,k,i,ll)=xmoment(m)
      m=m+1
      enddo      
      
      enddo      
      
*************************************
*     Table 11
*************************************
      xetass=0.d0      
	do k=1,5	
	do j=1,5
       do i=1,3
      xetass(j,k,i)=xmoment(m)
      m=m+1	
      enddo
	enddo
      enddo
      
      
	do i=1,2
	do k=0,6
	do j=0,6
      xwptnum(j,k,i)=xmoment(m)
      m=m+1	      
	enddo
	enddo
      enddo


!************************************
!     Table 99q Quits
!************************************
      xetnumqp=0.d0
!	Transitions 8p
      do ii=-1,2
      do n=-1,2
      do l=-1,2
      do k=-1,2
      do j=1,5
      do i=1,5
	xetnumqp(i,j,k,l,n,ii)=xmoment(m)
      m=m+1
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      
      
      xetnuqp=0.d0      
      do i=1,2 
      do j=5,4,-1          
      xetnuqp(j,1,2,i)=xmoment(m)
      m=m+1
      enddo
      enddo  
!************************************
!     Table 99q Quits
!************************************
     
      
!************************************
!     Table 99p
!************************************
      do i=1,2
      xetnuqp(5,1,1,i)=xmoment(m)
      m=m+1
      do j=1,4
      xetnuqp(j,1,1,i)=xmoment(m)
      m=m+1
      enddo
      enddo
      
!************************************
!     Table 99p2  Table 12
!************************************
      do i=1,2      
      do k=9,10
      do j=1,2
      xetnuqp(j,k,1,i)=xmoment(m)
      m=m+1
      enddo
      enddo
      enddo   
      j=2
      xetnuqp(3,9,1,1)=xetnum(4,j)/(xetnum(4,j)+xetnum(2,j))      
      j=4
      xetnuqp(3,10,1,1)=xetnum(2,j)/(xetnum(2,j)+xetnum(4,j))
      j=3      
      xetnuqp(3,9,1,2)=xetnum(4,j)/(xetnum(4,j)+xetnum(3,j))
      j=4      
      xetnuqp(3,10,1,2)=xetnum(3,j)/(xetnum(3,j)+xetnum(4,j))
      
      
!************************************
!     Joint Job-to-job 2 3 4      
!      Table       T1
!************************************
       do i=1,2 !Husband  Wife
      do k=2,4
      do j=1,5
      xetnuqp(j,k,1,i)=xmoment(m)
      m=m+1
      enddo
      enddo
       enddo      

!************************************
!     Joint Job-to-job missing    5 6 7  
!      Table       T1
!************************************
       do i=1,2 !Husband  Wife
	do k=5,7
      do j=1,5
      xetnuqp(j,k,1,i)=xmoment(m)
      m=m+1
      enddo
      enddo
       enddo      

!************************************
!     Joint Quits 2 3 4
!************************************
       do i=1,2 !Husband  Wife
      do k=2,4
      do j=1,5
      xetnuqp(j,k,2,i)=xmoment(m)
      m=m+1
      enddo
      enddo
       enddo
      
!************************************
!     Joint Quits Missing     5 6 7 
!************************************
       do i=1,2 !Husband  Wife
      do k=5,7
      do j=1,5
      xetnuqp(j,k,2,i)=xmoment(m)
      m=m+1
      enddo
      enddo
       enddo
      
!************************************
!     Missing in Quits conditional 8
!************************************
       do i=1,2 !Husband  Wife
      do j=1,5
      xetnuqp(j,8,2,i)=xmoment(m)
      m=m+1
      enddo
       enddo
      
!*****************************************xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
!      m=143
!************************************
!     Table 7
!************************************
	do k=1,11      
        do j=1,6
        xassdbn(j,k)=xmoment(m)

        m=m+1  
       enddo
       enddo
      
	do k=1,11      
        do j=1,6
	  xassdbnp(j,k)=xmoment(m)
        m=m+1      
       enddo
      enddo
      

      
	do k=1,4
        do j=1,6
	  xassdbnu(j,k)=xmoment(m)
        m=m+1      
       enddo
       enddo
      
	do k=1,4
        do j=1,6
	  xassdbnpu(j,k)=xmoment(m)
        m=m+1      
       enddo
      enddo

************************************
!*     Hazard
!*************************************
      do k=1,2
      do i=1,4 !Status
      do j=1,4 
	  exhaz0(i,j,k)=xmoment(m)
        m=m+1              
      enddo
      enddo
      enddo

      
      do ibrap=1,6
      do k=1,4
      do i=1,thazt              
	  exhaz(i,k,ibrap)=xmoment(m)
        m=m+1             
      enddo
      enddo
      enddo

      
      do ibrap=1,6
      do k=1,4
      do i=2,thazt              
	  exhaz3(i,k,ibrap)=xmoment(m)
        m=m+1             
      enddo
      enddo
      enddo


      
      do n=1,2      
      do ibrap=1,6
      do k=1,5
      do i=1,thazt
      do l=1,3
	  wtdurave(i,k,ibrap,n,l)=xmoment(m)
        m=m+1                        
      enddo !l      
      enddo !i
      enddo !k      
      enddo !ibrap
      enddo !n          

!************************************
!*     Individual hazard
!*************************************


!************************************
!*     Individual hazard
!*************************************
	xlabel(0)= 'Censored spell '
      xlabel(1)= 'Unemployed '
	xlabel(2)= 'Employed '
	xlabel(3)= 'Total '

	xlabelj(1)= ' Ind Entry'
	xlabelj(2)= ' Ind Exit'
      
!     Table H 5      
      do n=1,2      
      do i=1,2          
      do l=1,2
          do k=1,2
	  exhazi0(k,l,i,6,n)=xmoment(m)
        m=m+1                            
      enddo !k
      enddo !l
      enddo !i      
      enddo !n      



!     Table H 7 8
      do n=1,2    
      do ibrap=1,6          
      do j=1,2          
      do i=1,thazt
	  exhazi(i,j,ibrap,n)=xmoment(m)
        m=m+1                        
      enddo !i
      enddo !j      
      enddo !ibrap
      enddo !n
      
      
      
!     Table H 7 8
      do n=1,2    
      do ibrap=1,6          
      do j=1,2          
      do i=2,thazt
	  exhazi3(i,j,ibrap,n)=xmoment(m)
        m=m+1                        
      enddo !i
      enddo !j      
      enddo !ibrap
      enddo !n
      
!     Table H 9      
      do l=1,3      
      do n=1,2              
          do ibrap=1,6          
      do i=2,thazt
	  wtduravin(i,ibrap,n,l)=xmoment(m)
        m=m+1                        
          enddo !i
      enddo !ibrap          
      enddo !n
      enddo !l      
      
      
      

      nmoment=m-1
!      m=nmoment
!      write(*,*) m,xmoment(m),xlmoment(m)      
      
