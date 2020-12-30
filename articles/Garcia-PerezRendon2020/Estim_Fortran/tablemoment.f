!************************************
!     Moments
!************************************      
      istanda=0
      ichimo=1
      iproba=0
      xmoment=0
      m=1
*************************************
*     Table 1
*************************************
      xlmoment(m)='Employment Status UU'      
      xlmoment(m+1)='Employment Status EU'            
      xlmoment(m+2)='Employment Status UE'            
      xlmoment(m+3)='Employment Status EE'                  

	do k=0,1	
	do j=0,1	
      xmoment(m)=xenum(j,k)
!      write(*,*) m,xmoment(m),xlmoment(m)
      iproba(m)=1
      m=m+1
      enddo
      enddo      
      

      
*************************************
*     Table 2
*************************************
      xlmoment(m)='Wage husband. Empl.Stat EU'
      xlmoment(m+1)='SD Wage husband. Empl.Stat EU'
      xlmoment(m+2)='Wage husband. Empl.Stat EE'
      xlmoment(m+3)='SD Wage husband. Empl.Stat EE'
      
      j=1
	do k=0,1	
      xmoment(m)=xewag(j,k,1,1)
      m=m+1      
      xmoment(m)=xewag(j,k,1,2)
      istanda(m)=1      
      m=m+1
      enddo
      
*************************************
*     Table 3
*************************************
      xlmoment(m)='Wage wife. Empl.Stat UE'
      xlmoment(m+1)='SD Wage wife. Empl.Stat UE'
      xlmoment(m+2)='Wage wife. Empl.Stat EE'
      xlmoment(m+3)='SD Wage wife. Empl.Stat EE'
      
      k=1
	do j=0,1	
      xmoment(m)=xewag(j,k,2,1)
      m=m+1
      xmoment(m)=xewag(j,k,2,2)
      istanda(m)=1      
      m=m+1
      enddo      
      

*************************************
*     Table 4
*************************************
      xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'
      

	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
      xlabel(5)= ' T'

      ll=1
      do k=0,1	
	do j=0,1	
       xlmoment(m)='Wealth. Empl.Stat ' // trim(xlabel(ll))
      xmoment(m)=xeass(j,k,1)
      m=m+1
       xlmoment(m)='SD Wealth. Empl.Stat ' // trim(xlabel(ll))      
      xmoment(m)=xeass(j,k,2)
!      ichimo(m)=0      
      istanda(m)=1      
      m=m+1
       xlmoment(m)='N Wealth. Empl.Stat ' // trim(xlabel(ll))      
      xmoment(m)=xeass(j,k,3)
      ichimo(m)=0
      m=m+1
      
      ll=ll+1
      enddo      
      enddo      


      
      
      xlabelj(0)= 'U'
	xlabelj(1)= 'W1'
	xlabelj(2)= 'W2'
	xlabelj(3)= 'W3'
	xlabelj(4)= 'W4'
	xlabelj(5)= 'W5'
	xlabelj(6)= 'T'      
      
!     Table N 1
	do k=0,6	      
	do j=0,6	
      xlmoment(m)='Joint Wage Dbn '//trim(xgender(1)) // 
     *  ' ' // trim(xlabelj(j)) //' ' // trim(xgender(2)) //
     * ' ' // trim(xlabelj(k))
	xmoment(m)=xwnum(j,k)
       iproba(m)=1      
      if(k.eq.6.or.j.eq.6)ichimo(m)=0             
        m=m+1                          
      enddo
      enddo
      
	do j=0,6
      xlmoment(m)='Average Wage '//trim(xgender(1)) // 
     *  ' ' // trim(xlabelj(j)) //' ' // trim(xgender(2))
	xmoment(m)=xwnub(j,1,2)          
        m=m+1                          
      xlmoment(m)='Average Wage N '//trim(xgender(1)) // 
     *  ' ' // trim(xlabelj(j)) //' ' // trim(xgender(2))
	xmoment(m)=xwnub(j,1,1)        
      ichimo(m)=0      
        m=m+1                          
        
      enddo
	do j=0,6
      xlmoment(m)='Average Wage '//trim(xgender(2)) // 
     *  ' ' // trim(xlabelj(j)) //' ' // trim(xgender(1))
	xmoment(m)=xwnub(j,2,2)          
        m=m+1                          
      xlmoment(m)='Average Wage N '//trim(xgender(2)) // 
     *  ' ' // trim(xlabelj(j)) //' ' // trim(xgender(1))
	xmoment(m)=xwnub(j,2,1)          
      ichimo(m)=0      
        m=m+1                          
        
      enddo
      
      
!     Average Current Wealth by Joint Wage bracket      
	do k=0,6
	do j=0,6
      xlmoment(m)='Average Wealth '
     * // trim(xlabelj(j)) //' '// trim(xlabelj(k))
	xmoment(m)=xwass(j,k,1)
        m=m+1                      
      xlmoment(m)='SD Wealth '
     * // trim(xlabelj(j)) //' '// trim(xlabelj(k))      
	xmoment(m)=xwass(j,k,2)
      istanda(m)=1            
      ichimo(m)=0      
        m=m+1                      
      xlmoment(m)='N Wealth '
     * // trim(xlabelj(j)) //' '// trim(xlabelj(k))      
	xmoment(m)=xwass(j,k,3)
      ichimo(m)=0
        m=m+1                      
	enddo
	enddo
      
      
      
     
*************************************
*     Table 8
*************************************
      do k=1,5	
	do j=1,5	
       xlmoment(m)='Empl.Trans ' // trim(xlabel(k)) //
     *  '$\rightarrow$' // trim(xlabel(j)) // ' cell'
      xmoment(m)=xetnum(j,k)
      iproba(m)=1      
      m=m+1
      enddo      
      enddo      

*************************************
*     Table 8a
*************************************
      do k=1,5	
	do j=1,5	
       xlmoment(m)='Empl.Trans ' // trim(xlabel(k)) //
     *  '$\rightarrow$' // trim(xlabel(j)) // ' row'
          
      xmoment(m)=xetnumr(j,k)
      iproba(m)=1      
      if(j.eq.6) ichimo(m)=0      
      m=m+1
      enddo      
      enddo      
      
!************************************
!     Table 90t
!************************************
      xlmoment(m)='Empl.Trans. Husband U$\rightarrow$E'      
      xlmoment(m+1)='Empl.Trans. Husband U$\rightarrow$E,
     * Wife U$\rightarrow$U'
      xlmoment(m+2)='Empl.Trans. Husband U$\rightarrow$E, Wife
     * U$\rightarrow$E'
      xlmoment(m+3)='Empl.Trans. Husband U$\rightarrow$E, Wife
     * E$\rightarrow$U'
      xlmoment(m+4)='Empl.Trans. Husband U$\rightarrow$E, Wife
     * E$\rightarrow$E'
      xlmoment(m+5)='Empl.Trans. Husband E$\rightarrow$U'      
      xlmoment(m+6)='Empl.Trans. Husband E$\rightarrow$U, Wife
     * U$\rightarrow$U'
      xlmoment(m+7)='Empl.Trans. Husband E$\rightarrow$U, Wife
     * U$\rightarrow$E'
      xlmoment(m+8)='Empl.Trans. Husband E$\rightarrow$U, Wife
     * E$\rightarrow$U'
      xlmoment(m+9)='Empl.Trans. Husband E$\rightarrow$U, Wife
     * E$\rightarrow$E'      
      
      i=1
      do k=1,2	
      xmoment(m)=xetnumc(5,k,i)          
      iproba(m)=1      
      m=m+1      
	do j=1,4
      xmoment(m)=xetnumc(j,k,i)
      iproba(m)=1      
      m=m+1
      enddo      
      enddo      
      
      
      xlmoment(m)='Empl.Trans. Wife U$\rightarrow$E'      
      xlmoment(m+1)='Empl.Trans. Wife U$\rightarrow$E, 
     * Husband U$\rightarrow$U'
      xlmoment(m+2)='Empl.Trans. Wife U$\rightarrow$E, Husband
     * U$\rightarrow$E'
      xlmoment(m+3)='Empl.Trans. Wife U$\rightarrow$E, Husband
     *  E$\rightarrow$U'
      xlmoment(m+4)='Empl.Trans. Wife U$\rightarrow$E, Husband
     *  E$\rightarrow$E'
      xlmoment(m+5)='Empl.Trans. Wife E$\rightarrow$U'      
      xlmoment(m+6)='Empl.Trans. Wife E$\rightarrow$U, Husband
     *  U$\rightarrow$U'
      xlmoment(m+7)='Empl.Trans. Wife E$\rightarrow$U, Husband
     *  U$\rightarrow$E'
      xlmoment(m+8)='Empl.Trans. Wife E$\rightarrow$U, Husband
     *  E$\rightarrow$U'
      xlmoment(m+9)='Empl.Trans. Wife E$\rightarrow$U, Husband
     *  E$\rightarrow$E'      
      
      i=2
      do k=1,2	
      xmoment(m)=xetnumc(5,k,i)          
      iproba(m)=1      
      m=m+1      
	do j=1,4
      xmoment(m)=xetnumc(j,k,i)
      iproba(m)=1      
      m=m+1
      enddo      
      enddo      

      
      
*************************************
*     Table 9
*************************************
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'EE'
      
      
      xlabelj(1)='$\Delta$W'
      xlabelj(2)='SD $\Delta$W'
      
      i=1
      do ll=1,2
          
      do k=1,2	
	do j=3,5	
        xlmoment(m)=trim(xlabelj(ll)) //' ' // trim(xgender(i)) //' '
     *   //trim(xlabel(j))//
     * '$\rightarrow$' // trim(xlabel(k))
      xmoment(m)=xetwag(j,k,i,ll)
            if(ll.eq.2) ichimo(m)=0
      m=m+1
      enddo      
      enddo      
      do k=3,5	
	do j=1,5	
        xlmoment(m)=trim(xlabelj(ll)) //' ' // trim(xgender(i)) //' '
     *   // trim(xlabel(j))//
     * '$\rightarrow$'// trim(xlabel(k))
      xmoment(m)=xetwag(j,k,i,ll)
            if(ll.eq.2) ichimo(m)=0      
      istanda(m)=1      
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
        xlmoment(m)=trim(xlabelj(ll)) //' ' // trim(xgender(i)) //' '
     *   // trim(xlabel(j))//
     * '$\rightarrow$'// trim(xlabel(k))
      xmoment(m)=xetwag(j,k,i,ll)
      istanda(m)=ll-1      
      m=m+1
      enddo      
      
      j=5
        xlmoment(m)=trim(xlabelj(ll)) //' ' // trim(xgender(i)) //' '
     *   // trim(xlabel(j))//
     * '$\rightarrow$'// trim(xlabel(k))
      xmoment(m)=xetwag(j,k,i,ll)
      istanda(m)=ll-1      
      m=m+1
      enddo      

      do k=2,4,2
	do j=1,5
      if(k.eq.2.and.j.eq.3)goto 1458
        xlmoment(m)='SD $\Delta$W ' //' '// trim(xgender(i)) //
     *   ' '//trim(xlabel(j))//
     * '$\rightarrow$'// trim(xlabel(k))
      xmoment(m)=xetwag(j,k,i,ll)
          ichimo(m)=0
      istanda(m)=ll-1
      m=m+1
1458   continue   
      enddo      
      enddo      

      k=5
	do j=1,5
        xlmoment(m)='SD $\Delta$W ' //' '// trim(xgender(i)) //
     *   ' '//trim(xlabel(j))//
     * '$\rightarrow$'// trim(xlabel(k))
      xmoment(m)=xetwag(j,k,i,ll)
      ichimo(m)=0      
      istanda(m)=ll-1
      m=m+1
      enddo      
      
      enddo      

      
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'T'
      
*************************************
*     Table 11
*************************************
      xlabelj(1)='$\Delta$A '
      xlabelj(2)='SD $\Delta$A '
      xlabelj(3)='N $\Delta$A '

	do k=1,5	
	do j=1,5
       do i=1,3          
        xlmoment(m)=trim(xlabelj(i)) //' '// trim(xlabel(j))
     *    //'$\rightarrow$'// trim(xlabel(k))
      xmoment(m)=xetass(j,k,i)
      if(i.eq.2)istanda(m)=1
      if(i.ge.2)ichimo(m)=0
      m=m+1	
      enddo
	enddo
      enddo
      xlabelj(0)= 'U'
	xlabelj(1)= 'W1'
	xlabelj(2)= 'W2'
	xlabelj(3)= 'W3'
	xlabelj(4)= 'W4'
	xlabelj(5)= 'W5'
	xlabelj(6)= 'T'      

      
	do i=1,2
	do k=0,6
	do j=0,6
        xlmoment(m)='WB Tran ' //' ' // xgender(i)//' ' 
     *  // trim(xlabelj(j)) //'$\rightarrow$' // trim(xlabelj(k))
      xmoment(m)=xwptnum(j,k,i)
      iproba(m)=1           
      if(k.eq.6.or.j.eq.6.or.k.eq.j) ichimo(m)=0
      m=m+1	      
	enddo
	enddo
      enddo
      
      
	xlabelj(2)= 'EU'
	xlabelj(3)= 'UE'
	xlabelj(4)= 'T'
      
	xlabelj(5)= 'EU'
	xlabelj(6)= 'UE'
	xlabelj(7)= 'T'

      
!************************************
!     Table 99q Quits
!************************************
!	Transitions 8p
      do ii=-1,2
      do n=-1,2
      do l=-1,2
      do k=-1,2
      do j=1,5
      do i=1,5
      xlmoment(m)='xetnumqp '
	xmoment(m)=xetnumqp(i,j,k,l,n,ii)
      ichimo(m)=0
      m=m+1
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      
      xlmoment(m)='\% Quits in Husband E$\rightarrow$U'      
      xmoment(m)=xetnuqp(5,1,2,1)
      iproba(m)=1      
      m=m+1
      

      xlmoment(m)='\% Quits in Husband E$\rightarrow$U, Wife
     * E$\rightarrow$E'          
      xmoment(m)=xetnuqp(4,1,2,1)      
      iproba(m)=1      
      m=m+1

      xlmoment(m)='\% Quits in Wife E$\rightarrow$U'
      xmoment(m)=xetnuqp(5,1,2,2)      
      iproba(m)=1      
      m=m+1      
      
      xlmoment(m)='\% Quits in Wife E$\rightarrow$U, Husband
     *  E$\rightarrow$U'                  
      xmoment(m)=xetnuqp(4,1,2,2)      
      iproba(m)=1      
      m=m+1      
      

!************************************
!     Table 99p
!************************************
      xlmoment(m)='\% Job-to-job in Husband E$\rightarrow$E'            
      xmoment(m)=xetnuqp(5,1,1,1)
      iproba(m)=1      
      m=m+1

      xlmoment(m)='\% Job-to-job in Husband E$\rightarrow$E, Wife
     * U$\rightarrow$U'
      xlmoment(m+1)='\% Job-to-job in Husband E$\rightarrow$E, 
     * Wife U$\rightarrow$E'
      xlmoment(m+2)='\% Job-to-job in Husband E$\rightarrow$E, 
     * Wife E$\rightarrow$U'
      xlmoment(m+3)='\% Job-to-job in Husband E$\rightarrow$E, 
     * Wife E$\rightarrow$E'      
      do j=1,4
      xmoment(m)=xetnuqp(j,1,1,1)            
      iproba(m)=1      
      m=m+1
      enddo
      
      xlmoment(m)='\% Job-to-job in Wife  E$\rightarrow$E'            
      xmoment(m)=xetnuqp(5,1,1,2)      
      iproba(m)=1      
      m=m+1
      
      xlmoment(m)='\% Job-to-job in Wife E$\rightarrow$E, Husband
     * U$\rightarrow$U'
      xlmoment(m+1)='\% Job-to-job in Wife E$\rightarrow$E, 
     *Husband U$\rightarrow$E'
      xlmoment(m+2)='\% Job-to-job in Wife E$\rightarrow$E, 
     * Husband E$\rightarrow$U'
      xlmoment(m+3)='\% Job-to-job in Wife E$\rightarrow$E, 
     * Husband E$\rightarrow$E'      
      
      
      do j=1,4
      xmoment(m)=xetnuqp(j,1,1,2)      
      iproba(m)=1      
      m=m+1
      enddo
!************************************
!     Table 99p2  Table 12
!************************************
      xlmoment(m)='Husband U$\rightarrow$E, cond. on Wife
     * E$\rightarrow$E.
     * Same job'
      xlmoment(m+1)='Husband U$\rightarrow$E, cond. on Wife
     * E$\rightarrow$E.
     * Job-to-job'
!      xlmoment(m+2)='Husband U$\rightarrow$E, cond. on Wife
!     * E$\rightarrow$E '

      xmoment(m)=xetnuqp(1,9,1,1)
      iproba(m)=1      
      m=m+1
      xmoment(m)=xetnuqp(2,9,1,1)
      iproba(m)=1      
      m=m+1
!      xmoment(m)=xetnuqp(3,9,1,1) !!!!!!!!!!!!!!!!!!!!!!!
!      m=m+1
      
      
      xlmoment(m)='Husband E$\rightarrow$U, cond. on Wife
     * E$\rightarrow$E.
     * Same job'
      xlmoment(m+1)='Husband E$\rightarrow$U, cond. on Wife
     * E$\rightarrow$E.
     * Job-to-job'
!      xlmoment(m+2)='Husband E$\rightarrow$U, cond. on Wife
!     * E$\rightarrow$E '

      xmoment(m)=xetnuqp(1,10,1,1)
      iproba(m)=1      
      m=m+1
      xmoment(m)=xetnuqp(2,10,1,1)
      iproba(m)=1      
      m=m+1
!      xmoment(m)=xetnuqp(3,10,1,1) !!!!!!!!!!!!!!!!
!      m=m+1
      
      
      xlmoment(m)='Wife U$\rightarrow$E, cond. on Husband
     * E$\rightarrow$E. 
     * Same job'
      xlmoment(m+1)='Wife U$\rightarrow$E, cond. on Husband
     * E$\rightarrow$E.
     * Job-to-job'
!      xlmoment(m+2)='Wife U$\rightarrow$E, cond. on Husband
!     * E$\rightarrow$E '
      
      xmoment(m)=xetnuqp(1,9,1,2)
      iproba(m)=1      
      m=m+1
      xmoment(m)=xetnuqp(2,9,1,2)
      iproba(m)=1      
      m=m+1
!      xmoment(m)=xetnuqp(3,9,1,2)
!      m=m+1

      xlmoment(m)='Wife E$\rightarrow$U, cond. on Husband
     * E$\rightarrow$E.
     * Same job'      
      xlmoment(m+1)='Wife E$\rightarrow$U, cond. on Husband
     * E$\rightarrow$E.
     *Job-to-job'
!      xlmoment(m+2)='Wife E$\rightarrow$U, cond. on Husband
!     * E$\rightarrow$E '
      
      xmoment(m)=xetnuqp(1,10,1,2)
      iproba(m)=1      
      m=m+1
      xmoment(m)=xetnuqp(2,10,1,2)
      iproba(m)=1      
      m=m+1
!      xmoment(m)=xetnuqp(3,10,1,2)
!      m=m+1
      
!     Joint Job-to-job 2 3 4      
!      Table       T1
!     Husband      
      do k=2,4
      do j=1,5
        xlmoment(m)='Job-to-job '// trim(xgender(1)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
          
      xmoment(m)=xetnuqp(j,k,1,1)
      iproba(m)=1      
      ichimo(m)=0
      m=m+1
      enddo
      enddo
      
!     Wife    
      do k=2,4      
      do j=1,5
        xlmoment(m)='Job-to-job '// trim(xgender(2)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
          
      xmoment(m)=xetnuqp(j,k,1,2)
      iproba(m)=1      
      ichimo(m)=0      
      m=m+1
      enddo
      enddo

      
!     Joint Job-to-job missing    5 6 7  
!     Husband
	do k=5,7
      do j=1,5
        xlmoment(m)='JTJ Missing '// trim(xgender(1)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
      xmoment(m)=xetnuqp(j,k,1,1)
      ichimo(m)=0            
      iproba(m)=1      
      m=m+1
      enddo
      enddo      
      
!     Wife
	do k=5,7
      do j=1,5
        xlmoment(m)='JTJ Missing '// trim(xgender(2)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
      xmoment(m)=xetnuqp(j,k,1,2)
      ichimo(m)=0            
      iproba(m)=1      
      m=m+1
      enddo
      enddo      
      

!     Joint Quits 2 3 4
!     Husband      
      do k=2,4
      do j=1,5
        xlmoment(m)='Quits '// trim(xgender(1)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
      xmoment(m)=xetnuqp(j,k,2,1)
      ichimo(m)=0                  
      iproba(m)=1      
      m=m+1
      enddo
      enddo
      
!     Wife    
      do k=2,4      
      do j=1,5
        xlmoment(m)='Quits '// trim(xgender(2)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
      xmoment(m)=xetnuqp(j,k,2,2)
      iproba(m)=1      
      ichimo(m)=0                        
      m=m+1
      enddo
      enddo
      
      
      
!     Joint Quits Missing     5 6 7 
!     Husband
	do k=5,7
      do j=1,5
        xlmoment(m)='Quits Missing '// trim(xgender(1)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
      xmoment(m)=xetnuqp(j,k,2,1)
      ichimo(m)=0            
      iproba(m)=1      
      m=m+1
      enddo
      enddo      
      
!     Wife
	do k=5,7
      do j=1,5
        xlmoment(m)='Quits Missing '// trim(xgender(2)) //' '
     *   // trim(xlabelj(k))//' '// trim(xlabel(j))
      xmoment(m)=xetnuqp(j,k,2,2)
      ichimo(m)=0            
      iproba(m)=1      
      m=m+1
      enddo
      enddo      
      
      
      
!     Missing in Quits conditional 8
!     Husband     
!     Husband
      do j=1,5
        xlmoment(m)='EU '// trim(xgender(1)) //' '
     *   // trim(xlabel(j))
      xmoment(m)=xetnuqp(j,8,2,1)
      ichimo(m)=0            
      iproba(m)=1      
      m=m+1
      enddo
      
!     Wife
      do j=1,5
        xlmoment(m)='EU '// trim(xgender(2)) //' '
     *   // trim(xlabel(j))
      xmoment(m)=xetnuqp(j,8,2,2)
      ichimo(m)=0            
      iproba(m)=1      
      m=m+1
      enddo
      
      
      
!*****************************************xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       
      
!************************************
!     Table 7
!************************************
	xlabel(1)= 'All'
	xlabel(2)= 'UU'
	xlabel(3)= 'UE'
	xlabel(4)= 'EU'
	xlabel(5)= 'EE'
	xlabel(6)= 'E1'
	xlabel(7)= 'E2'
	xlabel(8)= 'MW1'
	xlabel(9)= 'SW1'
	xlabel(10)= 'MW2'
	xlabel(11)= 'SW2'
      
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'
      
      
	do k=1,11      
        do j=1,6
        xlmoment(m)=trim(xlabel(k)) //' '// trim(xlabelj(j))//' curr'
	  xmoment(m)=xassdbn(j,k)
        if (k.eq.1.and.j.eq.6)ichimo(m)=0 !All T curr
              if(k.le.7)iproba(m)=1
        m=m+1      
       enddo
      enddo

      
	do k=1,11      
        do j=1,6
        xlmoment(m)=trim(xlabel(k)) //' '// trim(xlabelj(j))//' perm'
	  xmoment(m)=xassdbnp(j,k)
         if(k.le.7)iproba(m)=1        
        if (k.eq.1.and.j.eq.6)ichimo(m)=0 !All T perm
        m=m+1      
       enddo
      enddo
      

	xlabel(1)= 'UR1: U'
	xlabel(2)= 'UR1: E'
	xlabel(3)= 'UR2: U'
	xlabel(4)= 'UR2: E'
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'
      

      
	do k=1,4
        do j=1,6
        xlmoment(m)=trim(xlabel(k))//' '// trim(xlabelj(j))//' curr'
	  xmoment(m)=xassdbnu(j,k)
       iproba(m)=1                
        m=m+1      
       enddo
       enddo
      
	do k=1,4
        do j=1,6
        xlmoment(m)=trim(xlabel(k))//' '// trim(xlabelj(j))//' perm'
	  xmoment(m)=xassdbnpu(j,k)
       iproba(m)=1                
        m=m+1      
       enddo
      enddo

************************************
!*     Hazard
!*************************************
	xlabel(0)= 'Censored'
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'

	xlabelj(1)= 'UU'
	xlabelj(2)= 'UE'
	xlabelj(3)= 'EU'
	xlabelj(4)= 'EE'
      
	xlabelk(1)= ' Entry'
	xlabelk(2)= ' Exit'

      
!     Table 7      
      do k=1,2
      do i=1,4 !Status
      do j=1,4 
        xlmoment(m)=trim(xlabel(j)) //'$\rightarrow$'// 
     *  trim(xlabelj(i))// trim(xlabelk(k))
	  xmoment(m)=exhaz0(i,j,k)
       iproba(m)=1                        
        m=m+1              
      enddo
      enddo
      enddo      

      
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
      
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'
      
      
	xlabelk(1)= ' 1'
	xlabelk(2)= ' 2'
	xlabelk(3)= ' 3'
	xlabelk(4)= ' 4'
	xlabelk(5)= ' 5'
	xlabelk(6)= ' 6'
      
	xlabelk(7)= ' 7'
	xlabelk(8)= ' 8'
	xlabelk(9)= ' 9'
	xlabelk(10)= ' 10'
	xlabelk(11)= ' 11'
	xlabelk(12)= ' 12'
      

!     Table H2      
      do ibrap=1,6
      do k=1,4
      do i=1,thazt              
        xlmoment(m)=trim(xlabel(k)) // ' '// trim(xlabelj(ibrap)) //
     *    ' ExHaz ' // trim(xlabelk(i)) 
	  xmoment(m)=exhaz(i,k,ibrap)
       ichimo(m)=0                    
       iproba(m)=1           
        m=m+1             
      enddo
      enddo
      enddo

      do ibrap=1,6
      do k=1,4
      do i=2,thazt              
        xlmoment(m)=trim(xlabel(k)) // ' '// trim(xlabelj(ibrap)) //
     *    ' Haz '// trim(xlabelk(i)) 
	  xmoment(m)=exhaz3(i,k,ibrap)
       if(ibrap.ne.6)ichimo(m)=0                    
       iproba(m)=1           
        m=m+1             
      enddo
      enddo
      enddo
      
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'

      
	xlabel(1)= ' 1'
	xlabel(2)= ' 2'
	xlabel(3)= ' 3'
	xlabel(4)= ' 4'
	xlabel(5)= ' 5'
	xlabel(6)= ' 6'
      
	xlabel(7)= ' 7'
	xlabel(8)= ' 8'
	xlabel(9)= ' 9'
	xlabel(10)= ' 10'
	xlabel(11)= ' 11'
	xlabel(12)= ' 12'
      
!     Table H 4      
      do n=1,2      
      do ibrap=1,6
      do k=1,5
      do i=1,thazt
      do l=1,3
      xlmoment(m)=trim(xgender(n)) //' '// trim(xlabelj(ibrap)) // 
     *   trim(xlabel(i)) //' AccWa'
	  xmoment(m)=wtdurave(i,k,ibrap,n,l)
!      if (l.ge.2)ichimo(m)=0
      ichimo(m)=0        
       if(ibrap.ne.6)ichimo(m)=0                          
       if(k.ne.5)ichimo(m)=0                          
        m=m+1                        
      enddo !l      
      enddo !i
      enddo !k      
      enddo !ibrap
      enddo !n          

!************************************
!*     Individual hazard
!*************************************
	xlabel(0)= 'Censored spell '
      xlabel(1)= 'U '
	xlabel(2)= 'E'
	xlabel(3)= 'Total '

	xlabelj(1)= ' Ind Entry'
	xlabelj(2)= ' Ind Exit'
      
!     Table H 5      
      do n=1,2      
      do i=1,2          
      do l=1,2
          do k=1,2
        xlmoment(m)=trim(xgender(n)) // ' ' // trim(xlabel(l)) //
     *   ' ' //  trim(xlabel(k)) // trim(xlabelj(i))
	  xmoment(m)=exhazi0(k,l,i,6,n)
       iproba(m)=1                                
        m=m+1                            
      enddo !k
      enddo !l
      enddo !i      
      enddo !n      


	xlabelj(1)= 'Unemployment'
	xlabelj(2)= 'Employment'
      

	xlabelk(1)= 'U'
	xlabelk(2)= 'E'

      
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'

      
	xlabel(1)= '1'
	xlabel(2)= '2'
	xlabel(3)= '3'
	xlabel(4)= '4'
	xlabel(5)= '5'
	xlabel(6)= '6'
      
	xlabel(7)= '7'
	xlabel(8)= '8'
	xlabel(9)= '9'
	xlabel(10)= '10'
	xlabel(11)= '11'
	xlabel(12)= '12'

!     Table H 7 8
      do n=1,2    
      do ibrap=1,6          
      do j=1,2          
      do i=1,thazt
      xlmoment(m)=trim(xgender(n)) // ' ' // trim(xlabelk(j)) // 
     * ' ' // trim(xlabelj(ibrap))//
     *' ExHazi' // trim(xlabel(i))
	  xmoment(m)=exhazi(i,j,ibrap,n)
       iproba(m)=1                                
       ichimo(m)=0
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
      xlmoment(m)=trim(xgender(n)) // ' ' // trim(xlabelk(j)) // 
     * ' ' // trim(xlabelj(ibrap))//
     *' Ind Haz ' // trim(xlabel(i))
	  xmoment(m)=exhazi3(i,j,ibrap,n)
       iproba(m)=1                                
       if(ibrap.ne.6.and.ibrap.ne.1)ichimo(m)=0                           
        m=m+1                        
      enddo !i
      enddo !j      
      enddo !ibrap
      enddo !n
      
      
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'

      
	xlabel(1)= '1'
	xlabel(2)= '2'
	xlabel(3)= '3'
	xlabel(4)= '4'
	xlabel(5)= '5'
	xlabel(6)= '6'
      
	xlabel(7)= '7'
	xlabel(8)= '8'
	xlabel(9)= '9'
	xlabel(10)= '10'
	xlabel(11)= '11'
	xlabel(12)= '12'
      
!     Table H 9      
      do l=1,3      
      do n=1,2              
          do ibrap=1,6          
      do i=2,thazt
      xlmoment(m)=trim(xgender(n)) // ' ' // trim(xlabelj(ibrap)) // 
     *  ' Ind AccWa ' // trim(xlabel(i))
	  xmoment(m)=wtduravin(i,ibrap,n,l)
      if (l.ge.2)ichimo(m)=0  
       if(ibrap.ne.6.and.ibrap.ne.1)ichimo(m)=0                           
        m=m+1                        

          enddo !i
      enddo !ibrap          
      enddo !n
      enddo !l      

      
      
      nmoment=m-1
!      m=nmoment
!      write(*,*) m,xmoment(m),xlmoment(m)      
