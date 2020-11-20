      subroutine des_fit(ichimo,iproba,nmoment,thazt,
     * xmoment,xmoments,xmomentv,xlmoment,filetexa)      
	implicit none
	intrinsic max,min,abs,int      
      integer nmobs,inu,ix,i,j,k,l,m,na,nw,nmoment,maxmom,
     * ll,thazt,ibrap,n,ii
	integer ifecha(8)      
	parameter (maxmom=20000,nmobs=48)
      character*100 xtitlef(30)      
	character*25 xlabel(0:37),xlabelj(0:37),xlabelk(0:47)      
      character*80 xlmoment(maxmom)      
      double precision xmoment(maxmom),xmomentv(maxmom,2)      
      double precision xmoments(maxmom)
!      integer ixmoment(maxmom),ixmomentv(maxmom,2)      
!      integer ixmoments(maxmom)
      integer ichimo(maxmom),iproba(maxmom)
	character*30 filetexa      
	real*8	xdef,xtolu,bet,r,mtot,xrbet
	common /params/ xdef,xtolu,bet,r,mtot
	real*8  sig,bmin(2),xlu(2),xle(2),xlo(2),xt(2),xm(2)
     *        ,std(2),slei(3),spar,slow,shigh,a0,splow,sphigh
	common /pars/ sig,bmin,xlu,xle,xlo,xt,xm,std,
     *        slei,spar,slow,shigh,a0,splow,sphigh
	integer iyear,imonth,iday,ihour,iminute,isecond,ihund      
!     True      
	real*8 xenum(0:2,0:2),xewag(0:2,0:2,2,2),xeass(0:2,0:2,3),
     *    xwnum(0:6,0:6),xeasst(0:2,0:2,nmobs,3),xenumt(0:2,0:2,nmobs),
     *    xewagt(0:2,0:2,nmobs,2,2),
     *  xwass(0:6,0:6,3),xass(6,11),xetnum(5,5),xetnumr(5,5),
     * xetnumc(5,2,2),
     * xetnumqp(5,5,-1:2,-1:2,-1:2,-1:2),xetnuqp(5,10,2,2),
     *      xetwag(5,5,2,2),xetwagqp(5,5,-1:2,-1:2,-1:2,-1:2,2,2),      
     * xwptnum(0:6,0:6,2),xetass(5,5,3),xwnub(0:6,2,2),rs,xassdbn(6,11),
     * xassdbnp(6,11),
     * xassdbnu(6,4),xassdbnpu(6,4),
     * exhaz(nmobs,4,6),
     * exhaz2(nmobs,4,6),exhaz3(nmobs,4,6),exhaz0(4,4,2), 
     * exhazi(nmobs,2,6,2),exhazi2(nmobs,2,6,2),
     * exhazi0(2,2,2,6,2),exhazi3(nmobs,2,6,2),
     * wtdurave(nmobs,5,6,2,3),  
     * wtduravin(nmobs,6,2,3)
!     Simulated      
	real*8 xenums(0:2,0:2),xewags(0:2,0:2,2,2),xeasss(0:2,0:2,3),
     *    xwnums(0:6,0:6),
     * xwasss(0:6,0:6,3),xasss(6,11),xetnums(5,5),xetnumrs(5,5),
     * xetnumcs(5,2,2),      
     *      xetwags(5,5,2,2),
     * xetwagqps(5,5,-1:2,-1:2,-1:2,-1:2,2,2),      
     * xwptnums(0:6,0:6,2),xetasss(5,5,3),xwnubs(0:6,2,2),
     * xassdbns(6,11), 
     * xassdbnps(6,11),xassdbnus(6,4),xassdbnpus(6,4),
     *xetnumqps(5,5,-1:2,-1:2,-1:2,-1:2),xetnuqps(5,10,2,2),
     *    xeassts(0:2,0:2,nmobs,3),xenumts(0:2,0:2,nmobs),
     *    xewagts(0:2,0:2,nmobs,2,2),xarris(2,6),
     * exhazs(nmobs,4,6),
     * exhaz2s(nmobs,4,6),exhaz3s(nmobs,4,6),exhaz0s(4,4,2), 
     * exhazis(nmobs,2,6,2),exhazi2s(nmobs,2,6,2),
     * exhazi0s(2,2,2,6,2),exhazi3s(nmobs,2,6,2),
     * wtduraves(nmobs,5,6,2,3),  
     * wtduravins(nmobs,6,2,3)
      real*8  a1,a2,a3,a4,a5
      real*8  w1,w2,w3,w4,w5
	real*8  amn,amx,wmx,wmn,umx,umn
	real*8  grida,gridu
	common /bounds/ umn,umx,wmn,wmx,amn,amx,gridu
	integer kp,jp,kq,jq,llfin
      real*8 xptypes(4),xm_types(2,2),slei_types(2,2)
	common /types/ xm_types,slei_types,xptypes
      integer types,indi_type(4,4),ntypes,ltypes
      common /itypes/ indi_type,ntypes,ltypes
	real*8 xwdi(3),xwdis(3)
      
      grida=(amx-amn)/na
      gridu=(umx-umn)/nw
      
!*************************
!     Bounds
!*************************           
      include 'thresholds.f'      
      
      
!************************************
!     Moments
!************************************      
      include 'momentable.f'            
      include 'momentables.f'            
      
!************************************
!     Moments were transferred to tables
!************************************
      call date_and_time(values=ifecha)      
      
	open (401,file=filetexa)   !TeX
      
      
      

      write(401,*) '\documentclass[12pt]{article}'
      write(401,*) '\setlength{\textwidth}{6in}'
      write(401,*) '\setlength{\textheight}{8.5in}'
      write(401,*) '\setlength{\topmargin}{0.25in}'
      write(401,*) '\setlength{\oddsidemargin}{0.25in}'
      write(401,*) '\setlength{\footskip}{0.4in}'
      write(401,*) '\setlength{\headheight}{0.0in}'
      write(401,*) '\setlength{\headsep}{0.5in}'
!      write(401,*) '\input tcilatex'

      write(401,*) ''
      write(401,*) '\begin{document}'
      write(401,*) '\renewcommand{\baselinestretch}{1}'
	write(401,*) '\pagestyle{myheadings}'
	write(401,*) '\markright{Family Job Search and Wealth. '
	write(401,*) "Garc\'{\i}a-P\'erez and Rendon. "
      write(401,"(i4,'/',i2,'/',i2,' ',i4,':',i2,' ',i2,'.',i3)") 
     * ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8)
	write(401,*) " }"      
      write(401,*) '\small '
      write(401,*) ''
      write(401,*) '{\Large Actual and Predicted}'
      write(401,*) ''
      write(401,*) '\bigskip' 
      write(401,*) ''
      

!************************************
!     Parameter values 
!************************************
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'           
      write(401,*) '\begin{tabular}{ccc}'
      write(401,*) '\hline \hline'      
      write(401,*) '\multicolumn{3}{c}{Parameter values} \\ '
      write(401,*) '\multicolumn{3}{c}{Baseline Parameters} \\ '
      write(401,*) '\hline \hline'
      write(401,"(1x,a40,f10.4,1x,a4)")
     *  '$\beta $ & \multicolumn{2}{c}{',bet,'}\\'
      write(401,"(1x,a40,f10.4,1x,a4)")
     *  '$r$ & \multicolumn{2}{c}{',r,'}\\'
      write(401,"(1x,a40,f10.4,1x,a4)")
     *  '$\gamma $ & \multicolumn{2}{c}{',sig,'}\\'
      write(401,"(1x,a40,f10.4,1x,a4)")
     *  '$s$ & \multicolumn{2}{c}{',spar,'}\\'
      write(401,"(1x,a40,f10.4,1x,a4)")
     *  '$\vartheta_3$ & \multicolumn{2}{c}{',slei(3),'}\\'
      write(401,*) '& husband & wife \\ \hline'
    
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$b$ &',bmin(1),'&',bmin(2),'\\'
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$\lambda$ &',xlu(1),'&',xlu(2),
     *  '\\'
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$\pi$ &',xlo(1),'&',xlo(2),'\\'
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$\theta $ &',xt(1),'&',xt(2),'\\'
      
      
!      do types=ltypes,ntypes
!	write(401,"(a20,2(i1,1x),a5,2(1x,f10.4,1x,a4))")'
!     * $\mu_{',indi_type(1,types),indi_type(2,types),'} $ &',
!     * xm_types(1,indi_type(1,types)),'&',
!     * xm_types(2,indi_type(2,types)),'\\'      
!      enddo      
       if(ntypes.eq.ltypes)then
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$\mu$ &',xm(1),'&',xm(2),'\\'
      endif
      
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$\sigma$ &',std(1),'&',std(2),'\\'
       if(ntypes.eq.ltypes)then
	write(401,"(a20,2(1x,f10.4,1x,a4))")'$\vartheta$ &',slei(1),'&',
     * slei(2),'\\'      
      endif
      
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'                  
      write(401,*) '}'
      write(401,*) ' ' 
!      write(401,*) '\vspace{1.5cm}'
      write(401,*) '\bigskip'       
      write(401,*) ' ' 

      if(ntypes.gt.ltypes)then
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'           
      write(401,*) '\begin{tabular}{rrrrrrrrr}'
      write(401,*) '\multicolumn{9}{c}{Parameters by Type} \\ '      
      write(401,*) '\hline \hline'      
      write(401,*) '\multicolumn{3}{c}{Types} & &'
      write(401,*) '\multicolumn{5}{c}{Parameter values} \\ '
      write(401,*) 'Type & Husband & Wife & & $\mu_1$ & $\mu_2$ 
     *  &    $\vartheta_1$ & $\vartheta_2$ & $\Pr$(Type) \\ '      
      write(401,*) '\hline \hline'
      
      do types=ltypes,ntypes

      write(401,"(3(i4,' & '),5(' & ',f15.4),' \\')") types,
     *   10*indi_type(1,types)+indi_type(3,types),
     *   10*indi_type(2,types)+indi_type(4,types),
     *  xm_types(1,indi_type(1,types)),xm_types(2,indi_type(2,types)),
     *slei_types(1,indi_type(3,types)),slei_types(2,indi_type(4,types)),
     * xptypes(types)
      enddo
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'                  
      write(401,*) '}'
      write(401,*) ' ' 
!      write(401,*) '\vspace{1.5cm}'
      write(401,*) '\bigskip'       
      write(401,*) ' ' 
      endif
      
      
!************************************
!     Exercises 1
!************************************
!      write(401,*) ix,inu,fin,401
          
      

!******************************************************************************
!     Table 1 paper
!******************************************************************************      
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'      
      write(401,*) '\begin{tabular}{lrrrrr}'
      write(401,*) '\multicolumn{6}{c}{Table 1. Employment,'
      write(401,*) ' Wages, and Wealth by Household'
      write(401,*) 'Employment Status} \\ \hline\hline'
      write(401,*) '& \multicolumn{5}{c}{Spouse} \\'
      write(401,*) '   \cline{2-6}'
      write(401,*) '& \multicolumn{2}{c}{Actual} & '
      write(401,*) '  & \multicolumn{2}{c}{Predicted} \\ '
      write(401,*) '\cline{2-6}'
      write(401,*) 'Variable & Unemployed & Employed &'
      write(401,*) '    & Unemployed & Employed \\ \hline\hline'

      xlabel(0)= '\ \ \ Unemployed'
	xlabel(1)= '\ \ \ Employed'
      
      write(401,*) 'Joint Employment Status &  &  &  &  &  \\ '
      write(401,*) 'Husband &  &  &  &  &  \\ '
	do j=0,1	
	write(401,1920)xlabel(j),
     *      (100*xenum(j,k),k=0,1),
     *      (100*xenums(j,k),k=0,1)      
	enddo

	xwdi=0.d0
	xwdis=0.d0
	do j=1,5
	do k=1,5
	if(j.eq.k)then
	xwdi(1)=xwdi(1)+xwnum(j,k)
	xwdis(1)=xwdis(1)+xwnums(j,k)	
	elseif(j.gt.k)then
	xwdi(2)=xwdi(2)+xwnum(j,k)
	xwdis(2)=xwdis(2)+xwnums(j,k)
	elseif(j.lt.k)then
	xwdi(3)=xwdi(3)+xwnum(j,k)
	xwdis(3)=xwdis(3)+xwnums(j,k)
	endif
	enddo
	enddo
	xwdi=100*xwdi/xenum(1,1)
	xwdis=100*xwdis/xenums(1,1)

        write(401,*) 'Wages &  &  &  &  &  \\ '
	
	write(401,1921)"Same for both", xwdi(1),xwdis(1)
	write(401,1921)"Husband is higher", xwdi(2),xwdis(2)
	write(401,1921)"Wife is higher", xwdi(3),xwdis(3)
 1921  format(1x,a20,2(1x,'&'),1x,f10.2,'&',2(1x,'&'),1x,f10.2,'\\')



     
      write(401,*) 'Unemployment Rate &  &  &  &  &  \\ '
      j=0
	write(401,1920) '\ \ \ Husband',
     * (100.d0*xenum(j,k)/xenum(2,k),k=0,1),
     * (100.d0*xenums(j,k)/xenums(2,k),k=0,1)      
      
	k=0	
	write(401,1920) '\ \ \ Wife', 
     * (100.d0*xenum(j,k)/xenum(j,2),j=0,1),
     * (100.d0*xenums(j,k)/xenums(j,2),j=0,1)
      
      
      
 1920  format(1x,a20,2(1x,'&',1x,f10.2),'&',2(1x,'&',1x,f10.2),'\\')
      
      write(401,*) 'Wages &  &  &  &  &  \\ '
	j=1
	write(401,1422) '\ \ \ Husband',
     *      (int(xewag(j,k,1,1)),k=0,1),
     *      (int(xewags(j,k,1,1)),k=0,1)     
	write(401,1423) 
     *      (int(xewag(j,k,1,2)),k=0,1),
     *      (int(xewags(j,k,1,2)),k=0,1)     
      k=1
	write(401,1422) '\ \ \ Wife', 
     *       (int(xewag(j,k,2,1)),j=0,1),
     *       (int(xewags(j,k,2,1)),j=0,1)      
	write(401,1423) 
     *       (int(xewag(j,k,2,2)),j=0,1),
     *       (int(xewags(j,k,2,2)),j=0,1)      

      
 1422  format(1x,a20,2(1x,'&',1x,i10),'&',2(1x,'&',1x,i10),'\\')
 1423  format(16x,2(1x,'& (',i10,')'),'&',2(1x,'& (',i10,')'),'\\')

      write(401,*) 'Wealth if Husband &  &  &  &  &  \\ '
	do j=0,1	
	write(401,1422) xlabel(j),
     *  (int(xeass(j,k,1)),k=0,1),
     *  (int(xeasss(j,k,1)),k=0,1)     
	write(401,1423) 
     *  (int(xeass(j,k,2)),k=0,1),
     *  (int(xeasss(j,k,2)),k=0,1)      
      enddo
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'            
      write(401,*) '}'
      write(401,*) ' ' 
      write(401,*) '\vspace{1.5cm}'
      write(401,*) ' ' 
      
!******************************************************************************
!     Table 1 paper \end
!******************************************************************************      

!******************************************************************************
!     Table 2 paper
!******************************************************************************      
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'      
      write(401,*) '\begin{tabular}{lrrrrrrrr}'
      write(401,*) "\multicolumn{9}{c}{Table 2. Unemployment Rate and
     *      Average Wage by Spouse's"
      write(401,*) 'Wage Segment} \\ \hline\hline'
      write(401,*) '& \multicolumn{4}{c}{Unemployment Rate (\%)}
     *      & \multicolumn{4}{c}{Average'
      write(401,*) 'Wage (\$)} \\ '
      write(401,*) '& \multicolumn{2}{c}{Husband} &' 
      write(401,*) '\multicolumn{2}{c}{Wife} &' 
      write(401,*) '\multicolumn{2}{c}{Husband} &'
      write(401,*) ' \multicolumn{2}{c}{Wife} \\'
      
      write(401,*) 'Spouse is &'
      write(401,*) '\multicolumn{1}{c}{Actual} &'
      write(401,*) '\multicolumn{1}{c}{Predicted} &' 
      write(401,*) '\multicolumn{1}{c}{Actual} &'
      write(401,*) '\multicolumn{1}{c}{Predicted} &'
      write(401,*) '\multicolumn{1}{c}{Actual} &'
      write(401,*) '\multicolumn{1}{c}{Predicted} &'
      write(401,*) '\multicolumn{1}{c}{Actual} &'
      write(401,*) '\multicolumn{1}{r}{Predicted} \\ '

      write(401,*) '\hline\hline'
      write(401,*) '  & & & & & & & & \\'

	xlabel(0)= 'Unemployed'
!      write(xlabel(1),'(a7,i5,a2,i5,a1)' ) 
      write(xlabel(1),416),int(wmn),int(w1)
      write(xlabel(2),416),int(w1),int(w2)
      write(xlabel(3),416),int(w2),int(w3)
      write(xlabel(4),416),int(w3),int(w4)
      write(xlabel(5),416),int(w4),int(wmx)      
	xlabel(6)= 'Total'
416   format("\lbrack",i5,", ",i5,")")         
      k=0
	do j=0,5	
	write(401,406)xlabel(j),
     * '& ', 100*xwnum(k,j)/xwnum(6,j),
     * '& ', 100*xwnums(k,j)/xwnums(6,j),
     * '& ', 100*xwnum(j,k)/xwnum(j,6),
     * '& ', 100*xwnums(j,k)/xwnums(j,6),
     * '& ', int(xwnub(j,1,2)+0.5),
     * '& ', int(xwnubs(j,1,2)+0.5),      
     * '& ', int(xwnub(j,2,2)+0.5),
     * '& ', int(xwnubs(j,2,2)+0.5),      
     * '\\'
      enddo   
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'            
      write(401,*) '}'
      write(401,*) ' ' 
      write(401,*) '\vspace{1.5cm}'
      write(401,*) ' ' 
      
406   format(a20,4(a3,f5.2),4(a3,i5),a2)
!******************************************************************************
!     Table 2 paper \end
!******************************************************************************      

!******************************************************************************
!     Table 3 paper 
!******************************************************************************      
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'      
      write(401,*) '\begin{tabular}{lrrrrrrlrrrrr}'
      write(401,*) '\multicolumn{13}{c}{Table 3. Household Employment
     *      Transitions, as a'
      write(401,*) 'Percentage of All Transitions} \\ \hline\hline'
      write(401,*) '& \multicolumn{5}{c}{Actual} &  & 
     *          & \multicolumn{5}{c}{Predicted} \\ '
      write(401,*) '\cline{2-5}\cline{9-12}'
      write(401,*) '\multicolumn{1}{c}{$t$} & '      
      write(401,*) '\multicolumn{1}{c}{uu} & '
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} & '
      write(401,*) '\multicolumn{1}{c}{Total} & & '
      write(401,*) '\multicolumn{1}{c}{$t$} & '            
      write(401,*) '\multicolumn{1}{c}{uu} & '
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} & '
      write(401,*) '\multicolumn{1}{c}{Total} \\'           
      write(401,*) '\hline\hline'
      write(401,*) '$t-1$} &  & & & &  &  & $t-1$'
      write(401,*) '&  &  &  &  &  \\ '
	xlabel(1)= 'uu'
	xlabel(2)= 'ue'
	xlabel(3)= 'eu'
	xlabel(4)= 'ee'
	xlabel(5)= 'Total'
	do k=1,5	
	write(401,526)xlabel(k), (100*xetnum(j,k),j=1,5),
     *    xlabel(k), (100*xetnums(j,k),j=1,5)
	enddo
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}%'
      write(401,*) '}'
      write(401,*) ' ' 
      write(401,*) '\vspace{1.5cm}'
      write(401,*) ' ' 
 526  FORMAT(1x,a20,5(1X,'&',1X,F10.2),'&&',
     * a20,5(1X,'&',1X,F10.2),'\\')
!******************************************************************************
!     Table 3 paper\end
!******************************************************************************      
!******************************************************************************
!     Table 4 paper 
!******************************************************************************      
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'      
      write(401,*) '\begin{tabular}{lrrrrrrlrrrrr}'
      write(401,*) '\multicolumn{13}{c}{Table 4. Household Employment
     *      Transitions, Conditional'
      write(401,*) 'on Current Household Employment Status} \\
     *      \hline\hline'
      write(401,*) '& \multicolumn{5}{c}{Actual} &  & 
     *          & \multicolumn{5}{c}{Predicted} \\ '
      write(401,*) '\cline{2-5}\cline{9-12}'
      write(401,*) '\multicolumn{1}{c}{$t$} & '      
      write(401,*) '\multicolumn{1}{c}{uu} & '
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} & '
      write(401,*) '\multicolumn{1}{c}{Total} & & '
      write(401,*) '\multicolumn{1}{c}{$t$} & '            
      write(401,*) '\multicolumn{1}{c}{uu} & '
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} & '
      write(401,*) '\multicolumn{1}{c}{Total} \\'           
      write(401,*) '\hline\hline'
      write(401,*) '$t-1$} &  & & & &  &  & $t-1$'
      write(401,*) '&  &  &  &  &  \\ '
	do k=1,5	
	write(401,526)xlabel(k), (100*xetnumr(j,k),j=1,5),
     *   xlabel(k),  (100*xetnumrs(j,k),j=1,5)
	enddo
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'            
      write(401,*) '}'
      write(401,*) ' ' 
      write(401,*) '\vspace{1.5cm}'
      write(401,*) ' ' 
!******************************************************************************
!     Table 4 paper \end
!******************************************************************************      
!******************************************************************************
!     Table 5 paper
!******************************************************************************      
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'            
      write(401,*) '\begin{tabular}{lrrrrrcrrrrr}'
      write(401,*) '\multicolumn{12}{c}{Table 5.' 
      write(401,*) 'Employment Transitions, Wage, and Wealth'
      write(401,*) 'Variations by} \\ '
      write(401,*) "\multicolumn{12}{c}{Spouse's Employment"
      write(401,*) 'Transitions (standard deviations in'
      write(401,*) 'smaller fonts)} \\ \hline\hline'
      write(401,*) 'Transition &'
      write(401,*) '\multicolumn{5}{c}{Actual} &  &'
      write(401,*) '\multicolumn{5}{c}{Predicted} \\'
      write(401,*) '\cline{2-6}\cline{8-12}'
      write(401,*) ' & Total &'
      write(401,*) "\multicolumn{4}{c}{By Spouse's Transitions} &"
      write(401,*) '\multicolumn{1}{r}{} & Total &' 
      write(401,*) "\multicolumn{4}{c}{By Spouse's Transitions}"
      write(401,*) '\\ \cline{3-6}\cline{9-12}'
      write(401,*) '& & u$\rightarrow $u & u$\rightarrow $e & e$%'
      write(401,*) '\rightarrow $u & e$\rightarrow $e &'
      write(401,*) '\multicolumn{1}{r}{} &  & u$\rightarrow $%'
      write(401,*) 'u & u$\rightarrow $e & e$\rightarrow $u &'
      write(401,*) 'e$\rightarrow $e \\ \hline\hline'
      write(401,*) '\multicolumn{4}{l}{Employment Transitions (\%)}'
      write(401,*) '&  &  &  &  &  &  &  &  \\ '

	write(401,4126) "\ \ \ Husband: u$\rightarrow $e", 
     *  100*(xetnum(3,1)+xetnum(3,2)+xetnum(4,1)+xetnum(4,2))/
     *      (xetnum(5,1)+xetnum(5,2)),
     *  (100*xetnum(3,j)/(xetnum(3,j)+xetnum(1,j)),
     *  100*xetnum(4,j)/(xetnum(4,j)+xetnum(2,j)), j=1,2),
     *  100*(xetnums(3,1)+xetnums(3,2)+xetnums(4,1)+xetnums(4,2))/
     *      (xetnums(5,1)+xetnums(5,2)),
     *  (100*xetnums(3,j)/(xetnums(3,j)+xetnums(1,j)),
     *  100*xetnums(4,j)/(xetnums(4,j)+xetnums(2,j)), j=1,2)
      
	write(401,4126) "\multicolumn{1}{r}{e$\rightarrow $u} ", 
     *  100*(xetnum(1,3)+xetnum(2,3)+xetnum(1,4)+xetnum(2,4))/
     *      (xetnum(5,3)+xetnum(5,4)),
     *     (100*xetnum(1,j)/(xetnum(3,j)+xetnum(1,j)),
     *      100*xetnum(2,j)/(xetnum(4,j)+xetnum(2,j)), j=3,4),
     *  100*(xetnums(1,3)+xetnums(2,3)+xetnums(1,4)+xetnums(2,4))/
     *      (xetnums(5,3)+xetnums(5,4)),
     *     (100*xetnums(1,j)/(xetnums(3,j)+xetnums(1,j)),
     *      100*xetnums(2,j)/(xetnums(4,j)+xetnums(2,j)), j=3,4)      

	write(401,4126) "\ \ \ Wife:\ \ \ \ \ \ \ u$\rightarrow $e", 
     *  100*(xetnum(2,1)+xetnum(2,3)+xetnum(4,1)+xetnum(4,3))/
     *      (xetnum(5,3)+xetnum(5,2)),
     *      (100*xetnum(2,j)/(xetnum(2,j)+xetnum(1,j)),
     *      100*xetnum(4,j)/(xetnum(4,j)+xetnum(3,j)), j=1,3,2),
     *  100*(xetnums(2,1)+xetnums(2,3)+xetnums(4,1)+xetnums(4,3))/
     *      (xetnums(5,3)+xetnums(5,2)),
     *      (100*xetnums(2,j)/(xetnum(2,j)+xetnums(1,j)),
     *      100*xetnums(4,j)/(xetnum(4,j)+xetnums(3,j)), j=1,3,2) 

      
	write(401,4126) "\multicolumn{1}{r}{e$\rightarrow $u}", 
     *  100*(xetnum(1,2)+xetnum(1,4)+xetnum(3,2)+xetnum(3,4))/
     *      (xetnum(5,2)+xetnum(5,4)),
     *      (100*xetnum(1,j)/(xetnum(2,j)+xetnum(1,j)),
     *      100*xetnum(3,j)/(xetnum(4,j)+xetnum(3,j)), j=2,4,2),
     *  100*(xetnums(1,2)+xetnums(1,4)+xetnums(3,2)+xetnums(3,4))/
     *      (xetnums(5,2)+xetnums(5,4)),
     *      (100*xetnums(1,j)/(xetnums(2,j)+xetnums(1,j)),
     *      100*xetnums(3,j)/(xetnums(4,j)+xetnums(3,j)), j=2,4,2)
      write(401,*) '&  &  &  &  &  & '
      write(401,*) ' &  &  &  &  &  \\ '
      

      write(401,*) '\multicolumn{4}{l}{Job-to-Job in Employment'
      write(401,*) ' Transitions}  &  &  & '
      write(401,*) ' &  &  &  &  &  \\' 
      
	write(401,4126) "\ \ \ Husband: e$\rightarrow $e", 
     *  100*xetnuqp(5,1,1,1),(100*xetnuqp(j,1,1,1),j=1,4),
     *  100*xetnuqps(5,1,1,1),(100*xetnuqps(j,1,1,1),j=1,4)
      
      
	write(401,4126) "\ \ \ Wife:\ \ \ \ \ \ \ e$\rightarrow $e", 
     *  100*xetnuqp(5,1,1,2),(100*xetnuqp(j,1,1,2),j=1,4),
     *  100*xetnuqps(5,1,1,2),(100*xetnuqps(j,1,1,2),j=1,4)      
      
      write(401,*) '\multicolumn{4}{l}{Quits in Employment'
      write(401,*) ' Transitions}  &  &  & '
      write(401,*) ' &  &  &  &  &  \\' 

	write(401,4128) "\ \ \ Husband: e$\rightarrow $u", 
     *  100*xetnuqp(5,1,2,1),100*xetnuqp(4,1,2,1),
     *  100*xetnuqps(5,1,2,1),100*xetnuqps(4,1,2,1)      
	write(401,4128) "\ \ \ Wife:\ \ \ \ \ \ \ e$\rightarrow $u", 
     *  100*xetnuqp(5,1,2,2),100*xetnuqp(4,1,2,2),
     *  100*xetnuqps(5,1,2,2),100*xetnuqps(4,1,2,2)            
      write(401,*) '&  &  &  &  &  & '
      write(401,*) ' &  &  &  &  &  \\ '
      
      
      write(401,*) '\multicolumn{4}{l}{Wage variations in'
      write(401,*) 'e$\rightarrow $e (\$)} &  &  & '
      write(401,*) ' &  &  &  &  &  \\' 
      
      
	write(401,4229) "\ \ \ Husband", 
     * int((xetwag(3,3,1,1)*xetnum(3,3)
     *     +xetwag(3,4,1,1)*xetnum(3,4)
     *     +xetwag(4,3,1,1)*xetnum(4,3)
     *     +xetwag(4,4,1,1)*xetnum(4,4))/      
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))),
     *       int(xetwag(3,3,1,1)),int(xetwag(4,3,1,1)),
     *    int(xetwag(3,4,1,1)),int(xetwag(4,4,1,1)),
     * int((xetwags(3,3,1,1)*xetnums(3,3)
     *     +xetwags(3,4,1,1)*xetnums(3,4)
     *     +xetwags(4,3,1,1)*xetnums(4,3)
     *     +xetwags(4,4,1,1)*xetnums(4,4))/      
     *  (xetnums(3,3)+xetnums(3,4)+xetnums(4,3)+xetnums(4,4))),
     *       int(xetwags(3,3,1,1)),int(xetwags(4,3,1,1)),
     *    int(xetwags(3,4,1,1)),int(xetwags(4,4,1,1))

      
	write(401,4230) " ", 
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
     *                      int(xetwag(3,4,1,2)),int(xetwag(4,4,1,2)),
     * int(sqrt( 
     * (xetwags(3,3,1,2)*xetnums(3,3)*xetwags(3,3,1,2)*xetnums(3,3)
     * +xetwags(3,4,1,2)*xetnums(3,4)*xetwags(3,4,1,2)*xetnums(3,4)
     * +xetwags(4,3,1,2)*xetnums(4,3)*xetwags(4,3,1,2)*xetnums(4,3)
     * +xetwags(4,4,1,2)*xetnums(4,4)*xetwags(4,3,1,2)*xetnums(4,3)
     *      )/ (     
     *  (xetnums(3,3)+xetnums(3,4)+xetnums(4,3)+xetnums(4,4))*
     *  (xetnums(3,3)+xetnums(3,4)+xetnums(4,3)+xetnums(4,4))   )   
     *      )),
     *      int(xetwags(3,3,1,2)),int(xetwags(4,3,1,2)),
     *                      int(xetwags(3,4,1,2)),int(xetwags(4,4,1,2))
      
	write(401,4229) "\ \ \ Wife", 
     * int((xetwag(2,2,1,1)*xetnum(2,2)
     *     +xetwag(2,4,1,1)*xetnum(2,4)
     *     +xetwag(4,2,1,1)*xetnum(4,2)
     *     +xetwag(4,4,1,1)*xetnum(4,4))/      
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))),
     *      int(xetwag(2,2,2,1)),int(xetwag(4,2,2,1)),
     *        int(xetwag(2,4,2,1)),int(xetwag(4,4,2,1)),
     * int((xetwags(2,2,1,1)*xetnums(2,2)
     *     +xetwags(2,4,1,1)*xetnums(2,4)
     *     +xetwags(4,2,1,1)*xetnums(4,2)
     *     +xetwags(4,4,1,1)*xetnums(4,4))/      
     *  (xetnums(2,2)+xetnums(2,4)+xetnums(4,2)+xetnums(4,4))),
     *      int(xetwags(2,2,2,1)),int(xetwags(4,2,2,1)),
     *          int(xetwags(2,4,2,1)),int(xetwags(4,4,2,1))      
	write(401,4230) " ", 
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
     *           int(xetwag(2,4,2,2)),int(xetwag(4,4,2,2)),
     * int(sqrt( 
     * (xetwags(2,2,1,2)*xetnums(2,2)*xetwags(2,2,1,2)*xetnums(2,2)
     * +xetwags(2,4,1,2)*xetnums(2,4)*xetwags(2,4,1,2)*xetnums(2,4)
     * +xetwags(4,2,1,2)*xetnums(4,2)*xetwags(4,2,1,2)*xetnums(4,2)
     * +xetwags(4,4,1,2)*xetnums(4,4)*xetwags(4,4,1,2)*xetnums(4,4)
     *      )/ (     
     *  (xetnums(2,2)+xetnums(2,4)+xetnums(4,2)+xetnums(4,4))*
     *  (xetnums(2,2)+xetnums(2,4)+xetnums(4,2)+xetnums(4,4))   )   
     *      )),
     *      int(xetwags(2,2,2,2)),int(xetwags(4,2,2,2)),
     *      int(xetwags(2,4,2,2)),int(xetwags(4,4,2,2))

      write(401,*) '\multicolumn{4}{l}{Wealth variations'
      write(401,*) 'in e$\rightarrow $e (\$)} &  &  &' 
      write(401,*) ' &  &  &  &  &  \\' 
	write(401,4229) "\ \ \ Husband", 
     * int((xetass(3,3,1)*xetnum(3,3)
     *     +xetass(3,4,1)*xetnum(3,4)
     *     +xetass(4,2,1)*xetnum(4,3)
     *     +xetass(4,3,1)*xetnum(4,4))/      
     *  (xetnum(3,3)+xetnum(3,4)+xetnum(4,3)+xetnum(4,4))),
     *  int(xetass(3,3,1)),int(xetass(4,3,1)),
     *                      int(xetass(3,4,1)),int(xetass(4,4,1)),
     * int((xetasss(3,3,1)*xetnums(3,3)
     *     +xetasss(3,4,1)*xetnums(3,4)
     *     +xetasss(4,2,1)*xetnums(4,3)
     *     +xetasss(4,3,1)*xetnums(4,4))/      
     *  (xetnums(3,3)+xetnums(3,4)+xetnums(4,3)+xetnums(4,4))),
     *  int(xetasss(3,3,1)),int(xetasss(4,3,1)),
     *                      int(xetasss(3,4,1)),int(xetasss(4,4,1))

      
	write(401,4230) " ", 
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
     *                      int(xetass(3,4,2)),int(xetass(4,4,2)),
     * int(sqrt( 
     * (xetasss(3,3,2)*xetnums(3,3)*xetasss(3,3,2)*xetnums(3,3)
     * +xetasss(3,4,2)*xetnums(3,4)*xetasss(3,4,2)*xetnums(3,4)
     * +xetasss(4,3,2)*xetnums(4,3)*xetasss(4,3,2)*xetnums(4,3)
     * +xetasss(4,4,2)*xetnums(4,4)+xetasss(4,4,2)*xetnums(4,4)
     *      )/ (     
     *  (xetnums(3,3)+xetnums(3,4)+xetnums(4,3)+xetnums(4,4))*
     *  (xetnums(3,3)+xetnums(3,4)+xetnums(4,3)+xetnums(4,4))   )   
     *      )),
     *   int(xetasss(3,3,2)),int(xetasss(4,3,2)),
     *                      int(xetasss(3,4,2)),int(xetasss(4,4,2))

	write(401,4229) "\ \ \ Wife", 
     * int((xetass(2,2,1)*xetnum(2,2)
     *     +xetass(2,4,1)*xetnum(2,4)
     *     +xetass(4,2,1)*xetnum(4,2)
     *     +xetass(4,4,1)*xetnum(4,4))/      
     *  (xetnum(2,2)+xetnum(2,4)+xetnum(4,2)+xetnum(4,4))),
     *      int(xetass(2,2,1)),int(xetass(4,2,1)),
     *                      int(xetass(2,4,1)),int(xetass(4,4,1)),
     * int((xetasss(2,2,1)*xetnums(2,2)
     *     +xetasss(2,4,1)*xetnums(2,4)
     *     +xetasss(4,2,1)*xetnums(4,2)
     *     +xetasss(4,4,1)*xetnums(4,4))/      
     *  (xetnums(2,2)+xetnums(2,4)+xetnums(4,2)+xetnums(4,4))),
     *      int(xetasss(2,2,1)),int(xetasss(4,2,1)),
     *                      int(xetasss(2,4,1)),int(xetasss(4,4,1))      
      write(401,4230) " ", 
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
     *                      int(xetass(2,4,2)),int(xetass(4,4,2)),
     * int(sqrt( 
     * (xetasss(2,2,2)*xetnums(2,2)*xetasss(2,2,2)*xetnums(2,2)
     * +xetasss(2,4,2)*xetnums(2,4)*xetasss(2,4,2)*xetnums(2,4)
     * +xetasss(4,2,2)*xetnums(4,2)*xetasss(4,2,2)*xetnums(4,2)
     * +xetasss(4,4,2)*xetnums(4,4)*xetasss(4,4,2)*xetnums(4,4)
     *      )/ (     
     *  (xetnums(2,2)+xetnums(2,4)+xetnums(4,2)+xetnums(4,4))*
     *  (xetnums(2,2)+xetnums(2,4)+xetnums(4,2)+xetnums(4,4))   )   
     *      )),
     * int(xetasss(2,2,2)),int(xetasss(4,2,2)),
     *                      int(xetasss(2,4,2)),int(xetasss(4,4,2))


      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'            
      write(401,*) '}'
      write(401,*) ' ' 
      write(401,*) '\vspace{1.5cm}'
      write(401,*) ' ' 
!******************************************************************************
!     Table 5 paper \end
!******************************************************************************      

!******************************************************************************
!     Table 7 paper 
!******************************************************************************      
	xlabel(0)= 'Censored'
	xlabel(1)= 'uu'
	xlabel(2)= 'ue'
	xlabel(3)= 'eu'
	xlabel(4)= 'ee'
	xlabel(5)= 'Total'

      
      write(401,*) '{\small '
      write(401,*) '\begin{center}'         
      write(401,*) '\begin{tabular}{lrrrrrrrr}'
      write(401,*) '\multicolumn{9}{c}{Table 7a. Entry Employment'
      write(401,*) 'Status by Employment Status'
      write(401,*) 'Spell} \\ '
      write(401,*) '\multicolumn{9}{c}{in Percentage'
      write(401,*) '(each column adds up to 100\%)} \\'
      write(401,*) '\hline\hline'
      write(401,*) '\multicolumn{1}{c}{Previous} &'
      write(401,*) '\multicolumn{8}{c}{Employment'
      write(401,*) 'Status Spell} \\ \cline{2-9}'
      write(401,*) '\multicolumn{1}{c}{Employment} &'
      write(401,*) '\multicolumn{4}{c}{Actual} &'
      write(401,*) '\multicolumn{4}{c}{Predicted} \\'
      write(401,*) '\cline{2-9}'
      write(401,*) '\multicolumn{1}{c}{Status} &'
      write(401,*) '\multicolumn{1}{c}{uu} & ' 
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} & '
      write(401,*) '\multicolumn{1}{c}{uu} & ' 
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} \\ '
      write(401,*) '\hline\hline'
      write(401,*) ' &  &  &  &  &  &  &  &  \\'      
      do j=1,4
	write(401,5526) xlabel(j), (100*exhaz0(i,j,1),i=1,4),
     *  (100*exhaz0s(i,j,1),i=1,4)
      enddo
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}%'
      write(401,*) '\end{center}'         
      write(401,*) '}'
      write(401,*) '\bigskip'
      

      write(401,*) '{\small '
      write(401,*) '\begin{center}'         
      write(401,*) '\begin{tabular}{lrrrrrrrr}'
      write(401,*) '\multicolumn{9}{c}{Table 7b. Exit Employment'
      write(401,*) 'Status by Employment Status'
      write(401,*) 'Spell} \\ '
      write(401,*) '\multicolumn{9}{c}{in Percentage'
      write(401,*) '(each column adds up to 100\%)} \\'
      write(401,*) '\hline\hline'
      write(401,*) '\multicolumn{1}{c}{Previous} &'
      write(401,*) '\multicolumn{8}{c}{Employment'
      write(401,*) 'Status Spell} \\ \cline{2-9}'
      write(401,*) '\multicolumn{1}{c}{Employment} &'
      write(401,*) '\multicolumn{4}{c}{Actual} &'
      write(401,*) '\multicolumn{4}{c}{Predicted} \\'
      write(401,*) '\cline{2-9}'
      write(401,*) '\multicolumn{1}{c}{Status} &'
      write(401,*) '\multicolumn{1}{c}{uu} & ' 
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} & '
      write(401,*) '\multicolumn{1}{c}{uu} & ' 
      write(401,*) '\multicolumn{1}{c}{ue} & '
      write(401,*) '\multicolumn{1}{c}{eu} & '
      write(401,*) '\multicolumn{1}{c}{ee} \\ '
      write(401,*) '\hline\hline'
      write(401,*) ' &  &  &  &  &  &  &  &  \\'      
      do j=1,4
	write(401,5526) xlabel(j), (100*exhaz0(i,j,2),i=1,4),
     *  (100*exhaz0s(i,j,2),i=1,4)
      enddo
      
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}%'
      write(401,*) '\end{center}'         
      write(401,*) '}'
      write(401,*) '\bigskip'

!******************************************************************************
!     Table 7 paper \end
!******************************************************************************      

      

!******************************************************************************
!     Table AX3 paper
!******************************************************************************      
      write(401,*) '{\small' 
      write(401,*) '\begin{center}'            
      write(401,*) '\begin{tabular}{rrrrcrrr}'
      write(401,*) '\multicolumn{8}{c}{Table AX3.' 
      write(401,*)"Individual Job separation and Job taking } \\ "
      write(401,*) '\multicolumn{8}{c}{by'
      write(401,*) "Spouse's Employment to Employment"
      write(401,*) "Transitions} \\"
      write(401,*) '\hline\hline'
      write(401,*) '\multicolumn{1}{c}{Employment} &'
      write(401,*) '\multicolumn{3}{c}{Actual} &  &'
      write(401,*) '\multicolumn{3}{c}{Predicted} \\'
      write(401,*) '\cline{2-4}\cline{6-8}'
      write(401,*) ' \multicolumn{1}{c}{Transitions}& '
      write(401,*) "\multicolumn{3}{c}{ Spouse's Transition} & &"
      write(401,*) "\multicolumn{3}{c}{ Spouse's Transition} \\"
      write(401,*) ' & All e$\rightarrow $e & Same Job &'
      write(401,*) 'Job-to-Job &'
      write(401,*) ' & All e$\rightarrow $e & Same Job &'
      write(401,*) 'Job-to-Job \\'
      write(401,*) '\hline\hline'
      write(401,*) '&  &  &  &  &  &  &  \\ '

      
	write(401,4130) "\ \ \ Husband: u$\rightarrow $e", 
     *  100*xetnuqp(3,9,1,1),
     *  100*xetnuqp(1,9,1,1),100*xetnuqp(2,9,1,1),
     *  100*xetnuqps(3,9,1,1),
     *  100*xetnuqps(1,9,1,1),100*xetnuqps(2,9,1,1)

      write(401,4130) " e$\rightarrow $u",100*xetnuqp(3,10,1,1),
     *  100*xetnuqp(1,10,1,1),100*xetnuqp(2,10,1,1),
     * 100*xetnuqps(3,10,1,1),
     *  100*xetnuqps(1,10,1,1),100*xetnuqps(2,10,1,1)      
      

	write(401,4130) "\ \ \ Wife:\ \ \ \ \ \ \ u$\rightarrow $e", 
     *   100*xetnuqp(3,9,1,2),
     *  100*xetnuqp(1,9,1,2),100*xetnuqp(2,9,1,2),
     *   100*xetnuqps(3,9,1,2),
     *  100*xetnuqps(1,9,1,2),100*xetnuqps(2,9,1,2)
      
      
      write(401,4130) "e$\rightarrow $u",100*xetnuqp(3,10,1,2),
     *  100*xetnuqp(1,10,1,2),100*xetnuqp(2,10,1,2),
     * 100*xetnuqps(3,10,1,2),
     *  100*xetnuqps(1,10,1,2),100*xetnuqps(2,10,1,2)      
      
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}'
      write(401,*) '\end{center}'            
      write(401,*) '}'
      write(401,*) ' ' 
      write(401,*) '\vspace{1.5cm}'
      write(401,*) ' ' 
      
      
!******************************************************************************
!     Table AX3 paper \end
!******************************************************************************      
      

!******************************************************************************
!     Table A1 paper
!******************************************************************************      
      ll=0
      do m=1,nmoment
          
!      ixmoments=int(xmoments)
!      ixmoment=int(xmoment)
!      ixmomentv=int(xmomentv)
      
      if(ichimo(m).eq.1.and.xmomentv(m,2).ne.0.d0) then                 
      ll=ll+1          
      endif
      enddo
      llfin=ll
      
      ll=0
      do m=1,nmoment
      if(ichimo(m).eq.1.and.xmomentv(m,2).ne.0.d0) then                 
      ll=ll+1          
         if(real(ll)/40.d0.eq.real(ll/40)+1.d0/40.d0)then
      write(401,*) '{\small '
      write(401,*) '\begin{center}'               
      write(401,*) '\begin{tabular}{ll rrrr}'
      write(401,*) '\multicolumn{6}{c}{Table A1. Actual
     * and Predicted Moments used in the Estimation} \\ '
      write(401,*) '\multicolumn{6}{c}{Moment Weight: 
     *      Bootstrap Variance} \\' 
      write(401,*) '\hline\hline'      
      write(401,*) '\multicolumn{2}{l}{Moment Name} 
     * & \multicolumn{1}{c}{Predicted}' 
      write(401,*) '& \multicolumn{1}{c}{Actual}' 
      write(401,*) '& \multicolumn{1}{c}{Bootstrap Mean}' 
      write(401,*) '& \multicolumn{1}{c}{Bootstrap Variance}\\'       
      write(401,*) '\hline\hline'
      write(401,*) ' &  &  &  & &  \\'      
          endif          
          
        if(iproba(m).eq.0)then
!        write(401,4127) ll,xlmoment(m),int(xmoments(m)),
!     *    int(xmoment(m)),int(xmomentv(m,1)),int(xmomentv(m,2))
!        write(401,4127) ll,xlmoment(m),ixmoments(m),
!     *    ixmoment(m),ixmomentv(m,1),ixmomentv(m,2)
         write(401,4129) ll,xlmoment(m),int(xmoments(m)),
     *    int(xmoment(m)),int(xmomentv(m,1)),xmomentv(m,2)
           
        else
      write(401,4125) ll,xlmoment(m),xmoments(m),xmoment(m),
     *    xmomentv(m,1),xmomentv(m,2)
            endif

      if(real(ll)/40.d0.eq.real(ll/40).or.m.eq.nmoment.or.ll.eq.llfin)
     *     then
      write(401,*) '\hline\hline'
      write(401,*) '\end{tabular}%'
      write(401,*) '\end{center}'         
      write(401,*) '}'
      write(401,*) '  '      
      write(401,*) '\bigskip'
      write(401,*) '  '      
      endif
            endif
      enddo      
      
      close(401)
!******************************************************************************
!     Table A1 paper \end
!******************************************************************************      
         
4125  format(1x,i4,'. & ',a80,3(' & ',f6.4),1(' & ',f12.10),' \\')
4127  format(1x,i4,'. & ',a80,4(' & ',i34),' \\')                   
4129  format(1x,i4,'. & ',a80,3(' & ',i34),1(' & ',f30.0)' \\')                         
      
      
 120  format(1x,a30,3(1x,'&',1x,f10.2),'\\')
 121  format(16x,3(1x,'&',1x,f10.2),'\\')

 420  format(1x,a30,3(1x,'&',1x,i10),'\\')
 421  format(16x,3(1x,'&',1x,i10),'\\')
      
 122  format(1x,a30,7(1x,'&',1x,f10.2),'\\')
 123  format(16x,7(1x,'&',1x,f10.2),'\\')

 222  format(1x,a30,7(1x,'&',1x,i11),'\\')
 223  format(16x,7(1x,'&',1x,i11),'\\')

 124  format(1x,a30,6(1x,'&',1x,f10.2),'\\')
 125  format(16x,6(1x,'&',1x,f10.2),'\\')

 126  format(1x,a30,5(1x,'&',1x,f10.2),'\\')
 127  format(16x,5(1x,'&',1x,f10.2),'\\')

1126  format(1x,a30,4(1x,'&',1x,f10.2),'\\') 
3126  format(1x,a30,5(1x,'&',1x,f10.2),'\\')       
4126  format(1x,a50,5(1x,'&',1x,f10.2),'&',
     *5(1x,'&',1x,f10.2),'\\')
4128  format(1x,a50,1x,'&',1x,f10.2,1x,'& & & &',1x,f10.2,'& &',
     *1x,f10.2,'& & & &',1x,f10.2,'\\')
      
4130  format(1x,a50,3(1x,'&',1x,f10.2),'&',
     *3(1x,'&',1x,f10.2),'\\')

     
 226  format(1x,a30,5(1x,'&',1x,i10),'\\')
 227  format(16x,5(1x,'&',1x,i10),'\\')
 229  format(1x,a30,4(1x,'&',1x,i10),'\\')      
1229  format(1x,a30,4(1x,'& (',i10,')'),'\\')            
3229  format(1x,a30,5(1x,'& (',i10,')'),'\\')                  

4229  format(1x,a50,5(1x,'&',1x,i10),'&',
     *5(1x,'&',1x,i10),'\\')
4230  format('{',a50,5(' } & {\footnotesize ',i10),'} & {',
     *5(' } &{\footnotesize ',i10),'} \\')
5526  format(1x,a30,8(1x,'&',1x,f10.2),'\\')            
     
 128  format(1x,a30,12(1x,'&',1x,f10.2),'\\')
 129  format(16x,12(1x,'&',1x,f10.2),'\\')

 220  format(1x,i3,4(1x,'&',1x,f10.2),8(1x,'&',1x,f10.0),'\\')
 320  format(1x,i3,4(1x,'&',1x,f10.2),8(1x,'&',1x,i10),'\\') 
      
 228  format(1x,a30,12(1x,'&',1x,a10),'\\')


 130  format(1x,a30,13(1x,'&',1x,f10.2),'\\')
 132  format(1x,a30,13(1x,'&',1x,f10.2),'\\')
 230  format(1x,a30,13(1x,'&',1x,a10),'\\')

 322  format((1x,a30),'part:',2(1x,a30),7(1x,'&',1x,f10.2),'\\')
 323  format(16x,7(1x,'&',1x,f10.2),'\\')


!416   format("\lbrack",i5,", ",i5,")")               
      return
      end
         
      
