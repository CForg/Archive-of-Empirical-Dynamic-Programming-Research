! fortran file for estimation

! modules
module module487
contains

pure function mean1(x)
real , intent(in), dimension(:) :: x
real  ::   mean1
mean1=sum(x)/size(x)
end function mean1

pure function mean3(x)
real , intent(in), dimension(:,:,:) :: x
real  ::   mean3
mean3=sum(x)/size(x)
end function mean3


pure function mean2(x)
real , intent(in), dimension(:,:) :: x
real  ::   mean2
mean2=sum(x)/size(x)
end function mean2

pure function mean2i(x,i)
real , intent(in), dimension(:,:) :: x
integer, intent(in) :: i
real , dimension(size(x,3-i)) ::   mean2i
mean2i=sum(x,i)/size(x,i)
end function mean2i


pure function wmean1(w, x)
real , intent(in), dimension(:) :: w, x
real  ::   wmean1
wmean1=sum(x*w)		/max(.0001, sum(w))
end function wmean1

pure function wmean2(w, x)
real , intent(in), dimension(:,:) :: w, x
real  ::   wmean2
wmean2=sum(x*w)		/max(.0001, sum(w))
end function wmean2

pure function wmean3(w, x)
real , intent(in), dimension(:,:,:) :: w, x
real  ::   wmean3
wmean3=sum(x*w)		/max(.0001, sum(w))
end function wmean3

pure function wmean4(w, x)
real , intent(in), dimension(:,:,:,:) :: w, x
real  ::   wmean4
wmean4=sum(x*w)		/max(.0001, sum(w))
end function wmean4

pure function wmean5(w, x,i)
integer, intent(in) :: i
real , intent(in), dimension(:,:) :: w, x
real  ::   wmean5(size(w,3-i))
wmean5=sum(x*w,i)		/max(.0001, sum(w,i))
end function wmean5


function collapse3(x, i)
integer, intent(in) :: i
real , intent(in) :: x(:,:,:)
real , dimension(size(x,i)) :: collapse3
if (i==1) collapse3=sum(sum(x,3),2)
if (i==2) collapse3=sum(sum(x,3),1)
if (i==3) collapse3=sum(sum(x,2),1)
end function

function collapse4(x, i)
integer, intent(in) :: i
real , intent(in) :: x(:,:,:,:)
real , dimension(size(x,i)) :: collapse4
if (i==1) collapse4=sum(sum(sum(x,4),3),2)
if (i==2) collapse4=sum(sum(sum(x,4),3),1)
if (i==3) collapse4=sum(sum(sum(x,4),2),1)
if (i==4) collapse4=sum(sum(sum(x,3),2),1)
end function

pure function plus(x1, x2)
real , intent(in) :: x2(:), x1(:,:)
real , dimension(size(x1,1), size(x1,2)):: plus
plus=x1+spread(x2,2, size(x1,2))
end function plus

pure function plus2(x2, x1)
real , intent(in) :: x2(:), x1(:,:)
real , dimension(size(x1,1), size(x1,2)):: plus2
plus2=x1+spread(x2,2, size(x1,2))
end function plus2


pure function positive(x1)
real , intent(in) :: x1(:)
real , dimension(size(x1)):: positive
positive = max(0.0001, x1)
end function positive

pure function fn(x1)
real , intent(in) :: x1(:)
real , dimension(size(x1))::  fn
fn = log(x1 + sqrt(x1**2 +1))
end function fn


pure function fn2(x1)
real , intent(in) :: x1(:)
real , dimension(size(x1))::  fn2
fn2 = (exp(x1)-exp(-x1))*.5
end function fn2


end module module487

! main program

PROGRAM MAIN

USE MSIMSL
use module487
IMPLICIT NONE
INTEGER Nvar, maxfcn, ct

real  stepsize, ftol

parameter (Nvar=168)		!174


real  XGS(Nvar)
real  fx(Nvar)
real  FV2
external fcn
integer i
real  pr(51, 8)

stepsize=.05
 ftol=.00001
  maxfcn=50000

!! read initial parameters

open(1, file='pr487.txt')

do i=1,51
read(1,*) pr(i,:)
enddo; 
close(1)

ct=0

! alpha, production function, sector 1, for 1960

xgs(ct+1:ct+3)=log(pr(14,1:3))
ct=ct+3
! alpha, production function, sector 2
xgs(ct+1:ct+3)=log(pr(14,5:7))
ct=ct+3


! alpha for 1980
xgs(ct+1:ct+3)=log(pr(15,1:3)/ pr(14,1:3))
ct=ct+3
xgs(ct+1:ct+3)=log(pr(15,5:7) / pr(14,5:7))
ct=ct+3

! alpha, for 2000
xgs(ct+1:ct+3)=log(pr(16,1:3) / pr(15,1:3))
ct=ct+3
xgs(ct+1:ct+3)=log(pr(16,5:7) / pr(15, 5:7))
ct=ct+3


! sigma, elasticity, in production function
XGS(ct+1:ct+4)=log(pr(23, 1:4 ))
ct=ct+4

! type probability, type 2 3 4 
! male low education
xgs(ct+1:ct+3)= log(pr(21,2:4) )
ct=ct+3

! male high education type 2, 3, 4
xgs(ct+1:ct+3)= log(pr(21,6:8) )
ct=ct+3

! female low education type 2 3 4
xgs(ct+1:ct+3)= log(pr(22,2:4) )
ct=ct+3

! female high education type 2 3 4
xgs(ct+1:ct+3)= log(pr(22,6:8) )
ct=ct+3

! schooling consumption value for old generation
xgs(ct+1:ct+4)=log(pr(24,1:4))
ct=ct+4

!school and home constant male type 1
! skill constant is normalized to be 0
XGS(ct+1:ct+2)=log(pr(7:8, 1))
ct=ct+2

! constant for female type 1
XGS(ct+1:ct+6)=pr(1:6,2)  
xgs(ct+7:ct+8)=log(pr(7:8,2))
ct=ct+8

! skill, school, home constant for type 2 3 4
do i=3,5
XGS(ct+1:ct+6)=pr(1:6,i)  
xgs(ct+7:ct+8)=log(pr(7:8,1)) + pr(7:8,i)
ct=ct+8
enddo


! schooling coefficient in skill function
XGS(ct+1:ct+6)=log(pr(32,1:6))
ct=ct+6

! returns to x, sector 1
XGS(ct+1:ct+3)= log(pr(26,1:3))
XGS(ct+4:ct+5)=log(pr(27,2:3))
XGS(ct+6)=log(pr(28,3))
XGS(ct+7)=log(pr(26,4) /  pr(26,1))

! returns to x, sector 2
XGS(ct+8:ct+10)= log(pr(29,4:6))    
XGS(ct+11:ct+12)=log(pr(30,5:6))
XGS(ct+13)=log(pr(31,6))
XGS(ct+14)=log(pr(29,1) /  pr(29,4))

XGS(ct+15:ct+20)= log(pr(9,1:6))    !return to x^2
ct=ct+20


XGS(ct+1)=log(pr(10,3))    ! schooling cost
xgs(ct+2)=log(pr(10,4)-pr(10,3))

ct=ct+2

! male switching cost
XGS(ct+1:ct+2)=log(pr(36,2:3))		
XGS(ct+3)=log(pr(37,1))				
XGS(ct+4)=log(pr(37,3))				
XGS(ct+5:ct+6)=log(pr(38,1:2))		
XGS(ct+7)=log(pr(42,1))				
XGS(ct+8)=log(pr(36,7))				
xgs(ct+9)=log(pr(36,8))				
xgs(ct+10)=log(pr(36,4))			
ct=ct+10


XGS(ct+1:ct+2)=log(pr(39,5:6))		
XGS(ct+3)=log(pr(40,4))				
XGS(ct+4)=log(pr(40,6))				
XGS(ct+5:ct+6)=log(pr(41,4:5))		
xgs(ct+7)=log(pr(39,1))			
xgs(ct+8) = log(pr(43,1))		


ct=ct+8

! female switching cost
XGS(ct+1:ct+2)=log(pr(44,2:3))		
XGS(ct+3)=log(pr(45,1))				
XGS(ct+4)=log(pr(45,3))				
XGS(ct+5:ct+6)=log(pr(46,1:2))		
XGS(ct+7)=log(pr(50,1))				
XGS(ct+8)=log(pr(44,7))				
xgs(ct+9)=log(pr(44,8))				
xgs(ct+10)=log(pr(44,4))			
ct=ct+10


XGS(ct+1:ct+2)=log(pr(47,5:6))		
XGS(ct+3)=log(pr(48,4))				
XGS(ct+4)=log(pr(48,6))				
XGS(ct+5:ct+6)=log(pr(49,4:5))		
xgs(ct+7)=log(pr(47,1))			
xgs(ct+8) = log(pr(51,1))		


ct=ct+8

! std, standard deviation of skill shocks, schooling shocks, and home shocks
XGS(ct+1:ct+6)=log(pr(33,1:6))		! skill shocks, male and female are the same
ct=ct+6
XGS(ct+1:ct+2)=log(pr(33,7:8))		! school and home shocks for male
XGS(ct+3:ct+4)=log(pr(34,7:8))		! school and home shocks for female
ct=ct+4

XGS(ct+1:ct+2)=fn(pr(10,1:2)/1000)	! consumption value of kids
ct=ct+2

XGS(ct+1:ct+6)=log(pr(17,1:6))		! skill depreciation
ct=ct+6


XGS(ct+1:ct+2)=log(pr(12,3:4))		! retirement process
ct=ct+2


XGS(ct+1:ct+5) = fn(pr(34,2:6)/1000)	! nb, non pecuniary benefit for males
XGS(ct+6:ct+10)= fn(pr(35,2:6)/1000)	! nb, non pecuniary benefit for females
ct=ct+10

xgs(ct+1:ct+2)=log(pr(10,5:6))		! high school reentry cost
ct=ct+2

CALL umpol(Fcn, Nvar, XGS, stepsize, ftol, maxfcn, fx, FV2)	! optimization routine


end program




SUBROUTINE FCN(Nvar, fx, FV2)



use msimsl
use module487

implicit none
interface wmean
module procedure wmean1, wmean2, wmean3, wmean4, wmean5
end interface wmean
! 441.1 
interface collapse
	module procedure collapse3, collapse4
end interface collapse

interface operator(+)
	module procedure plus, plus2
end interface 

interface mean
module procedure mean1, mean2, mean2i, mean3
end interface mean


! variable declaration
INTEGER Nvar
integer nemax
INTEGER i, ia,  in,  p, u, u2,  i3, ct, ix, ik,  u3, iexp
INTEGER nn, uu, uu2, pp, age,  ip, pp0	!,n4
INTEGER n,  n3, ns, nt, ne, nk, nsc
INTEGER it, ie, is, nc, ic, ic1, ic2,age2, nx, i16, isc		
real  cp, cp2, R0, rinterval, oldFV, updt1, updt3, sn,  updt2, updt, sn3 
parameter (age=50, nn=800, pp=100, uu2=10, n=100,  n3=2400,  uu=2, nemax=102 , nsc=18, ns=6, nt=4, ne=4, nc=8, nk=2, nx=2, pp0=-40)
parameter (cp=.03, cp2=.01, R0=8.5, rinterval=5, updt1=1./6, sn=1.E-8, updt3=1, sn3=.001)

integer p1, p2, p3, p4, p5, p6, p7
parameter (p1=68, p2=79, p3=90, p4=93, p5=pp, p6=74, p7=92)

integer nz, iz, pz
parameter (nz=2, pz=40)

real Ve(n3, n,nc,nc)
real , dimension(n3, n,nc):: ve2	!, ve3
real  Re(n3,ns), Xe(n3,age, ns+1), xe4(n3,age,ns+1, nc)
real  RAND(n3, n,nc)

real   EMAX(age+1,nemax,nc,nx,nt), EMAX3(n3,nc), s3(n3,nemax) , SST, SSE	


integer se(n3,age)
integer, dimension(n3,age) :: ede, kide
integer, dimension(n3,n,nx):: kide4	!(n3,n,nx)		!, se4(n3,age,nc)

real  rkide1(n3, age), rse(n3), rkide(n3,n)	

INTEGER irx(ns+1)
real   rx(ns+1), rre(n3,ns)
real    R4(n3,n,  ns)	, z4(n3, n, nz)
real  dr4(n3,n,ns)
real , dimension(nn,age)::    logw2, RNNT, er, er10, rkid, df3
real   erp(nx)
integer x4(nn,age,ns,nc)

integer, dimension(nn,age):: kid10, pd10,  st10, s10, sex10, typ10
integer, dimension(nn,age):: kid, CD,  pd,  wkid, ST, sex, ED, typ, S

integer, dimension(p6:p7,nn,age):: cd2,  ocd2, icd2

integer, dimension(nn,age,ns)::  X, x10
integer s4(nn,age,nc)

real , dimension(nn,age,ns)::  LOGH, LOGW
real , dimension(nn,age,nc) ::  V,RNN, util
real   REQ(pp0:pp,ns,uu2+1)
real  R(pp0:pp,ns,uu) 


real   FV2, FV(25)	

integer iter
real  fx(Nvar), fx0(Nvar)	
real  Ka(pp0:pp,nz,uu), z(pp0:pp,nz, uu)

real   AS(pp0:pp, ns)
real  aka(pp0:pp,nz) , WEIGHT(pp0:pp,age)     ! cohort size(period, age)	COHORT(pp+age-1), 

real  df, c0(8,nx, nt), cs(ns), c1(ns,ns), c2(ns), std(nc,nx), c4(nc,nc,nx), c7(2),  ck(nx), df2(age,2)	!c6(ns), 
real  MPK(3,3,age,nx,ne,pp0:pp)	!, MPK2(3,3,age,nx,ne)
real  cap(pp0:pp), out(pp0:pp+1,nz)
real  ap(4,nz,pp0:pp), ces(2,2), sm(2,2), rk(nz), ka2(nz), rs(pp0:pp,ns)
real  sdr(ns,nx), sd(age+1,ns,nx), nb(ns, nx)
real  m(pp0:pp,6,2)
real  pr(51, 8)


real  acd16(17, nx, 0:1, nc)
real ,dimension(p1:p5,nx,ne,nc):: acde, smcde
real ,dimension(p1:p5,nx,nk,nc):: acdk, smcdk

real , dimension(p6:p7-1, nx, nc, nc):: pcd, smpcd
real , dimension(nx, nc, nc) :: pcd2, smpcd2
real , dimension(1:age-1, nx, 4, 4):: icd, smicd
real , dimension(1:age-1, nx, 5,5):: ocd, smocd

real  pwgt(p6:p7-1, nx, nc), iwgt(1:age-1, nx, 4), owgt(1:age-1, nx, 5)

real    SMCD16(p2:p5,age, nx, 0:1, nc)	!SMCD(p1:p4,age,nx,ne,nc),
real  SMCD162(age,nx,0:1,nc)
real  smcdt(p1:p5, age, nx,nt,nc)
real  SMWT(p1:p5,age,nx,ne)
real , dimension(p1:p5,age,nx,nc):: SMWT3, WT3
real  smwt9(p1:p5,age,nx), wt9(p1:p5,age,nx)
real , dimension(p1:p5,age,nx,ne,nk,nc)::  smwt7, wt7
real  smwt8(p2:p5, age, nx, 0:1) 


real , dimension(p1:p5,age,nx,ne,nc):: SMWT5, WT5
real , dimension(p1:p5,age,nx,0:nsc):: smwt4, wt4
real , dimension(p1:p5,age,nx,ne,ns)::  SMW, W3, smw2

real , dimension(p1:p5,age,nx):: wa, smwa
real , dimension(p1:p5,nx,ne):: we, smwe, smwe2, we2
real , dimension(p1:p5,nx,ns)::  ws, smws, smws2, ws2

real  smwi(p1:p5, nx, 2), smwi2(p1:p5, nx, 2), wi2(p1:p5, nx,2)
real  smwo(p1:p5, nx, 3), smwo2(p1:p5, nx, 3), wo2(p1:p5,nx,3)

real  akrent(pp0:pp)
real  tp(nx,nt, 2)	

integer fa1, fa2


real  cr(ns,nz+1+ns,uu)			
real  cr2(ns, nz+1+ns, 0:uu)
real  cz(nz, nz+1,uu)
real  cz2(nz, nz+1, 0:uu)
real  mat(nz,nz,0:uu)
real  rnz(n3,n,nz)
real  varz(nz,nz,uu)

real  rz(pz,nz+ns)
real  predz(pp0:pp,nz)		
real  ze(n3,nz)
real  dre(n3,ns)

real  erz(pp0:pp, nz)		
real  erze(n3,n, nz)		
real  dz(nz)
real  dr(ns)

integer year(n3)
real  ryear(n3)

integer p10

real  hr(nx)

integer sex1(nn/2), sex2(nn/2), sx(nn/2)


integer ct3, x3(nn*age*33, 4)
real  y3(nn*age*33), lw(nn,age, p1:p5)
real, dimension(ns,ns,nx)::  dlw, adlw, wdlw				! dlw(current, past, sex)
real, dimension(ns,2:age,nx)::  dlwa, adlwa, wdlwa
real, dimension(ns, 10, nx):: dlwa2, adlwa2, wdlwa2
integer ct6
integer x6(nn*age*20, 8)	! x1-x6, choice sex
real  y6(nn*age*20)				! logwage
real  cd6(ns, 0:4, ns, nx)	! conditonal choice, work experiences, occ-sector, sex
real  logw6(ns, 0:4, ns, nx)	! log wage 

real, dimension(ns,0:4,ns,nx)::  acd6, alogw6, wcd6

integer:: age3, age4
parameter (age3=14, age4=16)
integer xcum(p3:p4,nn,age3:age4, nc)
real  relxcum(p3:p4,nx, 6, 0:age4)
real  arelxcum(nx,6, 0:age4)
real  c5(-50+pp0:pp,age, nx)

real  me1, me2, me

real  lc(pp0:pp),nis(pp0:pp), cpsbea(pp0:pp)

real d1
real u3max

d1=1.
u3max=20
iter=iter+1


if (iter==1) fx0=0

! take the parameter values from the main program
ct=0

ip=60
do ix=1,2
ap(1:3,ix,ip)=exp(fx(ct+1:ct+3) )		!/ (1+exp(fx(ct+1))+exp(fx(ct+2))+exp(fx(ct+3)))
ap(4,ix,ip)=1- ap(1,ix,ip) - ap(2,ix,ip) - ap(3,ix,ip)

ct=ct+3
enddo


ip=80
do ix=1,2
ap(1:3,ix,ip)=exp(fx(ct+1:ct+3) )*ap(1:3,ix,60)		!/ (1+exp(fx(ct+1))+exp(fx(ct+2))+exp(fx(ct+3)))
ap(4,ix,ip)=1- ap(1,ix,ip) - ap(2,ix,ip) - ap(3,ix,ip)


ct=ct+3
enddo
!enddo


ip=pp
do ix=1,2
ap(1:3,ix,ip)=exp(fx(ct+1:ct+3) )*ap(1:3,ix,80)		!/ (1+exp(fx(ct+1))+exp(fx(ct+2))+exp(fx(ct+3)))
ap(4,ix,ip)=1- ap(1,ix,ip) - ap(2,ix,ip) - ap(3,ix,ip)

ct=ct+3
enddo

! 1 to 9



do ip=pp0,59
ap(:,:,ip)=ap(:,:,60)
enddo


do ip=60,80
ap(:,:,ip)=1.*(80-ip)/(80-60)*ap(:,:,60) + 1.*(ip-60)/(80-60)* ap(:,:,80)
enddo


do ip=80,pp
ap(:,:,ip)=1.*(pp-ip)/(pp-80)*ap(:,:,80) + 1.*(ip-80)/(pp-80)* ap(:,:,pp)
enddo


do ix=1,2
sm(ix,1:2)= ( exp(fx(ct+1:ct+2))-1 ) / exp(fx(ct+1:ct+2))

ct=ct+2
enddo


do is=1,2
do ix=1,2
tp(is,2:4,ix) = exp(fx(ct+1:ct+3) )	!/ (1+exp(fx(ct+1))+exp(fx(ct+2))+exp(fx(ct+3)))
tp(is,1,ix)=1-sum(tp(is,2:4,ix))

ct=ct+3
enddo
enddo


c5(0, 1, 1)=exp(fx(ct+1))
c5(40,1,1)=exp(fx(ct+2))

ct=ct+2 


c5(0, 1, 2)=exp(fx(ct+1))
c5(40,1,2)=exp(fx(ct+2))


ct=ct+2
c5(60:pp, 1, :)=1

do ip=1,40
do ix=1,nx
c5(ip,1,ix)= 1.*(40-ip)/40*c5(0,1,ix)+ 1.*ip/40*c5(40,1,ix)
enddo; enddo

do ip=pp0-50,0
do ix=1,nx
c5(ip,1,ix)=c5(0,1,ix)
enddo; enddo

do ip=40,60
do ix=1,nx
c5(ip,1,ix)= 1.*(60-ip)/20*c5(40,1,ix)+ 1.*(ip-40)/20*c5(60,1,ix)
enddo; enddo

do ix=1,nx
do ip=pp0-50+1,pp
do ia=2,age
c5(ip,ia,ix)=c5(ip-1,ia-1,ix)
enddo; enddo; enddo



c0(1:6,1,1)=0
c0(7:8,1,1)=exp(fx(ct+1:ct+2))

ct=ct+2

c0(1:6,2,1)=fx(ct+1:ct+6)
c0(7:8,2,1)=exp(fx(ct+7:ct+8))

ct=ct+8



do it=2,4
c0(1:6,1,it)= c0(1:6,1,1)+fx(ct+1:ct+6) 
c0(7:8,1,it)=exp(fx(ct+7:ct+8))
c0(1:6,2,it)= c0(1:6,2,1)+fx(ct+1:ct+6)  
c0(7:8,2,it)=c0(7:8,2,1)*c0(7:8,1,it)/c0(7:8,1,1)


ct=ct+8
enddo

cs(1:6)=exp(fx(ct+1:ct+6))  
ct=ct+6

c1=0
c1(1,1:3)=exp(fx(ct+1:ct+3)) ! return to x
c1(2,2:3)=exp(fx(ct+4:ct+5))
c1(3,3)=exp(fx(ct+6))

!c1(1:3,4:6)=c1(1:3,1:3)*fx(31)/10
c1(1:3,4:6)=c1(1:3,1:3)	*exp(fx(ct+7))



c1(4,4:6)=exp(fx(ct+8:ct+10)) ! return to x
c1(5,5:6)=exp(fx(ct+11:ct+12))
c1(6,6)=exp(fx(ct+13))

c1(4:6,1:3)=c1(4:6,4:6)	*exp(fx(ct+14))



!return to x^2
c2=exp(fx(ct+15:ct+20))
ct=ct+20


c7(1:2)=exp(fx(ct+1:ct+2))   ! schooling cost

df=.95			!fx(ct+3)/100   !df

ct=ct+2

! switching
c4=0

do ix=1,nx
c4(1,2:3,ix)=exp(fx(ct+1:ct+2))
c4(2,1,ix)=exp(fx(ct+3))
c4(2,3,ix)=exp(fx(ct+4))
c4(3,1:2,ix)=exp(fx(ct+5:ct+6))


c4(7,:,ix)=exp(fx(ct+7))
c4(7,7,ix)=0
c4(1:6,7,ix)=exp(fx(ct+8))
c4(1:6,8,ix)=exp(fx(ct+9))


c4(1:3,4:6,ix)=c4(1:3,1:3,ix)	+exp(fx(ct+10))



ct=ct+10



c4(4,5:6, ix)=exp(fx(ct+1:ct+2))
c4(5,4,ix)=exp(fx(ct+3))
c4(5,6,ix)=exp(fx(ct+4))
c4(6,4:5, ix)=exp(fx(ct+5:ct+6))
c4(4:6,1:3,ix)=c4(4:6, 4:6, ix) + exp(fx(ct+7))


c4(8,1:6,ix)= exp(fx(ct+8))
c4(8,7,ix)= c4(8,1,ix)
c4(8,8,ix)=0


ct=ct+8

enddo



! std

std(1:6,1 )=exp(fx(ct+1:ct+6))
std(1:6,2)=std(1:6,1)

ct=ct+6


do ix=1,nx
std(7:8,ix)=exp(fx(ct+1:ct+2))
ct=ct+2
enddo


!ct=ct+2


ck(1:1)=fn2(fx(ct+1:ct+1))*1000
ck(2:2)=fn2(fx(ct+2:ct+2))*1000
ct=ct+2




! skill depreciation
sdr(:,1)=exp(fx(ct+1:ct+6))
sdr(:,2)=sdr(:,1)
ct=ct+6


sd=0
do ia=26,age
sd(ia, :,:)=sd(ia-1,:,:)-sdr
enddo

do ix=1,nx
erp(ix) = exp(fx(ct+1))		! by sex only
ct=ct+1
enddo



! non pecuniary benefit; nb
! male
do ix=1,nx
nb(1,ix)=0 !-1000
nb(2:6,ix)= fn2(fx(ct+1:ct+5))*1000

ct=ct+5
enddo

!!!!!!!! high school reentry

do ix=1,nx
hr(ix)=exp(fx(ct+1))


ct=ct+1

enddo



if (iter==1) then

! read the data moments
open(1, file='ka3_475.txt')
read(1,*) aka(1:pp,:)
forall (ip=pp0:0) aka(ip,:)=aka(1,:)


open(1, file='lcapital_470.txt')
read(1,*) cap(1:pp)
cap(pp0:0)=cap(1)


open(1, file='arelxcum.txt')
do ix=1,nx
do ic=1,6
read(1,*) arelxcum(ix,ic,0:age4)
enddo
enddo

arelxcum=arelxcum/100


open(1, file='loutput_470.txt')
read(1,*) out(1:pp+1,:)

do ip=pp0,0
out(ip,:)=out(1,:)
enddo


open(1, file='wt_475.txt')			
READ(1,*) WT7      

open (1, file= 'pwgt.txt')
do ic2=1,nc
do ix=1,nx
do ip=p6,p7-1
read (1,*) pwgt(ip, ix, ic2)
enddo; enddo; enddo


open (1, file= 'iwgt.txt')
do ic2=1,4
do ix=1,nx
do ia=1,age-1
read (1,*) iwgt(ia, ix, ic2)
enddo; enddo; enddo

open (1, file= 'owgt.txt')
do ic2=1,5
do ix=1,nx
do ia=1,age-1
read (1,*) owgt(ia, ix, ic2)
enddo; enddo; enddo


open (1, file= 'pcd.txt')
do ic2=1,nc
do ix=1,nx
do ip=p6,p7-1
read (1,*) pcd(ip, ix, :, ic2)
enddo; enddo; enddo; !enddo




open (1, file= 'icd.txt')
do ic2=1,4
do ix=1,nx
do ia=1,age-1
read (1,*) icd(ia, ix, :, ic2)
enddo; enddo; enddo; !enddo


open (1, file= 'ocd.txt')
do ic2=1,5
do ix=1,nx
do ia=1,age-1
read (1,*) ocd(ia, ix, :, ic2)
enddo; enddo; enddo; !enddo

wt3=sum(sum(wt7,5),4)
wt9=sum(wt3(:,:,:,1:ns),4)
wt5=sum(wt7,5)

OPEN(1,file='acd16_2.txt' )   
READ(1,*) ACD16(1:15,:,:,:)      


open(1, file='wt4_473.txt')		
read(1,*) wt4





open(1, file='lc_473.txt')
read(1,*) lc(1:pp)
lc(pp0:0)=lc(1)

open(1, file='w3_475.txt')		
READ(1,*) W3      

do ip=p1,p5
w3(ip,:,1,:,:)=w3(ip,:,1,:,:)		+log(lc(ip))
w3(ip,:,2,:,:)=w3(ip,:,2,:,:)		+log(lc(ip))
enddo

OPEN(1,file='lws2_487.txt' )   
do ix=1,nx
READ(1,*) ws2(:,ix,:)
enddo      

ws2=ws2**2

OPEN(1,file='lwe2_487.txt' )   
do ix=1,nx
READ(1,*) we2(:,ix,:)
enddo      

we2=we2**2

OPEN(1,file='lwi2.txt' )   
do ix=1,nx
READ(1,*) wi2(:,ix,:)
enddo      

wi2=wi2**2

OPEN(1,file='lwo2.txt' )   
do ix=1,nx
READ(1,*) wo2(:,ix,:)
enddo      

wo2=wo2**2



OPEN(1,file='adlw2_472.txt' )   
do ix=1,nx
do is=1,ns
READ(1,*) adlwa(is,2:age, ix)
enddo
enddo      


OPEN(1,file='wdlw2_472.txt' )   
do ix=1,nx
do is=1,ns
READ(1,*) wdlwa(is,2:age, ix)
enddo
enddo      

do ix=1,nx; do is=1,ns; do ia=1,10
adlwa2(is,ia,ix)=sum(adlwa(is,max(2,5*ia-4):5*ia,ix)*wdlwa(is,max(2,5*ia-4):5*ia,ix))/sum(wdlwa(is,max(2,5*ia-4):5*ia,ix))
wdlwa2(is,ia,ix)=sum(wdlwa(is,max(2,5*ia-4):5*ia,ix))
enddo; enddo; enddo


OPEN(1,file='adlw_472.txt' )   
do ix=1,nx
do is=1,ns
READ(1,*) adlw(is,:, ix)
enddo
enddo      


OPEN(1,file='wdlw_472.txt' )   
do ix=1,nx
do ic=1,ns
READ(1,*) wdlw(ic, :, ix)
enddo; enddo

open(1, file='acd6_472.txt')
read(1,*) acd6

acd6=acd6/100.

open(1, file='wcd6_472.txt')
read(1,*) wcd6


open(1, file='alogw6_472.txt')
read (1,*) alogw6


alogw6= alogw6+log(sum(lc(80:93))/14.)


open(1, file='nis_473.txt')
read(1,*) nis(1:pp)

nis(pp0:0)=nis(1)

open(1, file='cpsbea_475.txt')
read(1,*) cpsbea(1:pp)

cpsbea(pp0:0)=cpsbea(1)

open(1, file='akrental_477.txt')

read (1,*) akrent(1:pp)
akrent(pp0:0)=akrent(1)

open(1, file='mpk19012000.txt')
read(1,*) mpk(:,:,:,:,1,1:pp)		! educ==1

forall (ip=pp0:0) mpk(:,:,:,:,:,ip)=mpk(:,:,:,:,:,1)

mpk(:,:,:,:,2,:)=mpk(:,:,:,:,1,:)
mpk(:,:,:,:,3,:)=mpk(:,:,:,:,1,:)
mpk(:,:,:,:,4,:)=mpk(:,:,:,:,1,:)

OPEN(1,file='mpncaesy6195sm.txt' )

do ip=61, 95; do ix=1,nx; do ie=1,ne
read(1,*) mpk(:,:,:,ix,ie,ip)
enddo; enddo; enddo;

do ip=96,pp
mpk(:,:,:,:,:,ip)=mpk(:,:,:,:,:,95)
enddo

mpk(2,:,:,:,:,:)=mpk(1,:,:,:,:,:)+mpk(2,:,:,:,:,:)



open(1, file='cohortwgt.txt')
do ip=1,pp
read(1,*) weight(ip,:)
enddo

forall (ip=pp0:0) weight(ip,:) = weight(1,:)

weight = weight/100




do p=pp0,pp

if (p<=10) then
m(p,1,1)=12; m(p,2,1)=19; m(p,3,1)=64; m(p,4,1)=79; m(p,5,1)=89; m(p,6,1)=96
m(p,1,2)=9; m(p,2,2)=16; m(p,3,2)=49; m(p,4,2)=66; m(p,5,2)=70; m(p,6,2)=82


elseif (p>10 .and. p<=20) then
m(p,1,1)=9; m(p,2,1)=16; m(p,3,1)=48; m(p,4,1)=68; m(p,5,1)=76; m(p,6,1)=85
m(p,1,2)=5; m(p,2,2)=11; m(p,3,2)=33; m(p,4,2)=54; m(p,5,2)=60; m(p,6,2)=66

elseif (p>20 .and. p<=30) then
m(p,1,1)=1; m(p,2,1)=8; m(p,3,1)=19; m(p,4,1)=48; m(p,5,1)=59; m(p,6,1)=78
m(p,1,2)=2; m(p,2,2)=7; m(p,3,2)=12; m(p,4,2)=46; m(p,5,2)=51; m(p,6,2)=56

elseif (p>30 .and. p<=40) then
m(p,1,1)=1; m(p,2,1)=4; m(p,3,1)=11; m(p,4,1)=26; m(p,5,1)=41; m(p,6,1)=64
m(p,1,2)=1; m(p,2,2)=3; m(p,3,2)=7; m(p,4,2)=18; m(p,5,2)=32; m(p,6,2)=53


elseif (p>40 .and. p<=50) then
m(p,1,1)=1; m(p,2,1)=4; m(p,3,1)=6; m(p,4,1)=22; m(p,5,1)=40; m(p,6,1)=67
m(p,1,2)=0; m(p,2,2)=2; m(p,3,2)=3; m(p,4,2)=16; m(p,5,2)=27; m(p,6,2)=55
elseif (p>50 .and. p<=60) then
m(p,1,1)=0; m(p,2,1)=2; m(p,3,1)=3; m(p,4,1)=13; m(p,5,1)=28; m(p,6,1)=55
m(p,1,2)=0; m(p,2,2)=1; m(p,3,2)=2; m(p,4,2)=8; m(p,5,2)=18; m(p,6,2)=47
elseif (p>60 .and. p<=70) then
m(p,1,1)=0; m(p,2,1)=1; m(p,3,1)=1; m(p,4,1)=5; m(p,5,1)=16; m(p,6,1)=50
m(p,1,2)=0; m(p,2,2)=0; m(p,3,2)=1; m(p,4,2)=4; m(p,5,2)=12; m(p,6,2)=45
elseif (p>70 .and. p<=80) then
m(p,1,1)=0; m(p,2,1)=0; m(p,3,1)=1; m(p,4,1)=3; m(p,5,1)=15; m(p,6,1)=55
m(p,1,2)=0; m(p,2,2)=0; m(p,3,2)=0; m(p,4,2)=2; m(p,5,2)=10; m(p,6,2)=48
elseif (p>80 .and. p<=100) then
m(p,1,1)=0; m(p,2,1)=0; m(p,3,1)=1; m(p,4,1)=3; m(p,5,1)=17; m(p,6,1)=60
m(p,1,2)=0; m(p,2,2)=0; m(p,3,2)=0; m(p,4,2)=2; m(p,5,2)=11; m(p,6,2)=48

endif

enddo	!p


oldFV=1.0E5

forall (i=1:nn/2)
sex1(i)=i
sex2(i)=i+nn/2
end forall


! initial guess for forecasting rule
cr2=0; cz2=0

close(1)



endif		!(iter==1)




!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

p10=60

df2=df
do ia=1,age
df2(ia,:)= df*((ia<45)+(ia>=45)*(1-(ia-44)*erp)/(1-(ia-45)*erp))*(ia<age)
enddo


DO u=1,uu      !!!!! updating forecasting function

CALL RNSET(1)     !!!!! they should have the same RANDom variables


EMAX=0

DO ia=age,2,(-1)      !!! backward calculation of emax function


! generate emax state variables
call rnun(n3, ryear)
ryear=ryear*100
year=floor(ryear)+1
call rnnoa(n3*n*nz, rnz)
CALL rnnoa(n3* n*8, RAND)  !!! SMulation for fu1 individual skill1 shock

forall (i3=1:n3) rse(i3)=1.*i3/n3
se(:,ia)= floor(rse*min(ia+3,11))+8   !!!!!!!!!!!!!!!!!!!!
EDe(:,ia)=1+(se(:,ia)>=12)+(se(:,ia)>=13)+(se(:,ia)>=16)

do i3=1,n3
call rnper(7, irx)
CALL rnun(7, rx)
Xe(i3,ia,irx(1))=rx(1)
Xe(i3,ia,irx(2))=rx(2)*(1-xe(i3,ia,irx(1)))
Xe(i3,ia,irx(3))=rx(3)*(1-xe(i3,ia,irx(1))-xe(i3,ia,irx(2)))
Xe(i3,ia,irx(4))=rx(4)*(1-xe(i3,ia,irx(1))-xe(i3,ia,irx(2))-xe(i3,ia,irx(3)))
Xe(i3,ia,irx(5))=1-xe(i3,ia,irx(1))-xe(i3,ia,irx(2))-xe(i3,ia,irx(3))-xe(i3,ia,irx(4))
enddo		!i3
forall (i=1:7)  Xe(:,ia, i)=Xe(:,ia, i)*min(ia-1., ia-1.+12-se(:,ia))

do ic=1,nc
xe4(:,:,:,ic) = xe
enddo

forall (is=1:ns) xe4(:,:,is,is)=xe(:,:,is)+1


call rnun(n3*age, rkide1)
kide=(rkide1>.6) + (rkide1>.9)

call rnun(n3*n, rkide)
call rnun(n3*nz, ze)
ze = .1*(ze -.5)
call rnun(n3*ns, dre)
dre = .1*(dre -.5)
forall (i3=1:n3, i=1:n) erze(i3,i,:)= matmul(mat(:,:,u-1), rnz(i3,i,:))
forall (i3=1:n3, ix=1:nx) kide4(i3,:,ix)=(rkide(i3,:)>mpk(1,kide(i3,ia-1)+1,ia,ix,ede(i3,ia), year(i3)))+(rkide(i3,:)>mpk(2,kide(i3,ia-1)+1,ia,ix,ede(i3,ia),year(i3)))
CALL rnun(n3*ns, rre)  
rre=3*rre-1.5
forall (is=1:ns) Re(:,is)=R0+ rre(:,is);
forall (iz=1:nz) Z4(:, :, iz)=cz2(iz,1,u-1) + matmul(ze,  cz2(iz,2:3,u-1)) + erze(:,:,iz); 
forall (i3=1:n3, is=1:ns) R4(i3,:,is) = re(i3,is) + cr2(is,1,u-1)+ matmul(z4(i3,:,:),cr2(is,2:3,u-1)) +sum(dre(i3,:)*cr2(is,4:9,u-1)) 
forall (i3=1:n3, is=1:ns) dr4(i3,:,is)=r4(i3,:,is)-re(i3,is)


! vectorize state variables
call sub4(s3)


! emax simulation
do it=1,nt
do ix=1,nx; 

ve=-1000000


forall (i3=1:n3, is=1:ns) ve2(i3,:,is) = EXP(r4(i3,:,is)+c0(is,ix,it)+cs(is)*se(i3,ia)+ sum(c1(is,:)* xe(i3,ia,1:6))**c2(is) +sd(ia,is,ix)  +std(is,ix)*RAND(i3,:,is)) +nb(is,ix) +df2(ia,ix)*emaxf(r4(i3,:,:), se(i3,ia), xe4(i3,ia,1:6,is) , kide4(i3,:,ix),z4(i3,:,:),dr4(i3,:,:), year(i3)+1 , ia+1, ix,it, is) 
forall (is=1:ns, ic=1:nc)  ve(:,:,is,ic) =ve2(:,:,is)  -c4(is,ic, ix) 

if (ia<=25) forall (i3=1:n3) ve2(i3,:,7) = c5(year(i3),ia,ix)*c0(7,ix,it)   -c7(1)*(se(i3,ia)>=12) -c7(2)*(se(i3,ia)>=16)+std(7,ix)*RAND(i3,:,7) 	+df2(ia,ix)*emaxf(r4(i3,:,:), min(nsc, se(i3,ia)+1), xe(i3,ia,1:6), kide4(i3,:,ix),z4(i3,:,:),dr4(i3,:,:), year(i3)+1, ia+1,ix,it, 7) 
if (ia<=25) forall (i3=1:n3, ic=1:nc)  ve(i3,:,7,ic) = ve2(i3,:,7)  -c4(7,ic,ix)*(1+hr(ix)*(se(i3,ia)<12))

forall (i3=1:n3)  ve2(i3,:,8) =    c0(8,ix,it) +  ck(ix)*kide4(i3,:,ix)+ std(8,ix)*RAND(i3,:,8) + df2(ia,ix)*emaxf(r4(i3,:,:), se(i3,ia), xe(i3,ia,1:6) , kide4(i3,:,ix), z4(i3,:,:),dr4(i3,:,:), year(i3)+1,  ia+1, ix,it, 8) 
forall (ic=1:nc)  ve(:,:,8,ic) = ve2(:,:,8) -c4(8,ic, ix) 

forall (ic=1:nc) EMAX3(:,ic)= log(max(1., mean(maxval(VE(:,:,:,ic),3),2)))



do ic=1,nc;

if (ic==7 .and. ia>26) cycle
 
CALL rlse(n3, EMAX3(:,ic), nemax-1,    s3(:,2:nemax) ,      n3 , 1 ,emax(ia,:,ic,ix,it), SST, SSE)
! emax() carries the emax apporoximation coefficients

enddo ! ic


enddo;	!ix
enddo; !it


ENDDO   !!! ia
! end of emax approximation


! beginning of model simulation


! initialize the state variables
S=8; 

do ix=1,nx
S(1+ (ix-1)*nn/2                  :nn/200*m(1,1,ix) + (ix-1)*nn/2,:)=0
S(nn/200*m(1,1,ix)+1 + (ix-1)*nn/2:nn/200*m(1,2,ix) + (ix-1)*nn/2,:)=2
S(nn/200*m(1,2,ix)+1 + (ix-1)*nn/2:nn/200*m(1,3,ix) + (ix-1)*nn/2,:)=4
S(nn/200*m(1,3,ix)+1 + (ix-1)*nn/2:nn/200*m(1,4,ix) + (ix-1)*nn/2,:)=6
S(nn/200*m(1,4,ix)+1 + (ix-1)*nn/2:nn/200*m(1,5,ix) + (ix-1)*nn/2,:)=8
S(nn/200*m(1,5,ix)+1 + (ix-1)*nn/2:nn/200*m(1,6,ix) + (ix-1)*nn/2,:)=9
S(nn/200*m(1,6,ix)+1 + (ix-1)*nn/2:nn/200*100 + (ix-1)*nn/2,1)=10
enddo


x=0 ; 

V=0; cd=8; pd=8; kid=0; wkid=1		!; cd2=0

sex(sex1,:)=1
sex(sex2,:)=2
ST=(S>9)


!sex=T(:,:,1)+1

call rnset(1)

CALL rnun(nn*age*1, RNNT)   


do ix=1,nx
sx=(ix==1)*sex1+(ix==2)*sex2
do ia=1,age;
Typ(sx,ia)=												&
 1											  *(RNNT(sx, ia)<=sum(tp(ix,1:1,st(sx,ia)+1),1))		&
+2*(RNNT(sx,ia)>sum(tp(ix,1:1,st(sx,ia)+1),1))*(RNNT(sx, ia)<=sum(tp(ix,1:2,st(sx,ia)+1),1))	&
+3*(RNNT(sx,ia)>sum(tp(ix,1:2,st(sx,ia)+1),1))*(RNNT(sx, ia)<=sum(tp(ix,1:3,st(sx,ia)+1),1))		&
+4*(RNNT(sx,ia)>sum(tp(ix,1:3,st(sx,ia)+1),1))
enddo; enddo


CALL rnun(nn*age, er)   


if (u>1) r(:,:,u)=r(:,:,u-1)
if (u>1) z(:,:,u)=z(:,:,u-1)



! indivual optimization + equilibrium skill prices and capital stock begins
DO p=pp0*(u==1)+p10*(u>1),pp*(uu>1)+p5*(uu==1)

call rnset(p)

if (iter==1) print*, u, p


if (u>1 .and. p==p10) then
s=s10; x=x10; sex=sex10; typ=typ10; pd=pd10; kid=kid10; st=st10; er=er10
endif


do ix=1,nx
S(1+ (ix-1)*nn/2                  :nn/200*m(p,1,ix) + (ix-1)*nn/2,1)=0
S(nn/200*m(p,1,ix)+1 + (ix-1)*nn/2:nn/200*m(p,2,ix) + (ix-1)*nn/2,1)=2
S(nn/200*m(p,2,ix)+1 + (ix-1)*nn/2:nn/200*m(p,3,ix) + (ix-1)*nn/2,1)=4
S(nn/200*m(p,3,ix)+1 + (ix-1)*nn/2:nn/200*m(p,4,ix) + (ix-1)*nn/2,1)=6
S(nn/200*m(p,4,ix)+1 + (ix-1)*nn/2:nn/200*m(p,5,ix) + (ix-1)*nn/2,1)=8
S(nn/200*m(p,5,ix)+1 + (ix-1)*nn/2:nn/200*m(p,6,ix) + (ix-1)*nn/2,1)=9
S(nn/200*m(p,6,ix)+1 + (ix-1)*nn/2:nn/200*100 + (ix-1)*nn/2,1)=10
enddo


ED=1+(s>=12)+(s>=13)+(s>=16)


! age 16 new cohort initialization every period
pd(:,1)=7*(S(:,1)>=9)+8*(S(:,1)<9)
X(:,1,:)=0
kid(:,1)=0
wkid=(kid>0)+1
sex(sex1,1)=1
sex(sex2,1)=2
ST(:,1)=(S(:,1)>9)
CALL rnun(nn, RNNT(:,1))   
do ix=1,nx
 sx=(ix==1)*sex1+(ix==2)*sex2
Typ(sx,1)=												&
 1										  *(RNNT(sx, 1)<=sum(tp(ix,1:1,st(sx,1)+1),1))		&
+2*(RNNT(sx,1)>sum(tp(ix,1:1,st(sx,1)+1),1))*(RNNT(sx, 1)<=sum(tp(ix,1:2,st(sx,1)+1),1))	&
+3*(RNNT(sx,1)>sum(tp(ix,1:2,st(sx,1)+1),1))*(RNNT(sx, 1)<=sum(tp(ix,1:3,st(sx,1)+1),1))		&
+4*(RNNT(sx,1)>sum(tp(ix,1:3,st(sx,1)+1),1))
enddo



if (uu>1 .and. u==1 .and. p==p10) then
s10 = s
x10 = x
sex10=sex
typ10=typ
pd10=pd
kid10=kid
st10=st
er10=er
endif


! shocks to skill and home and school value
CALL rnnoa(nn*age*8, RNN)   
do ix=1,nx
 sx=(ix==1)*sex1+(ix==2)*sex2
forall (ic=1:nc) rnn(sx,:,ic)=std(ic,ix)*rnn(sx,:,ic)
enddo


! guess for equilibrium skill prices
if (p==pp0 .and. u==1) R(1,:,u)= R0	
IF (p>pp0)  then 
if (u==1) then
 r(p,:,u)=r(p-1,:,u)
else
r(p,:,u)=r(p-1,:,u) + r(p,:,u-1)-r(p-1,:,u-1)
  endif
endif


forall (ic=1:nc) x4(:, :,:,ic)=x	!(:,:,is)		!**c2
forall (is=1:ns) x4(:, :,is,is)=(x(:,:,is)+1)		!**c2
forall (ic=1:nc) s4(:,:,ic)=s
s4(:,:,7)=min(nsc, s+1)

! log wage calculation
forall (ia=1:age, is=1:ns) LOGH(sex1,ia,is)=c0(is,1, typ(sex1,ia))+cs(is)*S(sex1,ia)+matmul(X(sex1,ia,:), c1(is,:))**c2(is)+sd(ia,is,1) +RNN(sex1,ia,is)
forall (ia=1:age, is=1:ns) LOGH(sex2,ia,is)=c0(is,2, typ(sex2,ia))+cs(is)*S(sex2,ia)+matmul(X(sex2,ia,:), c1(is,:))**c2(is)+sd(ia,is,2) +RNN(sex2,ia,is)



REQ(p,:,1)=R(p,:,u)

! guess for equilibrium capital stock 
if (p==pp0 .and. u==1) then
ka(p,:,u)=aka(p,:)	
elseif (p>pp0 .and. u==1) then
ka(p,:,u)=ka(p-1,:,u) + aka(p,:)-aka(p-1,:)
else
ka(p,:,u)= ka(p-1,:,u) + ka(p,:,u-1) - ka(p-1,:,u-1)
endif


! choice specific utility calculation
do ix=1,nx
sx= (ix==1)*sex1 + (ix==2)*sex2
forall (ia=1:age) util(sx,ia,8)=RNN(sx,ia,8)+c0(8,ix, typ(sx,ia))+ ck(ix)*kid(sx,ia) -c4(8, pd(sx,ia), ix) 
forall (ia=1:25) util(sx,ia,7)=-c7(1)*(S(sx,ia)>=12)-c7(2)*(S(sx,ia)>=16)+RNN(sx,ia,7)+ c5(p,ia,ix)*c0(7,ix, typ(sx,ia))-c4(7, pd(sx,ia), ix)*(1+hr(ix)*(S(sx,ia)<12))
forall (ia=1:age) df3(sx,ia)=df2(ia,ix)
enddo

V=-1000000

! iteration routine for equilibrium skill prices
do u2=1,(p<=pp0+1)*uu2 + (p<59 .and. p>pp0)*2+(p>=59)*uu2

if (u2==1 .and. p>pp0 .and. u==1) z(p,:,u)=z(p-1,:,u)
if (u2==1 .and. u>1) z(p,:,u)=z(p-1,:,u)+ z(p,:,u-1)-z(p-1,:,u-1)

if (p>pp0) DZ=Z(p,:,u)-Z(p-1,:,u)
if (p==pp0) DZ=0

if (p>pp0) DR=R(p,:,u)-R(p-1,:,u)
if (p==pp0) DR=0

! individual choice and wages and retirement
forall (is=1:ns) LOGW(:,:,is)=R(p,is,u)+LOGH(:,:,is); 
forall (ia=1:age, is=1:ns) util(sex1,ia,is)=EXP(LOGW(sex1,ia,is))-c4(is, pd(sex1,ia), 1) +nb(is,1)
forall (ia=1:age, is=1:ns) util(sex2,ia,is)=EXP(LOGW(sex2,ia,is))-c4(is, pd(sex2,ia), 2) +nb(is,2)
forall (ia=1:age, is=1:ns)	V(:,ia,is)=df3(:,ia)*emaxf2(s(:,ia), x4(:,ia,:,is), kid(:,ia),p+1, ia+1, sex(:,ia), typ(:,ia), is)+util(:,ia,is)
forall (ia=1:25)			V(:,ia,7) =df3(:,ia)*emaxf2(s4(:,ia,7), x(:,ia,:), kid(:,ia),p+1, ia+1, sex(:,ia), typ(:,ia), 7)+util(:,ia,7)
forall (ia=1:age)			V(:,ia,8) =df3(:,ia)*emaxf2(s(:,ia), x(:,ia,:), kid(:,ia),p+1, ia+1, sex(:,ia), typ(:,ia), 8)+util(:,ia,8)
CD=(maxloc(V,3))
do ia=46,age
where (er(:,ia)<=erp(sex(:,ia))*(ia-45)) cd(:,ia)= 8
enddo

forall (is=1:ns) AS(p, is)=LOG(max(sn, sum(WEIGHT(p,:)/nn*SUM(exp(LOGH(:,:,is))*(CD==is),1))));		!enddo

if (u2==1) updt=updt1
if (p==pp0) updt=updt1/10.
if (u2>=3) then
IF (sum((REQ(p,:,u2)-REQ(p,:,u2-1))*(REQ(p,:,u2-1)-REQ(p,:,u2-2)))<0 ) then
updt=updt/2.
endif
endif

! iterative routine for equilibrium capital stock along with z process
do u3=1,20*(p==pp0)+u3max*(p<59 .and. p>pp0)+20*(p>=59)

do i=1,2
ces(1,i)=1/sm(1,i)*log(ap(1,i,p)/(1-ap(2,i,p)-ap(3,i,p))*exp(AS(p, 3*i-2))**sm(1,i)+ap(4,i,p)/(1-ap(2,i,p)-ap(3,i,p))*exp(ka(p,i,u))**sm(1,i))
ces(2,i)=1/sm(2,i)* log(ap(2,i,p)*exp(AS(p, 3*i-1))**sm(2,i)+ap(3,i,p)*exp(AS(p,3*i))**sm(2,i) +(1-ap(2,i,p)-ap(3,i,p))*exp(ces(1,i))**sm(2,i))
enddo

z(p,:,u)=out(p,:)-ces(2,:)

rk=out(p,:)-sm(2,:)*ces(2,:)+ (sm(2,:)-sm(1,:))*ces(1,:)+(sm(1,:)-1)*ka(p,:,u)+log(ap(4,:,p)) + log(nis(p))

ka2 =(out(p,:)-sm(2,:)*ces(2,:)+ (sm(2,:)-sm(1,:))*ces(1,:)+log(ap(4,:,p)) -log(akrent(p)/nis(p)) ) / (1- sm(1,:))


updt2=.2

ka(p,:,u)= (1-updt2)* ka(p,:,u) + updt2*ka2

if (iter==1) write(3,'(3i5, 500f15.5)') p, u2, u3, ka(p,:,u), ka2

if (maxval(abs(ka(p,:,u)-ka2))/updt2<cp2) exit
enddo !u3
! end of equilibrium capital stock calculation



forall (i=1:2) r(p,3*i-2,u) = out(p,i) - sm(2,i)*ces(2,i)  + (sm(1,i)-1)*AS(p, 3*i-2) + log(ap(1,i,p)) + (sm(2,i)-sm(1,i))*ces(1,i) +log(nis(p))+log(cpsbea(p))
forall (i=1:2) r(p,3*i-1:3*i,u) = out(p,i) - sm(2,i)*ces(2,i)  + (sm(2,i)-1)*AS(p, 3*i-1:3*i)+ log(ap(2:3,i,p)) +log(nis(p))+log(cpsbea(p))

rs(p,:) = r(p,:,u)
r(p,:,u) = updt * r(p,:,u) + (1-updt)* REQ(p,:,u2)


do is=1,ns
R(p,is,u)=max(R(p,is,u), R0-rinterval)
R(p,is,u)=min(R(p,is,u), R0+rinterval)
REQ(p,is,u2+1:uu2+1)=R(p,is,u); 
enddo

IF (maxval(abs(REQ(p,:,u2+1)-REQ(p,:,u2)))/updt<cp ) exit
ENDDO              !!! u2  






if (u==uu .and. p>=p6 .and. p<=p7) cd2(p,:,:)=cd
if (u==uu .and. p>=p6 .and. p<=p7) ocd2(p,:,:)=1*(cd==1 .or. cd==4) + 2*(cd==2 .or. cd==5) + 3*(cd==3 .or. cd==6) + 4* (cd==7) + 5*(cd==8)
if (u==uu .and. p>=p6 .and. p<=p7) icd2(p,:,:)=1*(cd==1 .or. cd==2 .or. cd==3) + 2*(cd==4 .or. cd==5 .or. cd==6) + 3* (cd==7) + 4*(cd==8)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

logw2=0
do is=1,ns
Logw2=Logw2+(cd==is)*logw(:,:,is)
enddo

! simulated moment

if (p>=p1 .and. p<=p5 .and. u==uu) then

forall (ic=1:nc, ik=1:nk, ie=1:ne, ix=1:nx) SMWT7(p,:,ix,ie,ik,ic) = sum(1.*(ED==ie)*(sex==ix)*(wkid==ik)*(cd==ic),1)/(nn/2)
SMWT3(p,:,:,:)= sum(sum(smwt7(p,:,:,:,:,:),4),3)
smwt9(p,:,:)=sum(smwt3(p,:,:,1:ns),3)
SMWT5(p,:,:,:,:) = sum(smwt7(P,:,:,:,:,:),4)
smwt(p,:,:,:)=sum(smwt5(p,:,:,:,:),4)

forall (isc=1:nsc, ix=1:nx) SMWT4(p,:,ix,isc) = sum(1.*(S==isc)*(sex==ix),1)/(nn/2)


forall (is=1:ns, ie=1:ne, ix=1:nx, ia=1:age) &
SMW(p,ia,ix,ie,is) = wmean(d1*(sex(:,ia)==ix)*(ed(:,ia)==ie)*(cd(:,ia)==is), LOGW2(:,ia))
forall (is=1:ns, ie=1:ne, ix=1:nx, ia=1:age) &
SMW2(p,ia,ix,ie,is) = wmean(d1*(sex(:,ia)==ix)*(ed(:,ia)==ie)*(cd(:,ia)==is), LOGW2(:,ia)**2)


forall (ic=1:nc, it=1:nt, ix=1:nx) &
SMCDt(p,:,ix,it,ic)= wmean(d1*(typ==it)*(sex==ix), d1*(cd==ic),1)		!/max(sum(1.*(typ==it)*(sex==ix),1), sn)

endif



if (p>=p1 .and. p<=p5 .and. u==uu) then			! for d.lw
if (p==p1) ct3=0


lw(:,:,p)=logw2


if (p>=p1+1) then
do ia=2,age; 
do in=1,nn
if (cd(in,ia)<=6 .and. pd(in, ia)<=6) then
ct3=ct3+1
x3(ct3,1)=pd(in,ia)
x3(ct3,2)=cd(in,ia)
x3(ct3,3)=ia
x3(ct3,4)=sex(in,ia)
y3(ct3)=lw(in,ia,p)-lw(in,ia-1,p-1)
endif		
enddo
enddo
endif		


endif   





if (p>=p2 .and. p<=p4 .and. u==uu) then			! for d.lw


if (p==79) ct6=0
age2=20
do ia=1,age2; 

if (p==80 .and. ia==3 .or.	&
p==81	.and. ia>=3 .and. ia<=4 .or. &
p==82 .and. ia>=3 .and. ia<=5 .or. &
p==83 .and. ia>=3 .and. ia<=6 .or. &
p==84 .and. ia>=4 .and. ia<=7 .or. &
p==85 .and. ia>=5 .and. ia<=8 .or. &
p==86 .and. ia>=6 .and. ia<=9 .or. &
p==87 .and. ia>=7 .and. ia<=10 .or. &
p==88 .and. ia>=8 .and. ia<=11 .or. &
p==89 .and. ia>=9 .and. ia<=12 .or. &
p==90 .and. ia>=10 .and. ia<=13 .or. &
p==91 .and. ia>=11 .and. ia<=14 .or. &
p==92 .and. ia>=12 .and. ia<=15 .or. &
p==93 .and. ia>=13 .and. ia<=16 ) then

do in=1,nn

if (cd(in,ia)<=6) then
ct6=ct6+1

do is=1,ns; x6(ct6, is)=x(in,ia,is); enddo
x6(ct6, 7) = cd(in,ia)
x6(ct6, 8)= sex(in,ia)
y6(ct6)= logw2(in,ia)

endif 

enddo ! in



endif

enddo


endif   



if (p>=p2 .and. p<=p5 .and. u==uu) then			! for d.lw

do ix=1,nx; do i16=0,1
smwt8(p,:, ix, i16) = sum(1.*(sex==ix)*(ST==i16),1)/(nn/2)
enddo; enddo

forall (ic=1:nc, i16=0:1, ix=1:nx) SMCD16(p,:,ix,i16,ic)= wmean(d1*(sex==ix)*(ST==i16), d1*(cd==ic),1)	!/max(sum(1.*(sex==ix)*(ST==i16),1), sn)

endif 



! next period's state variable update
pd(:,2:age)=cd(:,1:age-1)
S(:,2:age)=S(:,1:age-1)+(CD(:,1:age-1)==7)
sex(:,2:age)=sex(:,1:age-1)
typ(:,2:age)=typ(:,1:age-1)
ST(:,2:age)=ST(:,1:age-1)
do is=1,ns
X(:,2:age,is)=X(:,1:age-1,is)+(CD(:,1:age-1)==is)
enddo;
call rnun(nn*age, rkid)
forall (ia=age:2:-1, in=1:nn) kid(in,ia)=(rkid(in,ia)>mpk(1,kid(in,ia-1)+1,ia,sex(in,ia),ed(in,ia),p))+(rkid(in,ia)>mpk(2,kid(in,ia-1)+1,ia,sex(in,ia),ed(in,ia), p))
er(:,2:age)=er(:,1:age-1)
call rnun(nn, er(:,1) )


ENDDO          !!!!!!!!!!!!!!!!!!!!!!!!!!!! end p  

! estimate the expectant consistent forecasting rule
if (uu>1) then

rz(:,1:2) = z(61:pp,:,u) - z(60:pp-1, :,u)
rz(:,3:8) = r(60:pp-1,:,u) - r(59:pp-2, :,u)

do is=1,ns
call rlse (pz, r(61:pp, is, u)-r(60:pp-1,is,u), nz+ns, rz, pz, 1, cr(is,:,u), SST, SSE)
enddo

do iz=1,nz
call rlse (pz, z(61:pp,iz,u) - z(60:pp-1,iz,u) , nz, z(60:pp-1,:,u)-z(59:pp-2,:,u), pz, 1, cz(iz,:,u), SST, SSE)
enddo

forall (iz=1:nz) predz(3:pp,iz) = cz(iz,1,u) + matmul(z(2:pp-1,:,u) - z(1:pp-2,:,u) , cz(iz,2:3,u)) 

erz=0
erz(3:pp,:) = z(3:pp,:,u)- z(2:pp-1,:,u) - predz(3:pp,:) 


forall (iz=1:nz) varz(iz,iz,u)= mean(erz(61:pp,iz)**2)-(mean(erz(61:pp,iz)))**2
varz(1,2,u)=mean(erz(61:pp,1)*erz(61:pp,2))-mean(erz(61:pp,1))*mean(erz(61:pp,2))
varz(2,1,u)=varz(1,2,u)

! make variance covariance matrix for z process
mat(1,1,u)=sqrt(varz(1,1,u)-varz(1,2,u)**2/varz(2,2,u))
mat(1,2,u)=varz(1,2,u)/sqrt(varz(2,2,u))
mat(2,1,u)=0
mat(2,2,u)=sqrt(varz(2,2,u))


cr2(:,:,u)= (1-updt3)* cr2(:,:,u-1) + updt3* cr(:,:,u)
cz2(:,:,u)= (1-updt3)* cz2(:,:,u-1) + updt3* cz(:,:,u)

endif !(uu>1)


ENDDO              !!! end u







! simulated moments
age2=50

do ip=p6,p7-1
do ix=1,nx
sx=(ix==1)*sex1+(ix==2)*sex2
do ic1=1,nc
do ic2=1,nc
smpcd(ip, ix, ic1, ic2) = sum( matmul(1.*(cd2(ip,sx,1:age-1)==ic2)*(cd2(ip+1, sx,2:age)==ic1), weight(ip,1:age-1) ) )/ &
 max(.0001, sum( matmul(1.*(cd2(ip,sx,1:age-1)==ic2), weight(ip,1:age-1) ) ))


enddo; enddo; enddo; enddo


do ic2=1,nc
do ix=1,nx
if (iter==1) pcd2(ix,:,ic2)=(sum(pcd(p6:74, ix, :, ic2),1) + sum(pcd(76:83,ix,:,ic2),1) + sum(pcd(85:p7-1,ix,:,ic2),1)) / (p7-p6-2)
smpcd2(ix,:,ic2)=(sum(smpcd(p6:74, ix, :, ic2),1)+ sum(smpcd(76:83,ix,:,ic2),1) + sum(smpcd(85:p7-1,ix,:,ic2),1)) / (p7-p6-2)
enddo
enddo


do ia=1,age-1
do ix=1,nx
sx=(ix==1)*sex1+(ix==2)*sex2
do ic1=1,5
do ic2=1,5
smocd(ia, ix, ic1, ic2) = sum( matmul(weight(p6:p7-1,ia), 1.*(ocd2(p6:p7-1,sx,ia)==ic2)*(ocd2(p6+1:p7, sx,ia+1)==ic1) ) )/ &
 max(.0001, sum( matmul(weight(p6:p7-1,ia), 1.*(ocd2(p6:p7-1,sx,ia)==ic2) ) ))



enddo; enddo; enddo; enddo


do ia=1,age-1
do ix=1,nx
sx=(ix==1)*sex1+(ix==2)*sex2
do ic1=1,4
do ic2=1,4
smicd(ia, ix, ic1, ic2) = sum( matmul(weight(p6:p7-1,ia), 1.*(icd2(p6:p7-1,sx,ia)==ic2)*(icd2(p6+1:p7, sx,ia+1)==ic1) ) )/ &
 max(.0001, sum( matmul(weight(p6:p7-1,ia), 1.*(icd2(p6:p7-1,sx,ia)==ic2) ) ))
enddo; enddo; enddo; enddo


fa1=1
fa2=50
do ip=p1,p5; do ix=1,nx; do ie=1,ne; do ic=1,nc
if (iter==1) acde(ip,ix,ie,ic)=sum(weight(ip,:)*wt5(ip,fa1:fa2,ix,ie,ic))/sum(matmul(weight(ip,:),wt5(ip,fa1:fa2,ix,ie,:)))
smcde(ip,ix,ie,ic)=sum(weight(ip,:)*smwt5(ip,fa1:fa2,ix,ie,ic))/sum(matmul(weight(ip,:),smwt5(ip,fa1:fa2,ix,ie,:)))
enddo; enddo; enddo; enddo



fa1=6
fa2=25

do ip=p1,p5; do ix=1,nx; do ik=1,nk; do ic=1,nc
if (iter==1) acdk(ip,ix,ik,ic)=sum(wt7(ip,fa1:fa2,ix,:,ik,ic)) /sum(wt7(ip,fa1:fa2,ix,:,ik,:))
smcdk(ip,ix,ik,ic)=sum(smwt7(ip,fa1:fa2,ix,:,ik,ic))/sum(smwt7(ip,fa1:fa2,ix,:,ik,:))
enddo; enddo; enddo; enddo


age2=15

do i16=0,1; do ix=1,2; do ia=1,age2;  do ic=1,nc; 
SMCD162(ia,ix,i16,ic) = mean(SMCD16(max(p2,ia+73):min(p4,ia+80),ia,ix,i16,ic))	!/(min(p4,ia+80)-max(p2,ia+73)+1)
enddo; enddo; enddo; enddo; 


do ip=p1,p5; do ia=1,age; do ix=1,nx
if (iter==1) wa(ip,ia,ix)= wmean(wt5(ip,ia,ix,:,1:ns),w3(ip,ia,ix,:,:))
if (sum(smwt5(ip,ia,ix,:,1:ns))>.001) smwa(ip,ia,ix)=wmean(smwt5(ip,ia,ix,:,1:ns),smw(ip,ia,ix,:,:))
if (sum(smwt5(ip,ia,ix,:,1:ns))<=.001) smwa(ip,ia,ix)=wmean(smwt5(ip,:,ix,:,1:ns),smw(ip,:,ix,:,:))
enddo; enddo; enddo

do ip=p1,p5; do ix=1,nx; do ie=1,ne

if (iter==1) we(ip,ix,ie)=0
smwe(ip,ix,ie)=0
smwe2(ip,ix,ie)=0



do ia=1,age
if (iter==1) we(ip,ix,ie)=we(ip,ix,ie) + weight(ip,ia)*sum(wt5(ip,ia,ix,ie,1:ns)*w3(ip,ia,ix,ie,:)) / sum(weight(ip,:)*sum(wt5(ip,:,ix,ie,1:ns),2))
if (sum(smwt5(ip,:,ix,ie,1:ns))>.001) smwe(ip,ix,ie)=smwe(ip,ix,ie)+weight(ip,ia)*sum(smwt5(ip,ia,ix,ie,1:ns)*smw(ip,ia,ix,ie,:)) / max(.001, sum(weight(ip,:)*sum(smwt5(ip,:,ix,ie,1:ns),2)))
if (sum(smwt5(ip,:,ix,ie,1:ns))>.001) smwe2(ip,ix,ie)=smwe2(ip,ix,ie)+weight(ip,ia)*sum(smwt5(ip,ia,ix,ie,1:ns)*smw2(ip,ia,ix,ie,:)) / max(.001, sum(weight(ip,:)*sum(smwt5(ip,:,ix,ie,1:ns),2)))
if (sum(smwt5(ip,:,ix,ie,1:ns))<=.001) smwe(ip,ix,ie)=smwe(ip,ix,ie)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1:ns)*smw(ip,ia,ix,:,:)) / max(.001, sum(weight(ip,:)*sum(sum(smwt5(ip,:,ix,:,1:ns),3),2)))
if (sum(smwt5(ip,:,ix,ie,1:ns))<=.001) smwe2(ip,ix,ie)=smwe2(ip,ix,ie)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1:ns)*smw2(ip,ia,ix,:,:)) / max(.001, sum(weight(ip,:)*sum(sum(smwt5(ip,:,ix,:,1:ns),3),2)))
enddo

enddo; enddo; enddo


fa1=1; fa2=50

do ip=p1,p5; do ix=1,nx; do is=1,ns
if (iter==1) ws(ip,ix,is)=0
smws(ip,ix,is)=0
smws2(ip,ix,is)=0

do ia=1,age
if (iter==1) ws(ip,ix,is)=ws(ip,ix,is) + weight(ip,ia)*sum(wt5(ip,ia,ix,:,is)*w3(ip,ia,ix,:,is)) / sum(weight(ip,:)*wt3(ip,:,ix,is))
if (sum(smwt3(ip,:,ix,is))>.001) smws(ip,ix,is)=smws(ip,ix,is)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,is)*smw(ip,ia,ix,:,is)) / max(.001, sum(weight(ip,:)*smwt3(ip,:,ix,is)))
if (sum(smwt3(ip,:,ix,is))>.001) smws2(ip,ix,is)=smws2(ip,ix,is)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,is)*smw2(ip,ia,ix,:,is)) / max(.001, sum(weight(ip,:)*smwt3(ip,:,ix,is)))
if (sum(smwt3(ip,:,ix,is))<=.001) smws(ip,ix,is)=smws(ip,ix,is)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1:ns)*smw(ip,ia,ix,:,1:ns)) / max(.001, sum(weight(ip,:)*sum(smwt3(ip,:,ix,1:ns),2)))
if (sum(smwt3(ip,:,ix,is))<=.001) smws2(ip,ix,is)=smws2(ip,ix,is)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1:ns)*smw2(ip,ia,ix,:,1:ns)) / max(.001, sum(weight(ip,:)*sum(smwt3(ip,:,ix,1:ns),2)))

enddo

enddo; enddo; enddo



do ip=p1,p5; do ix=1,nx; 
smwi(ip,ix,1:2)=0
smwi2(ip,ix,1:2)=0

smwo(ip,ix,1:3)=0
smwo2(ip,ix,1:3)=0

do ia=1,age

smwi(ip,ix,1)=smwi(ip,ix,1)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1:3)*smw(ip,ia,ix,:,1:3)) / sum(weight(ip,:)*sum(smwt3(ip,:,ix,1:3),2))
smwi(ip,ix,2)=smwi(ip,ix,2)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,4:6)*smw(ip,ia,ix,:,4:6)) / sum(weight(ip,:)*sum(smwt3(ip,:,ix,4:6),2))

smwi2(ip,ix,1)=smwi2(ip,ix,1)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1:3)*smw2(ip,ia,ix,:,1:3)) / sum(weight(ip,:)*sum(smwt3(ip,:,ix,1:3),2))
smwi2(ip,ix,2)=smwi2(ip,ix,2)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,4:6)*smw2(ip,ia,ix,:,4:6)) / sum(weight(ip,:)*sum(smwt3(ip,:,ix,4:6),2))


smwo(ip,ix,1)=smwo(ip,ix,1)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1)*smw(ip,ia,ix,:,1)+smwt5(ip,ia,ix,:,4)*smw(ip,ia,ix,:,4)) / sum(weight(ip,:)*(smwt3(ip,:,ix,1)+smwt3(ip,:,ix,4)))
smwo(ip,ix,2)=smwo(ip,ix,2)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,2)*smw(ip,ia,ix,:,2)+smwt5(ip,ia,ix,:,5)*smw(ip,ia,ix,:,5)) / sum(weight(ip,:)*(smwt3(ip,:,ix,2)+smwt3(ip,:,ix,5)))
smwo(ip,ix,3)=smwo(ip,ix,3)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,3)*smw(ip,ia,ix,:,3)+smwt5(ip,ia,ix,:,6)*smw(ip,ia,ix,:,6)) / sum(weight(ip,:)*(smwt3(ip,:,ix,3)+smwt3(ip,:,ix,6)))


smwo2(ip,ix,1)=smwo2(ip,ix,1)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,1)*smw2(ip,ia,ix,:,1)+smwt5(ip,ia,ix,:,4)*smw2(ip,ia,ix,:,4)) / sum(weight(ip,:)*(smwt3(ip,:,ix,1)+smwt3(ip,:,ix,4)))
smwo2(ip,ix,2)=smwo2(ip,ix,2)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,2)*smw2(ip,ia,ix,:,2)+smwt5(ip,ia,ix,:,5)*smw2(ip,ia,ix,:,5)) / sum(weight(ip,:)*(smwt3(ip,:,ix,2)+smwt3(ip,:,ix,5)))
smwo2(ip,ix,3)=smwo2(ip,ix,3)+weight(ip,ia)*sum(smwt5(ip,ia,ix,:,3)*smw2(ip,ia,ix,:,3)+smwt5(ip,ia,ix,:,6)*smw2(ip,ia,ix,:,6)) / sum(weight(ip,:)*(smwt3(ip,:,ix,3)+smwt3(ip,:,ix,6)))



enddo; 
enddo; enddo; 


do ip=p3,p4
do ic=1,nc
do ia=age3,age4
xcum(ip,:,ia,ic)=0
do i=1,ia-1
xcum(ip,:,ia,ic) =xcum(ip,:,ia,ic)+ 1*(cd2(ip-ia+i, :, i)==ic)
enddo; enddo; enddo; enddo

do ix=1,nx
sx=(ix==1)*sex1 + (ix==2)*sex2
do ip=p3,p4
do in=0, age4
relxcum(ip,ix, 1,in)= sum(1.*(sum(xcum(ip,sx,age3:age4,1:3),2)==in))/(.5*nn*(age4-age3+1))
relxcum(ip,ix, 2,in)= sum(1.*(sum(xcum(ip,sx,age3:age4,4:6),2)==in))/(.5*nn*(age4-age3+1))
relxcum(ip,ix, 3,in)= sum(1.*(xcum(ip,sx,age3:age4,1)+xcum(ip,sx,age3:age4,4)==in))/(.5*nn*(age4-age3+1))
relxcum(ip,ix, 4,in)= sum(1.*(xcum(ip,sx,age3:age4,2)+xcum(ip,sx,age3:age4,5)==in))/(.5*nn*(age4-age3+1))
relxcum(ip,ix, 5,in)= sum(1.*(xcum(ip,sx,age3:age4,3)+xcum(ip,sx,age3:age4,6)==in))/(.5*nn*(age4-age3+1))
relxcum(ip,ix, 6,in)= sum(1.*(xcum(ip,sx,age3:age4,8)==in))/(.5*nn*(age4-age3+1))


enddo; enddo; enddo; !enddo


me1=0
me2=0

do ip=p1,p5; do ix=1,nx; 

do ie=1,ne
me1=me1+ sum(weight(ip,:)*sum(wt5(ip,:,ix,ie,1:ns),2))/ sum(weight(ip,:)*wt9(ip,:,ix))*(we2(ip,ix,ie)-smwe2(ip,ix,ie)+smwe(ip,ix,ie)**2)
me2=me2+ sum(weight(ip,:)*sum(wt5(ip,:,ix,ie,1:ns),2))/ sum(weight(ip,:)*wt9(ip,:,ix))
enddo

do is=1,ns
me1= me1+ sum(weight(ip,:)*wt3(ip,:,ix,is))/sum(weight(ip,:)*wt9(ip,:,ix))*(ws2(ip,ix,is)-smws2(ip,ix,is)+smws(ip,ix,is)**2)
me2=me2+ sum(weight(ip,:)*wt3(ip,:,ix,is))/sum(weight(ip,:)*wt9(ip,:,ix))
enddo

enddo; enddo

me=max(0., me1/me2)


x6(:,1:ns)=min(x6(:, 1:ns), 4)
do ix=1,nx
do is=1,ns
do iexp = 0,4
logw6(:,iexp,is, ix)= sum(y6(1:ct6)*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp))/ max(.001, sum(1.*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp)))
do ic=1,ns

cd6(ic, iexp, is, ix) = sum(1.*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp)*(x6(1:ct6, 7)==ic))/ max(.001, sum(1.*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp)))
if (sum(1.*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp)*(x6(1:ct6, 7)==ic))>.01) logw6(ic,iexp,is, ix)= sum(y6(1:ct6)*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp)*(x6(1:ct6, 7)==ic))/ sum(1.*(x6(1:ct6,8)==ix)*(x6(1:ct6,is)==iexp)*(x6(1:ct6, 7)==ic))
enddo; enddo; enddo; enddo



do ix=1,nx
do ic=1,ns	!current
do ic2=1,ns	!past

dlw(ic,ic2, ix)= sum(y3(1:ct3)*(x3(1:ct3,1)==ic2)*(x3(1:ct3,2)==ic)*(x3(1:ct3,4)==ix))/max(.001,sum(1.*(x3(1:ct3,1)==ic2)*(x3(1:ct3,2)==ic)*(x3(1:ct3,4)==ix)))

enddo; enddo; enddo

do ix=1,nx
do ic=1,ns	!current
do ia=2,age

dlwa(ic,ia, ix)= sum(y3(1:ct3)*(x3(1:ct3,3)==ia)*(x3(1:ct3,2)==ic)*(x3(1:ct3,4)==ix))/max(.001,sum(1.*(x3(1:ct3,3)==ia)*(x3(1:ct3,2)==ic)*(x3(1:ct3,4)==ix)))

enddo; enddo; enddo



do ix=1,nx
do ic=1,ns	!current
do ia=1,10

dlwa2(ic,ia, ix)= sum(y3(1:ct3)*(x3(1:ct3,3)>=(5*ia-4) .and. x3(1:ct3,3)<=5*ia)*(x3(1:ct3,2)==ic)*(x3(1:ct3,4)==ix))/max(.001,sum(1.*(x3(1:ct3,3)>=(5*ia-4) .and. x3(1:ct3,3)<=5*ia)*(x3(1:ct3,2)==ic)*(x3(1:ct3,4)==ix)))

enddo; enddo; enddo

! calculate the function value and write the result to a file 'pr487.txt'
fx0= fx



fv=0
do ia=1,age; do ix=1,nx; do ic=1,nc
fv(1)= fv(1) + sum(weight(p1:p5,ia))* (mean(wt3(p1:p5,ia,ix,ic))- mean(smwt3(p1:p5,ia,ix,ic)))**2 / sum(weight(p1:p5,:)) 

enddo; enddo; enddo;

do ip=p1,p5;  do ix=1,nx; do ie=1,ne;do ic=1,nc
fv(2)= fv(2) + (sum(weight(ip,:)*wt5(ip,:,ix,ie,ic))/sum(weight(ip,:))- sum(weight(ip,:)*smwt5(ip,:,ix,ie,ic))/sum(weight(ip,:)) )**2 


enddo; enddo; enddo; enddo

fa1=6; fa2=25

FV(3)=0
do ip=p1,p5;  do ix=1,nx; do ik=1,nk;do ic=1,nc
fv(3)= fv(3) + (sum(weight(ip,fa1:fa2)*sum(wt7(ip,fa1:fa2,ix,:,ik,ic),2))/sum(weight(ip,fa1:fa2))- sum(weight(ip,fa1:fa2)*sum(smwt7(ip,fa1:fa2,ix,:,ik,ic),2))/sum(weight(ip,fa1:fa2)) )**2 
enddo; enddo; enddo; enddo


! education distribution	

age2=age

FV(4)=0
do ix=1,2; do ia=1,age2; do ip=p1,p4-2

FV(4)=FV(4)			&
+weight(ip,ia)*((sum(SMWT4(ip,ia,ix, 0:11))-sum(WT4(ip,ia,ix, 0:11)) )**2			&
+(sum(SMWT4(ip,ia,ix,12:12))-sum(WT4(ip,ia,ix,12:12)) )**2			&
+(sum(SMWT4(ip,ia,ix,13:15))-sum(WT4(ip,ia,ix,13:15)) )**2			&
+(sum(SMWT4(ip,ia,ix,16:16))-sum(WT4(ip,ia,ix,16:16)) )**2			&
+(sum(SMWT4(ip,ia,ix,17:18))-sum(WT4(ip,ia,ix,17:18)) )**2 )		&
/sum(weight(ip,1:age2))	
enddo; enddo; enddo; 

! capital stock
FV(6)= mean((ka(61:p5,:,uu)-aka(61:p5,:))**2) 


age2=15

do i16=0,1; do ix=1,2; do ia=1,age2;  do ic=1,nc; 
FV(7)=FV(7) + (SMCD162(ia,ix,i16,ic)- acd16(ia,ix,i16,ic))**2  
enddo; enddo; enddo; enddo; 

fa1=6
fa2=45
do ip=p1,p5; do ix=1,nx
fv(8)=fv(8) + ( wmean(sum(wt3(ip,fa1:fa2,ix,1:3),1), ws(ip,ix,1:3)) - wmean(sum(smwt3(ip,fa1:fa2,ix,1:3),1),smws(ip,ix,1:3)) )**2 	&
+			  ( wmean(sum(wt3(ip,fa1:fa2,ix,4:6),1), ws(ip,ix,4:6)) - wmean(sum(smwt3(ip,fa1:fa2,ix,4:6),1),smws(ip,ix,4:6)) )**2   

enddo; enddo


do ip=p1,p5;  do ix=1,nx; do ie=1,ne
FV(9)= FV(9) + sum(weight(ip,:)*sum(wt5(ip,:,ix,ie,1:ns),2))*(we2(ip,ix,ie)-smwe2(ip,ix,ie)+smwe(ip,ix,ie)**2-me)**2 / sum(weight(ip,:)*wt9(ip,:,ix)) 

enddo; enddo; enddo


do ip=p1,p5;  do ix=1,nx;do is=1,ns
FV(10)= FV(10) + sum(weight(ip,:)*wt3(ip,:,ix,is))*(ws2(ip,ix,is)-smws2(ip,ix,is)+smws(ip,ix,is)**2-me)**2 /sum(weight(ip,:)*wt9(ip,:,ix)) 

enddo; enddo; enddo



fa1=6
fa2=age
FV(11)=0
do ia=fa1,fa2; do ix=1,nx
FV(11)= FV(11) + sum(wt9(p1:p5,ia,ix))*(mean(wa(p1:p5,ia,ix)-smwa(p1:p5,ia,ix)))**2 /sum(wt9(p1:p5,fa1:fa2,ix))  

enddo; enddo; 



FV(12)=0
do ip=p1,p5;  do ix=1,nx; do ie=1,ne
FV(12)= FV(12) + sum(weight(ip,:)*sum(wt5(ip,:,ix,ie,1:ns),2))*(we(ip,ix,ie)-smwe(ip,ix,ie))**2 / sum(weight(ip,:)*wt9(ip,:,ix)) 

enddo; enddo; enddo



do ip=p1,p5;  do ix=1,nx;do is=1,ns
FV(13)= FV(13) + sum(weight(ip,:)*wt3(ip,:,ix,is))*(ws(ip,ix,is)-smws(ip,ix,is))**2 /sum(weight(ip,:)*wt9(ip,:,ix)) 
enddo; enddo; enddo




fv(16)=0
do ix=1,nx; do ic2=1,nc; do ic1=1,nc
fv(16)= fv(16) + mean(pwgt(p6:p7-1,ix,ic2)/(p7-p6)*(pcd(p6:p7-1,ix, ic1, ic2) - smpcd(p6:p7-1,ix,ic1,ic2)))**2 

enddo; enddo; enddo; 


age2=45
do ix=1,nx
do ia=1,age2
do ic2=1,5
do ic1=1,5
if (ic2==4 .and. ia>10) cycle
fv(17)= fv(17) + owgt(ia,ix,ic2)*(ocd(ia,ix, ic1, ic2) - smocd(ia,ix,ic1,ic2))**2
enddo; enddo; enddo; enddo


do ix=1,nx; do ia=1,age2; do ic2=1,4 ; do ic1=1,4
if (ic2==3 .and. ia>10) cycle
fv(18)= fv(18) + iwgt(ia,ix,ic2)*(icd(ia,ix, ic1, ic2) - smicd(ia,ix,ic1,ic2))**2 
enddo; enddo; enddo; enddo


do ix=1,nx; do ic=1,6
fv(19)= fv(19) + sum((mean(relxcum(p3:p4,ix,ic,:),1)- arelxcum(ix,ic,:))**2) 
enddo; enddo; 


do ip=p1,p5;  
do ix=1,nx; ;do ic=1,nc
fv(20)= fv(20) + (wmean(weight(ip,:),wt3(ip,:,ix,ic)-smwt3(ip,:,ix,ic)))**2 
enddo; enddo; enddo;


do ix=1,nx; do iexp=0,4; do is=1,ns; do ic=1,ns
fv(21)= fv(21) + sum(wcd6(:, iexp, is, ix))* (cd6(ic, iexp, is, ix) - acd6(ic, iexp, is, ix))**2 / sum(wcd6) 
enddo; enddo; enddo; enddo



do ix=1,nx; do iexp=0,4; do is=1,ns; do ic=1,ns
fv(22)= fv(22) + sum(wcd6(:, iexp, is, ix))* (logw6(ic, iexp, is, ix) - alogw6(ic, iexp, is, ix))**2  / sum(wcd6) 
enddo; enddo; enddo; enddo



do ix=1,nx; do ic=1,ns; do ic2=1,ns
fv(23)=fv(23) + wdlw(ic, ic2, ix)* (dlw(ic, ic2, ix)- adlw(ic, ic2, ix))**2 /sum(wdlw) 
enddo; enddo; enddo

do ix=1,nx; do ic=1,ns; do ia=1,10
fv(24)=fv(24) + wdlwa2(ic, ia, ix)* (dlwa2(ic, ia, ix)- adlwa2(ic, ia, ix))**2 /sum(wdlwa2) 
enddo; enddo; enddo

FV2=sum(FV(1:25)) -fv(15) 

OLDFV=MIN(OLDFV, FV2)


IF (oldFV==FV2 .or. iter==1) then

pr=0


pr(1:8,1)=c0(:,1,1)


pr(1:6,2)=c0(1:6,2,1)-c0(1:6,1,1)
pr(1:6,3)=c0(1:6,1,2)-c0(1:6,1,1)
pr(1:6,4)=c0(1:6,1,3)-c0(1:6,1,1)
pr(1:6,5)=c0(1:6,1,4)-c0(1:6,1,1)

pr(7:8,2)=c0(7:8,2,1)
pr(7:8,3)=log(c0(7:8,1,2)/c0(7:8,1,1))
pr(7:8,4)=log(c0(7:8,1,3)/c0(7:8,1,1))
pr(7:8,5)=log(c0(7:8,1,4)/c0(7:8,1,1))

pr(9,1:6)=c2
pr(10,1:2)=ck
pr(10,3)=c7(1)
pr(10,4)=c7(1)+c7(2)		! graduate tuition


pr(10,5:6)=hr

pr(11,1)=df
pr(12,3:4)=erp

pr(14,1:4)=ap(1:4,1,60)
pr(14,5:8)=ap(1:4,2,60)

pr(15,1:4)=ap(1:4,1,80)
pr(15,5:8)=ap(1:4,2,80)

pr(16,1:4)=ap(1:4,1,pp)
pr(16,5:8)=ap(1:4,2,pp)

pr(17,1:6)=sdr(:,1)


pr(21,1:4)=tp(1,1:4,1)
pr(21,5:8)=tp(1,1:4,2)

pr(22,1:4)=tp(2,1:4,1)
pr(22,5:8)=tp(2,1:4,2)

pr(23,1:2)=1/(1-sm(1,:))
pr(23,3:4)=1/(1-sm(2,:))

pr(24,1)=c5(0,1,1)
pr(24,2)=c5(40,1,1)
pr(24,3)=c5(0,1,2)
pr(24,4)=c5(40,1,2)

pr(26:31,1:6)=c1


pr(32,1:6)=cs

pr(33,1:8)=std(:,1)
pr(34,7:8)=std(7:8,2)

pr(34:35,1:6)=transpose(nb(1:6,1:2))

pr(36:43, 1:8) = c4(:,:,1)
pr(44:51, 1:8)=c4(:,:,2)



open(1, file='pr487.txt')

do i=1,51
WRITE(1, '(500f15.6)') pr(i,:)
enddo; 
write(1,*) ""

WRITE(1, '(500f20.6)') FV2, FV

endif



contains


! emax approximation
pure function emaxf(re, se, xe, kide, ze,dre, year, ia,  ix,it, ic)
implicit none

integer, intent(in) :: ia,  ic, it,ix, year		!, n
integer j, ct, is	!, i

real , intent(in) :: re(n,ns),  xe(ns) , ze(n,2), dre(n,ns)		!, maxee(n)
integer, intent(in) :: kide(n), se
real  emaxf(n)

real  s3(n, nemax)

if (ia==age+1) then
emaxf=0
return
endif

s3(:,1)=1
s3(:,2:7)= (re-7) 
s3(:,8:13)=(re>8)*(re-8)
s3(:,14:19)=(re>9)*(re-9) 

forall (is=1:ns) s3(:,19+is)=Xe(is)

s3(:,26)=Se
s3(:,27)=(ia<=5)*(Se>=10)+(ia>5)*(Se>=12)
s3(:,28)=(ia<=5)*(Se>=12)+(ia>5)*(Se>=16)
s3(:,29)=kide


ct=29

do is=1,ns; 
do j=20,29
ct=ct+1
s3(:,ct)=re(:,is)*s3(:,j)
enddo; 
enddo



s3(:,ct+1:ct+2)=ze	!(:,1)
ct=ct+2


s3(:,ct+1:ct+6)=dre
ct=ct+6

s3(:,ct+1)= max(1, min(pp, year))
s3(:,ct+2)= (year>20)*(min(pp,year)-20)
s3(:,ct+3)= (year>40)*(min(pp,year)-40)
s3(:,ct+4)= (year>60)*(min(pp,year)-60)
s3(:,ct+5)= (year>80)*(min(pp,year)-80)



emaxf = exp(matmul(s3, emax(ia,:,ic,ix,it)))

 end function



! calculate value function in model simulation
pure function emaxf2(s, x, kid,year, ia,ix,it, ic)
implicit none
integer, intent(in) :: ia,  ic, year
integer ct, is, in

integer, intent(in) :: ix(nn), it(nn), x(nn,ns)

!real , intent(in) :: r(ns) , dz(2)
integer, intent(in) :: kid(nn), s(nn)
real  emaxf2(nn)

real  s5(nn, nemax)

if (ia==age+1) then
emaxf2=0
return
endif



s5(:,1)=1
do is=1,ns
s5(:,1+is)= (R(p,is,u)-7) 
s5(:,7+is)=(R(p,is,u)>8)*(R(p,is,u)-8) 
s5(:,13+is)=(R(p,is,u)>9)*(R(p,is,u)-9) 
enddo	!is

s5(:,20:25)=x
s5(:,26)=s
s5(:,27)=(ia<=5)*(s>=10)+(ia>5)*(s>=12)
s5(:,28)=(ia<=5)*(s>=12)+(ia>5)*(s>=16)
s5(:,29)=kid

ct=29

do is=1,ns; 
!do j=20,29
s5(:,ct+1:ct+10)=R(p,is,u)*s5(:,20:29)
ct=ct+10
!enddo; 
enddo



s5(:,ct+1)=dz(1)
s5(:,ct+2)=dz(2)

ct=ct+2
forall (is=1:ns) s5(:,ct+is)=dr(is)

ct=ct+6


s5(:,ct+1)=max(1, min(pp,year))
s5(:,ct+2)= (year>20)*(min(pp,year)-20)
s5(:,ct+3)= (year>40)*(min(pp,year)-40)
s5(:,ct+4)= (year>60)*(min(pp,year)-60)
s5(:,ct+5)= (year>80)*(min(pp,year)-80)


forall (in=1:nn) emaxf2(in) = exp(sum(s5(in,:)*emax(ia,:,ic, ix(in), it(in))))
 end function




! make a matrix for state variables
subroutine sub4(s3)
real s3(n3,nemax)

s3(:,2:7)= (re-7) 
s3(:,8:13)=(re>8)*(re-8) 
s3(:,14:19)=(re>9)*(re-9)

s3(:,20:25)=Xe(:,ia,1:6)

s3(:,26)=Se(:,ia)
s3(:,27)=(ia<=5)*(Se(:,ia)>=10)+(ia>5)*(Se(:,ia)>=12)
s3(:,28)=(ia<=5)*(Se(:,ia)>=12)+(ia>5)*(Se(:,ia)>=16)
s3(:,29)=kide(:,ia)

ct=29

do is=1,ns		!; do j=20,29
forall (i3=1:n3) s3(i3, ct+1:ct+10)=re(i3,is)*s3(i3,20:29)
ct=ct+10
enddo		!; enddo

s3(:,ct+1:ct+2)= ze
ct=ct+2
s3(:,ct+1:ct+6)=dre

ct=ct+6

s3(:,ct+1)= year
s3(:,ct+2)= (year>20)*(year-20)
s3(:,ct+3)= (year>40)*(year-40)
s3(:,ct+4)= (year>60)*(year-60)
s3(:,ct+5)= (year>80)*(year-80)



end subroutine sub4

end subroutine fcn




















