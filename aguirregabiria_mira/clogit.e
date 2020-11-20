new ;
closeall ;

/************************************************/
/* Example that calls the procedure CLOGIT.SRC  */
/************************************************/
library myprocs pgraph ;

/****************/
/* 1. Constants */
/****************/
nalt = 5 ;
nobs = 2000 ;
npar = 3 ;

meanz = ones(nalt*npar,1) ;
sdz = 2* rndu(nalt*npar,1) ;
meanr = zeros(nalt,1) ;
sdr = rndu(nalt,1) ;
bmat = (1|2|3) ;

/******************/
/* 2. Simulations */
/******************/
zobs = (meanz') + (sdz').*rndn(nobs,nalt*npar) ;
robs = (meanr') + (sdr').*rndn(nobs,nalt) ;
eps = -ln(-ln(rndu(nobs,nalt))) ;
yobs = zeros(nobs,nalt) ;
j=1 ;
do while j<=nalt ;
  yobs[.,j] = zobs[.,npar*(j-1)+1:npar*j]*bmat + robs[.,j] + eps[.,j] ;
  j=j+1 ;
endo ;
yobs = maxindc(yobs') ;
  

/*****************/
/* 3. Estimation */
/*****************/
namesb = "b1" | "b2" | "b3" ;

{best, varest} = clogit(yobs,zobs,robs,namesb) ;
