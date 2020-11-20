new ;
closeall ;

/**************************************************/
/* Example that calls the procedure MULTILOG.SRC  */
/**************************************************/
library myprocs pgraph ;

/****************/
/* 1. Constants */
/****************/
nalt = 5 ;
nobs = 5000 ;
npar = 4 ;

meanx = ones(1,npar-1) ;
sdx = 2* rndu(1,npar-1) ;
bmat = (0.0|0.0|0.0|0.0)
     | (-1.0|1.0|2.0|3.0) 
     | (-2.0|1.1|2.1|3.1)
     | (-3.0|1.2|2.2|3.2) 
     | (-4.0|1.3|2.3|3.3) ;

/******************/
/* 2. Simulations */
/******************/
xobs = meanx + sdx.*rndn(nobs,npar-1) ;
xobs = ones(nobs,1)~xobs ;
eps = -ln(-ln(rndu(nobs,nalt))) ;
yobs = zeros(nobs,nalt) ;
j=1 ;
do while j<=nalt ;
  yobs[.,j] = xobs * bmat[npar*(j-1)+1:npar*j] + eps[.,j] ;
  j=j+1 ;
endo ;
yobs = maxindc(yobs') ;

meanc(yobs.==seqa(1,1,nalt)');

/*****************/
/* 3. Estimation */
/*****************/
namesb = ("b0_1" | "b1_1" | "b2_1" | "b3_1")
       | ("b0_2" | "b1_2" | "b2_2" | "b3_2")
       | ("b0_3" | "b1_3" | "b2_3" | "b3_3")
       | ("b0_4" | "b1_4" | "b2_4" | "b3_4") ;

{best, varest} = multilog(yobs,xobs) ;







