      subroutine standev(nmoment)
	implicit none
	intrinsic max,min,abs,int    
      integer np,maxmom,nchimo,nzmax,nps,kbench,nchi
      integer i,j,k,jj,ii
      integer ierror,ierr,nmoment
	integer ifecha(8)

      parameter (maxmom=20000,nchimo=maxmom,np=29)
      
      real*8  func,p0(np),xi(np,np)
	real*8	xdef,xtolu,bet,r,mtot,xrbet
	real*8  sig,bmin(2),xlu(2),xle(2),xlo(2),xt(2),xm(2)
     *        ,std(2),slei(3),spar,slow,shigh,a0,splow,sphigh
      real*8 zol, zmax,zincrease,v1,v,s,p,a
      real*8  zder(nchimo,np),zcov(np,np),
     * zcinv(np,np),indx(np),zm(nchimo,np,5)!,zdp(np,nchimo)
     * ,zinc1(np),zinc2(np),pam(np,5),yzs(5,5),xzs(5)
      real*8 zpi1,zpi2
      character*30 filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes, 
     *     fileorp,
     *    filetexr,filetexa,filetex,filemomx
      character*100 xtitlef(30)
      character*4 hep(20),heq,heq2
 
      common /files/ filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes,fileorp,
     *    filetexr,filetexa,filetex,filemomx,xtitlef,heq,heq2

	common /params/ xdef,xtolu,bet,r,mtot
	common /pars/ sig,bmin,xlu,xle,xlo,xt,xm,std,
     *        slei,spar,slow,shigh,a0,splow,sphigh,xcost
      real*8 xmoel(30)
      real*8 chi2m(maxmom)      
      common /migra4/ chi2m
!     Heterogeneity      
      real*8 xptypes(4),xm_types(2,2),slei_types(2,2),xcost(3)
	common /types/ xm_types,slei_types,xptypes
	integer types,ntypes,indi_type(2,4),ltypes
      common /itypes/ indi_type,ntypes,ltypes      
      
      

!*************************************
!Standard errors
!*************************************      
      p0(1)=xm_types(1,1)
      p0(2)=xm_types(2,1)
      p0(3)=xm_types(1,2)
      p0(4)=xm_types(2,2)      

      p0(5)=slei_types(1,1)
      p0(6)=slei_types(2,1)
      p0(7)=slei_types(1,2)
      p0(8)=slei_types(2,2)

      p0(9)=bmin(1)
      p0(10)=bmin(2)

      p0(11)=xlu(1)
	p0(12)=xlo(1)
      p0(13)=xt(1)
      p0(14)=std(1)

      p0(15)=xlu(2)
      p0(16)=xlo(2)
      p0(17)=xt(2)
	p0(18)=std(2)

	p0(19)=sig            !#      
      p0(20)=spar
	p0(21)=slei(3)
      
!	p0(25)=xcost(1)
!	p0(26)=xcost(2)
!	p0(27)=xcost(3)      

	nps=21
	do i=1,3
	if(xptypes(i).ne.0.d0)then
	nps=nps+1
        p0(nps)=xptypes(i)
	endif
	enddo
      xptypes(4)=1.d0-xptypes(1)-xptypes(2)-xptypes(3)
     
        
      
      open (8, file='errjs_'//trim(heq2)//'.out')                
      open (18, file='errjs_'//trim(heq2)//'.tex')                      
!*******************************************
!     Initialize 
!*******************************************      
      zmax=0.05 
      nzmax=5
!      zmax=0.001
!      nzmax=3
      
!      nchi=6   !Moments
!
!      nps=24  !Number of parameters
      zder=0.d0
      zcov=0.d0
      ierror=1              !indicator  =1, compute derivatives, =0, read them    
	write(*,*),ierror

!*******************************************
!     Matrix of parameters
!*******************************************      
      zincrease=-zmax
      do k=1,nzmax
      do j=1,nps
      pam(j,k)=p0(j)*(1.d0+zincrease)
!      write(*,*)k,j,zincrease,pam(j,k)
      enddo
!      write(*,*)k,zincrease
      zincrease=zincrease+2*zmax/(nzmax-1)      
      enddo
!      read(*,*)
      kbench=1+(nzmax-1)/2
      open (9, file='errors2_'//trim(heq2)//'.txt')                            
      if (ierror.eq.1)then             !compute derivatives
          
!*******************************************
!     Benchmark level
!*******************************************      

      do j=1,nps
      p0(j)=pam(j,kbench)
      enddo
!      read(*,*)
      zol=func(p0)                            
      nchi=nmoment            
!      write(*,*) 'standard dev',nps,nchi,nmoment      
      do j=1,nps
		do ii=1,nchi
			zm(ii,j,kbench)=chi2m(ii)
!              write(*,*)zol,chi2m(ii),ii,j,k
          enddo
      enddo
!			zm(1:nchi,j,kbench)=chi2m(1:nchi)
!			zm(:,j,kbench)=chi2m(:)              
!      write(*,*) 'standard dev1',nchi,nmoment
 !     read(*,*)

!*******************************************
!     Functions of parameters' set
!*******************************************      
      do j=1,nps
      p0(j)=pam(j,kbench)
      enddo

      do j=1,nps
      do k=1,nzmax
          if(k.ne.kbench)then          
      p0(j)=pam(j,k)
      zol=func(p0)                      
		do ii=1,nchi
			zm(ii,j,k)=chi2m(ii)
  !            write(*,*)zol,chi2m(ii),ii,j,k              
          enddo
          endif   
          
 !     write(*,*) 'standard dev2',j,k
 !     read(*,*)
          
      enddo !k
      p0(j)=pam(j,kbench)      
      enddo !j

!*******************************************
!     Computing the derivative 
! PROGRAM ndff    of "FORTRAN PROGRAMS"
!FORTRAN PROGRAMS FOR SOLVIMG NUMERICAL PROBLEMS, Designed by T K Rajan
!victoriacollege.in/download/FORTRAN%20PROGRAMS.pdf      
!http://victoriacollege.in/Dep_FacultyProfile.php?id=rajanmaths&did=7      
!*******************************************      
          write(8,*) nmoment
          write(9,*) nmoment

      do jj=1,nps
		do ii=1,nchi
          do k=1,nzmax
          yzs(k,1)=zm(ii,jj,k)              
          xzs(k)=pam(jj,k)                        
          enddo
      a=xzs(kbench)
      do  j=2,nzmax
      do  i=1,nzmax-j+1
      yzs(i,j)=(yzs(i+1,j-1)-yzs(i,j-1))/(xzs(i+j-1)-xzs(i))
      enddo
      enddo
      v=yzs(1,2)
      DO I=3,NZMAX
      S=0.D0
      DO J=1,I-1
      P=1.D0
      DO K=1,I-1
      IF(K.NE.J) P=P*(A-XZS(K))
      ENDDO !K
      s=s+p
      enddo !j
      v=v+s*yzs(1,i)
      enddo !i
          
          zder(ii,jj)=v                                                   !New derivative of arbitrarily many points
        v1=(-zm(ii,jj,5)+8*zm(ii,jj,4)-8*zm(ii,jj,2)+zm(ii,jj,1))/       !With five function evaluations
     *        (6*(pam(jj,4)-pam(jj,2)))
          
          
          write(8,*) ii,jj,zder(ii,jj),v1   !Storing for future use if nzmax=5, then zder=v1
          write(9,*) ii,jj,zder(ii,jj),v1   !store derivatives          
          write(*,*) ii,jj,zder(ii,jj),v1       

          
      write(1,"(2(1x,i3,1x,f15.4),2(1x,f15.4))")
     *  jj,pam(jj,kbench),ii,zm(ii,jj,kbench),
     *   zder(ii,jj), zder(ii,jj)*pam(jj,kbench)/zm(ii,jj,kbench)
          
          enddo       !ii
      enddo           !jj
      write(*,*) ' '	
      write(8,*) ' '      
      
      else                                !else
      read(9,*) nmoment
      nchi=nmoment                            
      do j=1,nps
		do i=1,nchi
          read(9,*) ii,jj,zder(i,j),v1   !recover previously stored derivatives
          enddo
      enddo
      endif      
      close(9)      
      
     
!*******************************************
!     zcov=zder'zder
!*******************************************      
      zcov=0.d0      
      do j=1,nps
        do i=1,nps
          do k=1,nchi
            zcov(i,j)=zder(k,i)*zder(k,j)+zcov(i,j)
          enddo
        enddo
      enddo
      continue
      
	do j=1,nps
		do i=1,nps
          write(8,*) i,j,zcov(i,j) !Storing for future use
          write(*,*) i,j,zcov(i,j)          
			zcinv(i,j)=0.d0
      enddo
			zcinv(j,j)=1.d0
      enddo
      write(*,*) ' '	
      write(8,*) ' '      
!*******************************************
!     Inverse of zcov
!*******************************************      
      call gaussj(zcov,nps,np,zcinv,nps,np,ierr)   
      write(*,*) ierr	
      write(8,*) ierr     

      write(*,*) ' '	
      write(8,*) ' '      
     	do i=1,nps
      p0(i)=pam(i,kbench)
      enddo
      
      call date_and_time(values=ifecha)    
      
      
      write(18,*) '\documentclass[12pt]{article}'
      write(18,*) '\setlength{\textwidth}{6in}'
      write(18,*) '\setlength{\textheight}{8.5in}'
      write(18,*) '\setlength{\topmargin}{0.25in}'
      write(18,*) '\setlength{\oddsidemargin}{0.25in}'
      write(18,*) '\setlength{\footskip}{0.4in}'
      write(18,*) '\setlength{\headheight}{0.0in}'
      write(18,*) '\setlength{\headsep}{0.5in}'
      write(18,*) '\input tcilatex'
	write(18,*) ' '       
      write(18,*) '\begin{document}'
      write(18,*) '\renewcommand{\baselinestretch}{1}'
	write(18,*) '\pagestyle{myheadings}'
	write(18,*) '\markright{Family Job Search and Wealth. '
	write(18,*) "J. I. Garc\'{\i}a-P\'erez and S. Rendon"
      write(18,"(i4,'/',i2,'/',i2,' ',i4,':',i2,' ',i2,'.',i3)") 
     * ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8)
	write(18,*) " }"            

      
      write(18,*)"\begin{center}"
      write(18,*)"{\small"
      write(18,*)"\begin{tabular}{lclrrrr}"
      write(18,*) '\multicolumn{7}{c}{Table 6. Parameter Values' 
      write(18,*) 'and Asymptotic Standard Errors in parentheses} \\ '
      write(18,*) '\hline \hline'
      write(18,*) 'Parameter &  $\widehat{\Theta }$ &  &',
     *         '\multicolumn{4}{c}{Estimate} \\'
      write(18,*) '\cline{4-7}'
      write(18,*) '&  &  & \multicolumn{2}{c}{Husband} & '
      write(18,*) '\multicolumn{2}{c}{Wife} \\'
      write(18,*) '\hline \hline'
!      write(18,*) '&  &  &  &  &  &  \\'      
      write(18,*) 'Individual: &  &  &  &  &  &  \\'

      

      i=11 !      p0(i)=xlu(1)      
      j=15 !      p0(j)=xlu(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Arrival Rate Unemployed: & $\lambda$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))
      
     
      i=12      !	p0(i)=xlo(1)
      j=16      !p0(j)=xlo(2)
      ii=13! p0(i)=xt(1)
      jj=17! p0(j)=xt(2)


      zpi1=dsqrt(abs((1-p0(ii))*(1-p0(ii))*zcov(i,i)
     * +p0(i)*p0(i)*zcov(ii,ii)
     *      -2*p0(i)*(1-p0(ii))*zcov(i,ii)))
      zpi2=dsqrt(abs((1-p0(jj))*(1-p0(jj))*zcov(j,j)
     * +p0(j)*p0(j)*zcov(jj,jj)
     *      -2*p0(j)*(1-p0(jj))*zcov(j,jj)))

      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Arrival Rate Employed: & $\pi$ ",
!     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))      
     * (1-p0(6))*p0(i),zpi1,(1-p0(11))*p0(j),zpi2

      i=13! p0(i)=xt(1)
      j=17! p0(j)=xt(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Layoff Rate: & $\theta$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))      

      i=14 !    p0(i)=std(1)
	j=18! p0(j)=std(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Standard Deviation of Logwagess: & $\sigma$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))

      i=9      !      p0(i)=bmin(1)
      j=10      !      p0(j)=bmin(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Unemployment Transfers: & $b$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))
      
      
      
      write(18,*) 'Individual heterogenous: &  &  &  &  &  &  \\'      
      i=1 !      p0(i)=xm(1)
      j=2! p0(j)=xm(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Mean Logwages: & $\mu_1$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))      
      
      
      i=3 !      p(i)=xm(1)
      j=4! p0(j)=xm(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Mean Logwages: & $\mu_2$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))      
      
      i=5 !p0(i)=slei(1)
	j=6 !p0(j)=slei(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Leisure: & $\vartheta_1$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))

      i=7 !p0(i)=slei(1)
	j=8 !p0(j)=slei(2)
      write(18,"(A60,'& ',2(' & ', 1x,f15.4,1x,' & (',f15.6,')'),'\\')")
     *"\ \ \ Leisure: & $\vartheta_2$ ",
     * p0(i),dsqrt(abs(zcov(i,i))),p0(j),dsqrt(abs(zcov(j,j)))
    
      
      
      write(18,*) 'Common: &  &  &  &  &  &  \\'
      i=19  !P0(i)=sig   
      write(18,"(A100,1x,f15.4,1x,a35,f15.6,')}\\')")
     *'\ \ \ Relative Risk Aversion: & $\gamma$ &
     *  & \multicolumn{2}{r}{', 
     *    p0(i),'} & \multicolumn{2}{l}{(',dsqrt(abs(zcov(i,i)))

      i=20   !p0(i)=spar
      write(18,"(A100,1x,f15.4,1x,a35,f15.6,')}\\')")
     * '\ \ \ Borrowing Constraint: & $s$ & & \multicolumn{2}{r}{', 
     *    p0(i),'} & \multicolumn{2}{l}{(',dsqrt(abs(zcov(i,i)))

      i=21       !p0(i)=slei(3)      
      write(18,"(a100,1x,f15.4,1x,a35,f15.6,')}\\')")
     * '\ \ \ Leisure: & $\vartheta _{3}$ & & \multicolumn{2}{r}{', 
     *    p0(i),'} & \multicolumn{2}{l}{(',dsqrt(abs(zcov(i,i)))



 

      write(18,*) 'Types: &  &  &  &  &  &  \\'
!       p0(1)=xptypes(1)
!      p0(2)=xptypes(2)
!      p0(3)=xptypes(3)


	i=21
      do types=1,3
	if(xptypes(types).ne.0.d0)then
	i=i+1
      write(18,"(a35,i1,i1,a6,a35,1x,f15.4,1x,a35,f15.6,')}\\')")
     *"\ \ \ Type Proportion : & $p_{",
     * indi_type(1,types),indi_type(2,types),"}$ & ",
     *  '& \multicolumn{2}{r}{', 
     *    p0(i),'} & \multicolumn{2}{l}{(',dsqrt(abs(zcov(i,i)))
	endif
      enddo
!      xptypes(4)=1.d0-xptypes(1)-xptypes(2)-xptypes(3)

	zpi2=0.d0
	i=21
      do ii=1,3
	if(xptypes(ii).ne.0.d0)then
	i=i+1

	j=21
      do jj=1,3
	if(xptypes(jj).ne.0.d0)then
	j=j+1
	if(ii.eq.jj)then
	zpi2=zpi2+zcov(i,j)
	else
	zpi2=zpi2-zcov(i,j)
	endif

	endif
      enddo



	endif
      enddo




	if(xptypes(4).ne.0.d0)then
	i=4
      write(18,"(a35,i1,i1,a6,a35,1x,f15.4,1x,a35,f15.6,')}\\')")
     *"\ \ \ Type Proportion : & $p_{",
     * indi_type(1,i),indi_type(2,i),"}$ & ",
     *  '& \multicolumn{2}{r}{', 
     *    xptypes(i),'} & \multicolumn{2}{l}{(',dsqrt(abs(zpi2))
	endif
      
      
      write(18,*) '\hline\hline'
      write(18,*) '\end{tabular}'
      write(18,*) '\end{center}'      
      write(18,*) '}  '      
      write(18,*) '  '
      

!************************************
!     Parameter values 
!************************************
      write(18,*) '{\small' 
      write(18,*) '\begin{center}'           
      write(18,*) '\begin{tabular}{ccc}'
      write(18,*) '\hline \hline'      
      write(18,*) '\multicolumn{3}{c}{Parameter values} \\ '
      write(18,*) '\multicolumn{3}{c}{Baeline Parameters} \\ '
      write(18,*) '\hline \hline'
      write(18,"(1x,a40,f10.4,1x,a4)")
     *  '$\beta $ & \multicolumn{2}{c}{',bet,'}\\'
      write(18,"(1x,a40,f10.4,1x,a4)")
     *  '$r$ & \multicolumn{2}{c}{',r,'}\\'
      write(18,"(1x,a40,f10.4,1x,a4)")
     *  '$\gamma $ & \multicolumn{2}{c}{',sig,'}\\'
      write(18,"(1x,a40,f10.4,1x,a4)")
     *  '$s$ & \multicolumn{2}{c}{',spar,'}\\'
      write(18,"(1x,a40,f10.4,1x,a4)")
     *  '$\vartheta_3$ & \multicolumn{2}{c}{',slei(3),'}\\'
      write(18,*) '& husband & wife \\ \hline'
    
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$b$ &',bmin(1),'&',bmin(2),'\\'
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$\lambda$ &',xlu(1),'&',xlu(2),
     *  '\\'
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$\pi$ &',xlo(1),'&',xlo(2),'\\'
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$\theta $ &',xt(1),'&',xt(2),'\\'
      
      
       if(ntypes.eq.ltypes)then
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$\mu$ &',xm(1),'&',xm(2),'\\'
      endif
      
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$\sigma$ &',std(1),'&',std(2),'\\'
       if(ntypes.eq.ltypes)then
	write(18,"(a20,2(1x,f10.4,1x,a4))")'$\vartheta$ &',slei(1),'&',
     * slei(2),'\\'      
      endif
      
     
      write(18,*) '\hline\hline'
      write(18,*) '\end{tabular}'
      write(18,*) '\end{center}'                  
      write(18,*) '}'
      write(18,*) ' ' 
!      write(18,*) '\vspace{1.5cm}'
      write(18,*) '\bigskip'       
      write(18,*) ' ' 

      write(18,*) '{\small' 
      write(18,*) '\begin{center}'           
      write(18,*) '\begin{tabular}{rrrrrrrrr}'
      write(18,*) '\multicolumn{9}{c}{Parameters by Type} \\ '      
      write(18,*) '\hline \hline'      
      write(18,*) '\multicolumn{3}{c}{Types} & &'
      write(18,*) '\multicolumn{5}{c}{Parameter values} \\ '
      write(18,*) 'Type & Husband & Wife & & $\mu_1$ & $\mu_2$ 
     *  &    $\vartheta_1$ & $\vartheta_2$ & $\Pr$(Type) \\ '      
      write(18,*) '\hline \hline'
      
      do types=1,4
      write(18,"(3(i4,' & '),5(' & ',f15.4),' \\')") types,
     *   indi_type(1,types),indi_type(2,types),
     *  xm_types(1,indi_type(1,types)),xm_types(2,indi_type(2,types)),
     *slei_types(1,indi_type(1,types)),slei_types(2,indi_type(2,types)),
     * xptypes(types)
      enddo
      write(18,*) '\hline\hline'
      write(18,*) '\end{tabular}'
      write(18,*) '\end{center}'                  
      write(18,*) '}'
      write(18,*) ' ' 
!      write(18,*) '\vspace{1.5cm}'
      write(18,*) '\bigskip'       
      write(18,*) ' ' 

      
      
      write(18,*) '\end{document}'
      

      close(18)            
      
      return
      end
         
      
      
