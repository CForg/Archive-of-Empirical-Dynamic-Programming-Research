new ;
closeall ;
/***********************************************************************/ 
/*  NPL_SING_E                                                         */ 
/*  This program estimates John Rust's bus engine replacement model    */
/*  (Rust, Econometrica 1987) using the Nested Pseudo Likelihood (NPL) */
/*  algorithm in Aguirregabiria and Mira (Econometrica, 2002).         */
/*                                                                     */ 
/*  by Victor Aguirregabiria                                           */ 
/*                                                                     */ 
/*  First version: September, 2001                                     */ 
/*  Last version: January, 2007                                        */
/*                                                                     */ 
/***********************************************************************/ 

library nplprocs pgraph gauss ;
format /mb1 /ros 16,4 ;

/*********************/ 
/* 0. Some constants */ 
/*********************/ 
@ Names of structural parameters @
namespar = "ReplaceC" | "MaintenC" ;

@ Value of discount factor @               
beta = 0.99 ;

@ Number of state variables @
kvarx = 1 ;

@ Number of choice alternatives @
jchoice = 2 ;

@ Number of cells in discretization of the state variable @
ncelx = 201 ;

@ Number of observations @
nobs = 8260 ;   

@ Number of individuals (bus engines) in the data @
nindiv = 104 ;

@ Datafile @
filedat  = "c:\\MYPAPERS\\KPIE\\bus1234.dat" ;  

"" ;
"/******************************/" ; 
"/* 1. Reading Rust's bus data */" ; 
"/******************************/" ; 
open dtin = ^filedat for read varindxi ;
data = readr(dtin,nobs);

iobs = data[.,ibusid] ;     @ individuals (buses) ID's @
aobs = data[.,idrep] ;      @ Replacement decision @
xobs = data[.,iaccumile] ;  @ Cumulative mileage @
xobs = xobs/1e6 ;

"" ;
"/********************************************************/" ;
"/* 2. Discretization of the decision and state variable */" ;
"/********************************************************/" ;
aval = (0|1) ;
indobsa = aobs+1 ; @ indaobs should be 1,2,...,J @

minx = quantile(xobs,0.01) ;
maxx = quantile(xobs,0.99) ;
stepx = int(1e6*(maxx-minx)/(ncelx-1) )/1e6 ;
xthre = seqa(minx+stepx,stepx,ncelx-1) ;
xval = seqa(minx,stepx,ncelx) ;
indobsx = discthre(xobs,xthre) ;

"" ;
"/****************************************/" ;
"/* 3. Specification of utility function */" ;
"/****************************************/" ;
zmat1 = zeros(ncelx,1) ~ (-xval[.,1]) ;
zmat2 = (-ones(ncelx,1)) ~ zeros(ncelx,1) ;
zmat = zmat1 ~ zmat2 ;
clear zmat1, zmat2 ;

"" ;
"/****************************************************************/" ;
"/* 4. Estimation of transition probabilities of state variables */" ;
"/****************************************************************/" ;
@ Nonparametric PDF of additional mileage @
iobs_1 = (0|iobs[1:nobs-1]) ;
xobs_1 = (0|xobs[1:nobs-1]) ;
aobs_1 = (0|aobs[1:nobs-1]) ;
dxobs = (1-aobs_1).*(xobs-xobs_1) + aobs_1.*xobs ;
dxobs = selif(dxobs,(iobs.==iobs_1)) ;
mindx = 0 ;
maxdx = quantile(dxobs,0.999) ;
numdx = 2 + int(maxdx/stepx) ;
dxval = seqa(0,stepx,numdx) ;
pdfdx = kernel1(dxobs,dxval) ;
pdfdx = pdfdx./sumc(pdfdx) ;

@ Transition matrices @
fmat2 = ones(ncelx,1).*.((pdfdx')~zeros(1,ncelx-numdx)) ;
fmat1 = (pdfdx')~zeros(1,ncelx-numdx) ;
j=2 ;
do while j<=(ncelx-1) ;
  colz = ncelx - (j-1+numdx) ;
  if (colz>0) ;
    fmat1 = fmat1 | (zeros(1,(j-1))~(pdfdx')~zeros(1,colz)) ;
  elseif (colz==0) ;
    fmat1 = fmat1 | (zeros(1,(j-1))~(pdfdx')) ;
  elseif (colz<0) ;
    buff = pdfdx[1:numdx+colz-1] | sumc(pdfdx[numdx+colz:numdx]) ;
    fmat1 = fmat1 | (zeros(1,(j-1))~(buff')) ;
  endif ;
  j=j+1 ;
endo ;
fmat1 = fmat1 | (zeros(1,ncelx-1)~1) ;

"" ;
"/***********************************/" ;
"/* 5. Initial choice probabilities */" ;
"/***********************************/" ;
xprob0 = ones(ncelx,1)
        ~xval[.,1]
        ~(xval[.,1].*xval[.,1])
        ~(xval[.,1].*xval[.,1].*xval[.,1]) ;
{best,varest} = multilog(indobsa,xprob0[indobsx,.]) ;
best = reshape(best,jchoice-1,cols(xprob0))' ;
prob0 = 1./(1+exp(-xprob0 * best)) ;
prob0 = (1-prob0)~prob0 ;

"" ;
"/***************************/" ;
"/* 6. Sructural estimation */" ;
"/***************************/";
{tetaest,varest,pest} =
npl_sing(indobsa,indobsx,zmat,prob0,beta,fmat1~fmat2,namespar);

end ;