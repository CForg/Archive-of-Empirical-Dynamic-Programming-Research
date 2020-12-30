      
!************************************
!     Moments
!************************************      
      m=1
*************************************
*     Table 1
*************************************
      xenums=0.d0
	do k=0,1	
	do j=0,1	
      xenums(j,k)=xmoments(m)
      m=m+1
      enddo
      enddo      
      do k=0,1	      
	do j=0,1	
      xenums(2,k)=xenums(2,k)+xenums(j,k)
      xenums(j,2)=xenums(j,2)+xenums(j,k)
      xenums(2,2)=xenums(2,2)+xenums(j,k)
      enddo
      enddo            
      
      
*************************************
*     Table 2
*************************************
      j=1
	do k=0,1	
      xewags(j,k,1,1)=xmoments(m)
      m=m+1      
      xewags(j,k,1,2)=xmoments(m)
      m=m+1
      enddo
      
*************************************
*     Table 3
*************************************
      k=1
	do j=0,1	
      xewags(j,k,2,1)=xmoments(m)
      m=m+1
      xewags(j,k,2,2)=xmoments(m)
      m=m+1
      enddo      
      
*************************************
*     Table 4
*************************************
      do k=0,1	
	do j=0,1	
      xeasss(j,k,1)=xmoments(m)
      m=m+1
      xeasss(j,k,2)=xmoments(m)
      m=m+1
      xeasss(j,k,3)=xmoments(m)
      m=m+1
      enddo      
      enddo      

      

!     Table N 1
	do k=0,6	      
	do j=0,6	
	xwnums(j,k)=xmoments(m)
        m=m+1                          
      enddo
      enddo

      do j=0,6
	xwnubs(j,1,2)=xmoments(m)
        m=m+1                          
	xwnubs(j,1,1)=xmoments(m)
        m=m+1                          
      enddo
	do j=0,6
	xwnubs(j,2,2)=xmoments(m)
        m=m+1                          
	xwnubs(j,2,1)=xmoments(m)
        m=m+1                          
      enddo
      
      
	do k=0,6
	do j=0,6
      do i=1,3
	xwasss(j,k,i)=xmoments(m)
        m=m+1                      
	enddo
	enddo
	enddo
      
*************************************
*     Table 8
*************************************
      do k=1,5
	do j=1,5	
      xetnums(j,k)=xmoments(m)
      m=m+1
      enddo      
      enddo      


*************************************
*     Table 8a
*************************************
      do k=1,5
      do j=1,5	
      xetnumrs(j,k)=xmoments(m)          
      m=m+1
      enddo      
      enddo      
      
!************************************
!     Table 90t
!************************************
      
      do i=1,2
      do k=1,2	
      xetnumcs(5,k,i)=xmoments(m)
      m=m+1      
	do j=1,4
      xetnumcs(j,k,i)=xmoments(m)
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
      xetwags(j,k,i,ll)=xmoments(m)
      m=m+1
      enddo      
      enddo      
      do k=3,5	
	do j=1,5	
      xetwags(j,k,i,ll)=xmoments(m)
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
      xetwags(j,k,i,ll)=xmoments(m)
      m=m+1
      enddo      
      j=5
      xetwags(j,k,i,ll)=xmoments(m)
      m=m+1
      enddo      
      do k=2,4,2
	do j=1,5
      if(k.eq.2.and.j.eq.3)goto 7458
      xetwags(j,k,i,ll)=xmoments(m)
      m=m+1
7458   continue   
      enddo      
      enddo      
      k=5
	do j=1,5
      xetwags(j,k,i,ll)=xmoments(m)
      m=m+1
      enddo      
      
      enddo      
      
*************************************
*     Table 11
*************************************
      xetasss=0.d0      
	do k=1,5	
	do j=1,5
       do i=1,3          
      xetasss(j,k,i)=xmoments(m)
      m=m+1	
      enddo
	enddo
      enddo
      
      
	do i=1,2
	do k=0,6
	do j=0,6
      xwptnums(j,k,i)=xmoments(m)
      m=m+1	      
	enddo
	enddo
      enddo
      

!************************************
!     Table 99q Quits
!************************************
      xetnumqps=0.d0
!	Transitions 8p
      do ii=-1,2
      do n=-1,2
      do l=-1,2
      do k=-1,2
      do j=1,5
      do i=1,5
	xetnumqps(i,j,k,l,n,ii)=xmoments(m)
      m=m+1
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      
      
      xetnuqps=0.d0      
      do i=1,2 
      do j=5,4,-1          
      xetnuqps(j,1,2,i)=xmoments(m)
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
      xetnuqps(5,1,1,i)=xmoments(m)
      m=m+1
      do j=1,4
      xetnuqps(j,1,1,i)=xmoments(m)
      m=m+1
      enddo
      enddo
      
!************************************
!     Table 99p2  Table 12
!************************************
      do i=1,2      
      do k=9,10
      do j=1,2
      xetnuqps(j,k,1,i)=xmoments(m)
      m=m+1
      enddo
      enddo
      enddo   
      j=2
      xetnuqps(3,9,1,1)=xetnums(4,j)/(xetnums(4,j)+xetnums(2,j))      
      j=4
      xetnuqps(3,10,1,1)=xetnums(2,j)/(xetnums(2,j)+xetnums(4,j))
      j=3      
      xetnuqps(3,9,1,2)=xetnums(4,j)/(xetnums(4,j)+xetnums(3,j))
      j=4      
      xetnuqps(3,10,1,2)=xetnums(3,j)/(xetnums(3,j)+xetnums(4,j))
      
      
!************************************
!     Joint Job-to-job 2 3 4      
!      Table       T1
!************************************
       do i=1,2 !Husband  Wife
      do k=2,4
      do j=1,5
      xetnuqps(j,k,1,i)=xmoments(m)
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
      xetnuqps(j,k,1,i)=xmoments(m)
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
      xetnuqps(j,k,2,i)=xmoments(m)
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
      xetnuqps(j,k,2,i)=xmoments(m)
      m=m+1
      enddo
      enddo
       enddo
      
!************************************
!     Missing in Quits conditional 8
!************************************
       do i=1,2 !Husband  Wife
      do j=1,5
      xetnuqps(j,8,2,i)=xmoments(m)
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
        xassdbns(j,k)=xmoments(m)
        m=m+1  
       enddo
       enddo
      
	do k=1,11      
        do j=1,6
	  xassdbnps(j,k)=xmoments(m)
        m=m+1      
       enddo
      enddo
      

      
	do k=1,4
        do j=1,6
	  xassdbnus(j,k)=xmoments(m)
        m=m+1      
       enddo
       enddo
      
	do k=1,4
        do j=1,6
	  xassdbnpus(j,k)=xmoments(m)
        m=m+1      
       enddo
      enddo
************************************
!*     Hazard
!*************************************
      do k=1,2
      do i=1,4 !Status
      do j=1,4 
	  exhaz0s(i,j,k)=xmoments(m)
        m=m+1              
      enddo
      enddo
      enddo

      
      do ibrap=1,6
      do k=1,4
      do i=1,thazt              
	  exhazs(i,k,ibrap)=xmoments(m)
        m=m+1             
      enddo
      enddo
      enddo

      
      do ibrap=1,6
      do k=1,4
      do i=2,thazt              
	  exhaz3s(i,k,ibrap)=xmoments(m)
        m=m+1             
      enddo
      enddo
      enddo


      
      do n=1,2      
      do ibrap=1,6
      do k=1,5
      do i=1,thazt
      do l=1,3
	  wtduraves(i,k,ibrap,n,l)=xmoments(m)
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
	  exhazi0s(k,l,i,6,n)=xmoments(m)
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
	  exhazis(i,j,ibrap,n)=xmoments(m)
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
	  exhazi3s(i,j,ibrap,n)=xmoments(m)
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
	  wtduravins(i,ibrap,n,l)=xmoments(m)
        m=m+1                        
          enddo !i
      enddo !ibrap          
      enddo !n
      enddo !l      
      
            
      
      
      nmoment=m-1
!      m=nmoment
!      writes(*,*) m,xmoments(m),xlmoments(m)      
      
