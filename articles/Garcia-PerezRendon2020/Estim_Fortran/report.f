	if (itex.eq.1)then
!     Reporting Descriptive stats 
!************************************
      call date_and_time(values=ifecha)    
          
	open (201,file=filetex)   !tex

      write(201,*) '\documentclass[12pt]{article}'
      write(201,*) '\setlength{\textwidth}{6in}'
      write(201,*) '\setlength{\textheight}{8.5in}'
      write(201,*) '\setlength{\topmargin}{0.25in}'
      write(201,*) '\setlength{\oddsidemargin}{0.25in}'
      write(201,*) '\setlength{\footskip}{0.4in}'
      write(201,*) '\setlength{\headheight}{0.0in}'
      write(201,*) '\setlength{\headsep}{0.5in}'
!      write(201,*) '\input tcilatex'

      write(201,*) ''
      write(201,*) '\begin{document}'
      write(201,*) '\renewcommand{\baselinestretch}{1}'
	write(201,*) '\pagestyle{myheadings}'
	write(201,*) '\markright{Family Job Search and Wealth. '
	write(201,*) "Garc\'{\i}a-P\'erez and Rendon. "
      write(201,"(i4,'/',i2,'/',i2,' ',i4,':',i2,' ',i2,'.',i3)") 
     * ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8)
	write(201,*) " }"      
!      write(201,*) '\small '
      write(201,*) ''
      write(201,*) '{\Large ',xac,' ',ix,'}'
      write(201,*) '\bigskip' 
      write(201,*) '\section{Main Tables}'
      write(201,*) ''

      
       itable=1      
!************************************
!     Table 1-4, 4a
!************************************
	xlabel(0)='\ \ Unemployed'
	xlabel(1)='\ \ Employed'
      
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{lrr}'
      write(201,*) '\multicolumn{3}{c}{Table ',itable,'. ',xac,
     *" Employment, Wages, and Wealth by}\\"
      write(201,*)'\multicolumn{3}{c}{Household Employment Status}\\'
      write(201,*) '\hline \hline'
      write(201,*) xac,' & \multicolumn{2}{c}{Spouse} \\ '
      write(201,*) '\cline{2-3}'
      write(201,*) 'Variable & Unemployed & Employed   \\ '
      write(201,*) 'Joint Employment Status &  &   \\ '
      write(201,*) 'Husband &  &   \\ '
      write(201,*) '\hline\hline'
      
	do j=0,1	
	write(201,920)xlabel(j), (100.d0*xenum(j,k),k=0,1)
	enddo
      
	xwdi=0.d0
	do j=1,5
	do k=1,5
	if(j.eq.k)then
	xwdi(1)=xwdi(1)+xwnum(j,k)	
	elseif(j.gt.k)then
	xwdi(2)=xwdi(2)+xwnum(j,k)
	elseif(j.lt.k)then
	xwdi(3)=xwdi(3)+xwnum(j,k)
	endif
	enddo
	enddo
	xwdi=100*xwdi/xenum(1,1)
        write(201,*) 'Wages  &  &  \\ '   
	
	write(201,921)"Same for both", xwdi(1)
	write(201,921)"Husband is higher", xwdi(2)
	write(201,921)"Wife is higher", xwdi(3)
 921  format(1x,a15,2(1x,'&'),1x,f10.2,' \\')
      
      write(201,*) 'Unemployment Rate &  &  \\ '      
      j=0
	write(201,920) 'Husband', (100.d0*xenum(j,k)/xenum(2,k),k=0,1)
	k=0	
	write(201,920) 'Wife', (100.d0*xenum(j,k)/xenum(j,2),j=0,1)
 920  format(1x,a15,2(1x,'&',1x,f10.2),' \\')
      write(201,*) 'Wages &  &  \\ '            
 
	j=1
	write(201,422) '\ \ Husband', (int(xewag(j,k,1,1)),k=0,1)
	write(201,423)           (int(xewag(j,k,1,2)),k=0,1)
      k=1
	write(201,422) '\ \ Wife', (int(xewag(j,k,2,1)),j=0,1)
	write(201,423)           (int(xewag(j,k,2,2)),j=0,1)
 422  format(1x,a15,2(1x,'&',1x,i10),' \\')
 423  format(16x,2(1x,'& (',1x,i10,')'),' \\')
     
      write(201,*) 'Wealth if Husband &  &  \\ '      
	do j=0,1	
	write(201,422) xlabel(j), (int(xeass(j,k,1)),k=0,1)
	write(201,423)           (int(xeass(j,k,2)),k=0,1)
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

 
      
      itable=itable+1      
      
*************************************
*     Table 5c
*************************************
	xlabel(0)= 'Unemployed'
!      write(xlabel(1),'(a7,i5,a2,i5,a1)' ) 
      write(xlabel(1),416),int(wmn),int(w1)
      write(xlabel(2),416),int(w1),int(w2)
      write(xlabel(3),416),int(w2),int(w3)
      write(xlabel(4),416),int(w3),int(w4)
      write(xlabel(5),416),int(w4),int(wmx)      
	xlabel(6)= 'Total'

      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l rr rr}'
      write(201,*) '\multicolumn{5}{c}{Table ', itable,'. ',xac,
     *" Unemployment Rate and Average Wage } \\ "
      write(201,*) "\multicolumn{5}{c}{by Spouse's Wage Segment} \\ "
      write(201,*) '\hline \hline'
      write(201,*) 'Spouse is &'
      write(201,*) '\multicolumn{2}{c}{Unemployment Rate} & 
     * \multicolumn{2}{c}{Average Wage} \\  '
      
      
      write(201,*) 'Spouse is &'
      write(201,*) '\multicolumn{1}{c}{Husband} & 
     * \multicolumn{1}{c}{Wife} &  '
      write(201,*) '\multicolumn{1}{c}{Husband} & 
     * \multicolumn{1}{c}{Wife} \\  '

      write(201,*) '\hline\hline'
      write(201,*) 'Wage Segment  &  &  &  & \\ '
	do j=0,5	
	write(201,1920) xlabel(j),
     * 100*xwnum(0,j)/xwnum(6,j),100*xwnum(j,0)/xwnum(j,6),
     * int(xwnub(j,1,2)+0.5),int(xwnub(j,2,2)+0.5)
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

1920  format(1x,a30,2(1x,'&',1x,f10.2),2(1x,'&',1x,i6),' \\')
      

	
      
      itable=itable+1            
      
      
      
!************************************
!     Table 8
!************************************
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'T'
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table',itable,'. ',xac,
     *'Employment Transitions} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '

	do k=1,5	
	write(201,126)xlabel(k), (100*xetnum(j,k),j=1,5)
!      write(201,*) ' &  &  & & & &   \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1            
!************************************
!     Table 8a
!************************************
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'T'
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table',itable,'. ',xac,
     * 'Employment Transitions. Row} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '

	do k=1,5	
	write(201,126)xlabel(k), (100*xetnumr(j,k),j=1,5)
!      write(201,*) ' &  &  & & & &   \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1            
      
      
!************************************
!     Table 90t
!************************************
            write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r }'
      write(201,*) '\multicolumn{6}{c}{Table ',itable,'. ',xac,
     * 'Employment, Wage variations and Asset variations  } \\ '
      write(201,*) "\multicolumn{6}{c}{conditional on Spouse's
     * Employment Transitions } \\ "
      write(201,*) '\hline \hline'
      write(201,*) "Transition & Total / \multicolumn{4}{c}{
     *   Spouse's Transitions}  \\ "
      write(201,*) '\cline{2-5}'
      write(201,*) ' & Total & UU & UE  &EU & EE  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' Employment Transitions & &  &  & &  \\ '      
	write(201,1126) "Husband UE", 
     *  100*(xetnum(3,1)+xetnum(3,2)+xetnum(4,1)+xetnum(4,2))/
     *      (xetnum(5,1)+xetnum(5,2)),
     *  (100*xetnum(3,j)/(xetnum(3,j)+xetnum(1,j)),
     *  100*xetnum(4,j)/(xetnum(4,j)+xetnum(2,j)), j=1,2)
	write(201,1126) " \ \ \ \  EU", 
     *  100*(xetnum(1,3)+xetnum(2,3)+xetnum(1,4)+xetnum(2,4))/
     *      (xetnum(5,3)+xetnum(5,4)),
     *     (100*xetnum(1,j)/(xetnum(3,j)+xetnum(1,j)),
     *      100*xetnum(2,j)/(xetnum(4,j)+xetnum(2,j)), j=3,4)      
!      write(201,*) ' Wife &  &  & & \\ '      
	write(201,1126) "Wife: UE", 
     *  100*(xetnum(2,1)+xetnum(2,3)+xetnum(4,1)+xetnum(4,3))/
     *      (xetnum(5,3)+xetnum(5,1)),
     *      (100*xetnum(2,j)/(xetnum(2,j)+xetnum(1,j)),
     *      100*xetnum(4,j)/(xetnum(4,j)+xetnum(3,j)), j=1,3,2) 
	write(201,1126) " \ \ \ \ EU", 
     *  100*(xetnum(1,2)+xetnum(1,4)+xetnum(3,2)+xetnum(3,4))/
     *      (xetnum(5,2)+xetnum(5,4)),
     *      (100*xetnum(1,j)/(xetnum(2,j)+xetnum(1,j)),
     *      100*xetnum(3,j)/(xetnum(4,j)+xetnum(3,j)), j=2,4,2)

      
      write(201,*) ' Job-to-Job  &  &  &  & &  \\'      
!      write(201,*) ' Husband &  &  & &  \\ '      
      write(201,2129) 'Husband:  EE', 
     *  100*xetnuqp(5,1,1,1),(100*xetnuqp(j,1,1,1),j=1,4)
!      write(201,*) ' Wife &  &  & & \\ '      
	write(201,2129) "Wife:  EE", 
     *  100*xetnuqp(5,1,1,2),(100*xetnuqp(j,1,1,2),j=1,4)
      
      write(201,*) ' Quits &  &  &  & &  \\'      
!      write(201,*) ' Husband &  &  & &  \\ '      
      write(201,3129) 'Husband:  EU', 
     *  100*xetnuqp(5,1,2,1),100*xetnuqp(4,1,2,1)
!      write(201,*) ' Wife &  &  & & \\ '      
	write(201,3129) "Wife:  EU", 
     *  100*xetnuqp(5,1,2,2),100*xetnuqp(4,1,2,2)

3129  format(1x,a20,1x,'&',1x,f10.2,1x,' & & & & ',1x,f10.2,' \\')
      write(201,*) 'Wage variations EE &  & &  & &  \\ '
	write(201,1229) "Husband", 
     * int((xetwag(3,3,1,1)*xetnum(3,3)
     *     +xetwag(3,4,1,1)*xetnum(3,4)
     *     +xetwag(4,3,1,1)*xetnum(4,3)
     *     +xetwag(4,4,1,1)*xetnum(4,4))/      
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))),
     *       int(xetwag(3,3,1,1)),int(xetwag(4,3,1,1)),
     *                      int(xetwag(3,4,1,1)),int(xetwag(4,4,1,1))
	write(201,1229) " ", 
     * int(sqrt( 
     * (xetwag(3,3,1,2)*xetnum(3,3)*xetwag(3,3,1,2)*xetnum(3,3)
     * +xetwag(3,4,1,2)*xetnum(3,4)*xetwag(3,4,1,2)*xetnum(3,4)
     * +xetwag(4,3,1,2)*xetnum(4,3)*xetwag(4,3,1,2)*xetnum(4,3)
     * +xetwag(4,4,1,2)*xetnum(4,4)*xetwag(4,3,1,2)*xetnum(4,3)
     *      )/ (     
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))*
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))   )   
     *      )),
     *      int(xetwag(3,3,1,2)),int(xetwag(4,3,1,2)),
     *                      int(xetwag(3,4,1,2)),int(xetwag(4,4,1,2))
	write(201,1229) "Wife", 
     * int((xetwag(2,2,1,1)*xetnum(2,2)
     *     +xetwag(2,4,1,1)*xetnum(2,4)
     *     +xetwag(4,2,1,1)*xetnum(4,2)
     *     +xetwag(4,4,1,1)*xetnum(4,4))/      
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))),
     *      int(xetwag(2,2,2,1)),int(xetwag(4,2,2,1)),
     *                      int(xetwag(2,4,2,1)),int(xetwag(4,4,2,1))
	write(201,1229) " ", 
     * int(sqrt( 
     * (xetwag(2,2,1,2)*xetnum(2,2)*xetwag(2,2,1,2)*xetnum(2,2)
     * +xetwag(2,4,1,2)*xetnum(2,4)*xetwag(2,4,1,2)*xetnum(2,4)
     * +xetwag(4,2,1,2)*xetnum(4,2)*xetwag(4,2,1,2)*xetnum(4,2)
     * +xetwag(4,4,1,2)*xetnum(4,4)*xetwag(4,4,1,2)*xetnum(4,4)
     *      )/ (     
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))*
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))   )   
     *      )),
     *      int(xetwag(2,2,2,2)),int(xetwag(4,2,2,2)),
     *                      int(xetwag(2,4,2,2)),int(xetwag(4,4,2,2))
      
      write(201,*) 'Asset variations EE & &  &  & &  \\ '
	write(201,1229) "Husband ",  
     * int((xetass(3,3,1)*xetnum(3,3)
     *     +xetass(3,4,1)*xetnum(3,4)
     *     +xetass(4,2,1)*xetnum(4,3)
     *     +xetass(4,3,1)*xetnum(4,4))/      
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))),
     *  int(xetass(3,3,1)),int(xetass(4,3,1)),
     *                      int(xetass(3,4,1)),int(xetass(4,4,1))
	write(201,1229) " ",   
     * int(sqrt( 
     * (xetass(3,3,2)*xetnum(3,3)*xetass(3,3,2)*xetnum(3,3)
     * +xetass(3,4,2)*xetnum(3,4)*xetass(3,4,2)*xetnum(3,4)
     * +xetass(4,3,2)*xetnum(4,3)*xetass(4,3,2)*xetnum(4,3)
     * +xetass(4,4,2)*xetnum(4,4)+xetass(4,4,2)*xetnum(4,4)
     *      )/ (     
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))*
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))   )   
     *      )),
     *   int(xetass(3,3,2)),int(xetass(4,3,2)),
     *                      int(xetass(3,4,2)),int(xetass(4,4,2))
	write(201,1229) "Wife", 
     * int((xetass(2,2,1)*xetnum(2,2)
     *     +xetass(2,4,1)*xetnum(2,4)
     *     +xetass(4,2,1)*xetnum(4,2)
     *     +xetass(4,4,1)*xetnum(4,4))/      
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))),
     *      int(xetass(2,2,1)),int(xetass(4,2,1)),
     *                      int(xetass(2,4,1)),int(xetass(4,4,1))
	write(201,1229) " ", 
     * int(sqrt( 
     * (xetass(2,2,2)*xetnum(2,2)*xetass(2,2,2)*xetnum(2,2)
     * +xetass(2,4,2)*xetnum(2,4)*xetass(2,4,2)*xetnum(2,4)
     * +xetass(4,2,2)*xetnum(4,2)*xetass(4,2,2)*xetnum(4,2)
     * +xetass(4,4,2)*xetnum(4,4)*xetass(4,4,2)*xetnum(4,4)
     *      )/ (     
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))*
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))   )   
     *      )),
     * int(xetass(2,2,2)),int(xetass(4,2,2)),
     *                      int(xetass(2,4,2)),int(xetass(4,4,2))

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+2                  

      
!************************************
!     Table Hazards
!************************************
      
	xlabel(0)= 'Censored'
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'Total'

      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrrrr}'
      write(201,*)'\multicolumn{5}{c}{Table',itable,xac,'. Employment'
      write(201,*) 'Status at Exit by Employment Status'
      write(201,*) 'Spell} \\ '
      write(201,*) '\multicolumn{5}{c}{in Percentage'
      write(201,*) '(each column adds up to 100\%)} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Exit} &'
      write(201,*) '\multicolumn{4}{c}{Employment'
      write(201,*) 'Status Spell} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{1}{c}{UU} & ' 
      write(201,*) '\multicolumn{1}{c}{UE} & '
      write(201,*) '\multicolumn{1}{c}{EU} & '
      write(201,*) '\multicolumn{1}{c}{EE} \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  &  &   \\'      
      do j=1,4
	write(201,5527) xlabel(j), (100*exhaz0(i,j,1),i=1,4)
      enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
             

      itable=itable+1                  
      
!*********************************************************************            
      write(201,*) '\section{Other Status Tables}'
!*********************************************************************            
      itable=1
!************************************
!     Table S W 1
!************************************
	xlabel(0)= 'Unemployed'
!      write(xlabel(1),'(a7,i5,a2,i5,a1)' ) 
      write(xlabel(1),416),int(wmn),int(w1)
      write(xlabel(2),416),int(w1),int(w2)
      write(xlabel(3),416),int(w2),int(w3)
      write(xlabel(4),416),int(w3),int(w4)
      write(xlabel(5),416),int(w4),int(wmx)      
	xlabel(6)= 'Total'
      
	xlabelj(0)= ''
!      write(xlabel(1),'(a7,i5,a2,i5,a1)' ) 
      write(xlabelj(1),415),int(amn),int(a1)
      write(xlabelj(2),415),int(a1),int(a2)
      write(xlabelj(3),415),int(a2),int(a3)
      write(xlabelj(4),415),int(a3),int(a4)
      write(xlabelj(5),415),int(a4),int(amx)      
	xlabelj(6)= 'Total'
415   format("\lbrack",i6,", ",i6,")")              

      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r l r}'
      write(201,*) '\multicolumn{4}{c}{Table S',itable,'. ',
     *      'Wage and Wealth brackets} \\ \hline \hline'
      write(201,*) '\multicolumn{2}{c}{Wage W} &'
      write(201,*) '\multicolumn{2}{c}{Wealth A} \\'      
      write(201,*) '\hline\hline'
	write(201,*) ' &  & & \\ '
		
	write(201,*)   " & ",xlabel(0)," &   &   \\"
	do j=1,6	
	write(201,*) 'W',j, " & ",xlabel(j)," & A",j, " & ",xlabelj(j)," \\"
	enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1                  
      
      
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r r r}'
      write(201,*) '\multicolumn{8}{c}{Table S',itable,'. ',xac,
     *      'Wage bracket.} \\ \hline \hline'
      write(201,*) 'Husband & \multicolumn{6}{c}{Wife} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-7}'
      write(201,*) ' &  U &  W1 & W2 & W3 & W4 & W5 & T \\ '

!	write(201,122)(xlabel(j),j=1,6)

      write(201,*) '\hline\hline'
	write(201,*) ' &  & &  &  & & & \\ '

	do j=0,6	
	write(201,122)xlabel(j), (100*xwnum(j,k),k=0,6)
!	write(201,*) ' &  & & &  & & & \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1                  
!************************************
!     Table S W 1 a
!************************************

416   format("\lbrack",i5,", ",i5,")")  
      write(201,*) '{\small '            
      write(201,*) '\begin{tabular}{l r r r r r r r}'
      write(201,*) '\multicolumn{8}{c}{Table S',itable,'. ',xac,
     *      'Wage bracket. Row} \\  \hline \hline'
      write(201,*) 'Husband & \multicolumn{6}{c}{Wife} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-7}'
      write(201,*) ' &  U &  W1 & W2 & W3 & W4 & W5 & T \\ '

!	write(201,122)(xlabel(j),j=1,6)

      write(201,*) '\hline\hline'
	write(201,*) ' &  & &  &  & & & \\ '

	do j=0,6	
	write(201,122)xlabel(j), (100*xwnum(j,k)/xwnum(j,6),k=0,6)
!	write(201,*) ' &  & & &  & & & \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "          
      itable=itable+1                        
!************************************
!     Table S W 1 b
!************************************
	xlabel(0)= 'Unemployed'
!      write(xlabel(1),'(a7,i5,a2,i5,a1)' ) 
      write(xlabel(1),416),int(wmn),int(w1)
      write(xlabel(2),416),int(w1),int(w2)
      write(xlabel(3),416),int(w2),int(w3)
      write(xlabel(4),416),int(w3),int(w4)
      write(xlabel(5),416),int(w4),int(wmx)      
	xlabel(6)= 'Total'
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r r r}'
      write(201,*) '\multicolumn{8}{c}{Table S',itable,'. ',xac,
     *    'Wage bracket. Column} \\  \hline \hline'
      write(201,*) 'Husband & \multicolumn{6}{c}{Wife} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-7}'
      write(201,*) ' &  U &  W1 & W2 & W3 & W4 & W5 & T \\ '

!	write(201,122)(xlabel(j),j=1,6)

      write(201,*) '\hline\hline'
	write(201,*) ' &  & &  &  & & & \\ '

	do j=0,6	
	write(201,122)xlabel(j), (100*xwnum(j,k)/xwnum(6,k),k=0,6)
!	write(201,*) ' &  & & &  & & & \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1                  
      
!************************************
!     Table S A 1
!************************************
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r r r}'
      write(201,*) '\multicolumn{8}{c}{Table S',itable,'. ',xac,
     *  ' Average Current Wealth by Wage bracket} \\  \hline \hline'
      write(201,*) 'Husband & \multicolumn{6}{c}{Wife} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-7}'
      write(201,*) ' &  U &  W1 & W2 & W3 & W4 & W5 & T \\ '
      write(201,*) '\hline\hline'
	write(201,*) ' &  & &  &  & & & \\ '

	do j=0,6	
	write(201,222)xlabel(j), (int(xwass(j,k,1)),k=0,6)
	write(201,223)           (int(xwass(j,k,2)),k=0,6)
!	write(201,*) ' &  &  & & & & & \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
     
      itable=itable+1                        
      
*************************************
*     Table S A 2a
*************************************
	xlabel(1)= '\%'
	xlabel(2)= 'UU'
	xlabel(3)= 'UE'
	xlabel(4)= 'EU'
	xlabel(5)= 'EE'
	xlabel(6)= 'E1'
	xlabel(7)= 'E2'
	xlabel(8)= 'W1'
	xlabel(9)= 'SW1'
	xlabel(10)= 'W2'
	xlabel(11)= 'SW2'
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r r}'
      write(201,*) '\multicolumn{7}{c}{Table S',itable,'. Current'
	write(201,*) ' Wealth distribution by Employment Status and} \\ '
      write(201,*) '\multicolumn{7}{c}{Average Wages '
	write(201,*) ' by Current Wealth bracket} \\ '
      write(201,*) '\hline \hline'
      write(201,*) 'Variable & \multicolumn{5}{c}{Bracket} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-6}'
      write(201,*) ' &  A1 & A2 & A3 & A4 & A5 & T \\ '
      write(201,*) '\hline\hline'
	write(201,*) ' &  &  &  & & & \\ '

      k=1
	write(201,224)xlabel(k), (100*xassdbn(j,k),j=1,5),xassdbn(6,k)
	do k=2,7	
	write(201,224)xlabel(k), (100*xassdbn(j,k),j=1,6)
c	write(201,*) ' &  &  &  & & & \\ '
	enddo
	do k=8,11	
	write(201,225)xlabel(k), (int(xassdbn(j,k)),j=1,6)
c	write(201,*) ' &  &  &  & & & \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
*************************************

      itable=itable+1                        
     
      
*************************************
*     Table S A 2b
*************************************
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r r}'
      write(201,*) '\multicolumn{7}{c}{Table S',itable,'. Average '
	write(201,*) 'Wealth distribution by Employment Status and} \\ '
      write(201,*) '\multicolumn{7}{c}{Average Wages '
	write(201,*) ' by Average Wealth bracket} \\ '
      write(201,*) '\hline \hline'
      write(201,*) 'Variable & \multicolumn{5}{c}{Bracket} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-6}'
      write(201,*) ' &  A1 & A2 & A3 & A4 & A5 & T \\ '
      write(201,*) '\hline\hline'
	write(201,*) ' &  &  &  & & & \\ '

      k=1
	write(201,224)xlabel(k), (100*xassdbnp(j,k),j=1,5),xassdbnp(6,k)
	do k=2,7	
	write(201,224)xlabel(k), (100*xassdbnp(j,k),j=1,6)
c	write(201,*) ' &  &  &  & & & \\ '
	enddo
	do k=8,11	
	write(201,225)xlabel(k), (int(xassdbnp(j,k)),j=1,6)
c	write(201,*) ' &  &  &  & & & \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1                        
*************************************

*************************************
*     Table S A 3a
*************************************
	xlabel(1)= 'UR1: U'
	xlabel(2)= 'UR1: E'
	xlabel(3)= 'UR2: U'
	xlabel(4)= 'UR2: E'
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r r}'
      write(201,*) '\multicolumn{7}{c}{Table S',itable,'. Conditional '
	write(201,*) ' Unemployment Rate by } \\ '
      write(201,*) '\multicolumn{7}{c}{Current'
	write(201,*) ' Wealth bracket} \\ '
      
      write(201,*) '\hline \hline'
      write(201,*) 'Variable & \multicolumn{5}{c}{Bracket} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-6}'
      write(201,*) ' &  A1 & A2 & A3 & A4 & A5 & T \\ '
      write(201,*) '\hline\hline'
	write(201,*) ' &  &  &  & & & \\ '

      do k=1,4
      write(201,224)xlabel(k), (100*xassdbnu(j,k),j=1,6)
      enddo      
c	write(201,*) ' &  &  &  & & & \\ '

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "            
      itable=itable+1                        
*************************************

*************************************
*     Table S A 3b
*************************************
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r r}'
      write(201,*) '\multicolumn{7}{c}{Table S',itable,'. Conditional '
	write(201,*) ' Unemployment Rate by } \\ '
      write(201,*) '\multicolumn{7}{c}{Average'
	write(201,*) ' Wealth bracket} \\ '
      write(201,*) '\hline \hline'
      write(201,*) 'Variable & \multicolumn{5}{c}{Bracket} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-6}'
      write(201,*) ' &  A1 & A2 & A3 & A4 & A5 & T \\ '
      write(201,*) '\hline\hline'
	write(201,*) ' &  &  &  & & & \\ '

      do k=1,4
      write(201,224)xlabel(k), (100*xassdbnpu(j,k),j=1,6)
      enddo      
      
c	write(201,*) ' &  &  &  & & & \\ '

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "              
      itable=itable+1                        
*************************************
      
2126  format(1x,a15,8(1x,'&',1x,f10.2),' \\')      
2127  format(1x,a15,2(1x,'&',1x,f10.2),' \\')            
      

      
!*********************************************************************      
      write(201,*) '\section{Other Transition Tables}'
!*********************************************************************      
      write(201,*) '\subsection{Joint Transitions}'      
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'T'


      itable=1
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table T',itable,'. ',xac,      
     *      'Employment Transitions job-to-job} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'JTJ husband &  &  & & &  \\ '
      m=2            
	do k=3,5	
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,1,1),j=1,5)
      m=m+1            
      
      enddo
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'JTJ wife &  &  & & &  \\ '
      m=2                  
	do k=2,5	
      if(k.ne.3)then                    
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,1,2),j=1,5)   
      m=m+1               
      endif
      enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

      itable=itable+1
      
      
      
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table T',itable,'. ',xac,      
     *      'Employment Transitions missing} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'Missing husband &  &  & & &  \\ '
      m=5
	do k=3,5	
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,1,1),j=1,5)      
      m=m+1
      enddo
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'Missing wife &  &  & & &  \\ '
      m=5      
	do k=2,5	
      if(k.ne.3)then          
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,1,2),j=1,5)            
      m=m+1      
      endif
      enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

      itable=itable+1
      
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table T',itable,'. ',xac,
     * 'Employment Transitions Quits} \\ \hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'Quits husband &  &  & & &  \\ '
      m=2
	do k=3,5	
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,2,1),j=1,5)
      m=m+1      
      enddo
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'Quits wife &  &  & & &  \\ '
      m=2      
	do k=2,5	
      if(k.ne.3)then          
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,2,2),j=1,5)
      m=m+1      
      endif
      enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*)'\multicolumn{6}{c}{Table T',itable,'. ',xac,      
     * 'Employment Transitions missing} \\  \hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'Missing husband &  &  & & &  \\ '
      m=5    
	do k=3,5	
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,2,1),j=1,5)
      m=m+1            
      enddo
      write(201,*) ' &  &  & & &  \\ '
      write(201,*) 'Missing wife &  &  & & &  \\ '
      m=5     
	do k=2,5	
      if(k.ne.3)then          
	write(201,126)xlabel(k),
     *  (100*xetnuqp(j,m,2,2),j=1,5)      
      m=m+1      
      endif      
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

      itable=itable+1
      
!************************************
!     Table 9 10
!************************************
      
      do ll=1,2
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table T', itable,'f.', xac,
     *      'Employment Transitions. Wages',xgender(ll),'} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & &  &  \\ '
	do k=1,5
	write(201,226)xlabel(k), (int(xetwag(j,k,ll,1)),j=1,5)
	write(201,227)           (int(xetwag(j,k,ll,2)),j=1,5)
!      write(201,*) ' &  &  & & &   \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

      itable=itable+1
      enddo      
      
      
!************************************
!     Table 11
!************************************
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r}'
      write(201,*) '\multicolumn{6}{c}{Table T',itable,'. ',xac,      
     *      'Employment Transitions Asset $\Delta A$} \\'
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &   \\ '

	do k=1,5	
	write(201,226)xlabel(k), (int(xetass(j,k,1)),j=1,5)
	write(201,227)           (int(xetass(j,k,2)),j=1,5)
      write(201,227)           (int(xetass(j,k,3)),j=1,5)
!      write(201,*) ' &  &  & & &   \\ '
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  

      itable=itable+1
!************************************
!     Table 14
!************************************
!	Wage partial transitions by gender 14
	xlabel(0)= 'Unemployed'
!      write(xlabel(1),'(a7,i5,a2,i5,a1)' ) 
      write(xlabel(1),416),int(wmn),int(w1)
      write(xlabel(2),416),int(w1),int(w2)
      write(xlabel(3),416),int(w2),int(w3)
      write(xlabel(4),416),int(w3),int(w4)
      write(xlabel(5),416),int(w4),int(wmx)      
	xlabel(6)= 'Total'
!************************************
!     Table 14a
!************************************
!	Wage partial transitions by gender 14
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r r r}'
      write(201,*) '\multicolumn{8}{c}{Table T',itable,'. ',xac,      
     *      ' Wage bracket. Transition. Row} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{6}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-7}'
      write(201,*) ' &  U &  W1 & W2 & W3 & W4 & W5 & T \\ '
      write(201,*) '\hline\hline'
	write(201,*) ' &  & &  &  & & & \\ '
	do m=1,2
	write(201,*) xgender(m)	
	write(201,*) ' &  & &  &  & & & \\ '
	do j=0,6
		write(201,122)xlabel(j),
     *		(100*xwptnum(j,k,m)/xwptnum(j,6,m),k=0,6)
	enddo
!	write(201,*) ' &  & &  &  & & & \\ '
	enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1
      goto 1460
!************************************
!     Table 20
!************************************
	xlabel(0)= 'U'
	xlabel(1)= 'E'
	xlabel(2)= 'T'
      write(201,*) '{\small '      
      write(201,*) '\begin{tabular}{l r r r r r r r r r r r r}'
      write(201,*) '\multicolumn{13}{c}{Table 20.',xac,
     *      'Employment Status, Wages and Assets} \\ '
      write(201,*) '\hline \hline'


      write(201,*) '$t$'
      write(201,*) ' &  PUU &  PEU & PUE & PEE '
      write(201,*) ' &  WHu WiU & WHu WiE & WWi HuU & WWi HuE '
      write(201,*) ' &  AUU &  AEU & AUE & AEE  \\ '
      write(201,*) '\hline\hline'



      write(201,*) ' &  &  & &  &  & &  &  & &  &  &   \\ '

	do t=1,nmobs
	write(201,320)t,
     * 100.d0*xenumt(0,0,t),100.d0*xenumt(1,0,t),
     * 100.d0*xenumt(0,1,t),100.d0*xenumt(1,1,t),
     * int(xewagt(1,0,t,1,1)), int(xewagt(1,1,t,1,1)),
     * int(xewagt(0,1,t,2,1)), int(xewagt(1,1,t,2,1)),
     * int(xeasst(0,0,t,1)), int(xeasst(1,0,t,1)),
     * int(xeasst(0,1,t,1)), int(xeasst(1,1,t,1))
!      write(201,*) ' &  &  &   \\ '
        enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  


1460  continue
!************************************
!     Table 11a
!************************************
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrrrrr}'
      write(201,*) '\multicolumn{6}{c}{Table T',itable,'. ',xac,      
     *      'Employment, Wages and } \\ '
      write(201,*) '\multicolumn{6}{c}{ Wealth by
     *      Employment Transitions} \\ '
      write(201,*) '\hline \hline'
      write(201,*) '$t$ & \multicolumn{4}{c}{$t+1$} & 
     * \multicolumn{1}{c}{Total} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE & T  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & & &  \\ '
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'T'

      
	do k=1,5	
	write(201,126)xlabel(k), (100*xetnum(j,k)/xetnum(5,k),j=1,5)
	write(201,226) '\ \ $\Delta$w1', (int(xetwag(j,k,1,1)),j=1,5)
	write(201,227)           (int(xetwag(j,k,1,2)),j=1,5)
	write(201,226) '\ \ $\Delta$w2',(int(xetwag(j,k,2,1)),j=1,5)
	write(201,227)		      (int(xetwag(j,k,2,2)),j=1,5)
	write(201,226) '\ \ $\Delta$A', (int(xetass(j,k,1)),j=1,5)
	write(201,227)           (int(xetass(j,k,2)),j=1,5)
	enddo

      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      
      itable=itable+1      
      write(201,*) '\subsection{Conditional Transitions}'            
!************************************
!     Table 99
!************************************
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r }'
      write(201,*) '\multicolumn{5}{c}{Table T',itable,'. ',xac,      
     * '$\Delta$ Wage Conditional Employment Transitions } \\ '
      write(201,*) '\hline \hline'
      write(201,*) "Transition & \multicolumn{4}{c}{
     *   Spouse's Transitions}  \\ "
      write(201,*) '\cline{2-5}'
      write(201,*) ' & UU & UE  &EU & EE  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & &  \\ '
      write(201,*) ' Husband &  &  & &  \\ '      
      
	write(201,229) "UE", int(xetwag(3,1,1,1)),int(xetwag(4,1,1,1)),
     *                      int(xetwag(3,2,1,1)),int(xetwag(4,2,1,1))
	write(201,229) "  ", int(xetwag(3,1,1,2)),int(xetwag(4,1,1,2)),
     *                      int(xetwag(3,2,1,2)),int(xetwag(4,2,1,2))

	write(201,229) "EU", int(xetwag(1,3,1,1)),int(xetwag(2,3,1,1)),
     *                      int(xetwag(1,4,1,1)),int(xetwag(2,4,1,1))
	write(201,229) " ", int(xetwag(1,3,1,2)),int(xetwag(2,3,1,2)),
     *                      int(xetwag(1,4,1,2)),int(xetwag(2,4,1,2))

	write(201,229) "EE", int(xetwag(3,3,1,1)),int(xetwag(4,3,1,1)),
     *                      int(xetwag(3,4,1,1)),int(xetwag(4,4,1,1))
	write(201,229) " ", int(xetwag(3,3,1,2)),int(xetwag(4,3,1,2)),
     *                      int(xetwag(3,4,1,2)),int(xetwag(4,4,1,2))
      
     
      write(201,*) ' Wife  &  &  & &  \\ '      
	write(201,229) "UE", int(xetwag(2,1,2,1)),int(xetwag(4,1,2,1)),
     *                      int(xetwag(2,3,2,1)),int(xetwag(4,3,2,1))
	write(201,229) "  ", int(xetwag(2,1,2,2)),int(xetwag(4,1,2,2)),
     *                      int(xetwag(2,3,2,2)),int(xetwag(4,3,2,2))

	write(201,229) "EU", int(xetwag(1,2,2,1)),int(xetwag(3,2,2,1)),
     *                      int(xetwag(1,4,2,1)),int(xetwag(3,4,2,1))
	write(201,229) "  ", int(xetwag(1,2,2,2)),int(xetwag(3,2,2,2)),
     *                      int(xetwag(1,4,2,2)),int(xetwag(3,4,2,2))

	write(201,229) "EE", int(xetwag(2,2,2,1)),int(xetwag(4,2,2,1)),
     *                      int(xetwag(2,4,2,1)),int(xetwag(4,4,2,1))
	write(201,229) " ", int(xetwag(2,2,2,2)),int(xetwag(4,2,2,2)),
     *                      int(xetwag(2,4,2,2)),int(xetwag(4,4,2,2))
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1
      
!************************************
!     Table 99q
!************************************
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{l r r r r r }'
      write(201,*) '\multicolumn{6}{c}{Table T',itable,'. ',xac,      
     * "Employment, Transitions. Missing Quits   } \\ "
      write(201,*) "\multicolumn{6}{c}{variable conditional on Spouse's
     * Employment Transitions } \\ "
      write(201,*) '\hline \hline'
      write(201,*) "Transition & Total & \multicolumn{4}{c}{
     *   Spouse's Transitions}  \\ "
      write(201,*) '\cline{3-6}'
      write(201,*) ' & & UU & UE  & EU & EE  \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  & &  \\ '            
      write(201,*) ' Missing in job separations &  &  &  & &  \\'      
      write(201,2129) 'Husband:  EU', 
     *  100*xetnuqp(5,8,2,1),(100*xetnuqp(j,8,2,1),j=1,4)      
!      write(201,*) ' Wife &  &  & & \\ '      
	write(201,2129) "Wife:  EU", 
     *  100*xetnuqp(5,8,2,2),(100*xetnuqp(j,8,2,2),j=1,4)      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) "}"                  
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                  
      itable=itable+1
      
      
!************************************
!     Table 99p2
!************************************
      write(201,*) '{\small '            
      write(201,*) '\begin{tabular}{l r r r  }'
      write(201,*) "\multicolumn{4}{c}{Table ",itable,'. ',xac,      
     * "Employment, Transitions. EE'} \\ "
      write(201,*) "\multicolumn{4}{c}{conditional on Spouse's
     * Employment Transitions } \\ "
      write(201,*) '\hline \hline'
      write(201,*) "Transition & \multicolumn{3}{c}{
     *   Spouse's Transitions}  \\ "
      write(201,*) '\cline{2-4}'
      write(201,*) " &  EE & EEs & EE'  \\ "
      write(201,*) '\hline\hline'
      write(201,*) ' Employment Transitions &  &  &  \\'      
      
	write(201,2130) "Husband UE",100*xetnuqp(3,9,1,1),
     *  100*xetnuqp(1,9,1,1),100*xetnuqp(2,9,1,1)
	write(201,2130) " \ \ \ \  EU",100*xetnuqp(3,10,1,1),
     *  100*xetnuqp(1,10,1,1),100*xetnuqp(2,10,1,1)
      
	write(201,2130) "Wife UE",100*xetnuqp(3,9,1,2),
     *  100*xetnuqp(1,9,1,2),100*xetnuqp(2,9,1,2)
	write(201,2130) " \ \ \ \  EU",100*xetnuqp(3,10,1,2),
     *  100*xetnuqp(1,10,1,2),100*xetnuqp(2,10,1,2)
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}'
      write(201,*) '}'            
      write(201,*) '  '
      itable=itable+1      
      
!*********************************************************************            
      write(201,*) '\section{Other Hazard and Accepted Wages Tables}'
!*********************************************************************            
      
************************************
*     Table Proportion of hazard entrance
*************************************
      itable=1      
	xlabel(0)= 'Censored'
	xlabel(1)= 'UU'
	xlabel(2)= 'UE'
	xlabel(3)= 'EU'
	xlabel(4)= 'EE'
	xlabel(5)= 'Total'


      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrrrr}'
      write(201,*) '\multicolumn{5}{c}{Table H',itable,xac,'. Exit'
      write(201,*) 'Status by Employment Status'
      write(201,*) 'Spell} \\ '
      write(201,*) '\multicolumn{5}{c}{in Percentage'
      write(201,*) '(each column adds up to 100\%)} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Exit} &'
      write(201,*) '\multicolumn{4}{c}{Employment'
      write(201,*) 'Status Spell} \\ '
      write(201,*) '\multicolumn{1}{c}{Employment} &'
      write(201,*) '\multicolumn{4}{c}{',xac,'}  \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{1}{c}{UU} & ' 
      write(201,*) '\multicolumn{1}{c}{UE} & '
      write(201,*) '\multicolumn{1}{c}{EU} & '
      write(201,*) '\multicolumn{1}{c}{EE} \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  &  &   \\'      
      do j=1,4
	write(201,5527) xlabel(j), (100*exhaz0(i,j,2),i=1,4)
      enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         
5527  format(1x,a30,4(1x,'&',1x,f10.2),' \\')       
5529  format(1x,i2,4(1x,'&',1x,f10.2),' \\')             
      
      
      itable=itable+1
      
      
!*****Hazard by transition  ********************************************** xxxxxx     
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrrrr}'
      write(201,*) '\multicolumn{5}{c}{Table H',itable,xac,'. Hazard'
      write(201,*) 'by Joint Employment'
      write(201,*) 'Spell} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Duration} &'
      write(201,*) '\multicolumn{4}{c}{Employment'
      write(201,*) 'Status} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{1}{c}{UU} & ' 
      write(201,*) '\multicolumn{1}{c}{UE} & '
      write(201,*) '\multicolumn{1}{c}{EU} & '
      write(201,*) '\multicolumn{1}{c}{EE} \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  &  &   \\'      
      do i=2,thazt
          write(201,5529) i, (100*exhaz3(i,k,6),k=1,4)
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         
      itable=itable+1
!***************************************************xxxx      
      
      goto 6528
!********************Average wages      
	xlabelj(1)= 'A1'
	xlabelj(2)= 'A2'
	xlabelj(3)= 'A3'
	xlabelj(4)= 'A4'
	xlabelj(5)= 'A5'
	xlabelj(6)= 'T'
      xlabel(1)='Accepted Wage'
      xlabel(3)='Wage Counts'
      

      
!********************Average wages individual
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrr}'
      write(201,*) '\multicolumn{3}{c}{Table H',itable,xac,'. '
      write(201,*) " Accepted Wage} \\"
      write(201,*) '\multicolumn{3}{c}{'      
      write(201,*)" by Duration of "      
      write(201,*) 'Joint Unemployment Spell} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Duration} &'
      write(201,*) '\multicolumn{2}{c}{Accepted'
      write(201,*) 'Wage} \\ '
      write(201,*) '\cline{2-3}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{1}{c}{Husband} & ' 
      write(201,*) '\multicolumn{1}{c}{Wife} \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  \\'      
      do i=2,thazt
          write(201,5532) i,(int(wtdurave(i,5,6,m,1)),m=1,2) 
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         
          
!********************Average wages end
      itable=itable+1      
      
6528  continue      
!5528  format(1x,i2,9(1x,'&',1x,i6),' \\')                 
5528  format(1x,i2,16(1x,'&',1x,i6),' \\')                       
7528  format(1x,i2,6(1x,'&',1x,i6),' \\')           



************************************
*     Table Proportion of individual hazard entrance
*************************************
	xlabel(0)= 'Censored spell'
      xlabel(1)= 'Unemployed'
	xlabel(2)= 'Employed'
	xlabel(3)= 'Total'
      m=1      
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrr}'
      write(201,*) '\multicolumn{3}{c}{Table H',itable,xac,'. '
      write(201,*)" Unemployment Rate } \\ "
      write(201,*) '\multicolumn{3}{c}{'
      write(201,*) 'of the Spouse at '
      write(201,*)  "Employment Status} \\ "
      write(201,*) "\multicolumn{3}{c}{Entry and Exit}"
      write(201,*) '\\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Employment} &'
      write(201,*) '\multicolumn{2}{c}{Status'
      write(201,*) 'Status Spell} \\ '
      write(201,*) '\cline{2-3}'      
      write(201,*) '\multicolumn{1}{c}{at} &'
      write(201,*) '\multicolumn{1}{c}{Unemployed} & ' 
      write(201,*) '\multicolumn{1}{c}{Employed} \\ '
      write(201,*) '\hline\hline'
      write(201,*) 'Entry &  &    \\'       
      
      do m=1,2
	write(201,5530) xgender(m), (100*exhazi0(k,1,1,6,m),k=1,2)  
      enddo
      write(201,*) 'Exit &  &    \\'             
      do m=1,2
	write(201,5530) xgender(m), (100*exhazi0(k,1,2,6,m),k=1,2)  
      enddo
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "            
      write(201,*) '\bigskip'
      write(201,*) "  "                   

5530  format(1x,a30,2(1x,'&',1x,f10.2),' \\')        
      
      itable=itable+1      
      
      
!***** Individual Hazard by transition  ********************************************** xxxxxx     
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrrrr}'
      write(201,*)'\multicolumn{5}{c}{Table H',itable,xac,'. Individual'
      write(201,*) "Hazard by Spouse's Employment Status"
      write(201,*) 'Spell} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Duration} &'
      write(201,*) '\multicolumn{4}{c}{Employment'
      write(201,*) 'Status} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{2}{c}{Husband} & ' 
      write(201,*) '\multicolumn{2}{c}{Wife} \\ '
      write(201,*) '\multicolumn{1}{c}{} &'      
      write(201,*) '\multicolumn{1}{c}{Unemployed} & ' 
      write(201,*) '\multicolumn{1}{c}{Employed} & '
      write(201,*) '\multicolumn{1}{c}{Unemployed} & ' 
      write(201,*) '\multicolumn{1}{c}{Employed} \\ '
      
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  &  &   \\'      
      do i=2,thazt
          write(201,5529) i,((100*exhazi3(i,j,6,m),j=1,2),m=1,2) 
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         
      itable=itable+1
      
!***************************************************xxxx      

5531  format(1x,i2,2(1x,'&',1x,f10.2),' \\')              
      
!***** Individual Hazard by transition wealth ********************************************** xxxxxx     
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrrrr}'
      write(201,*)'\multicolumn{5}{c}{Table H',itable,xac,'. Individual'
      write(201,*) "Hazard by Spouse's Employment Status"
      write(201,*) 'Spell. Wealth $\le$',int(a1),'} \\ '      
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Duration} &'
      write(201,*) '\multicolumn{4}{c}{Employment'
      write(201,*) 'Status} \\ '
      write(201,*) '\cline{2-5}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{2}{c}{Husband} & ' 
      write(201,*) '\multicolumn{2}{c}{Wife} \\ '
      write(201,*) '\multicolumn{1}{c}{} &'      
      write(201,*) '\multicolumn{1}{c}{Unemployed} & ' 
      write(201,*) '\multicolumn{1}{c}{Employed} & '
      write(201,*) '\multicolumn{1}{c}{Unemployed} & ' 
      write(201,*) '\multicolumn{1}{c}{Employed} \\ '
      
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  &  &   \\'      
      do i=2,thazt
          write(201,5529) i,((100*exhazi3(i,j,1,m),j=1,2),m=1,2) 
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         
      itable=itable+1
      
!***************************************************xxxx      
      
      itable=itable+1
      
!***************************************************xxxx      
      
      
      
!********************Average wages individual
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrr}'
      write(201,*) '\multicolumn{3}{c}{Table H',itable,'. ',xac
      write(201,*) " Individual Accepted Wage} \\"
      write(201,*) '\multicolumn{3}{c}{'      
      write(201,*)" by Duration of "      
      write(201,*) 'Unemployment} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Duration} &'
      write(201,*) '\multicolumn{2}{c}{Accepted'
      write(201,*) 'Wage} \\ '
      write(201,*) '\multicolumn{1}{c}{} &'
      write(201,*) '\multicolumn{2}{c}{',xac,'}  \\ '
      write(201,*) '\cline{2-3}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{1}{c}{Husband} & ' 
      write(201,*) '\multicolumn{1}{c}{Wife} \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  \\'      
      do i=2,thazt
          write(201,5532) i,(int(wtduravin(i,6,m,1)),m=1,2)
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         

5532  format(1x,i2,2(1x,'&',1x,i10),' \\')              
      itable=itable+1      
!********************Average wages individual end      
      
!********************Average wages individual, low wealth
      write(201,*) '{\small '
      write(201,*) '\begin{tabular}{lrr}'
      write(201,*) '\multicolumn{3}{c}{Table H',itable,'. ',xac
      write(201,*) " Individual Accepted Wage} \\"
      write(201,*) '\multicolumn{3}{c}{'      
      write(201,*)" by Duration of "      
      write(201,*) 'Unemployment. Wealth $\le$',int(a1),'} \\ '
      write(201,*) '\hline\hline'
      write(201,*) '\multicolumn{1}{c}{Duration} &'
      write(201,*) '\multicolumn{2}{c}{Accepted'
      write(201,*) 'Wage} \\ '
      write(201,*) '\multicolumn{1}{c}{} &'
      write(201,*) '\multicolumn{2}{c}{',xac,'}  \\ '
      write(201,*) '\cline{2-3}'
      write(201,*) '\multicolumn{1}{c}{Status} &'
      write(201,*) '\multicolumn{1}{c}{Husband} & ' 
      write(201,*) '\multicolumn{1}{c}{Wife} \\ '
      write(201,*) '\hline\hline'
      write(201,*) ' &  &  \\'      
      do i=2,thazt
          write(201,5532) i,(int(wtduravin(i,1,m,1)),m=1,2)
      enddo
      
      write(201,*) '\hline\hline'
      write(201,*) '\end{tabular}%'
      write(201,*) '}'
      write(201,*) "  "                  
      write(201,*) '\bigskip'
      write(201,*) "  "                         

      
      itable=itable+1
!********************Average wages individual end
      
      
      

      
      
      
      
      
      write(201,*) '\end{document}'


************************************
*     Reporting Descriptive stats done
*************************************
      close (201)

      endif  !201!************************************
      
      
2129  format(1x,a20,5(1x,'&',1x,f10.2),' \\') 
2130  format(1x,a20,3(1x,'&',1x,f10.2),' \\')       

 120  format(1x,a20,3(1x,'&',1x,f10.2),' \\')
 121  format(16x,3(1x,'&',1x,f10.2),' \\')

 420  format(1x,a20,3(1x,'&',1x,i10),' \\')
 421  format(16x,3(1x,'&',1x,i10),' \\')

 
 122  format(1x,a20,7(1x,'&',1x,f10.2),' \\')
 123  format(16x,7(1x,'&',1x,f10.2),' \\')

 222  format(1x,a20,7(1x,'&',1x,i11),' \\')
 223  format(16x,7(1x,'&',1x,i11),' \\')

 224  format(1x,a20,6(1x,'&',1x,f10.2),' \\')
 225  format(1x,a20,6(1x,'&',1x,i10),' \\')      
 125  format(16x,6(1x,'&',1x,f10.2),' \\')
3224  format(1x,i2,6(1x,'&',1x,f10.2),' \\')      

 126  format(1x,a20,5(1x,'&',1x,f10.2),' \\')
 127  format(16x,5(1x,'&',1x,f10.2),' \\')
 1126  format(1x,a20,5(1x,'&',1x,f10.2),' \\') 
 226   format(1x,a20,5(1x,'&',1x,i10),' \\')
 426  format(1x,a20,4(a1),5(1x,'&',1x,i10),' \\')
 227  format(16x,5(1x,'&',1x,i10),' \\')
 229  format(1x,a20,4(1x,'&',1x,i10),' \\')
 1229  format(1x,a20,5(1x,'&',1x,i10),' \\')      
 329  format(1x,a20,5(1x,'&',1x,i10),' \\')      
 
 128  format(1x,a20,12(1x,'&',1x,f10.2),' \\')
 129  format(16x,12(1x,'&',1x,f10.2),' \\')

 220  format(1x,i3,4(1x,'&',1x,f10.2),8(1x,'&',1x,f10.0),' \\')
 320  format(1x,i3,4(1x,'&',1x,f10.2),8(1x,'&',1x,i10),' \\') 

 228  format(1x,a20,12(1x,'&',1x,a10),' \\')


 130  format(1x,a20,13(1x,'&',1x,f10.2),' \\')
 132  format(1x,a20,13(1x,'&',1x,f10.2),' \\')
 230  format(1x,a20,13(1x,'&',1x,a10),' \\')

 322  format((1x,a20),'part:',2(1x,a15),7(1x,'&',1x,f10.2),' \\')
 323  format(16x,7(1x,'&',1x,f10.2),' \\')
      
720   format(1x,20(1x,f14.10))
 724  format(1x,20(1x,f20.2))
723   format(1x,i4,4(1x,f14.10),8(1x,f20.2))
725   format(1x,i4,1x,a80,5(1x,f44.20))      
823   format(1x,i4,4(1x,f20.2),8(1x,f20.2))    
      
717       format(1x,16(f7.4,1x))      
718       format(1x,i1,1x,i2,1x,4(i1,1x,4(i3,1x)))
719   format(1x,i2,1x,16(f7.4,1x))
7119       format(1x,i2,1x,16(i6,1x))      
721       format(4(1x,i2,1x,4(f7.4,1x)))
722   format(4(1x,i2,1x,3(f7.4,1x)))          
7123  format(1x,i2,1x,5(f7.4,1x))      
