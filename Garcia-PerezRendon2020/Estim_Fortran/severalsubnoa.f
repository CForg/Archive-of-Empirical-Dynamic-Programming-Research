
!******************************************************************
!** THE NEXT SUBR. CALCULATES THE VALUE OF THE NORMAL DISTR. FCT  **
!*******************************************************************
      real*8 function cumn(x)
      implicit real*8 (a-h,o-z)
      data          eps/0.25e-18/ !eps/0.1e-10/ !
      f=1.0
      z=-0.7071068*x
      sgn=1.0
      if(z.lt.0.0) sgn=-sgn
      z=sgn*z
      if(z.lt.1.0e-9) goto 100
      f=0.0
      if(z.gt.15.0) goto 100
      if(z.gt.8.0) goto 1
      d1=18.398386+z*(22.400395+z*(13.061386+z*(4.028390+z*
     *   0.56420138)))
      d2=18.398386+z*(43.160757+z*(43.364587+z*(23.640304+z*
     *   (7.1408372+z))))
      f=d1/d2
      go to 99
    1 d1=0.61410502+z*(0.3295899+z*0.5641896)
      d2=0.29534832+z*(1.5883528+z*(0.58418492))
      f=d1/d2
   99 f=f*exp(-z*z)
  100 if(sgn.lt.0.0) f=2.0-f
      cumn=0.5*f
      if(cumn.lt.eps) cumn=eps
      if(cumn.gt.1.0) cumn=1.0
      return
      end




      real*8 function ran1(idum)
      integer idum,ia,im,iq,ir,ntab,ndiv
      real*8 am,eps,rnmx
      parameter (ia=16807,im=2147483647,am=1./im,iq=127773,ir=2836,
     *     ntab=32,ndiv=1+(im-1)/ntab,eps=1.2e-7,rnmx=1.-eps)
      integer j,k,iv(ntab),iy
      save iv,iy
      data iv/ntab*0/,iy/0/
      if (idum .le. 0 .or. iy .eq. 0) then
       idum=max(-idum,1)
       do 11 j=ntab+8,1,-1
          k=idum/iq
          idum=ia*(idum-k*iq)-ir*k
          if (idum.lt.0) idum=idum+im
          if (j.le.ntab) iv(j)=idum
 11      continue
       iy=iv(1)
      endif
      k=idum/iq
      idum=ia*(idum-k*iq)-ir*k
      if (idum.lt.0) idum=idum+im
      j=1+iy/ndiv
      iy=iv(j)
      iv(j)=idum
      ran1=min(am*iy,rnmx)
      return
      end

      subroutine powell(p,xi,n,np,ftol,iter,fret)
      integer iter,n,np,nmax,itmax
      real*8 fret,ftol,p(np),xi(np,np),func
      external func
      parameter (nmax=50,itmax=200)
!    uses func,linmin
      integer i,ibig,j
      real*8 del,fp,fptt,xt,pt(nmax),ptt(nmax),xit(nmax)
      fret=func(p)
      do 11 j=1,n
        pt(j)=p(j)
11    continue
      iter=0
1     iter=iter+1
      fp=fret
      ibig=0
      del=0.
      do 13 i=1,n
        do 12 j=1,n
          xit(j)=xi(j,i)
12      continue
        fptt=fret
        call linmin(p,xit,n,fret)
        if(abs(fptt-fret).gt.del)then

          del=abs(fptt-fret)
          ibig=i
        endif
13    continue
      if(2.*abs(fp-fret).le.ftol*(abs(fp)+abs(fret)))return
      if(iter.eq.itmax) then
          write(*,*) 'powell exceeding maximum iterations'
         read (*,*)
      endif
      do 14 j=1,n
        ptt(j)=2.*p(j)-pt(j)
        xit(j)=p(j)-pt(j)
        pt(j)=p(j)
14    continue
      fptt=func(ptt)
      if(fptt.ge.fp)goto 1
      xt=2.*(fp-2.*fret+fptt)*(fp-fret-del)**2-del*(fp-fptt)**2
      if(xt.ge.0.)goto 1
      call linmin(p,xit,n,fret)
      do 15 j=1,n
        xi(j,ibig)=xi(j,n)

        xi(j,n)=xit(j)
15    continue
      goto 1
      end

      subroutine linmin(p,xi,n,fret)
      integer n,nmax
      real*8 fret,p(n),xi(n),xtol,f1dim
      parameter (nmax=50,xtol=1.e-4)
!cu    uses brent,f1dim,mnbrak
      integer j,ncom
      real*8 ax,bx,fa,fb,fx,xmin,xx,pcom(nmax),xicom(nmax),brent
      common /f1com/ pcom,xicom,ncom
      external f1dim
      ncom=n
      do 11 j=1,n
        pcom(j)=p(j)
        xicom(j)=xi(j)
11    continue
      ax=0.
      xx=1.
      call mnbrak(ax,xx,bx,fa,fx,fb,f1dim)
      fret=brent(ax,xx,bx,f1dim,xtol,xmin)
      do 12 j=1,n
        xi(j)=xmin*xi(j)
        p(j)=p(j)+xi(j)

12    continue
      return
      end

	subroutine mnbrak(ax,bx,cx,fa,fb,fc,func)
      real*8 ax,bx,cx,fa,fb,fc,func,gold,glimit,xtiny
      external func
      parameter (gold=1.618034, glimit=100., xtiny=1.e-20)
      real*8 dum,fu,q,r,u,ulim
      fa=func(ax)
      fb=func(bx)
      if(fb.gt.fa)then
        dum=ax
        ax=bx
        bx=dum
        dum=fb
        fb=fa
        fa=dum
      endif
      cx=bx+gold*(bx-ax)
      fc=func(cx)
1     if(fb.ge.fc)then
        r=(bx-ax)*(fb-fc)
        q=(bx-cx)*(fb-fa)
        u=bx-((bx-cx)*q-(bx-ax)*r)/(2.*sign(max(abs(q-r),xtiny),q-r))

        ulim=bx+glimit*(cx-bx)
        if((bx-u)*(u-cx).gt.0.)then
          fu=func(u)
          if(fu.lt.fc)then
            ax=bx
            fa=fb
            bx=u
            fb=fu
            return
          else if(fu.gt.fb)then
            cx=u
            fc=fu
            return
          endif
          u=cx+GOLD*(cx-bx)
          fu=func(u)
        else if((cx-u)*(u-ulim).gt.0.)then
          fu=func(u)
          if(fu.lt.fc)then
            bx=cx
            cx=u
            u=cx+GOLD*(cx-bx)

            fb=fc
            fc=fu
            fu=func(u)
          endif
        else if((u-ulim)*(ulim-cx).ge.0.)then
          u=ulim
          fu=func(u)
        else
          u=cx+GOLD*(cx-bx)
          fu=func(u)
        endif
        ax=bx
        bx=cx
        cx=u
        fa=fb
        fb=fc
        fc=fu
        goto 1
      endif
      return
      END
	

      real*8 function brent(ax,bx,cx,nf,xtol,xmin)
	integer itmax
      real*8 ax,bx,cx,xtol,xmin,nf,cgold,seps
	  external nf
      parameter (itmax=100,cgold=.3819660,seps=1.0e-10) 
      integer iter
	  real*8 a,b,d,e,etemp,fu,fv,fw,fx,p,q,r,xtol1,xtol2,u,v,w,x,xm
	  a=min(ax,cx)
        b=max(ax,cx)
	  v=bx
	  w=v
        x=v
        e=0.
        fx=nf(x)
      fv=fx
      fw=fx
      do 11 iter=1,ITMAX
        xm=0.5*(a+b)
        xtol1=xtol*abs(x)+seps
        xtol2=2.*xtol1
        if(abs(x-xm).le.(xtol2-.5*(b-a))) goto 3

        if(abs(e).gt.xtol1) then
          r=(x-w)*(fx-fv)
          q=(x-v)*(fx-fw)
          p=(x-v)*q-(x-w)*r
          q=2.*(q-r)
          if(q.gt.0.) p=-p
          q=abs(q)
          etemp=e
          e=d
          if(abs(p).ge.abs(.5*q*etemp).or.p.le.q*(a-x).or.p.ge.q*(b-x)) 
     *goto 1
          d=p/q
          u=x+d
          if(u-a.lt.xtol2 .or. b-u.lt.xtol2) d=sign(xtol1,xm-x)
          goto 2
        endif
1       if(x.ge.xm) then
          e=a-x
        else
          e=b-x
        endif
        d=CGOLD*e
2       if(abs(d).ge.xtol1) then

          u=x+d
        else
          u=x+sign(xtol1,d)
        endif
        fu=nf(u)
        if(fu.le.fx) then
          if(u.ge.x) then
            a=x
          else
            b=x
          endif
          v=w
          fv=fw
          w=x
          fw=fx
          x=u
          fx=fu
        else
          if(u.lt.x) then
            a=u
          else
            b=u
          endif
          if(fu.le.fw .or. w.eq.x) then
            v=w
            fv=fw
            w=u

            fw=fu
          else if(fu.le.fv .or. v.eq.x .or. v.eq.w) then
            v=u
            fv=fu
          endif
        endif
11    continue
       write(*,*)'brent exceed maximum iterations'
       read(*,*)
3     xmin=x
      brent=fx
      return
      END
	
      real*8 function f1dim(x)
	integer nmax
      real*8 func,x
      external func
      parameter (nmax=50)
!cu    uses func
      integer j,ncom
      real*8 pcom(nmax),xicom(nmax),xt(nmax)
      common /f1com/ pcom,xicom,ncom
      do 11 j=1,ncom
        xt(j)=pcom(j)+x*xicom(j)
11    continue
      f1dim=func(xt)
      return
      end    


      
      SUBROUTINE choldc(a,n,np,p)
      INTEGER n,np
      REAL*8 a(np,np),p(n)
      INTEGER i,j,k
      REAL sum
      do 13 i=1,n
        do 12 j=i,n
          sum=a(i,j)
          do 11 k=i-1,1,-1
            sum=sum-a(i,k)*a(j,k)
11        continue
          if(i.eq.j)then
            if(sum.le.0.)then  
	   write(*,*) 'choldc failed'
	   read(*,*)
  	    endif
            p(i)=sqrt(sum)
          else
            a(j,i)=sum/p(i)
          endif
12      continue
13    continue
      return
      END
C  (C) Copr. 1986-92 Numerical Recipes Software ~,A24.      
      
      
      real*8 function ppnd7 ( p, ifault )
c*********************************************************************72
c
cc PPND7 produces the normal deviate value corresponding to lower tail area = P.
c
c  Discussion:
c
c    The result is accurate to about 1 part in 10**7.
c
c  Modified:
c
c    13 January 2008
c
c  Author:
c
c    Michael Wichura
c
c  Reference:
c
c    Michael Wichura,
c    Algorithm AS 241:
c    The Percentage Points of the Normal Distribution,
c    Applied Statistics,
c    Volume 37, Number 3, 1988, pages 477-484.
c
c  Parameters:
c
c    Input, REAL*8  P, the value of the cumulative probability densitity function.
c    0 < P < 1.
c
c    Output, integer IFAULT, error flag.
c    0, no error.
c    1, P <= 0 or P >= 1.
c
c    Output, REAL*8  PPND7, the normal deviate value with the property that
c    the probability of a standard normal deviate being less than or
c    equal to PPND7 is P.
c
      implicit none

      real*8  a0
      real*8  a1
      real*8  a2
      real*8  a3
      real*8  b1
      real*8  b2
      real*8  b3
      real*8  c0
      real*8  c1
      real*8  c2
      real*8  c3
      real*8  const1
      real*8  const2
      real*8  d1
      real*8  d2
      real*8  e0
      real*8  e1
      real*8  e2
      real*8  e3
      real*8  f1
      real*8  f2
      integer ifault
      real*8  p
!      real*8  ppnd7
      real*8  q
      real*8  r
      real*8  split1
      real*8  split2

      parameter ( a0 = 3.3871327179E+00 )
      parameter ( a1 = 50.434271938E+00 )
      parameter ( a2 = 159.29113202E+00 )
      parameter ( a3 = 59.109374720E+00 )
      parameter ( b1 = 17.895169469E+00 )
      parameter ( b2 = 78.757757664E+00 )
      parameter ( b3 = 67.187563600E+00 )
      parameter ( c0 = 1.4234372777E+00 )
      parameter ( c1 = 2.7568153900E+00 )
      parameter ( c2 = 1.3067284816E+00 )
      parameter ( c3 = 0.17023821103E+00 )
      parameter ( const1 = 0.180625E+00 )
      parameter ( const2 = 1.6E+00 )
      parameter ( d1 = 0.73700164250E+00 )
      parameter ( d2 = 0.12021132975E+00 )
      parameter ( e0 = 6.6579051150E+00 )
      parameter ( e1 = 3.0812263860E+00 )
      parameter ( e2 = 0.42868294337E+00 )
      parameter ( e3 = 0.017337203997E+00 )
      parameter ( f1 = 0.24197894225E+00 )
      parameter ( f2 = 0.012258202635E+00 )
      parameter ( split1 = 0.425E+00 )
      parameter ( split2 = 5.0E+00 )

      ifault = 0
      q = p - 0.5E+00

      if ( abs ( q ) .le. split1 ) then

        r = const1 - q * q

        ppnd7 = q * (((
     &      a3   * r 
     &    + a2 ) * r 
     &    + a1 ) * r 
     &    + a0 ) / (((
     &      b3   * r 
     &    + b2 ) * r 
     &    + b1 ) * r 
     &    + 1.0E+00 )

      else

        if ( q .lt. 0.0E+00 ) then
          r = p
        else
          r = 1.0E+00 - p
        end if

        if ( r .le. 0.0E+00 ) then
          ifault = 1
          ppnd7 = 0.0E+00
          return
        end if

        r = sqrt ( - Dlog ( r ) )

        if ( r .le. split2 ) then

          r = r - const2

          ppnd7 = (((
     &      c3   * r 
     &    + c2 ) * r 
     &    + c1 ) * r
     &    + c0 ) / ((
     &      d2   * r 
     &    + d1 ) * r 
     &    + 1.0E+00 )

        else

          r = r - split2

          ppnd7 = (((
     &      e3   * r 
     &    + e2 ) * r 
     &    + e1 ) * r 
     &    + e0 ) / ((
     &      f2   * r 
     &    + f1 ) * r 
     &    + 1.0E+00 )

        end if

        if ( q .lt. 0.0E+00 ) then
          ppnd7 = - ppnd7
        end if

      end if

      return
      end
      

     
      subroutine gaussj(a,n,np,b,m,mp,ierr)

c  Purpose: Solution of the system of linear equations AX = B by
c     Gauss-Jordan elimination, where A is a matrix of order N and B is
c     an N x M matrix.  On output A is replaced by its matrix inverse
c     and B is preplaced by the corresponding set of solution vectors.

c  Source: W.H. Press et al, "Numerical Recipes," 1989, p. 28.

c  Modifications: 
c     1. Double  precision.
c     2. Error parameter IERR included.  0 = no error. 1 = singular 
c        matrix encountered; no inverse is returned.

c  Prepared by J. Applequist, 8/17/91.

      implicit real*8(a-h,o-z)

c        Set largest anticipated value of N.

      parameter (nmax=500)
      dimension a(np,np),b(np,mp),ipiv(nmax),indxr(nmax),indxc(nmax)
      ierr=0
      do 11 j=1,n
      ipiv(j)=0
 11   continue
      do 22 i=1,n
      big=0.d0
      do 13 j=1,n
      if (ipiv(j).ne.1) then
      do 12 k=1,n
      if (ipiv(k).eq.0) then
      if (dabs(a(j,k)).ge.big) then
      big=dabs(a(j,k))
      irow=j
      icol=k
      endif
      else if (ipiv(k).gt.1) then
      ierr=1
      return
      endif
 12   continue
      endif
 13   continue
      ipiv(icol)=ipiv(icol)+1
      if (irow.ne.icol) then
      do 14 l=1,n
      dum=a(irow,l)
      a(irow,l)=a(icol,l)
      a(icol,l)=dum
 14   continue
      do 15 l=1,m
      dum=b(irow,l)
      b(irow,l)=b(icol,l)
      b(icol,l)=dum
 15   continue
      endif
      indxr(i)=irow
      indxc(i)=icol
      if (a(icol,icol).eq.0.d0) then
      ierr=1
      return
      endif
      pivinv=1.d0/a(icol,icol)
      a(icol,icol)=1.d0
      do 16 l=1,n
      a(icol,l)=a(icol,l)*pivinv
 16   continue
      do 17 l=1,m
      b(icol,l)=b(icol,l)*pivinv
 17   continue
      do 21 ll=1,n
      if (ll.ne.icol) then
      dum=a(ll,icol)
      a(ll,icol)=0.d0
      do 18 l=1,n
      a(ll,l)=a(ll,l)-a(icol,l)*dum
 18   continue
      do 19 l=1,m
      b(ll,l)=b(ll,l)-b(icol,l)*dum
 19   continue
      endif
 21   continue
 22   continue
      do 24 l=n,1,-1
      if (indxr(l).ne.indxc(l)) then
      do 23 k=1,n
      dum=a(k,indxr(l))
      a(k,indxr(l))=a(k,indxc(l))
      a(k,indxc(l))=dum
 23   continue
      endif
 24   continue
      return
      end      

      
      
	subroutine desmoment(nmquest,ts,tl,
     * ama,w1m,w2m,i1m,i2m,ip1m,ip2m,iq1m,iq2m,
     * thazt,xmoment,xlmoment,nmoment,irep,filetex,xac,itex,nboot,iass,
     * istanda,ichimo,iproba,iproduce) !iproduce=1: produce tables, 0: do not
	implicit none
	integer ifecha(8)            
	integer i,j,k,l,m,n,nmquest,nmobs,jj,kk,lm,ll,kmlag,t,mm,ix,
     * iproduce 
	integer itex,na,ii,jp,kp,jq,kq,nmoment,lk,maxmom,npeople
	parameter (maxmom=20000,nmobs=48,
     *    npeople=140000)             
!	Input		
	integer	
     * 	i1m(npeople,nmobs),i2m(npeople,nmobs),
     * 	ip1m(npeople,nmobs),ip2m(npeople,nmobs),      
     * 	iq1m(npeople,nmobs),iq2m(npeople,nmobs),      
     * ts(nmquest),tl(nmquest)

!	real*8 w(0:nw,2),aa(na)
	real*8  w1old,w1now,w2old,w2now,amanow,amaold
      integer nboot
      real*8 ama(npeople,nmobs),w1m(npeople,nmobs),w2m(npeople,nmobs)
!	Output of desmoment
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

     	character*30 filetex,filemomx,filepara,
     *    filedata
      
!	Thresholds
!	real*8 w1,w2,w3,w4,wmn,wmx,gridu,umn
	real*8  amn,amx,wmx,wmn,umx,umn,ran1
	real*8 a1,a2,a3,a4,w1,w2,w3,w4,gridu
	real*8 dw(2,2),dcm(3)
      double precision xmoment(maxmom)
      integer istanda(maxmom),ichimo(maxmom),iproba(maxmom)
      character*80 xlmoment(maxmom)
	integer ie(2),lmg,iass
      integer iq1,iq2,ip1,ip2,tbeg,itable
	integer ielagi(2),ibra1
	integer ienow,ielag,irep,ibra,ielaga,ibrap,iacount
      integer i1,i2
      integer thaz,isi,ise,isx,itoti,inch,
     *thazt,thazi(2),isim(2),isem(2),isxm(2),
     *thazti(2)
      real*8 xtoti
	common /bounds/ umn,umx,wmn,wmx,amn,amx,gridu
!	Brackets
	integer iempl(2,2),iemplm(2,2),jbrw(2,2),jbrwm(2,2)
	real*8 	wagmat(2,2),asse(3)
      double precision xdeno
	character*25 xlabel(0:37),xlabelj(0:47)
      character*25 xlabelk(0:47)      
      character*7 xgender(2)
      character*10 xac
	real*8 xwdi(3)

!      write(*,*)ts(318),'ts count'      
      ix=1      
      xdeno=1.d-20
!      iass=1
      xgender(1)='Husband '
      xgender(2)='Wife '

!************************************
!     Descriptive stats
!************************************
!	write(*,*) nmquest,nmobs,irep
!	Initialize arrays	
	xenum=0.d0
	xewag=0.d0
	xeass=0.d0
      xassdbn=0.d0
      xassdbnp=0.d0      
      xassdbnu=0.d0
      xassdbnpu=0.d0      
      xetass=0.d0
      
      xwnub=0.d0
	xwnum=0.d0
	xwass=0.d0

	xass=0.d0

	xetnum=0.d0
      xetnumr=0.d0
      xetnumc=0.d0
      
      xetnumqp=0.d0
      xetnuqp=0.d0
      
	xetwag=0.d0
	xetwagqp=0.d0      

	xwptnum=0.d0


	iempl=0
      iemplm=0
      iempl(1:2,2)=2
      iemplm(1:2,2)=2

      jbrwm=0
      jbrw=0
      jbrw(1:2,2)=6
	jbrwm(1:2,2)=6
	
      w1now=0.d0
      w1old=0.d0
      w2old=0.d0
      w2now=0.d0
      
	dw=0.d0
	dcm=0.d0

	wagmat=0.d0
	asse=0.d0

      xmoment=0.d0

      include 'thresholds.f'            
      
      exhazi0=0.d0
      exhazi2=0.d0
      exhazi=0.d0

      exhaz0=0.d0
      exhaz2=0.d0
      exhaz=0.d0

      wtdurave=0.d0
      wtduravin=0.d0      
      thazt=0

!      write(*,*)nmquest,iass,'nmquest,iass'
!*************************************
!     Data
!************************************
!	do lm=1,nmquest     !Individuals
	do lk=1,nmquest     !Individuals  
!      write(*,*)ts(318),'ts count'                
          lm=lk
        if(nboot.gt.0)then
          rs=ran1(iass)    
          lm=int(rs*real(nmquest-1)+0.5)+1
        endif
      tbeg=ts(lm)
!      write(*,*)lm,tbeg, nboot,nmquest,rs,'tbeg'
!*******************************************     
!     Average assets bracket per individual      
!*******************************************
      amanow=0.d0      
      iacount=0
	do t=tbeg,tl(lm)   ! 1,nmobs		!observations !!!!!!!!!!!!!!!!!!!!!!
	if(ama(lm,t).ne.-9)then !Assets
          amanow=amanow+ama(lm,t)
      iacount=iacount+1      
      endif
      enddo      
      amanow=amanow/iacount
      ibrap=0
!	 if(amanow.gt.amn.and.amanow.le.a1)then
	 if(amanow.le.a1)then      
	  	  ibrap=1
	 elseif(amanow.gt.a1.and.amanow.le.a2)then
	  	  ibrap=2
	 elseif(amanow.gt.a2.and.amanow.le.a3)then
	  	  ibrap=3
	 elseif(amanow.gt.a3.and.amanow.le.a4)then
	  	  ibrap=4
!	 elseif(amanow.gt.a4.and.amanow.le.amx)then
	 elseif(amanow.gt.a4)then            
	  ibrap=5
       endif
!**************************************      
      amanow=-9      
        

	ielagi=-1

      ibra1=1

      iempl(1:2,1)=0
      jbrw(1:2,1)=0

	asse=0.d0
      
      w1old=w1m(lm,max(tbeg,1))          
      w2old=w2m(lm,max(tbeg,1))          

	thaz=0      
      thazi=0      

	ienow=-1
	ielag=-1
      ielaga=-1
      amaold=-1.d0
      kmlag=-1

      do t=tbeg,tl(lm)   ! 1,nmobs		!observations !!!!!!!!!!!!!!!!!!!!!!
	ie(1)=i1m(lm,t)        !Employment Status
	ie(2)=i2m(lm,t)        !Employment Status
      
	iq1=iq1m(lm,t)        !Quit !quit=1, layoff=0
	iq2=iq2m(lm,t)        !Quit !quit=1, layoff=0
      
	ip1=ip1m(lm,t)        !Employer number h
	ip2=ip2m(lm,t)        !Employer number w

      w1now=w1m(lm,t)          
      w2now=w2m(lm,t)          
      
      amanow=ama(lm,t)      
      
	iempl(1,1)=ie(1)
	iempl(2,1)=ie(2)
      
	wagmat(1,1)=w1m(lm,t)
	wagmat(1,2)=w1m(lm,t)*w1m(lm,t)
	wagmat(2,1)=w2m(lm,t)
	wagmat(2,2)=w2m(lm,t)*w2m(lm,t)

      do i=1,2
!         if(wagmat(i,1).eq.0.d0.or.ie(i).eq.0)then
         if(ie(i).eq.0)then             
             jbrw(i,1)=0
!         elseif(wagmat(i,1).gt.0.d0.and.wagmat(i,1).le.w1)then
         elseif(wagmat(i,1).le.w1)then             
	  jbrw(i,1)=1
	 elseif(wagmat(i,1).gt.w1.and.wagmat(i,1).le.w2)then
	  jbrw(i,1)=2
	 elseif(wagmat(i,1).gt.w2.and.wagmat(i,1).le.w3)then
	  jbrw(i,1)=3
	 elseif(wagmat(i,1).gt.w3.and.wagmat(i,1).le.w4)then
	  jbrw(i,1)=4
	 elseif(wagmat(i,1).gt.w4.and.wagmat(i,1).le.wmx)then
	  jbrw(i,1)=5
       endif
      enddo
      
!*********************************************************Assets start      
	if(ama(lm,t).ne.-9.d0)then !Assets
	asse(1)=ama(lm,t)
	asse(2)=ama(lm,t)*ama(lm,t)
	asse(3)=1.d0
!	 if(asse(1).gt.amn.and.asse(1).le.a1)then
	 if(asse(1).le.a1)then      
	  	  ibra=1
	 elseif(asse(1).gt.a1.and.asse(1).le.a2)then
	  	  ibra=2
	 elseif(asse(1).gt.a2.and.asse(1).le.a3)then
	  	  ibra=3
	 elseif(asse(1).gt.a3.and.asse(1).le.a4)then
	  	  ibra=4
!	 elseif(asse(1).gt.a4.and.asse(1).le.amx)then
	 elseif(asse(1).gt.a4)then            
	  ibra=5
       endif
!      endif


!	Tab Asset 4 (e husband,e wife,mean and variance)
	do i=1,3 !mean and variance
	do k=1,2
	kk=iempl(2,k)
	do j=1,2
	jj=iempl(1,j)
	xeass(jj,kk,i)=xeass(jj,kk,i)+asse(i)
	xeasst(jj,kk,t,i)=xeasst(jj,kk,t,i)+asse(i)
	enddo
	enddo
	enddo

!	Tab asset6
	do i=1,3 !mean and variance
	do k=1,2
	kk=jbrw(2,k)
	do j=1,2
	jj=jbrw(1,j)
	xwass(jj,kk,i)=xwass(jj,kk,i)+asse(i)
	enddo
	enddo
      enddo

      
      
!	Table 7: xassdbn: Asset brackets
!	By bracket
!	Table 7: xassdbn: Asset brackets
!	By bracket
      xassdbn(ibra,1)=xassdbn(ibra,1)+1               !number
      xassdbn(ibra,2)=xassdbn(ibra,2)+(1-ie(1))*(1-ie(2)) !uu
      xassdbn(ibra,3)=xassdbn(ibra,3)+(1-ie(1))*ie(2)     !ue
      xassdbn(ibra,4)=xassdbn(ibra,4)+ie(1)*(1-ie(2))     !eu
      xassdbn(ibra,5)=xassdbn(ibra,5)+ie(1)*ie(2)         !ee

      xassdbn(ibra,6)=xassdbn(ibra,6)+ie(1)          !e1
      xassdbn(ibra,7)=xassdbn(ibra,7)+ie(2)          !e2

      xassdbn(ibra,8)=xassdbn(ibra,8)+wagmat(1,1)
      xassdbn(ibra,9)=xassdbn(ibra,9)+wagmat(1,2)
      xassdbn(ibra,10)=xassdbn(ibra,10)+wagmat(2,1)
      xassdbn(ibra,11)=xassdbn(ibra,11)+wagmat(2,2)
*	Totals
      xassdbn(6,1)=xassdbn(6,1)+1               !number
      xassdbn(6,2)=xassdbn(6,2)+(1-ie(1))*(1-ie(2)) !uu
      xassdbn(6,3)=xassdbn(6,3)+(1-ie(1))*ie(2)     !ue
      xassdbn(6,4)=xassdbn(6,4)+ie(1)*(1-ie(2))     !eu
      xassdbn(6,5)=xassdbn(6,5)+ie(1)*ie(2)         !ee

      xassdbn(6,6)=xassdbn(6,6)+ie(1)          !e1
      xassdbn(6,7)=xassdbn(6,7)+ie(2)          !e2

      xassdbn(6,8)=xassdbn(6,8)+wagmat(1,1)
      xassdbn(6,9)=xassdbn(6,9)+wagmat(1,2)
      xassdbn(6,10)=xassdbn(6,10)+wagmat(2,1)
      xassdbn(6,11)=xassdbn(6,11)+wagmat(2,2)
      
      endif !	if(iao.ne.-9)then
!*********************************************************Assets end

      
*	Table 7a: xassdbn: Asset brackets
*	By bracket
      xassdbnp(ibrap,1)=xassdbnp(ibrap,1)+1               !number
      xassdbnp(ibrap,2)=xassdbnp(ibrap,2)+(1-ie(1))*(1-ie(2)) !uu
      xassdbnp(ibrap,3)=xassdbnp(ibrap,3)+(1-ie(1))*ie(2)     !ue
      xassdbnp(ibrap,4)=xassdbnp(ibrap,4)+ie(1)*(1-ie(2))     !eu
      xassdbnp(ibrap,5)=xassdbnp(ibrap,5)+ie(1)*ie(2)         !ee

      xassdbnp(ibrap,6)=xassdbnp(ibrap,6)+ie(1)         !e1
      xassdbnp(ibrap,7)=xassdbnp(ibrap,7)+ie(2)          !e2

      xassdbnp(ibrap,8)=xassdbnp(ibrap,8)+wagmat(1,1)
      xassdbnp(ibrap,9)=xassdbnp(ibrap,9)+wagmat(1,2)
      xassdbnp(ibrap,10)=xassdbnp(ibrap,10)+wagmat(2,1)
      xassdbnp(ibrap,11)=xassdbnp(ibrap,11)+wagmat(2,2)
*	Totals
      xassdbnp(6,1)=xassdbnp(6,1)+1               !number
      xassdbnp(6,2)=xassdbnp(6,2)+(1-ie(1))*(1-ie(2)) !uu
      xassdbnp(6,3)=xassdbnp(6,3)+(1-ie(1))*ie(2)     !ue
      xassdbnp(6,4)=xassdbnp(6,4)+ie(1)*(1-ie(2))     !eu
      xassdbnp(6,5)=xassdbnp(6,5)+ie(1)*ie(2)         !ee

      xassdbnp(6,6)=xassdbnp(6,6)+ie(1)          !e1
      xassdbnp(6,7)=xassdbnp(6,7)+ie(2)          !e2

      xassdbnp(6,8)=xassdbnp(6,8)+wagmat(1,1)
      xassdbnp(6,9)=xassdbnp(6,9)+wagmat(1,2)
      xassdbnp(6,10)=xassdbnp(6,10)+wagmat(2,1)
      xassdbnp(6,11)=xassdbnp(6,11)+wagmat(2,2)
      
      
!	write(*,*)lm,t,ie1,ie2,jw1,jw2


!	Table I: xe :Employment Status Husband and Wife
!	Number	1
	do k=1,2
	kk=iempl(2,k)
	do j=1,2
	jj=iempl(1,j)
	xenum(jj,kk)=xenum(jj,kk)+1
	xenumt(jj,kk,t)=xenumt(jj,kk,t)+1
!	write(*,*) k,j,jj,kk,xenum(jj,kk)
	enddo
	enddo

!	Tab Wages 2 and 3 [ie1,ie2,w husband or wife,mean or variance]
	do l=1,2 !mean and variance
	do i=1,2 !husband and wife
	do k=1,2
	kk=iempl(2,k)
	do j=1,2
	jj=iempl(1,j)
!	if ((kk.eq.0.and.wagmat(2,l).ne.0.d0).or.
!     *	(jj.eq.0.and.wagmat(1,l).ne.0.d0))then 
!	write(*,*) kk,jj,wagmat(i,l),i,l
!	endif
	xewag(jj,kk,i,l)=xewag(jj,kk,i,l)+wagmat(i,l)
	xewagt(jj,kk,t,i,l)=xewagt(jj,kk,t,i,l)+wagmat(i,l)
	enddo
	enddo
	enddo
	enddo


!	Table II: xw: Wage brackets Husband and Wife
!	Number 5
	do k=1,2
	kk=jbrw(2,k)
	do j=1,2
	jj=jbrw(1,j)
	xwnum(jj,kk)=xwnum(jj,kk)+1
	enddo
	enddo
      ii=jbrw(2,1)
	jj=jbrw(1,1)      
      xwnub(ii,1,1)=xwnub(ii,1,1)+ie(1)
      xwnub(jj,2,1)=xwnub(jj,2,1)+ie(2)
      xwnub(ii,1,2)=xwnub(ii,1,2)+wagmat(1,1)
      xwnub(jj,2,2)=xwnub(jj,2,2)+wagmat(2,1)


!	*****************************
!	Transitions
!	*****************************      
	iemplm=0
	ienow=2*ie(1)+ie(2)+1
      
!      write(*,*)lm,t,ta(lm),ienow,ielag   
!      write(*,*)ie1,ie2,ie1m,ie2m
	if (t.gt.1.and.t.gt.tbeg) then
      dw(1,1)=w1now-w1old
	dw(1,2)=dw(1,1)*dw(1,1)
	dw(2,1)=w2now-w2old
	dw(2,2)=dw(2,1)*dw(2,1)

!**********************************************      
!     Hazard
	if(thaz.eq.1.and.ienow.ne.ielag)then   !Hazard starts      
      exhaz0(ienow,ielag,1)=exhaz0(ienow,ielag,1)+1
      endif
	thaz=thaz+1          
	if(ienow.eq.ielag)then
	exhaz(thaz,ienow,ibrap)=exhaz(thaz,ienow,ibrap)+1.d0
      elseif(ienow.ne.ielag)then           !Hazard Exit          
      exhaz0(ielag,ienow,2)=exhaz0(ielag,ienow,2)+1
          
!*******************************************************
       do m=1,2
      if(ie(m).eq.1)then 
      wtdurave(thaz,ielag,ibrap,m,1:2)=wtdurave(thaz,ielag,ibrap,m,1:2)
     * +wagmat(m,1:2)
      wtdurave(thaz,ielag,ibrap,m,3)=wtdurave(thaz,ielag,ibrap,m,3)
     * +1.d0
      endif
      enddo
!*******************************************************
	thaz=0                                 !Time is reset
      endif
      thazt=max(thazt,thaz)
!**********************************************      
!     Individual Hazard      
      do m=1,2
	if(thazi(m).eq.0)then   !Hazard starts
      exhazi0(ie(m)+1,ie(3-m)+1,1,ibrap,m)=
     * exhazi0(ie(m)+1,ie(3-m)+1,1,ibrap,m)+1
      endif
      
      thazi(m)=thazi(m)+1         
      if(ie(m).eq.ielagi(m))then
      exhazi(thazi(m),ie(m)+1,ibrap,m)=exhazi(thazi(m),ie(m)+1,ibrap,m)
     *  +1
!      elseif(ie(m).ne.ielagi(m).and.thazi(m).gt.1)then           !Hazard Exit
      elseif(ie(m).ne.ielagi(m))then           !Hazard Exit          
      exhazi0(ielagi(m)+1,ie(3-m)+1,2,ibrap,m)=
     *  exhazi0(ielagi(m)+1,ie(3-m)+1,2,ibrap,m)+1
      
!*******************************************************
      if(ie(m).eq.1)then 
      wtduravin(thazi(m),ibrap,m,1:2)=
     * wtduravin(thazi(m),ibrap,m,1:2)+wagmat(m,1:2)
      wtduravin(thazi(m),ibrap,m,3)=
     *  wtduravin(thazi(m),ibrap,m,3)+1.d0
      endif
!*******************************************************
	thazi(m)=0                                  !Time is reset  !Hazard restarts
      endif          
      enddo !m
!     Individual Hazard      end
!**********************************************            
      
      
!	write(*,*)lm,t,ienow,iao,iao1


	iemplm(1,1)=ielagi(1)
	iemplm(2,1)=ielagi(2)
	iemplm(1,2)=2
	iemplm(2,2)=2

	

	if(ama(lm,t).ne.-9.and.amaold.ne.-9)then !Assets
      if(ielaga.gt.0)then !Transitions Assets          
	dcm(1)=(amanow-amaold)/(t-kmlag)          
	dcm(2)=dcm(1)*dcm(1)
	dcm(3)=1.d0

!	write(*,*)lm,t,kmlag,dcm(1)
!	pause

!	Tab Asset 11
	do k=1,3
      do jj=ielag,5,5-ielag
      do ii=ienow,5,5-ienow
	xetass(ii,jj,k)=xetass(ii,jj,k)+dcm(k) !ienow=1  ielaga=0
      enddo
      enddo
      enddo
      
      endif

	endif !	if(iao.ne.-9.and.iao1.gt.-1)then


!	Table IV: xet :Employment Status Husband and Wife
!	Transitions 8
      do jj=ielag,5,5-ielag
      do ii=ienow,5,5-ienow
	xetnum(ii,jj)=xetnum(ii,jj)+1
      enddo
      enddo

      

!	Table IV: xet :Employment Status Husband and Wife.Quits and Layoffs
!	Transitions 8q
!	Table IV: xet :Employment Status Husband and Wife. Change employer
!	Transitions 8p
      do kp=ip2,2,2-ip2
      do jp=ip1,2,2-ip1
      do kq=iq2,2,2-iq2
      do jq=iq1,2,2-iq1
      do jj=ielag,5,5-ielag
      do ii=ienow,5,5-ienow
	xetnumqp(ii,jj,jq,kq,jp,kp)=xetnumqp(ii,jj,jq,kq,jp,kp)+1      
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      
      
      
!	Tab Wages 9 and 10 [ie1,ie2,husband or wife,mean or variance]
	do k=1,2
      do j=1,2
      do jj=ielag,5,5-ielag
      do ii=ienow,5,5-ienow
      xetwag(ii,jj,j,k)=xetwag(ii,jj,j,k)+dw(j,k)
      enddo
      enddo
      enddo
      enddo
          
	do k=1,2
      do j=1,2
      do kp=ip2,2,2-ip2
      do jp=ip1,2,2-ip1
      do kq=iq2,2,2-iq2
      do jq=iq1,2,2-iq1
      do jj=ielag,5,5-ielag
      do ii=ienow,5,5-ienow
	xetwagqp(ii,jj,jq,kq,jp,kp,j,k)=xetwagqp(ii,jj,jq,kq,jp,kp,j,k)+dw(j,k)
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo
      

!	Table VI: xwpt: Wage Partial Transitions
!	Wage partial transitions by gender 14
      do i=1,2                !	Husband Wife
       do k=1,2               !Bracket total
       do j=1,2              !Bracket total
	xwptnum(jbrw(i,j),jbrwm(i,k),i)=xwptnum(jbrw(i,j),jbrwm(i,k),i)+1
      enddo            
      enddo      
      enddo
      endif !t.gt.1

	if(ama(lm,t).ne.-9)then !Assets
      amaold=amanow
	ielaga=ienow
	kmlag=t
      ibra1=ibra      
      endif
      
	ielagi=ie
      ielag=ienow
      w1old=w1now
      w2old=w2now

	jbrwm(1:2,1)=jbrw(1:2,1)

      enddo   !t
      enddo !lm


!     Totals
      thazt=min(thazt,nmobs/4)
      
      do ienow=1,4
      do i=1,thazt
      do ibrap=1,5
      exhaz(i,ienow,6)=exhaz(i,ienow,6)+exhaz(i,ienow,ibrap)
      enddo
      enddo
      enddo

      do n=1,2      
      do k=1,4
      do i=1,thazt
      do l=1,3
      do ibrap=1,5
	 wtdurave(i,k,6,n,l)=wtdurave(i,k,6,n,l)+wtdurave(i,k,ibrap,n,l)
      wtdurave(i,5,ibrap,n,l)=wtdurave(i,5,ibrap,n,l)
     *  +wtdurave(i,k,ibrap,n,l)
       wtdurave(i,5,6,n,l)=wtdurave(i,5,6,n,l)+wtdurave(i,k,ibrap,n,l)
      enddo !ibrap
      enddo !l      
      enddo !i
      enddo !k      
      enddo !n          
      

      do n=1,2      
      do i=1,2          
      do l=1,2
          do k=1,2
      do ibrap=1,5              
	  exhazi0(k,l,i,6,n)=exhazi0(k,l,i,6,n)+exhazi0(k,l,i,ibrap,n)
        enddo
      enddo !k
      enddo !l
      enddo !i      
      enddo !n      
      
      
      do n=1,2    
      do ibrap=1,5          
      do j=1,2          
      do i=1,thazt
      exhazi(i,j,6,n)=exhazi(i,j,6,n)+exhazi(i,j,ibrap,n)
      enddo !i
      enddo !j      
      enddo !ibrap
      enddo !n
      
      
      do l=1,3      
      do n=1,2              
          do ibrap=1,5        
      do i=2,thazt
      wtduravin(i,6,n,l)=wtduravin(i,6,n,l)+wtduravin(i,ibrap,n,l)
          enddo !i
      enddo !ibrap          
      enddo !n
      enddo !l      

      
!*************************************
!***** Duration Accepted wages end           
!*************************************      
      

!************************************************************************************************************
!     Producing tables
!************************************************************************************************************
      if (iproduce.eq.1)then
      include 'producing.f' 
      endif

      include 'tablemoment.f'
      
!************************************
!     Descriptive stats done
!************************************
         include 'report.f'
      
      return
      end

      
      subroutine  build_array(xmn,xmx,nx,xx)
	implicit none
	real*8 xx(nx),x,grid,xmn,xmx
      integer nx,i

	grid=(xmx-xmn)/(nx-1)
      x=xmn!+grid/2
	do i=1,nx
          xx(i)=x
        x=x+grid
      end do
      
      return
      end
      
      
      subroutine build_array_exp2(wmn,wmx,nx,xx,xmn,xmx)
	implicit none
	real*8 xx(0:nx,2),x,grid,xmn,xmx,wmn,wmx
      integer nx,i

      xmx=log(wmx)
      xmn=log(wmn)
      
	grid=(xmx-xmn)/nx
      x=xmn+grid/2
	do i=1,nx
          xx(i,1:2)=exp(x)
        x=x+grid
      end do
  	  xx(0,1:2)=0.d0       
      
      return
      end

      
      subroutine read_data(filedata,nmquest,ts,tl,ta,
     * ama,w1m,w2m,i1m,i2m,ip1m,ip2m,iq1m,iq2m)   
	implicit none
	intrinsic max,min,abs,int      
     	character*30 filedata
      integer	nn,nmquest,nmobs,npeople
      parameter(nmobs=48,npeople=140000)             
	real*8 ama(npeople,nmobs),w1m(npeople,nmobs),w2m(npeople,nmobs)
 	integer	i1m(npeople,nmobs),i2m(npeople,nmobs)
      integer	ip1m(npeople,nmobs),ip2m(npeople,nmobs)    
      integer	iq1m(npeople,nmobs),iq2m(npeople,nmobs)
	integer ts(npeople),tl(npeople),ta(npeople)
	integer	i,j,t
      integer iassi,init,i1,iostatus
      
	real*8	 w1,w2,at
	integer he,we,hleft,wleft,holf,wolf,hemp,wemp      
	real*8  amn,amx,wmx,wmn,umx,umn
	real*8  gridu
	common /bounds/ umn,umx,wmn,wmx,amn,amx,gridu
      
      
!**************************************************************************
!     Read the data from the sample
!**************************************************************************
!	open (301,file= "C:\Users\silvio\Documents\Nacho\sipp2\"//filedata)
      	open (301,file=filedata)
!          read (301,*) nn,nmquest
!          write(*,*)nn,nmquest,'nn'
	    i1=0
	    i1m  = -9
	    i2m  = -9
	    iq1m  = -1
	    iq2m  = -1
	    ip1m  = -1
	    ip2m  = -1
	    init=0
          
          ama=-9.d0
          w1m=-9.d0
          w2m=-9.d0
          
          t=0
	    i=0
!          nn=0
      do j=1,100000
	 read (301,*,iostat=iostatus) i1,
     *  t,he,we,hemp,wemp,hleft,wleft,holf,wolf,w1,
     *	w2,at
       if(iostatus.gt.0)then
          write(*,*) 'check input.  something was wrong'
      exit
      else if (iostatus < 0) then
!      write(*,*)  'the total is ', nn,i
      exit
      else
!      nn=nn+1
      end if

           
!       write(*,*) i1,t,he,we,hemp,wemp,hleft,wleft,holf,wolf,w1,
!     *	w2,at
       if(init.ne.i1) then
	 i=i+1
	 ts(i)=t
	 iassi=0
	 endif
       if(at.ne.-9.and.iassi.eq.0) then
	 ta(i)=t
	 iassi=1
	endif
	 tl(i)=t
	 init=i1

		i1m(i,t) = he
		i2m(i,t) = we
          
		iq1m(i,t) = hleft !quit=1, layoff=0
		iq2m(i,t) = wleft

!		if1m(i,t) = holf
!		if2m(i,t) = wolf

		ip1m(i,t) = hemp
		ip2m(i,t) = wemp              
          
          
          if(he.eq.0) then
			w1m(i,t) = 0.d0
          else
			w1m(i,t) =w1
!			w1m(i,t) = max(min(w1,wmx),wmn) !w cap              
		endif
		if(we.eq.0)then
			w2m(i,t) = 0.d0
          else
			w2m(i,t) = w2
!			w2m(i,t) = max(min(w2,wmx),wmn) !w cap              
          endif	
!		ama(i,t)=min(at,amx)              !a cap
		ama(i,t)=at
      enddo      	!j nn
      nmquest=i
      nn=j-1
      write(*,*)nn,nmquest
!      read(*,*)
      close (301)

      return
      end
     
     
      
      
     
     
      subroutine report_exercises
	implicit none
	intrinsic max,min,abs,int  
      integer irep,i,j
      integer iwhat,inu,npy,ix,fin    
      integer ifecha(8)
      common /index/ iwhat,inu,npy,ix,fin      
      character*12 xac      
      character*4 hep(10),heq,heq2
      character*100 xtitlef(30)  
      character*30 filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes,
     *     fileorp,
     *    filetexr,filetexa,filetex,filemomx
      common /files/ filepara,filetests,filedata,fileresults,
     *    fileresome,fileresomedes,fileorp,
     *    filetexr,filetexa,filetex,filemomx,xtitlef,heq,heq2
      character*30 filexercises
      real*8 xexercise(30,30,5)      
      common /exercise/ xexercise      
	character*50 xlabel(0:37)      
      integer m
      
	real*8	xdef,xtolu,bet,r,mtot,xrbet
	common /params/ xdef,xtolu,bet,r,mtot
     
	real*8  sig,bmin(2),xlu(2),xle(2),xlo(2),xt(2),xm(2)
     *        ,std(2),slei(3),spar,slow,shigh,a0,splow,sphigh
	common /pars/ sig,bmin,xlu,xle,xlo,xt,xm,std,
     *        slei,spar,slow,shigh,a0,splow,sphigh
!*******************************     
	integer types,ntypes,indi_type(2,4),ltypes
	common /itypes/ indi_type,ntypes,ltypes,types
	real*8 xptypes(4),xm_types(2,2),slei_types(2,2)
	common /types/ xm_types,slei_types,xptypes


      
      xac="Exercises"
      
      filexercises='exercises_'//trim(heq2)//'.tex'       
      
	open (501,file=filexercises)   !TeX
      write(501,*) '\documentclass[12pt]{article}'
      write(501,*) '\setlength{\textwidth}{6in}'
      write(501,*) '\setlength{\textheight}{8.5in}'
      write(501,*) '\setlength{\topmargin}{0.25in}'
      write(501,*) '\setlength{\oddsidemargin}{0.25in}'
      write(501,*) '\setlength{\footskip}{0.4in}'
      write(501,*) '\setlength{\headheight}{0.0in}'
      write(501,*) '\setlength{\headsep}{0.5in}'
!      write(501,*) '\input tcilatex'

      write(501,*) ''
      write(501,*) '\begin{document}'
      write(501,*) '\renewcommand{\baselinestretch}{1}'
	write(501,*) '\pagestyle{myheadings}'
	write(501,*) '\markright{Family Job Search and Wealth. '
	write(501,*) "Garc\'{\i}a-P\'erez and Rendon. "
      write(501,"(i4,'/',i2,'/',i2,' ',i4,':',i2,' ',i2,'.',i3)") 
     * ifecha(1),ifecha(2),ifecha(3),ifecha(5),
     *   ifecha(6),ifecha(7),ifecha(8)
	write(501,*) " }"      
!      write(501,*) '\small '
      write(501,*) ''

      write(501,*) '{\Large ',xac,' ',heq2,' }'
      
      

!************************************
!     Parameter values 
!************************************
      write(501,*) '{\small' 
      write(501,*) '\begin{center}'           
      write(501,*) '\begin{tabular}{ccc}'
      write(501,*) '\hline \hline'      
      write(501,*) '\multicolumn{3}{c}{Parameter values} \\ '
      write(501,*) '\multicolumn{3}{c}{Baeline Parameters} \\ '
      write(501,*) '\hline \hline'
      write(501,"(1x,a40,f10.4,1x,a4)")
     *  '$\beta $ & \multicolumn{2}{c}{',bet,'}\\'
      write(501,"(1x,a40,f10.4,1x,a4)")
     *  '$r$ & \multicolumn{2}{c}{',r,'}\\'
      write(501,"(1x,a40,f10.4,1x,a4)")
     *  '$\gamma $ & \multicolumn{2}{c}{',sig,'}\\'
      write(501,"(1x,a40,f10.4,1x,a4)")
     *  '$s$ & \multicolumn{2}{c}{',spar,'}\\'
      write(501,"(1x,a40,f10.4,1x,a4)")
     *  '$\vartheta_3$ & \multicolumn{2}{c}{',slei(3),'}\\'
      write(501,*) '& husband & wife \\ \hline'
    
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$b$ &',bmin(1),'&',bmin(2),'\\'
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\lambda$ &',xlu(1),'&',xlu(2),
     *  '\\'
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\pi$ &',xlo(1),'&',xlo(2),'\\'
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\theta $ &',xt(1),'&',xt(2),'\\'
      
      
!      do types=ltypes,ntypes
!	write(501,"(a20,2(i1,1x),a5,2(1x,f10.4,1x,a4))")'
!     * $\mu_{',indi_type(1,types),indi_type(2,types),'} $ &',
!     * xm_types(1,indi_type(1,types)),'&',
!     * xm_types(2,indi_type(2,types)),'\\'      
!      enddo      
       if(ntypes.eq.ltypes)then
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\mu$ &',xm(1),'&',xm(2),'\\'
      endif
      
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\sigma$ &',std(1),'&',std(2),'\\'
!      do types=ltypes,ntypes
!	write(501,"(a20,2(i1,1x),a5,2(1x,f10.4,1x,a4))")'
!     * $\vartheta_{',indi_type(1,types),indi_type(2,types),'} $ &',
!     * slei_types(1,indi_type(1,types)),'&',
!     * slei_types(2,indi_type(2,types)),'\\'      
!      enddo      
       if(ntypes.eq.ltypes)then
	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\vartheta$ &',slei(1),'&',
     * slei(2),'\\'      
      endif
      
!      if(ntypes.gt.ltypes)then
!	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\Pr(1 2)$ &',
!     * xptypes(1),'&',xptypes(2),'\\'      
!	write(501,"(a20,2(1x,f10.4,1x,a4))")'$\Pr(3 4)$ &',
!     * xptypes(3),'&',xptypes(4),'\\'      
!      endif
      
      write(501,*) '\hline\hline'
      write(501,*) '\end{tabular}'
      write(501,*) '\end{center}'                  
      write(501,*) '}'
      write(501,*) ' ' 
!      write(501,*) '\vspace{1.5cm}'
      write(501,*) '\bigskip'       
      write(501,*) ' ' 

      if(ntypes.gt.ltypes)then
      write(501,*) '{\small' 
      write(501,*) '\begin{center}'           
      write(501,*) '\begin{tabular}{rrrrrrrrr}'
      write(501,*) '\multicolumn{9}{c}{Parameters by Type} \\ '      
      write(501,*) '\hline \hline'      
      write(501,*) '\multicolumn{3}{c}{Types} & &'
      write(501,*) '\multicolumn{5}{c}{Parameter values} \\ '
      write(501,*) 'Type & Husband & Wife & & $\mu_1$ & $\mu_2$ 
     *  &    $\vartheta_1$ & $\vartheta_2$ & $\Pr$(Type) \\ '      
      write(501,*) '\hline \hline'
      
      do types=ltypes,ntypes
      write(501,"(3(i4,' & '),5(' & ',f15.4),' \\')") types,
     *   indi_type(1,types),indi_type(2,types),
     *  xm_types(1,indi_type(1,types)),xm_types(2,indi_type(2,types)),
     *slei_types(1,indi_type(1,types)),slei_types(2,indi_type(2,types)),
     * xptypes(types)
      enddo
      write(501,*) '\hline\hline'
      write(501,*) '\end{tabular}'
      write(501,*) '\end{center}'                  
      write(501,*) '}'
      write(501,*) ' ' 
!      write(501,*) '\vspace{1.5cm}'
      write(501,*) '\bigskip'       
      write(501,*) ' ' 
      endif
      
	do types=ltypes,ntypes
!************************************
!     Exercises paper
!************************************
      write(501,*) '{\small'
      write(501,*) '\begin{center}'            
      write(501,*) '\begin{tabular}{lrrrrrr}'
      write(501,*) '\multicolumn{7}{c}{Table 8. Effects on 
     * Employment, Wages and Wealth of Three Regime Changes:} \\' 
      write(501,*) '\multicolumn{7}{c}{i. An Economic Downturn, ii. 
     * Relaxing Borrowing Constraints, and} \\ '
      write(501,*)'\multicolumn{7}{c}{iii. Increasing Unemployment 
     *     Transfers. Types=',types,'} \\'
      write(501,*)'\hline\hline'
      write(501,*)'Variable & \multicolumn{2}{c}{Economic Downturn}'
      write(501,*)'& \multicolumn{1}{c}{Increase} &'
      write(501,*) '\multicolumn{3}{c}{Unemployment Transfers} \\'
      write(501,*)'\cline{2-3}\cline{5-7}'
      write(501,*)'& \multicolumn{1}{c}{Husband} &'
      write(501,*)'\multicolumn{1}{c}{Wife} &' 
      write(501,*)'\multicolumn{1}{c}{Debt Limit} &'
      write(501,*)'\multicolumn{1}{c}{Husband} &' 
      write(501,*)'\multicolumn{1}{c}{Wife} &' 
      write(501,*)'\multicolumn{1}{c}{Both} \\'
      write(501,*)'& '
      write(501,*)'\multicolumn{1}{c}{$+\theta _{1}$} &' 
      write(501,*)'\multicolumn{1}{c}{$+\theta _{2}$} &' 
      write(501,*)'\multicolumn{1}{c}{$+s$} &'
      write(501,*)'\multicolumn{1}{c}{$+b_{1}$} &' 
      write(501,*)'\multicolumn{1}{c}{$+b_{2}$} &'
      write(501,*)'\multicolumn{1}{c}{$+b_{1},+b_{2}$} \\' 
      write(501,*) '\hline\hline'
      write(501,*) 'Joint Employment Status (\%) &'
      write(501,*)'\multicolumn{1}{r}{} & \multicolumn{1}{r}{} &' 
      write(501,*)'\multicolumn{1}{r}{} & \multicolumn{1}{r}{} &'
      write(501,*)'\multicolumn{1}{r}{} & \multicolumn{1}{r}{} \\'

!      write(501,*) ' &  &  &  &  & &  \\ '     
      xlabel(1)='\ \ \ uu'
      xlabel(2)='\ \ \ ue'
      xlabel(3)='\ \ \ eu'
      xlabel(4)='\ \ \ ee'

      do i=1,4
      write(501,1520)xlabel(i),
     *      (xexercise(j,i,types)-xexercise(1,i,types)+0.005,j=2,7)      
      enddo
      
      xlabel(6)='\ \ \ Husband'
      xlabel(8)='\ \ \ Wife'
      
      write(501,*) 'Unemployment Rate$^{\ast }$ (\%) &  &  &  &  &'
      write(501,*) '&  \\ '
      do i=6,8,2
      write(501,1520)xlabel(i),
     *  (xexercise(j,i,types)-xexercise(1,i,types)+0.005,j=2,7)      
      enddo
 
      write(501,*) 'Wages$^{\ast }\ $(\$) &'
      write(501,*) '&  &  &  &  &  \\'
      xlabel(10)='\ \ \ Husband'
      xlabel(12)='\ \ \ Wife'

      do i=10,12,2
      write(501,1522)xlabel(i),
     *  (int(xexercise(j,i,types)-xexercise(1,i,types)),j=2,7)      
      enddo
      
      write(501,*) '& \multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} & '
      write(501,*) '\multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} \\'
      write(501,*) '\ Wealth$^{\ast \ast }$ (\$) \'
      write(501,*) '\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \'
      write(501,*) '\ \ \ \ \ \ \ '
      i=16
      write(501,1522) ' ',
     *   (int(xexercise(j,i,types)-xexercise(1,i,types)),j=2,7)       

      write(501,*) '\hline\hline'
      write(501,*)'\multicolumn{7}{l}{$^{\ast }$ if the spouse'
      write(501,*)'is employed. $^{\ast \ast }$\ if'
      write(501,*)'both are employed.}%'
      write(501,*) '\end{tabular}'
      write(501,*) '\end{center}'            
      write(501,*) '}'
      write(501,*) ' ' 
      write(501,*) '\vspace{1.5cm}'
      write(501,*) ' ' 
      
!************************************
!     Exercises paper \end
!************************************
	enddo
	types=5
!************************************
!     Exercises paper
!************************************
      write(501,*) '{\small'
      write(501,*) '\begin{center}'            
      write(501,*) '\begin{tabular}{lrrrrrr}'
      write(501,*) '\multicolumn{7}{c}{Table 8. Effects on 
     * Employment, Wages and Wealth of Three Regime Changes:} \\' 
      write(501,*) '\multicolumn{7}{c}{i. An Economic Downturn, ii. 
     * Relaxing Borrowing Constraints, and} \\ '
      write(501,*)'\multicolumn{7}{c}{iii. Increasing Unemployment 
     *     Transfers. All types} \\'
      write(501,*)'\hline\hline'
      write(501,*)'Variable & \multicolumn{2}{c}{Economic Downturn}'
      write(501,*)'& \multicolumn{1}{c}{Increase} &'
      write(501,*) '\multicolumn{3}{c}{Unemployment Transfers} \\'
      write(501,*)'\cline{2-3}\cline{5-7}'
      write(501,*)'& \multicolumn{1}{c}{Husband} &'
      write(501,*)'\multicolumn{1}{c}{Wife} &' 
      write(501,*)'\multicolumn{1}{c}{Debt Limit} &'
      write(501,*)'\multicolumn{1}{c}{Husband} &' 
      write(501,*)'\multicolumn{1}{c}{Wife} &' 
      write(501,*)'\multicolumn{1}{c}{Both} \\'
      write(501,*)'& '
      write(501,*)'\multicolumn{1}{c}{$+\theta _{1}$} &' 
      write(501,*)'\multicolumn{1}{c}{$+\theta _{2}$} &' 
      write(501,*)'\multicolumn{1}{c}{$+s$} &'
      write(501,*)'\multicolumn{1}{c}{$+b_{1}$} &' 
      write(501,*)'\multicolumn{1}{c}{$+b_{2}$} &'
      write(501,*)'\multicolumn{1}{c}{$+b_{1},+b_{2}$} \\' 
      write(501,*) '\hline\hline'
      write(501,*) 'Joint Employment Status (\%) &'
      write(501,*)'\multicolumn{1}{r}{} & \multicolumn{1}{r}{} &' 
      write(501,*)'\multicolumn{1}{r}{} & \multicolumn{1}{r}{} &'
      write(501,*)'\multicolumn{1}{r}{} & \multicolumn{1}{r}{} \\'

!      write(501,*) ' &  &  &  &  & &  \\ '     
      xlabel(1)='\ \ \ uu'
      xlabel(2)='\ \ \ ue'
      xlabel(3)='\ \ \ eu'
      xlabel(4)='\ \ \ ee'

      do i=1,4
      write(501,1520)xlabel(i),
     *      (xexercise(j,i,types)-xexercise(1,i,types)+0.005,j=2,7)      
      enddo
      
      xlabel(6)='\ \ \ Husband'
      xlabel(8)='\ \ \ Wife'
      

      write(501,*) 'Unemployment Rate$^{\ast }$ (\%) &  &  &  &  &'
      write(501,*) '&  \\ '
      do i=6,8,2
      write(501,1520)xlabel(i),
     *  (xexercise(j,i,types)-xexercise(1,i,types)+0.005,j=2,7)      
      enddo
 
      write(501,*) 'Wages$^{\ast }\ $(\$) &'
      write(501,*) '&  &  &  &  &  \\'
      xlabel(10)='\ \ \ Husband'
      xlabel(12)='\ \ \ Wife'

      do i=10,12,2
      write(501,1522)xlabel(i),
     *  (int(xexercise(j,i,types)-xexercise(1,i,types)),j=2,7)      
      enddo
      
      write(501,*) '& \multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} & '
      write(501,*) '\multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} &'
      write(501,*) '\multicolumn{1}{r}{} \\'
      write(501,*) '\ Wealth$^{\ast \ast }$ (\$) \'
      write(501,*) '\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \'
      write(501,*) '\ \ \ \ \ \ \ '
      i=16
      write(501,1522) ' ',
     *   (int(xexercise(j,i,types)-xexercise(1,i,types)),j=2,7)       

      write(501,*) '\hline\hline'
      write(501,*)'\multicolumn{7}{l}{$^{\ast }$ if the spouse'
      write(501,*)'is employed. $^{\ast \ast }$\ if'
      write(501,*)'both are employed.}%'
      write(501,*) '\end{tabular}'
      write(501,*) '\end{center}'            
      write(501,*) '}'
      write(501,*) ' ' 
      write(501,*) '\vspace{1.5cm}'
      write(501,*) ' ' 
      
!************************************
!     Exercises paper \end
!************************************
      
      close(501)      
!************************************
!     Exercises paper \end
!************************************
520   format(1x,a50,7(1x,' & ',1x,f10.2), !' & ',
     * 4(1x,' & ',1x,f10.2),' \\')
 522  format(1x,a50,7(1x,' & ',1x,i10),!' & ',
     * 4(1x,' & ',1x,i10),' \\')

1520  format(1x,a50,6(1x,' & ',1x,f10.2),' \\')
 1522  format(1x,a50,6(1x,' & ',1x,i10),' \\')
            
            
      return
      end
            
      
	subroutine momentdes(fileresults,
     *  thazt,xmoment,xlmoment,nmoment,filetex,xac,itex,iproduce)
      implicit none
      real*8 xexercise(30,30,5)      
      character*30 fileresults
      common /exercise/ xexercise      
	integer i,j,k,l,m,n,nmquest,nmobs,nw,jj,kk,lm,ll,kmlag,t,mm
	integer itex,ii,jp,kp,jq,kq,nmoment,lk,maxmom,iproduce
	parameter (maxmom=20000,nmobs=48)
	real*8  w1old,w1now,w2old,w2now,amanow,amaold
      integer iwhat,inu,npy,ix,fin      
      integer ifecha(8)
      common /index/ iwhat,inu,npy,ix,fin      
!	Output of desmoment
	real*8 xenum(0:2,0:2),xewag(0:2,0:2,2,2),xeass(0:2,0:2,3),
     *    xwnum(0:6,0:6),xeasst(0:2,0:2,nmobs,3),xenumt(0:2,0:2,nmobs),
     *    xewagt(0:2,0:2,nmobs,2,2),
     *  xwass(0:6,0:6,3),xass(6,11),xetnum(5,5),xetnumr(5,5),
     * xetnumc(5,2,2),      
     * xetnumqp(5,5,-1:2,-1:2,-1:2,-1:2),  
     * xetnuqp(5,10,2,2),       
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
     	character*30 filetex,filemomx, filepara,
     *    filedata,filehaz1,filehaz2
      integer istanda(maxmom),ichimo(maxmom),iproba(maxmom)      
!	Thresholds
	real*8  amn,amx,wmx,wmn,umx,umn,ran1
	real*8 a1,a2,a3,a4,w1,w2,w3,w4,gridu
	common /bounds/ umn,umx,wmn,wmx,amn,amx,gridu            
      double precision xmoment(maxmom)
      integer icihimo(maxmom)
      character*80 xlmoment(maxmom)
	integer ie(2),jw1,jw2,jbr1,jbr2,lmg,iass
      integer iq1,iq2,ip1,ip2,tbeg,itable
	integer iao1,ielagi(2),ibra1,jbr1m,jbr2m
	integer ienow,ielag,irep,ibra,ielaga,ibrap,iacount
      integer i1,i2
      integer thaz,isi,ise,isx,itoti,inch,
     *thazt,thazi(2),isim(2),isem(2),isxm(2),
     *thazti(2)
      real*8 ehaz(nmobs,0:4,4,-1:4,6)
      real*8 xtoti
!	Brackets
      character*25 xlabel(0:37),xlabelj(0:47)
      character*25 xlabelk(0:47)      
      character*7 xgender(2)
      character*10 xac
      real*8 chi2m(maxmom)      
      common /migra4/ chi2m
      double precision xdeno
!*******************************
	integer types,ntypes,indi_type(2,4),ltypes
	common /itypes/ indi_type,ntypes,ltypes,types
	real*8 xwdi(3)
      
      xdeno=1.d-20      
      
      
      
      include 'thresholds.f'                  
      
      xgender(1)='Husband'
      xgender(2)='Wife'
          
      
      include 'momentable.f'      
      
!************************************************************************************************************
!     Producing tables
!************************************************************************************************************
      if (iproduce.eq.1)then
      include 'producing.f' 
      include 'tablemoment.f'      
      endif

      
!************************************
!     Descriptive stats done
!************************************
         include 'report.f'
      
      
     
!************************************
!     Moments were transferred to tables
!************************************

      if(iwhat.eq.4.and.itex.eq.1)then                
      xexercise(ix,1:30,types)=0.d0
      
      xexercise(ix,1,types)=100*xenum(0,0)
      xexercise(ix,2,types)=100*xenum(0,1)
      xexercise(ix,3,types)=100*xenum(1,0)
      xexercise(ix,4,types)=100*xenum(1,1)
      
      xexercise(ix,5,types)=100.d0*xenum(0,0)/xenum(2,0)
      xexercise(ix,6,types)=100.d0*xenum(0,1)/xenum(2,1)
      xexercise(ix,7,types)=100.d0*xenum(0,0)/xenum(0,2)
      xexercise(ix,8,types)=100.d0*xenum(1,0)/xenum(1,2)

      xexercise(ix,9,types)=xewag(1,0,1,1)
      xexercise(ix,10,types)=xewag(1,1,1,1)

      xexercise(ix,11,types)=xewag(0,1,2,1)
      xexercise(ix,12,types)=xewag(1,1,2,1)

      xexercise(ix,13,types)=xeass(0,0,1)
      xexercise(ix,14,types)=xeass(0,1,1)

      xexercise(ix,15,types)=xeass(1,0,1)
      xexercise(ix,16,types)=xeass(1,1,1)
      
      endif
      
      return
      end
