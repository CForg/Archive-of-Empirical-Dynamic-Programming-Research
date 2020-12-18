      SUBROUTINE SETDATA
      integer iter,n,nx
      integer capr,j,j2,j3
      PARAMETER (n=1199,nt=15,capr=40,nx=8)
      
REAL*8 dw(n,nt),alnw(n,nt),acedu(n,nt),achh(n,nt),acmh(n,nt),aclh(n,nt),acho(n,nt)
REAL*8 edu(n,nt),emph(n,nt),empm(n,nt),empl(n,nt),home(n,nt),xvar(n,nx),nper(n),aced(n,nt)
REAL*8 afqt(n,1),u_w(n,nt,capr),cog(n,4)

      COMMON/INVAR1/dw
      COMMON/INVAR2/alnw
      COMMON/INVAR3/acedu
      COMMON/INVAR4/achh
      COMMON/INVAR5/acmh
      COMMON/INVAR6/aclh		  
      COMMON/INVAR7/acho		  
      COMMON/INVAR8/edu		  
      COMMON/INVAR9/emph		  
      COMMON/INVAR10/empm	  
      COMMON/INVAR11/empl		  
      COMMON/INVAR12/home  	  
      COMMON/INVAR13/xvar 	  	 
      COMMON/INVAR14/afqt 
      COMMON/INVAR16/u_w         	  
      COMMON/INVAR17/iter 
           	   	
      CALL OPENS
      
      DO J=1,N
      
      
       READ(12,*) (alnw(J,K),K=1,nt)
       READ(13,*) (aced(J,K),K=1,nt)
       READ(14,*) (aclh(J,K),K=1,nt)
       READ(15,*) (acmh(J,K),K=1,nt)
       READ(16,*) (achh(J,K),K=1,nt)
       
       READ(17,*) (dw(J,K),K=1,nt)
       READ(18,*) (edu(J,K),K=1,nt)
       READ(19,*) (empl(J,K),K=1,nt)
       READ(20,*) (empm(J,K),K=1,nt)
       READ(21,*) (emph(J,K),K=1,nt)
       READ(22,*) (home(J,K),K=1,nt)
      
       READ(23,*) (xvar(J,K),K=1,nx)
       READ(24,*) (cog(J,K),K=1,4)
    
       afqt(j,1)=cog(j,3)
               
       do j2=1,nt
       do j3=1,capr
         READ(27,*) u_w(j,j2,j3)
enddo
enddo
   
enddo

      iter=0
      write(6,*) iter
      RETURN
      END 
