!=============================================================
SUBROUTINE FUNCT(NPar,th,Fu)
IMPLICIT NONE
integer iter,nx,nper
integer capr,r,s,h,t,n,tper,e,et,u,eh,em,el,rs,npar
integer i,k,qq,sstart,estarth,estartm,estartl,ustart,sums1,sums2,ds1,ds2,ds3,ds4
integer qqm,qq1,qq2       
  
PARAMETER (n=1199,ns=4,np1=9,np2=np1+8,np3=np2+8,np4=np3+8,np5=np4+30,np=np5+21,nt=15,nx=8,capr=40)

REAL*8 TH(NP),as(ns),al(ns),am(ns),ah(ns),aw(ns),aws(ns),awl(ns),awm(ns),awh(ns)
REAL*8 bs(5),bl(4),bh(4),bw(1),bws(1),bwl(2),bwm(2),bwh(2),bm(4),preg(15)
REAL*8 pr(nt,ns),compl3(ns,capr+1),compl4(ns),fw(ns,nt),ff(n,ns) 
REAL*8 compl2(n,nt+1)

REAL*8 dw(n,nt),alnw(n,nt),acedu(n,nt),achh(n,nt),acmh(n,nt),aclh(n,nt),acho(n,nt)
REAL*8 edu(n,nt),emph(n,nt),empm(n,nt),empl(n,nt),home(n,nt),xvar(n,nx),u2c(n,nt,capr)

REAL*8 u_w(n,nt,capr),regwd(n,nt),eps_v(capr,nt),afqt(n,1),dpr(n),ew(n,capr+1)

REAL*8, allocatable:: ev3(:,:,:,:,:,:,:)
REAL*8, allocatable:: ev2(:,:,:,:,:,:,:)
REAL*8, allocatable:: vbar(:,:,:,:,:,:)

REAL*8 :: fu,beta,tao,sigw,rho,sigrho,s0,vp1,vp2,vp3,s_s,v1,v2,v3,v4,v5,v6,vb,dlvb
REAL*8 :: regwd1,regwd2,regwd3,regwd4,regwd5,eregw,expw,dden,calltypes,cp,q1,q2,q3,p1,p2,p3,p4

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
          	
allocate(ev3(1:nt+1,1:ns,0:nt,0:nt,0:nt,0:nt,0:nt))
allocate(ev2(1:nt,1:ns,0:nt,0:nt,0:nt,0:nt,0:nt))
allocate(vbar(0:nt,0:nt,0:nt,0:nt,0:nt,1:capr+1))

      cp=0
      npar=np
      
      beta=0.95
      tao=1

	 as(1:ns)=th(1:ns)  
	 al(1:ns)=th(np1+1:np1+ns)
	 am(1:ns)=th(np2+1:np2+ns)
	 ah(1:ns)=th(np3+1:np3+ns)

	 aw(1:ns)=th(np4+1:np4+ns)
	 aws(1:ns)=th(np4+6:np4+9)
	 awl(1:ns)=th(np4+11:np4+14)
	 awm(1:ns)=th(np4+17:np4+20)
	 awh(1:ns)=th(np4+23:np4+26)
	
	 bw(1)=th(np4+5)
	 bws(1)=th(np4+10)
	 bwl(1:2)=th(np4+15:np4+16)
	 bwm(1:2)=th(np4+21:np4+22)
	 bwh(1:2)=th(np4+27:np4+28)

	 bh(1:4)=th(np3+5:np3+8)
	 bl(1:4)=th(np1+5:np1+8)
	 bm(1:4)=th(np2+5:np2+8)
	 bs(1:5)=th(5:9)
 	   
     sigw=dexp(th(np4+29))			 
     rho=dexp(th(np4+30))/(1+dexp(th(np4+30)))
     sigrho=dsqrt(sigw*sigw/(1-rho*rho))
         
     preg(1:15)=th(np5+1:np5+15) 

!     Start the individual loop.	
do i=1,n
	
nper=xvar(i,1)	
if (nper.gt.nt) nper=nt
compl2(i,1)=1d0 
s0=acedu(i,1)-1
q1=dexp(th(np-5)+th(np-4)*s0) 
q2=dexp(th(np-3)+th(np-2)*s0) 
q3=dexp(th(np-1)+th(np)*s0) 

p1=q1/(1+q1+q2+q3)
p2=q2/(1+q1+q2+q3)
p3=q3/(1+q1+q2+q3)
p4=1-p1-p2-p3

do r=1,capr
do t=1,nt
 eps_v(r,t)=sigrho*u_w(i,t,r) 
enddo
enddo	

!     Start a "type" loop.
do k=1,ns  

compl3(k,1)=0
regwd1=aw(k)+bw(1)*afqt(i,1)
!=============================================
!ccccccccccccccccccccccccccccccccccccccccccccc
!ccccccccccccccccccccccccccccccccccccccccccccc
!ccccccccccccccccccccccccccccccccccccccccccccc
!=============================================

dpr(i)=1.d0
if (nper<3) then
dpr(i)=0.0
goto 9999
end if

do qq=nper-1,1,-1

qqm=qq-1
qq1=qq+1
qq2=qq1+1
 
if (qq==1) then
 sstart=0
 estarth=0
 estartm=0
 estartl=0
 ustart=0
endif
 
if (qq>=1) then 
 sstart=sum(edu(i,1:qqm))
 estarth=sum(emph(i,1:qqm))
 estartm=sum(empm(i,1:qqm))
 estartl=sum(empl(i,1:qqm))
 ustart=sum(home(i,1:qqm))
endif


do s=sstart,qqs,1
do eh=estarth,qqs,1
do em=estartm,qqs,1
do el=estartl,qqs,1
do u=ustart,qqs,1

 sums2=eh+em+el+u+s 
 if (sums2 == qqs) then

    vp1=preg(1)*s*s+preg(2)*u*u+preg(3)*eh*eh+preg(4)*em*em+preg(5)*el*el
    vp2=preg(6)*s*u+preg(7)*s*eh+preg(8)*s*em+preg(9)*s*el+preg(10)*u*eh
    vp3=preg(11)*u*em+preg(12)*u*el+preg(13)*eh*em+preg(14)*eh*el+preg(15)*em*el
    ev3(qq2,k,s,eh,em,el,u)=vp1+vp2+vp3
endif

enddo
enddo
enddo
enddo
enddo



do s=sstart,qq,1
do eh=estarth,qq,1
do em=estartm,qq,1
do el=estartl,qq,1
do u=ustart,qq,1
    
 sums1=eh+em+el+u+s 
 
 if (sums1 == qq) then
 
s_s=s+s0

ds1=0
ds2=0
ds3=0
ds4=0
      
if (s_s==11) ds1=1 
if (s_s>=12) ds2=1
if (s_s>=13.and.s_s<=15) ds3=1
if (s_s>=16) ds4=1  

v1=as(k)+bs(1)*afqt(i,1)+bs(2)*ds1+bs(3)*ds2+bs(4)*ds3+bs(5)*ds4+beta*vpall	
v2=0.0
	
regwd2=dexp(aws(k)+bws(1)*afqt(i,1))*s_s
regwd3=dexp(awl(k)+bwl(1)*afqt(i,1)+bwl(2)*s_s)*el
regwd4=dexp(awm(k)+bwm(1)*afqt(i,1)+bwm(2)*s_s)*em
regwd5=dexp(awh(k)+bwh(1)*afqt(i,1)+bwh(2)*s_s)*eh
eregw=regwd1+regwd2+regwd3+regwd4+regwd5

do r=1,capr
	
expw=eregw+eps_v(r,qq1)
  
v3=al(k)+bl(1)*afqt(i,1)+bl(2)*expw+bl(3)*s_s+bl(4)*el+beta*vpall
v4=am(k)+bm(1)*afqt(i,1)+bm(2)*expw+bm(3)*s_s+bm(4)*em+beta*vpall
v5=ah(k)+bh(1)*afqt(i,1)+bh(2)*expw+bh(3)*s_s+bh(4)*eh+beta*vpall

vb=dexp(v1/tao)+dexp(v2/tao)+dexp(v3/tao)+dexp(v4/tao)+dexp(v5/tao)	
dlvb=tao*(0.5772d0+dlog(vb))
vbar(s,eh,em,el,u,r+1)=dlvb+vbar(s,eh,em,el,u,r)
enddo

ev2(qq1,k,s,eh,em,el,u)=vbar(s,eh,em,el,u,capr+1)/capr

endif

enddo
enddo
enddo
enddo
enddo


s=sstart
eh=estarth
em=estartm
el=estartl
u=ustart
s_s=s+s0

ds1=0
ds2=0
ds3=0
ds4=0
      
if (s_s==11) ds1=1 
if (s_s>=12) ds2=1
if (s_s>=13.and.s_s<=15) ds3=1
if (s_s>=16) ds4=1  


v1=as(k)+bs(1)*afqt(i,1)+bs(2)*ds1+bs(3)*ds2+bs(4)*ds3+bs(5)*ds4+beta*ev2(qq1,k,s+1,eh,em,el,u)	
v2=0.0

regwd2=dexp(aws(k)+bws(1)*afqt(i,1))*s_s
regwd3=dexp(awl(k)+bwl(1)*afqt(i,1)+bwl(2)*s_s)*el
regwd4=dexp(awm(k)+bwm(1)*afqt(i,1)+bwm(2)*s_s)*em
regwd5=dexp(awh(k)+bwh(1)*afqt(i,1)+bwh(2)*s_s)*eh

do r=1,capr
  if (qq==1) ew(i,r+1)=regwd1+regwd2+regwd3+regwd4+regwd5+ew(i,r)
  if (qq>1)  ew(i,r+1)=regwd1+regwd2+regwd3+regwd4+regwd5+eps_v(r,qq1)+ew(i,r)
enddo

eregw=ew(i,capr+1)/capr

v3=al(k)+bl(1)*afqt(i,1)+bl(2)*eregw+bl(3)*s_s+bl(4)*el+beta*ev2(qq1,k,s,eh,em,el+1,u)
v4=am(k)+bm(1)*afqt(i,1)+bm(2)*eregw+bm(3)*s_s+bm(4)*em+beta*ev2(qq1,k,s,eh,em+1,el,u)
v5=ah(k)+bh(1)*afqt(i,1)+bh(2)*eregw+bh(3)*s_s+bh(4)*eh+beta*ev2(qq1,k,s,eh+1,em,el,u)

v6=dexp(v1/tao)+dexp(v2/tao)+dexp(v3/tao)+dexp(v4/tao)+dexp(v5/tao)

if (edu(i,qq).eq.1)   pr(qq,k)=dexp(v1/tao)/v6
if (home(i,qq).eq.1)   pr(qq,k)=dexp(v2/tao)/v6
if (empl(i,qq).eq.1)   pr(qq,k)=dexp(v3/tao)/v6
if (empm(i,qq).eq.1)   pr(qq,k)=dexp(v4/tao)/v6 
if (emph(i,qq).eq.1)   pr(qq,k)=dexp(v5/tao)/v6

!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
enddo
!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc   
!


9999 continue

      
compl2(i,1)=1.0

ff(i,k)=1.0
	
!     Wage densities
if (alnw(i,1).le.0.0) then
 dw(i,1)=0.0
else
 dw(i,1)=1.0
endif

 regwd2=dexp(aws(k)+bws(1)*afqt(i,1))*acedu(i,1)
 regwd3=dexp(awl(k)+bwl(1)*afqt(i,1)+bwl(2)*acedu(i,1))*aclh(i,1)
 regwd4=dexp(awm(k)+bwm(1)*afqt(i,1)+bwm(2)*acedu(i,1))*acmh(i,1)
 regwd5=dexp(awh(k)+bwh(1)*afqt(i,1)+bwh(2)*acedu(i,1))*achh(i,1)
 regwd(i,1)=regwd1+regwd2+regwd3+regwd4+regwd5
 
 fw(k,1) =(1/sigw)*dden((alnw(i,1)-regwd(i,1))/sigw)


do t=2,nper

if (alnw(i,t).le.0.0) then
 dw(i,t)=0.0
else
 dw(i,t)=1.0
endif

 regwd2=dexp(aws(k)+bws(1)*afqt(i,1))*acedu(i,t)
 regwd3=dexp(awl(k)+bwl(1)*afqt(i,1)+bwl(2)*acedu(i,t))*aclh(i,t)
 regwd4=dexp(awm(k)+bwm(1)*afqt(i,1)+bwm(2)*acedu(i,t))*acmh(i,t)
 regwd5=dexp(awh(k)+bwh(1)*afqt(i,1)+bwh(2)*acedu(i,t))*achh(i,t)
 
 regwd(i,t)=regwd1+regwd2+regwd3+regwd4+regwd5
 
 if (dw(i,t-1).eq.1) then
  fw(k,t) =(1/sigw)*dden((alnw(i,t)-regwd(i,t)-rho*(alnw(i,t-1)-regwd(i,t-1)))/sigw)
 else
  fw(k,t) =(1/sigw)*dden((alnw(i,t)-regwd(i,t))/sigw)
end if

ff(i,k)=ff(i,k)*(fw(k,t)**dw(i,t))
enddo


do t=1,nper
 if (t.le.nper) then
  tper=1
 else
  tper=0
 end if 
  compl2(i,t+1)=(pr(t,k)**tper)*compl2(i,t)        
enddo

compl4(k)=(compl2(i,nper+1)**dpr(i))*ff(i,k)
		
! end k-loop	 
enddo

      
calltypes=compl4(1)*p1+compl4(2)*p2+compl4(3)*p3+compl4(4)*p4
cp=cp+dlog(calltypes)
          
! end i-loop     
enddo

        iTER=iTER+1 
       
        Fu=-(cp/n)
        WRITE(6,1211) iTER,Fu,aws(1),awl(1),awm(1),awh(1)
        write(66,*) th(1:np)
     
 1211 FORMAT(1X,'ITER=',I7,1X,'Fu=',F14.9,1X,'aws=',f8.4,1X,'awl=',f8.4,1X,'awm=',f8.4,1X,'awh=',f8.4)
 
deallocate(ev3)
deallocate(ev2)
deallocate(vbar)

return
end



