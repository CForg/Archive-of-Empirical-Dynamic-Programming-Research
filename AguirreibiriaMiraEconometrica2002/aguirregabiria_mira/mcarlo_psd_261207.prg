<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=windows-1252"></HEAD>
<BODY><PRE>new ;
closeall ;

/********************************************************/ ;
/*  mcarlo_psd_1207.prg                                 */ ;
/*                                                      */ ; 
/*  This programs replicates the Monte Carlo experiment */ ;
/*  in the paper by Pesendorfer and Schmidt-Dengler     */ ;  
/*  (REStud, 2008)                                      */ ;
/*                                                      */ ;
/*  by Victor Aguirregabiria				*/ ;
/*  This version: December 29, 2007                     */ ;
/*                                                      */ ;
/********************************************************/ ;

library pgraph ;

@ -------------- @
@  OUTPUT FILE   @
@ -------------- @  
wdir = "c:\\mypapers\\psd_mcarlo\\progau\\" ;
buff = changedir(wdir) ;
fileout  = "mcarlo_psd_1207.out" ;
output file = ^fileout reset ;
format /mb1 /ros 16,4 ;

@ -------------- @
@   PARAMETERS   @
@ -------------- @  
xv      = 0.1 ;         @ Exit value @
ce      = -0.2 ;        @ Entry cost @
pi1     = 1.2 ;         @ Monopoly  profit @
pi2     = -1.2 ;        @ Duopoly profit @
dfact   = 0.90 ;      @ Discount factor @
sigma   = 1 ;         @ Std. Dev. of eps(1)-eps(0) @

kparam  = 3 ;       @ Number of parameters to estimate @
nobs    = 10000 ;     @ Number of observations @
nrepli  = 1000 ;    @ Number of Monte Carlo replications @
npliter = 30 ;      @ Maximum number of NPL iterations @

@ vector of states is (s1,s2) @
vstate = (0~0) | (0~1) | (1~0) | (1~1) ;
nplayer = 2 ;
nstate = rows(vstate) ;

@ Equilibrium probabilities @
peq1 = (0.2674|0.3865|0.1998|0.2485) 
     ~ (0.7243|0.5795|0.7772|0.7062) ;
peq1 = 1-peq1 ;

peq2 = (0.38|0.69|0.17|0.39) 
     ~ (0.47|0.16|0.70|0.42) ;
peq2 = 1-peq2 ;

peq3 = (0.42|0.70|0.16|0.41) 
     ~ (0.42|0.16|0.70|0.41) ;
peq3 = 1-peq3 ;

@ ------------------------------------------------ @
@ ****************    PROCEDURES    ************** @
@ ------------------------------------------------ @  

@ ---------------------------------- @
@ A. PROCEDURE EQUILIBRIUM MAPPING   @
@ ---------------------------------- @  
proc (1) = equilmap(prob0);
  local ns, newprob,
        profit1_a0, profit1_a1, profit2_a0, profit2_a1,
        iptran1_a0, iptran1_a1, iptran2_a0, iptran2_a1,
        eprofit1, eprofit2, ftran, value1, value2,
        vtilda1, vtilda2 ;
  ns = rows(prob0) ;
  newprob = prob0 ;
  @ ------------------------------ @
  @ a. Vectors of expected profits @
  @ ------------------------------ @
  profit1_a0 = xv.*vstate[.,1] ;
  profit1_a1 = ce.*(1-vstate[.,1]) 
             + pi1.*(1-prob0[.,2])
             + pi2.*prob0[.,2] ;
  eprofit1 = (1-prob0[.,1]).*profit1_a0 + prob0[.,1].*profit1_a1 
           +  sigma*pdfn(cdfni(prob0[.,1])) ;

  profit2_a0 = xv.*vstate[.,2] ;
  profit2_a1 = ce.*(1-vstate[.,2]) 
             + pi1.*(1-prob0[.,1])
             + pi2.*prob0[.,1] ;
  eprofit2 = (1-prob0[.,2]).*profit2_a0 + prob0[.,2].*profit2_a1
           +  sigma*pdfn(cdfni(prob0[.,2])) ;

  @ --------------------------- @
  @ b. Transition probabilities @
  @ --------------------------- @
  @ Remember: vstate = (0~0) | (0~1) | (1~0) | (1~1) @
  iptran1_a0 = (1-prob0[.,2]) ~ prob0[.,2]  ~ zeros(ns,1)~ zeros(ns,1) ;
  iptran1_a1 = zeros(ns,1)    ~ zeros(ns,1) ~ (1-prob0[.,2]) ~ prob0[.,2] ;
    
  iptran2_a0 = (1-prob0[.,1]) ~ zeros(ns,1)    ~ prob0[.,1] ~ zeros(ns,1) ;
  iptran2_a1 = zeros(ns,1)    ~ (1-prob0[.,1]) ~ zeros(ns,1)~ prob0[.,1] ;

  @ ---------------------------- @
  @ c. Updating probabilities    @
  @ ---------------------------- @
  ftran = (1-prob0[.,1]).*(1-prob0[.,2]) 
        ~ (1-prob0[.,1]).*prob0[.,2]
        ~ prob0[.,1].*(1-prob0[.,2])
        ~ prob0[.,1].*prob0[.,2] ;
  ftran = inv(eye(ns)-dfact*ftran) ;
  value1 = ftran * eprofit1 ;
  value2 = ftran * eprofit2 ;
  vtilda1 = (profit1_a1 + dfact * iptran1_a1 * value1) ;
          - (profit1_a0 + dfact * iptran1_a0 * value1) ;
  vtilda2 = (profit2_a1 + dfact * iptran2_a1 * value2)
          - (profit2_a0 + dfact * iptran2_a0 * value2) ;
  newprob = cdfn(vtilda1/sigma) ~ cdfn(vtilda2/sigma) ;
  retp(newprob) ;
endp ;

@ ------------------------------- @
@ B. PROCEDURE TO SIMULATE DATA   @
@ ------------------------------- @  
proc (2) = simdygam(numobs,pchoice,pste,vecs) ;
  local seed, nums, nplayer, pbuff0, pbuff1, uobs, aobs_1, aobs ;
  nums = rows(vecs) ;
  nplayer = cols(pchoice) ;
  pbuff1 = cumsumc(pste) ;
  pbuff0 = cumsumc((0|pste[1:nums-1])) ;
  uobs = rndu(numobs,1) ;
  uobs = ((uobs.&gt;=(pbuff0')).*(uobs.&lt;=(pbuff1'))) * seqa(1,1,nums) ;
  aobs_1 = vecs[uobs,.] ;
  aobs = (rndu(numobs,nplayer).&lt;=pchoice[uobs,.]) ;
  retp(aobs,aobs_1) ;
endp ;

@ -------------------------------------- @
@ C. PROCEDURE for FREQUENCY ESTIMATOR   @
@ -------------------------------------- @  
proc (1) = freqprob(yobs,xobs,xval) ;
  local numx, numq, prob1, t, selx, denom, numer ; 
  numx = rows(xval) ;
  numq = cols(yobs) ;
  prob1 = zeros(numx,numq) ;
  t=1 ;
  do while t&lt;=numx ;
    selx = prodc((xobs.==xval[t,.])') ;
    denom = sumc(selx) ;
    if (denom==0) ;
      prob1[t,.] = zeros(1,numq) ;
    else ;
      numer = sumc(selx.*yobs) ;
      prob1[t,.] = (numer')./denom ;
    endif ;
    t=t+1 ;
  endo ;
  retp(prob1) ;
endp ;

@ --------------------------------------------- @
@ D. PRECEDURE for CONSTRINED PROBIT ESTIMATOR  @
@ --------------------------------------------- @  
proc (3) = miprobit(ydum,x,rest,b0,out) ;
  local myzero, nobs, nparam, eps, namesb, iter, llike,
        criter, Fxb0, phixb0, lamdab0, dlogLb0,
        d2logLb0, b1, lamda0, lamda1, Avarb, sdb, tstat,
        numy1, numy0, logL0, LRI, pseudoR2, k ;
  myzero = 1e-36 ;
  nobs = rows(ydum) ;
  nparam = cols(x) ;
  eps = 1E-6 ;
  namesb = seqa(1,1,nparam) ;
  namesb = 0 $+ "b" $+ ftocv(namesb,2,0);
  iter=1 ;
  llike = 1000 ;
  criter = 1000 ;
  do while (criter&gt;eps) ;
    if (out==1) ;
      "" ;
      "Iteration                = " iter ;
      "Log-Likelihood function  = " llike ;
      "Criterion                = " criter ;
      "" ;
    endif ;
    Fxb0 = cdfn(x*b0+rest) ;
    Fxb0 = Fxb0 + (myzero - Fxb0).*(Fxb0.&lt;myzero)
                + (1-myzero - Fxb0).*(Fxb0.&gt;1-myzero);
    llike = ydum'*ln(Fxb0) + (1-ydum)'*ln(1-Fxb0) ;
    phixb0 = pdfn(x*b0+rest) ;
    lamdab0 = ydum.*(phixb0./Fxb0) + (1-ydum).*(-phixb0./(1-Fxb0)) ;
    dlogLb0 = x'*lamdab0 ;
    d2logLb0 = -((lamdab0.*(lamdab0 + x*b0 + rest)).*x)'*x ;
    b1 = b0 - inv(d2logLb0)*dlogLb0 ;
    criter = maxc(abs(b1-b0)) ;
    b0 = b1 ;
    iter = iter + 1 ;
  endo ;
  Fxb0 = cdfn(x*b0 + rest) ;
  Fxb0 = Fxb0 + (myzero - Fxb0).*(Fxb0.&lt;myzero)
              + (1-myzero - Fxb0).*(Fxb0.&gt;1-myzero);
  llike = ydum'*ln(Fxb0) + (1-ydum)'*ln(1-Fxb0) ;
  phixb0 = pdfn(x*b0 + rest) ;
  lamda0 = -phixb0./(1-Fxb0) ;
  lamda1 =  phixb0./Fxb0 ;
  Avarb  = ((lamda0.*lamda1).*x)'*x ;
  Avarb  = inv(-Avarb) ;
  sdb    = sqrt(diag(Avarb)) ;
  tstat  = b0./sdb ;
  numy1  = sumc(ydum) ;
  numy0  = nobs - numy1 ;
  logL0  = numy1*ln(numy1) + numy0*ln(numy0) - nobs*ln(nobs) ;
  LRI    = 1 - llike/logL0 ;
  pseudoR2 = 1 - ( (ydum - Fxb0)'*(ydum - Fxb0) )/numy1 ;
  if (out==1) ;
    "Number of Iterations     = " iter ;
    "Log-Likelihood function  = " llike ;
    "Likelihood Ratio Index   = " LRI ;
    "Pseudo-R2                = " pseudoR2 ;
    "" ;
    "------------------------------------------------------------------";
    "       Parameter     Estimate        Standard        t-ratios";
    "                                     Errors" ;
    "------------------------------------------------------------------";
    k=1;
    do while k&lt;=nparam;
      print $namesb[k];;b0[k];;sdb[k];;tstat[k];
      k=k+1 ;
    endo;
    "------------------------------------------------------------------";
  endif ;
  retp(b0,Avarb,llike) ;
endp ;


@ ------------------------------- @
@ E. PROCEDURE for NPL ITERATIONS @
@ ------------------------------- @  
proc (3) = npldygam(yobs,yobs_1,pchoice,disfact,mstate,b0,kiter);
  local myzero, nobs, nplayer, numx, kparam, best, varb,
        iter, indobs, u0, u1, e0, e1, ptran, inv_bf, 
        iptran1_a0, iptran1_a1, iptran2_a0, iptran2_a1,
        umat1_a0, umat1_a1, umat2_a0, umat2_a1,
        zmat1, zmat2, emat1_a0, emat1_a1, emat2_a0, emat2_a1,
        emat1, emat2, zobs, eobs, tetaest, varest, likelihood ;        
  @ ---------------@
  @ Some constants @
  @ ---------------@                
  myzero = 1e-16 ;
  nobs = rows(yobs) ;
  nplayer = cols(yobs) ;
  numx = rows(pchoice) ;
  kparam = 3 ;
  best = zeros(kparam,kiter) ;
  varb = zeros(kparam,kparam*kiter) ; 
  yobs = yobs[.,1] | yobs[.,2] ;

  @ --------------------------------------------@  
  @ Vector with indexes for the observed state  @
  @ --------------------------------------------@ 
  indobs = 1.*prodc((yobs_1.==mstate[1,.])')
         + 2.*prodc((yobs_1.==mstate[2,.])')
         + 3.*prodc((yobs_1.==mstate[3,.])')
         + 4.*prodc((yobs_1.==mstate[4,.])') ;
  
  @ ------------- @
  @ NPL algorithm @
  @ ------------- @ 
  iter=1 ;
  do while iter&lt;=kiter ;
    @ ---------------------------------------- @
    @ a. Truncation of probabilities to avoid  @ 
    @    inverse Mill's ratio = +INF           @
    @ ---------------------------------------- @    
    pchoice[.,1] = (pchoice[.,1].&lt;myzero).*myzero 
                 + (pchoice[.,1].&gt;(1-myzero)).*(1-myzero) 
                 + (pchoice[.,1].&gt;=myzero).*(pchoice[.,1].&lt;=(1-myzero)).*pchoice[.,1] ;
    pchoice[.,2] = (pchoice[.,2].&lt;myzero).*myzero 
                 + (pchoice[.,2].&gt;(1-myzero)).*(1-myzero) 
                 + (pchoice[.,2].&gt;=myzero).*(pchoice[.,2].&lt;=(1-myzero)).*pchoice[.,2] ;
    
    @ ------------------------------------- @
    @ b. Matrix of transition probabilities @
    @ ------------------------------------- @    
    ptran = (1-pchoice[.,1]).*(1-pchoice[.,2]) 
          ~ (1-pchoice[.,1]).*pchoice[.,2]
          ~ pchoice[.,1].*(1-pchoice[.,2])
          ~ pchoice[.,1].*pchoice[.,2] ;
    
    @ --------------------@
    @ c. Inverse of I-b*F @
    @ --------------------@    
    inv_bf = inv(eye(numx)-disfact*ptran) ;        
    
    @ ------------------------------------ @
    @ d. Matrices Pr(a[t] | a[t-1], ai[t]) @
    @ ------------------------------------ @
    iptran1_a0 = (1-pchoice[.,2]) ~ pchoice[.,2]   ~ zeros(nstate,1)  ~ zeros(nstate,1) ;
    iptran1_a1 = zeros(nstate,1)  ~ zeros(nstate,1)~ (1-pchoice[.,2]) ~ pchoice[.,2] ;    
    iptran2_a0 = (1-pchoice[.,1]) ~ zeros(nstate,1)  ~ pchoice[.,1]    ~ zeros(nstate,1) ;
    iptran2_a1 = zeros(nstate,1)  ~ (1-pchoice[.,1]) ~ zeros(nstate,1) ~ pchoice[.,1] ;
    
    @ -----------------------------------------@
    @ e. Construction of explanatory variables @
    @ -----------------------------------------@       
    umat1_a0 = zeros(numx,kparam) ;
    umat1_a1 = (1-mstate[.,1])~(1-pchoice[.,2])~pchoice[.,2] ;
    umat2_a0 = zeros(numx,kparam) ;
    umat2_a1 = (1-mstate[.,2])~(1-pchoice[.,1])~pchoice[.,1] ;
    
    zmat1 = (1-pchoice[.,1]).*umat1_a0 + pchoice[.,1].*umat1_a1 ;
    zmat1 = inv_bf * zmat1 ;
    zmat1 = (umat1_a1 + disfact * iptran1_a1 * zmat1)
          - (umat1_a0 + disfact * iptran1_a0 * zmat1) ;
          
    zmat2 = (1-pchoice[.,2]).*umat2_a0 + pchoice[.,2].*umat2_a1 ;
    zmat2 = inv_bf * zmat2 ;
    zmat2 = (umat2_a1 + disfact * iptran2_a1 * zmat2)
          - (umat2_a0 + disfact * iptran2_a0 * zmat2) ;
    
    emat1_a0 = xv*mstate[.,1] + 0.5* pdfn(cdfni(pchoice[.,1]))./(1-pchoice[.,1]) ;
    emat1_a1 = 0.5* pdfn(cdfni(pchoice[.,1]))./pchoice[.,1] ;    
    emat2_a0 = xv*mstate[.,2] + 0.5* pdfn(cdfni(pchoice[.,2]))./(1-pchoice[.,2]) ;
    emat2_a1 = 0.5* pdfn(cdfni(pchoice[.,2]))./pchoice[.,2] ;
    
    emat1 = (1-pchoice[.,1]).*emat1_a0 + pchoice[.,1].*emat1_a1 ;
    emat1 = inv_bf * emat1 ;
    emat1 = (disfact * iptran1_a1 * emat1)
          - (xv*mstate[.,1] + disfact * iptran1_a0 * emat1) ;
          
    emat2 = (1-pchoice[.,2]).*emat2_a0 + pchoice[.,2].*emat2_a1 ;
    emat2 = inv_bf * emat2 ;
    emat2 = (disfact * iptran2_a1 * emat2)
          - (xv*mstate[.,2] + disfact * iptran2_a0 * emat2) ;
    
    zobs = zmat1[indobs,.] | zmat2[indobs,.] ;
    eobs = emat1[indobs,.] | emat2[indobs,.] ;
            
    @ ----------------------------------------@
    @ f. Pseudo Maximum Likelihood Estimation @
    @ ----------------------------------------@
    {tetaest,varest,likelihood} = miprobit(yobs,zobs,eobs,zeros(kparam,1),0) ;
    best[.,iter] = tetaest ;
    varb[.,(iter-1)*kparam+1:iter*kparam] = varest ;
                   
    @ ------------------------- @
    @ g. Updating probabilities @
    @ ------------------------- @
    pchoice[.,1] = cdfn(zmat1*tetaest +emat1) ;    
    pchoice[.,2] = cdfn(zmat2*tetaest +emat2) ;
    
    iter=iter+1 ;
  endo ;
    
  retp(best,varb,likelihood) ;
endp ;



@ ------------------------------------------------ @
@ ****************   MAIN PROGRAM   ************** @
@ ------------------------------------------------ @  

@ -------------------------- @
@ 1. SELECTING EQUILIBRIUM   @
@ -------------------------- @  
pequil = peq3 ;

@ ------------------------------ @
@ 2. STEADY STATE DISTRIBUTION   @
@ ------------------------------ @  
ftran = (1-pequil[.,1]).*(1-pequil[.,2]) 
      ~ (1-pequil[.,1]).*pequil[.,2]
      ~ pequil[.,1].*(1-pequil[.,2])
      ~ pequil[.,1].*pequil[.,2] ;
cconv = 1e-6 ;
criter = 1000 ;
psteady = (1/nstate)*ones(nstate,1) ;
do while criter&gt;cconv ;
  "Criter =";; criter ;
  pbuff = ftran'*psteady ;
  criter = maxc(abs(pbuff-psteady)) ;
  psteady = pbuff ;
endo ;

@ -------------------------- @
@ 3. MONTE CARLO EXPERIMENT  @
@ -------------------------- @  
bmatfreq = zeros(kparam,nrepli*npliter) ;
bmatsim  = zeros(kparam,nrepli*npliter) ;
bmatnpl  = zeros(kparam,nrepli) ;
bmattrue = zeros(kparam,nrepli*npliter) ;
redraws=0;
draw=1 ;
do while (draw&lt;=nrepli) ;
  "MC REPLICATION =" draw ;

  @ ---------------- @
  @ 3.1. Simulations @
  @ ---------------- @  
  flag=0 ; 
  do while (flag==0) ; 
    {aobs , aobs_1} = simdygam(nobs,pequil,psteady,vstate) ;
    flag = (sumc(prodc((aobs_1.==vstate[1,.])')).&gt;0)
         .*(sumc(prodc((aobs_1.==vstate[2,.])')).&gt;0)
         .*(sumc(prodc((aobs_1.==vstate[3,.])')).&gt;0)
         .*(sumc(prodc((aobs_1.==vstate[4,.])')).&gt;0) ;
    redraws=redraws+flag;   @ counts the number of re-drawings @
  endo ; 

  @ ------------------------------------------------------------------- @
  @ 3.2. Estimation of initial CCPs: Frequency Asymmetric and Symmetric @
  @ ------------------------------------------------------------------- @
  prob_asy = freqprob(aobs,aobs_1,vstate) ; 

  prob_sym = ones(nstate,nplayer) ;
  prob_sym[1,.] = meanc(prob_asy[1,.]').*ones(1,2) ;
  prob_sym[4,.] = meanc(prob_asy[1,.]').*ones(1,2) ;
  prob_sym[2,1] = (prob_asy[2,1]+prob_asy[3,2])/2 ;
  prob_sym[3,2] = prob_sym[2,1] ;
  prob_sym[3,1] = (prob_asy[3,1]+prob_asy[2,2])/2 ;
  prob_sym[2,2] = prob_sym[3,1] ;

  @ ------------------- @
  @ 3.3. NPL Estimation @
  @ ------------------- @
  theta0 = zeros(kparam,1) ;

  {best1,varb,like1} = npldygam(aobs,aobs_1,prob_asy,dfact,vstate,theta0,npliter) ;
  bmatfreq[.,(draw-1)*npliter+1:draw*npliter] = best1 ;

  {best2,varb,like2} = npldygam(aobs,aobs_1,prob_sym,dfact,vstate,theta0,npliter) ;
  bmatsim[.,(draw-1)*npliter+1:draw*npliter] = best2 ;

  bmatnpl[.,draw] = (like1.&gt;=like2).*best1[.,npliter] 
                  + (like1.&lt;like2) .*best2[.,npliter] ;

  {best,varb,like} = npldygam(aobs,aobs_1,pequil,dfact,vstate,theta0,npliter) ;
  bmattrue[.,(draw-1)*npliter+1:draw*npliter] = best ;

  draw=draw+1 ;
endo ;

@ ----------------- @
@ 4. SAVING RESULTS @
@ ----------------- @ 
bfreq_ex3_10k = bmatfreq ;
save bfreq_ex3_10k ;
bsim_ex3_10k = bmatsim ;
save bsim_ex3_10k ;
bnpl_ex3_10k = bmatnpl ;
save bnpl_ex3_10k ;
btrue_ex3_10k = bmattrue ;
save btrue_ex3_10k ;

ec_freq = reshape(bmatfreq[1,.],nrepli,npliter) ;
p1_freq = reshape(bmatfreq[2,.],nrepli,npliter) ;
p2_freq = reshape(bmatfreq[3,.],nrepli,npliter) ;

ec_sim = reshape(bmatsim[1,.],nrepli,npliter) ;
p1_sim = reshape(bmatsim[2,.],nrepli,npliter) ;
p2_sim = reshape(bmatsim[3,.],nrepli,npliter) ;

ec_npl = bmatnpl[1,.]' ;
p1_npl = bmatnpl[2,.]' ;
p2_npl = bmatnpl[3,.]' ;

ec_true = reshape(bmattrue[1,.],nrepli,npliter) ;
p1_true = reshape(bmattrue[2,.],nrepli,npliter) ;
p2_true = reshape(bmattrue[3,.],nrepli,npliter) ;

@ -------------- @
@ 5. STATISTICS  @
@ -------------- @  
bias_ec_freq = meanc(ec_freq  - ce) ;
bias_p1_freq = meanc(p1_freq  - pi1) ;
bias_p2_freq = meanc(p2_freq  - pi2) ;

mse_ec_freq = stdc(ec_freq).^2 + bias_ec_freq.^2 ;
mse_p1_freq = stdc(p1_freq).^2 + bias_p1_freq.^2 ;
mse_p2_freq = stdc(p2_freq).^2 + bias_p2_freq.^2 ;

bias_ec_sim = meanc(ec_sim  - ce) ;
bias_p1_sim = meanc(p1_sim  - pi1) ;
bias_p2_sim = meanc(p2_sim  - pi2) ;

mse_ec_sim = stdc(ec_sim).^2 + bias_ec_sim.^2 ;
mse_p1_sim = stdc(p1_sim).^2 + bias_p1_sim.^2 ;
mse_p2_sim = stdc(p2_sim).^2 + bias_p2_sim.^2 ;

bias_ec_npl = meanc(ec_npl  - ce) ;
bias_p1_npl = meanc(p1_npl  - pi1) ;
bias_p2_npl = meanc(p2_npl  - pi2) ;

mse_ec_npl = stdc(ec_npl).^2 + bias_ec_npl.^2 ;
mse_p1_npl = stdc(p1_npl).^2 + bias_p1_npl.^2 ;
mse_p2_npl = stdc(p2_npl).^2 + bias_p2_npl.^2 ;

bias_ec_true = meanc(ec_true  - ce) ;
bias_p1_true = meanc(p1_true  - pi1) ;
bias_p2_true = meanc(p2_true  - pi2) ;

mse_ec_true = stdc(ec_true).^2 + bias_ec_true.^2 ;
mse_p1_true = stdc(p1_true).^2 + bias_p1_true.^2 ;
mse_p2_true = stdc(p2_true).^2 + bias_p2_true.^2 ;

@ ------------------- @
@ 6. TABLE and GRAPHS @
@ ------------------- @  
format /mb1 /rzs 16,3 ;
"------------------------------------------------------------------------------------------------------------------" ;
"   MONTE CARLO EXPERIMENT: EQUILIBRIUM 3 (T=10,000)" ;
"------------------------------------------------------------------------------------------------------------------" ;
"ESTIMATOR  ";; 
"       Bias C     ";; "        MSE C  ";; 
"       Bias Pi1   ";; "        MSE Pi1";; 
"       Bias Pi2   ";; "        MSE Pi2";
"------------------------------------------------------------------------------------------------------------------" ;
"1-PML(asy)";; 
bias_ec_freq[1];; mse_ec_freq[1] ;;
bias_p1_freq[1];; mse_p1_freq[1] ;; 
bias_p2_freq[1];; mse_p2_freq[1] ;
"10-PML(asy)";; 
bias_ec_freq[10];; mse_ec_freq[10] ;;
bias_p1_freq[10];; mse_p1_freq[10] ;; 
bias_p2_freq[10];; mse_p2_freq[10] ;
"30-PML(asy)";; 
bias_ec_freq[30];; mse_ec_freq[30] ;;
bias_p1_freq[30];; mse_p1_freq[30] ;; 
bias_p2_freq[30];; mse_p2_freq[30] ;
"------------------------------------------------------------------------------------------------------------------" ;
"1-PML(sym)";; 
bias_ec_sim[1];; mse_ec_sim[1] ;;
bias_p1_sim[1];; mse_p1_sim[1] ;; 
bias_p2_sim[1];; mse_p2_sim[1] ;
"10-PML(sym)";; 
bias_ec_sim[10];; mse_ec_sim[10] ;;
bias_p1_sim[10];; mse_p1_sim[10] ;; 
bias_p2_sim[10];; mse_p2_sim[10] ;
"30-PML(sym)";; 
bias_ec_sim[30];; mse_ec_sim[30] ;;
bias_p1_sim[30];; mse_p1_sim[30] ;; 
bias_p2_sim[30];; mse_p2_sim[30] ;
"------------------------------------------------------------------------------------------------------------------" ;
"1-PML(tru)";; 
bias_ec_true[1];; mse_ec_true[1] ;;
bias_p1_true[1];; mse_p1_true[1] ;; 
bias_p2_true[1];; mse_p2_true[1] ;
"10-PML(tru)";; 
bias_ec_true[10];; mse_ec_true[10] ;;
bias_p1_true[10];; mse_p1_true[10] ;; 
bias_p2_true[10];; mse_p2_true[10] ;
"30-PML(tru)";; 
bias_ec_true[30];; mse_ec_true[30] ;;
bias_p1_true[30];; mse_p1_true[30] ;; 
bias_p2_true[30];; mse_p2_true[30] ;
"------------------------------------------------------------------------------------------------------------------" ;
"NPL(max asy/sym)";; 
bias_ec_npl ;; mse_ec_npl ;;
bias_p1_npl ;; mse_p1_npl ;; 
bias_p2_npl ;; mse_p2_npl ;
"------------------------------------------------------------------------------------------------------------------" ;

output off ;

end ;</PRE></BODY></HTML>
