!************************************************************************************************************
!     Producing tables
!************************************************************************************************************
!	Table I
!	Table 2 and 3
	do i=1,2
	do k=0,2	
	do j=0,2
	if (xenum(j,k).gt.0.d0)then
	xewag(j,k,i,1)=xewag(j,k,i,1)/xenum(j,k)
	xewag(j,k,i,2)=(xewag(j,k,i,2)/xenum(j,k)
     *	              -xewag(j,k,i,1)*xewag(j,k,i,1))
	xewag(j,k,i,2)=sqrt(max(xewag(j,k,i,2),0.d0))
      else
	xewag(j,k,i,1)=0.d0
	xewag(j,k,i,2)=0.d0
	endif

	do t=1,nmobs
	if (xenumt(j,k,t).gt.0.d0)then
	xewagt(j,k,t,i,1)=xewagt(j,k,t,i,1)/xenumt(j,k,t)
	xewagt(j,k,t,i,2)=(xewagt(j,k,t,i,2)/xenumt(j,k,t)
     *	              -xewagt(j,k,t,i,1)*xewagt(j,k,t,i,1))
	xewagt(j,k,t,i,2)=sqrt(max(xewagt(j,k,t,i,2),0.d0))
      else
	xewagt(j,k,t,i,1)=0.d0
	xewagt(j,k,t,i,2)=0.d0
	endif
	enddo

	enddo
	enddo
	enddo

!	Table 4
	do k=0,2	
	do j=0,2
	if (xeass(j,k,3).gt.0.d0)then
	xeass(j,k,1)=xeass(j,k,1)/xeass(j,k,3)
	xeass(j,k,2)=(xeass(j,k,2)/xeass(j,k,3)
     *	-xeass(j,k,1)*xeass(j,k,1))
	xeass(j,k,2)=sqrt(max(xeass(j,k,2),0.d0))
      else
	xeass(j,k,1)=0.d0
	xeass(j,k,2)=0.d0      
	endif

	do t=1,nmobs
	if (xeasst(j,k,t,3).gt.0.d0)then
	xeasst(j,k,t,1)=xeasst(j,k,t,1)/xeasst(j,k,t,3)
	xeasst(j,k,t,2)=(xeasst(j,k,t,2)/xeasst(j,k,t,3)
     *	-xeasst(j,k,t,1)*xeasst(j,k,t,1))
	xeasst(j,k,t,2)=sqrt(max(xeasst(j,k,t,2),0.d0))
      else
	xeasst(j,k,t,1)=0.d0
	xeasst(j,k,t,2)=0.d0
	endif
	enddo

	enddo
      enddo


	do j=1,6   !Brackets
      xassdbnu(j,1)=xassdbn(j,2)/max(xassdbn(j,2)+xassdbn(j,4),1.d0)
      xassdbnu(j,2)=xassdbn(j,3)/max(xassdbn(j,3)+xassdbn(j,5),1.d0)
      xassdbnu(j,3)=xassdbn(j,2)/max(xassdbn(j,2)+xassdbn(j,3),1.d0)
	xassdbnu(j,4)=xassdbn(j,4)/max(xassdbn(j,4)+xassdbn(j,5),1.d0)
      enddo

!	Table 7: xassdbn: Asset brackets

	do j=1,6   !Brackets
	if (xassdbn(j,6).gt.0.d0)then          
	do k=8,9
	xassdbn(j,k)=xassdbn(j,k)/xassdbn(j,6)
      enddo
	endif      

	if (xassdbn(j,7).gt.0.d0)then      
	do k=10,11
	xassdbn(j,k)=xassdbn(j,k)/xassdbn(j,7)
      enddo
      endif      
      enddo

      do j=1,5      
	do k=1,7
	if (xassdbn(6,k).gt.0.d0)then                    
	xassdbn(j,k)=xassdbn(j,k)/xassdbn(6,k)
      else 
          xassdbn(j,k)=0.d0
      endif      
      enddo   
      enddo

	if (xassdbn(6,1).gt.0.d0)then                          
	do k=2,7
	xassdbn(6,k)=xassdbn(6,k)/xassdbn(6,1)
      enddo   
      else
	do k=2,7
	xassdbn(6,k)=0.d0
      enddo   
      
      endif      
      
      
      do j=1,6
	xassdbn(j,9)=sqrt(max(xassdbn(j,9)-xassdbn(j,8)*xassdbn(j,8),0.d0)) !sqrt
	xassdbn(j,11)=sqrt(max(xassdbn(j,11)-xassdbn(j,10)*xassdbn(j,10),0.d0)) !sqrt
      enddo !j=1,6
      

	do j=1,6   !Brackets
      xassdbnpu(j,1)=xassdbnp(j,2)/max(xassdbnp(j,2)+xassdbnp(j,4),1.d0)
      xassdbnpu(j,2)=xassdbnp(j,3)/max(xassdbnp(j,3)+xassdbnp(j,5),1.d0)
      xassdbnpu(j,3)=xassdbnp(j,2)/max(xassdbnp(j,2)+xassdbnp(j,3),1.d0)
	xassdbnpu(j,4)=xassdbnp(j,4)/max(xassdbnp(j,4)+xassdbnp(j,5),1.d0)
      enddo
      
!	Table 7a: xassdbnp: Asset brackets
      
	do j=1,6   !Brackets
	if (xassdbnp(j,6).gt.0.d0)then          
	do k=8,9
	xassdbnp(j,k)=xassdbnp(j,k)/xassdbnp(j,6)
      enddo
	endif      

	if (xassdbnp(j,7).gt.0.d0)then      
	do k=10,11
	xassdbnp(j,k)=xassdbnp(j,k)/xassdbnp(j,7)
      enddo
      endif      
      enddo

      do j=1,5      
	do k=1,7
	if (xassdbnp(6,k).gt.0.d0)then                    
	xassdbnp(j,k)=xassdbnp(j,k)/xassdbnp(6,k)
      endif      
      enddo   
      enddo

	if (xassdbnp(6,1).gt.0.d0)then                          
	do k=2,7
	xassdbnp(6,k)=xassdbnp(6,k)/xassdbnp(6,1)
      enddo   
      endif      
      
      
      do j=1,6
	xassdbnp(j,9)=sqrt(max(xassdbnp(j,9)-xassdbnp(j,8)*xassdbnp(j,8),0.d0)) !sqrt
	xassdbnp(j,11)=
     *  sqrt(max(xassdbnp(j,11)-xassdbnp(j,10)*xassdbnp(j,10),0.d0)) !sqrt
      enddo !j=1,6
      
      
      
      
!	Table 1
	do k=0,2	
	do j=0,2
	xenum(j,k)=xenum(j,k)/xenum(2,2)

	do t=1,nmobs
	xenumt(j,k,t)=xenumt(j,k,t)/xenumt(2,2,t)
	enddo

	enddo
	enddo

!	Table II: xw: Wage brackets Husband and Wife
!	Tab asset6
	do k=0,6
	do j=0,6
	if (xwass(j,k,3).gt.0.d0)then
	xwass(j,k,1)=xwass(j,k,1)/xwass(j,k,3)
	xwass(j,k,2)=(xwass(j,k,2)/xwass(j,k,3)   !sqrt
     *	-xwass(j,k,1)*xwass(j,k,1))
	xwass(j,k,2)=sqrt(max(xwass(j,k,2),0.d0))
	endif
	enddo
	enddo
!	Number 5
	do k=0,6	
	do j=0,6
	xwnum(j,k)=xwnum(j,k)/xwnum(6,6)
      enddo
	xwnub(k,1,2)=xwnub(k,1,2)/max(xwnub(k,1,1),1.d0)
	xwnub(k,2,2)=xwnub(k,2,2)/max(xwnub(k,2,1),1.d0)
      enddo


!	Table IV: xet :Employment Status Husband and Wife
!	Tab Wages 9 and 10 [ie1,ie2,husband or wife,mean or variance]
	do i=1,2
	do k=1,5	
	do j=1,5
	if (xetnum(j,k).gt.5.000d0)then
	xetwag(j,k,i,1)=xetwag(j,k,i,1)/xetnum(j,k)
	xetwag(j,k,i,2)=(xetwag(j,k,i,2)/xetnum(j,k)
     *	-xetwag(j,k,i,1)*xetwag(j,k,i,1))
	xetwag(j,k,i,2)=sqrt(max(xetwag(j,k,i,2),0.d0))
      else
	xetwag(j,k,i,1)=0.d0
	xetwag(j,k,i,2)=0.d0      
	endif
	enddo
	enddo
      enddo
!	Transitions 8
	xetnum=xetnum/xetnum(5,5)      
      do k=1,5	
	do j=1,5	
      xetnumr(j,k)=xetnum(j,k)/max(xetnum(5,k),xdeno)
      enddo      
      enddo      

      
!     Transition by spouse's transition
!     Husband UE   
      xetnumc(5,1,1)=(xetnum(3,1)+xetnum(3,2)+xetnum(4,1)+xetnum(4,2))/
     *      max(xetnum(5,1)+xetnum(5,2),xdeno)
      m=1
      do j=1,2
      xetnumc(m,1,1)=xetnum(3,j)/max(xetnum(3,j)+xetnum(1,j),xdeno)
            m=m+1
      xetnumc(m,1,1)=xetnum(4,j)/max(xetnum(4,j)+xetnum(2,j),xdeno) 
            m=m+1
      enddo
      
!     Husband EU      
      xetnumc(5,2,1)=(xetnum(1,3)+xetnum(2,3)+xetnum(1,4)+xetnum(2,4))/
     *      max(xetnum(5,3)+xetnum(5,4),xdeno)
      m=1
      do j=3,4      
      xetnumc(m,2,1)=xetnum(1,j)/max(xetnum(3,j)+xetnum(1,j),xdeno)
         m=m+1
      xetnumc(m,2,1)=xetnum(2,j)/max(xetnum(4,j)+xetnum(2,j),xdeno)
         m=m+1
      enddo
      

!     Wife UE            
      xetnumc(5,1,2)=(xetnum(2,1)+xetnum(2,3)+xetnum(4,1)+xetnum(4,3))/
     *      max(xetnum(5,3)+xetnum(5,2),xdeno)
      m=1      
       do j=1,3,2      
      xetnumc(m,1,2)=xetnum(2,j)/max(xetnum(2,j)+xetnum(1,j),xdeno)
      m=m+1      
      xetnumc(m,1,2)=xetnum(4,j)/max(xetnum(4,j)+xetnum(3,j),xdeno)
      m=m+1      
       enddo
       
!     Wife EU       
      xetnumc(5,2,2)=(xetnum(1,2)+xetnum(1,4)+xetnum(3,2)+xetnum(3,4))/
     *      max(xetnum(5,2)+xetnum(5,4),xdeno)
      m=1      
      do j=2,4,2
      xetnumc(m,2,2)=xetnum(1,j)/max(xetnum(2,j)+xetnum(1,j),xdeno)
      m=m+1      
      xetnumc(m,2,2)=xetnum(3,j)/max(xetnum(4,j)+xetnum(3,j),xdeno)
      m=m+1      
      enddo
      


!	Table IV: xet :Employment Status Husband and Wife aaaaaaaaaaaaa
!	Tab Wages 9 and 10 [ie1,ie2,husband or wife,mean or variance]

      do i=1,2
	do kp=-1,2                    
	do jp=-1,2          
	do kq=-1,2                    
	do jq=-1,2          
	do k=1,5	
	do j=1,5
	if (xetnumqp(j,k,jq,kq,jp,kp).gt.0.000d0)then
	xetwagqp(j,k,jq,kq,jp,kp,i,1)=
     * xetwagqp(j,k,jq,kq,jp,kp,i,1)/max(xetnumqp(j,k,jq,kq,jp,kp),1.d0)
	xetwagqp(j,k,jq,kq,jp,kp,i,2)=
     *(xetwagqp(j,k,jq,kq,jp,kp,i,2)/max(xetnumqp(j,k,jq,kq,jp,kp),1.d0)
     *	-xetwagqp(j,k,jq,kq,jp,kp,i,1)*xetwagqp(j,k,jq,kq,jp,kp,i,1))
	xetwagqp(j,k,jq,kq,jp,kp,i,2)=
     * sqrt(max(xetwagqp(j,k,jq,kq,jp,kp,i,2),0.d0))
	endif
	enddo
	enddo
      enddo
	enddo
      enddo
	enddo
      enddo
      
!	Transitions 8qp
	xetnumqp=xetnumqp/max(xetnumqp(5,5,2,2,2,2),1.d0)

!*********************************************************************      
!     Job-to-job conditional 1
!     Husband      
      xetnuqp(5,1,1,1)=(xetnumqp(3,3,2,2,1,2)+xetnumqp(3,4,2,2,1,2)
     *    +xetnumqp(4,3,2,2,1,2)+xetnumqp(4,4,2,2,1,2))/
     * max(xetnumqp(3,3,2,2,0,2)+xetnumqp(3,3,2,2,1,2)
     *  +xetnumqp(3,4,2,2,0,2)+xetnumqp(3,4,2,2,1,2)      
     * +xetnumqp(4,3,2,2,0,2)+xetnumqp(4,3,2,2,1,2)
     * +xetnumqp(4,4,2,2,0,2)+xetnumqp(4,4,2,2,1,2),xdeno)
      
      m=1
      do j=3,4
      xetnuqp(m,1,1,1)=xetnumqp(3,j,2,2,1,2)/
     * max(xetnumqp(3,j,2,2,0,2)+xetnumqp(3,j,2,2,1,2),xdeno)
      m=m+1
      xetnuqp(m,1,1,1)=xetnumqp(4,j,2,2,1,2)/
     * max(xetnumqp(4,j,2,2,0,2)+xetnumqp(4,j,2,2,1,2),xdeno)
      m=m+1
      enddo
      
      
!     Wife
      xetnuqp(5,1,1,2)=(xetnumqp(2,2,2,2,2,1)+xetnumqp(2,4,2,2,2,1)
     *    +xetnumqp(4,2,2,2,2,1)+xetnumqp(4,4,2,2,2,1))/
     * max(xetnumqp(2,2,2,2,2,0)+xetnumqp(2,2,2,2,2,1)
     * +xetnumqp(2,4,2,2,2,0)+xetnumqp(2,4,2,2,2,1)      
     * +xetnumqp(4,2,2,2,2,0)+xetnumqp(4,2,2,2,2,1)
     * +xetnumqp(4,4,2,2,2,0)+xetnumqp(4,4,2,2,2,1),xdeno)

      m=1
      do j=2,4,2
      xetnuqp(m,1,1,2)=xetnumqp(2,j,2,2,2,1)/
     *      max(xetnumqp(2,j,2,2,2,0)+xetnumqp(2,j,2,2,2,1),xdeno)
      m=m+1
      xetnuqp(m,1,1,2)=xetnumqp(4,j,2,2,2,1)/
     * max(xetnumqp(4,j,2,2,2,0)+xetnumqp(4,j,2,2,2,1),xdeno)
      m=m+1
      enddo
      
!     Quits conditional
!     Husband            
      xetnuqp(5,1,2,1)=(xetnumqp(1,3,1,2,2,2)+xetnumqp(1,4,1,2,2,2)
     *    +xetnumqp(2,3,1,2,2,2)+xetnumqp(2,4,1,2,2,2))/
     * max(xetnumqp(1,3,0,2,2,2)+xetnumqp(1,3,1,2,2,2)
     *  +xetnumqp(1,4,0,2,2,2)+xetnumqp(1,4,1,2,2,2)      
     * +xetnumqp(2,3,0,2,2,2)+xetnumqp(2,3,1,2,2,2)
     * +xetnumqp(2,4,0,2,2,2)+xetnumqp(2,4,1,2,2,2),xdeno)

      
      m=1
      do j=3,4
      xetnuqp(m,1,2,1)=xetnumqp(1,j,1,2,2,2)/
     *     max(xetnumqp(1,j,0,2,2,2)+xetnumqp(1,j,1,2,2,2),xdeno)
      m=m+1
      xetnuqp(m,1,2,1)=xetnumqp(2,j,1,2,2,2)/max(xetnumqp(2,j,0,2,2,2)
     * +xetnumqp(2,j,1,2,2,2),xdeno)
      m=m+1
      enddo

!     Wife      
      xetnuqp(5,1,2,2)=(xetnumqp(1,2,2,1,2,2)+xetnumqp(1,4,2,1,2,2)
     *    +xetnumqp(3,2,2,1,2,2)+xetnumqp(3,4,2,1,2,2))/
     * max(xetnumqp(1,2,2,0,2,2)+xetnumqp(1,2,2,1,2,2)
     * +xetnumqp(1,4,2,0,2,2)+xetnumqp(1,4,2,1,2,2)      
     * +xetnumqp(3,2,2,0,2,2)+xetnumqp(3,2,2,1,2,2)
     * +xetnumqp(3,4,2,0,2,2)+xetnumqp(3,4,2,1,2,2),xdeno)

      m=1
      do j=2,4,2
      xetnuqp(m,1,2,2)=xetnumqp(1,j,2,1,2,2)/
     * max(xetnumqp(1,j,2,0,2,2)+xetnumqp(1,j,2,1,2,2),xdeno)
      m=m+1
      xetnuqp(m,1,2,2)=xetnumqp(3,j,2,1,2,2)/
     * max(xetnumqp(3,j,2,0,2,2)+xetnumqp(3,j,2,1,2,2),xdeno)
      m=m+1
      enddo
      
!     Joint Job-to-job 2 3 4
!     Husband      
      m=2
	do k=3,5	
      do j=1,5
      xetnuqp(j,m,1,1)=xetnumqp(j,k,2,2,1,2)/
     * max(xetnumqp(j,k,2,2,1,2)+xetnumqp(j,k,2,2,0,2),xdeno)
      enddo
      m=m+1
      enddo
      
!     Wife      
      m=2      
	do k=2,5	
      if(k.ne.3)then                    
      do j=1,5          
      xetnuqp(j,m,1,2)=xetnumqp(j,k,2,2,2,1)/
     * max(xetnumqp(j,k,2,2,2,1)+xetnumqp(j,k,2,2,2,0),xdeno)
      enddo      
      m=m+1      
      endif
      enddo
      
!     Joint Job-to-job missing    5 6 7  
!     Husband
      m=5
	do k=3,5	
      do j=1,5
      xetnuqp(j,m,1,1)=
     * xetnumqp(j,k,2,2,-1,2)/max(xetnumqp(j,k,2,2,2,2),xdeno)
      enddo
      m=m+1
      enddo
      
!     Wife
      m=5 
	do k=2,5	
      if(k.ne.3)then                    
      do j=1,5          
      xetnuqp(j,m,1,2)=
     * xetnumqp(j,k,2,2,2,-1)/max(xetnumqp(j,k,2,2,2,2),xdeno)
      enddo      
      m=m+1      
      endif
      enddo
      

!     Joint Quits 2 3 4
!     Husband      
      m=2
	do k=3,5	
      do j=1,5
      xetnuqp(j,m,2,1)=xetnumqp(j,k,1,2,2,2)/
     *    max(xetnumqp(j,k,1,2,2,2)+xetnumqp(j,k,0,2,2,2),xdeno)
      enddo
      m=m+1
      enddo
      
!     Wife      
      m=2      
	do k=2,5	
      if(k.ne.3)then                    
      do j=1,5          
      xetnuqp(j,m,2,2)=xetnumqp(j,k,2,1,2,2)/
     *   max(xetnumqp(j,k,2,1,2,2)+xetnumqp(j,k,2,0,2,2),xdeno)
      enddo      
      m=m+1      
      endif
      enddo
      
!     Joint Quits Missing     5 6 7 
!     Husband 
      m=5
	do k=3,5	
      do j=1,5
      xetnuqp(j,m,2,1)=
     * xetnumqp(j,k,-1,2,2,2)/max(xetnumqp(j,k,2,2,2,2),xdeno)
      enddo
      m=m+1
      enddo
      
!     Wife      
      m=5 
	do k=2,5	
      if(k.ne.3)then                    
      do j=1,5          
      xetnuqp(j,m,2,2)=
     * xetnumqp(j,k,2,-1,2,2)/max(xetnumqp(j,k,2,2,2,2),xdeno)
      enddo      
      m=m+1      
      endif
      enddo
      
      
      
!     Missing in Quits conditional 8
!     Husband     
      xetnuqp(5,8,2,1)=(xetnumqp(1,3,-1,2,2,2)+xetnumqp(1,4,-1,2,2,2)
     *    +xetnumqp(2,3,-1,2,2,2)+xetnumqp(2,4,-1,2,2,2))/
     * max(xetnumqp(1,3,2,2,2,2)
     *  +xetnumqp(1,4,2,2,2,2)
     * +xetnumqp(2,3,2,2,2,2)
     * +xetnumqp(2,4,2,2,2,2),xdeno)
      
      m=1
      do j=3,4
      xetnuqp(m,8,2,1)=xetnumqp(1,j,-1,2,2,2)/
     * max(xetnumqp(1,j,2,2,2,2),xdeno)
      m=m+1
      xetnuqp(m,8,2,1)=xetnumqp(2,j,-1,2,2,2)/
     * max(xetnumqp(2,j,2,2,2,2),xdeno)
      m=m+1
      enddo

!     Wife      
      xetnuqp(5,8,2,2)=(xetnumqp(1,2,2,-1,2,2)+xetnumqp(1,4,2,-1,2,2)
     *    +xetnumqp(3,2,2,-1,2,2)+xetnumqp(3,4,2,-1,2,2))/
     * max(xetnumqp(1,2,2,2,2,2)
     * +xetnumqp(1,4,2,2,2,2)
     * +xetnumqp(3,2,2,2,2,2)
     * +xetnumqp(3,4,2,2,2,2),xdeno)

      m=1
      do j=2,4,2
      xetnuqp(m,8,2,2)=xetnumqp(1,j,2,-1,2,2)/
     * max(xetnumqp(1,j,2,2,2,2),xdeno)
      m=m+1
      xetnuqp(m,8,2,2)=xetnumqp(3,j,2,-1,2,2)/
     * max(xetnumqp(3,j,2,2,2,2),xdeno)
      m=m+1
      enddo
      
!     UE and EU by spouse's same job and job to job 9 10
!     Husband     
!     UE Same job 9
      j=2      
      xetnuqp(1,9,1,1)=xetnumqp(4,j,2,2,2,0)/
     * max(xetnumqp(4,j,2,2,2,0)+xetnumqp(2,j,2,2,2,0),xdeno)
!     UE job-to-job
      xetnuqp(2,9,1,1)=xetnumqp(4,j,2,2,2,1)/
     * max(xetnumqp(4,j,2,2,2,1)+xetnumqp(2,j,2,2,2,1),xdeno) 
!     UE All EE
      xetnuqp(3,9,1,1)=xetnum(4,j)/(xetnum(4,j)+xetnum(2,j))

      
!     EU Same job     10 
      j=4            
      xetnuqp(1,10,1,1)=xetnumqp(2,j,2,2,2,0)/
     *  max(xetnumqp(2,j,2,2,2,0)+xetnumqp(4,j,2,2,2,0),xdeno)
!     EU job-to-job
      xetnuqp(2,10,1,1)=xetnumqp(2,j,2,2,2,1)/
     *   max(xetnumqp(2,j,2,2,2,1)+xetnumqp(4,j,2,2,2,1),xdeno)
      xetnuqp(3,10,1,1)=xetnum(2,j)/max(xetnum(2,j)+xetnum(4,j),xdeno)
      
!     Wife     
!     UE Same job      
      j=3
      xetnuqp(1,9,1,2)=xetnumqp(4,j,2,2,0,2)/
     *  max(xetnumqp(4,j,2,2,0,2)+xetnumqp(3,j,2,2,0,2),xdeno)
!     UE job-to-job
      xetnuqp(2,9,1,2)=xetnumqp(4,j,2,2,1,2)/
     *  max(xetnumqp(4,j,2,2,1,2)+xetnumqp(3,j,2,2,1,2),xdeno)
      xetnuqp(3,9,1,2)=xetnum(4,j)/max(xetnum(4,j)+xetnum(3,j),xdeno)

!     EU Same job      
      j=4
      xetnuqp(1,10,1,2)=xetnumqp(3,j,2,2,0,2)/
     *  max(xetnumqp(3,j,2,2,0,2)+xetnumqp(4,j,2,2,0,2),xdeno)
!     EU job-to-job
      xetnuqp(2,10,1,2)=xetnumqp(3,j,2,2,1,2)/
     *   max(xetnumqp(3,j,2,2,1,2)+xetnumqp(4,j,2,2,1,2),xdeno)
      xetnuqp(3,10,1,2)=xetnum(3,j)/max(xetnum(3,j)+xetnum(4,j),xdeno)
      
     
!**************************************************************      
      
!	Tab Assets 11
	do k=1,5	
	do j=1,5
	if (xetass(j,k,3).gt.5.d0)then
	xetass(j,k,1)=xetass(j,k,1)/xetass(j,k,3)
	xetass(j,k,2)=(xetass(j,k,2)/xetass(j,k,3)
     *	-xetass(j,k,1)*xetass(j,k,1))
	xetass(j,k,2)=sqrt(max(xetass(j,k,2),0.d0))
      else
	xetass(j,k,1)=0.d0
	xetass(j,k,2)=0.d0
	endif
	enddo
	enddo


!	Wage partial transitions by gender 14
!	pause
	do m=1,2
	do k=0,6
	do j=0,6
	xwptnum(j,k,m)=xwptnum(j,k,m)/max(xwptnum(j,6,m),1.d0)
!	write(*,*) xwptnum(j,k,m)
!	write(1,*) xwptnum(j,k,m)
	enddo
	enddo
      enddo
      

!************************************
!*     Table Proportion of hazard entrance
!*************************************

! "Proportion of entry/exit"
      do k=1,2 !1: entry, 2:exit       
      do i=1,4 !Status
          
      xtoti=0.d0
      do j=1,4 
      xtoti=xtoti+exhaz0(i,j,k)
      enddo
      do j=1,4 
      exhaz0(i,j,k)=exhaz0(i,j,k)/max(xtoti,1.d0)
      enddo

      enddo
      enddo
      exhaz2=0.d0
      do ibrap=1,6
      do k=1,4
      do i=2,thazt              
          if(exhaz(i-1,k,ibrap).gt.0.d0)then
      exhaz2(i,k,ibrap)=1.d0-exhaz(i,k,ibrap)/exhaz(i-1,k,ibrap)
          else 
      exhaz2(i,k,ibrap)=0.d0
      endif
      enddo
      enddo
      enddo
           
      exhaz3=0.d0
      inch=2
!      write(11,*) "Smoothed Hazard by exit: MA(",inch,")"
!      write(11,*) "Wealth bracket: ",m ,xlabelj(m)          
      do ibrap=1,6
      do k=1,4
      do i=2,thazt              
          xtoti=0.d0
          do j=0,min(inch,i-2)
              xtoti=xtoti+exhaz2(i,k,ibrap)
           enddo
      exhaz3(i,k,ibrap)=xtoti/min(inch+1,i-2+1)
      enddo      
      enddo
      enddo
           
           
!***** Hazard end


!***** Duration Accepted wages end     
      
      do m=1,2            
      do ibrap=1,6
      do k=1,5
      do i=1,thazt
      do l=1,2
      wtdurave(i,k,ibrap,m,l)=wtdurave(i,k,ibrap,m,l)/
     *  max(wtdurave(i,k,ibrap,m,3),1.d0)
      enddo      
      wtdurave(i,k,ibrap,m,2)=sqrt(max(
     *  wtdurave(i,k,ibrap,m,2)-wtdurave(i,k,ibrap,m,1)
     * *wtdurave(i,k,ibrap,m,1),0.d0))  
      enddo
      enddo      
      enddo
      enddo   !m
!***** Duration Accepted wages end      

      
      
!************************************
!*     Individual hazard
!*************************************

! "Proportion of entry/exit"
      do m=1,2
      do ibrap=1,6
      do i=1,2 !1: entry, 2:exit
      do k=1,2        
      exhazi0(k,1,i,ibrap,m)=exhazi0(k,1,i,ibrap,m)/
     * (exhazi0(k,1,i,ibrap,m)+exhazi0(k,2,i,ibrap,m))
      exhazi0(k,2,i,ibrap,m)=1.d0-exhazi0(k,1,i,ibrap,m)
      enddo !k
      enddo !i
      enddo   !ibrap   
      enddo   !m

      exhazi3=0.d0
      inch=2
      do m=1,2
      do ibrap=1,6
!      write(11,*) "Hazard"             
          do k=1,2
      do i=thazt,2,-1
               if(exhazi(i-1,k,ibrap,m).gt.0.d0)then
       exhazi2(i,k,ibrap,m)=1.d0-
     * exhazi(i,k,ibrap,m)/exhazi(i-1,k,ibrap,m)
               else 
       exhazi2(i,k,ibrap,m)=0.d0                   
      endif
!          write(*,"(3(i3,1x),3(f20.2,1x))")m,ibrap,k,
!     *     exhazi2(i,k,ibrap,m),
!     *     exhazi(i,k,ibrap,m),exhazi(i-1,k,ibrap,m)

           enddo      !i          
          enddo      !k
           
           
!      write(11,*) "Smoothed Ind Hazard by exit: MA(",inch,")"
!      write(11,*) m,xgender(m),ibrap,xlabelj(ibrap)                      
      do k=1,2
      do i=2,thazt
          xtoti=0.d0
          do j=0,min(inch,i-2)
              xtoti=xtoti+exhazi2(i-j,k,ibrap,m)
           enddo
      exhazi3(i,k,ibrap,m)=xtoti/min(inch+1,i-2+1)
      enddo      
      enddo
           
           enddo !ibrap           
      enddo   !m   

!************************************
!*     Individual hazard
!*************************************
!*************************************
!***** Duration Accepted wages end           
!*************************************      

      do m=1,2
      do ibrap=1,6
      do i=1,thazt          
          
          do k=1,2                   
      wtduravin(i,ibrap,m,k)=wtduravin(i,ibrap,m,k)/
     * max(wtduravin(i,ibrap,m,3),1.d0)
      enddo      !k      
      wtduravin(i,ibrap,m,2)=sqrt(max(
     *  wtduravin(i,ibrap,m,2)-wtduravin(i,ibrap,m,1)
     * *wtduravin(i,ibrap,m,1),0.d0))  
      enddo
      enddo
      enddo

