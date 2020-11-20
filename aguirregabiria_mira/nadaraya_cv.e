new ;
closeall ;

/*****************************************************/
/* Example that calls the procedure NADARAYA_CV.SRC  */
/*****************************************************/
library myprocs pgraph ;

/****************/
/* 1. Constants */
/****************/
@ Simulating data: normal @
nobs = 200 ;
meanx = 1 ;
sdx = 5 ;
a0 = 1000 ;
a1 = 0.5 ;
a2 = -1 ;
a3 = 0.1 ;
sdeps = 10 ;

seed = 4720756 ;
x = meanx + sdx*rndns(nobs,1,seed) ;

eps = sdeps*rndns(nobs,1,seed) ;
y = a0 + a1*x + a2*x.*x + a3*x.*x.*x + eps ;

@ Percentiles: values of x in which the kernel estimator is obtained @
xval = quantile(x,seqa(1,1,99)/100) ;

@ True m(x) @
mtrue = a0 + a1*xval + a2*xval.*xval + a3*xval.*xval.*xval ;

@ Kernel m(x) @
hgrid = 1.06*stdc(x)*(nobs^(-.2)) ;
hgrid = (seqa(140,1,20)/1000)*hgrid ;

{mkern,hopt,cvfun} = nadaraya_cv(x,y,xval,hgrid,1) ;

title("True and Kernel regressions") ;
xlabel("x") ;
ylabel("m(x)") ;
xy(xval,mtrue~mkern) ;

end ;




