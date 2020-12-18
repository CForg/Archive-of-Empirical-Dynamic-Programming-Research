CalcLikelihoodCCP.SVFI <- function(param.u.str, param.sieve,
                                   x.bar.dat, x.u.str.dat, pl.dat, d, na,
                                   x.bar.grid, x.u.str.grid, pl.grid, xxx.grid,
                                   beta, iterlim.svfi){
  # calculate likelihood for choices using SVFI
  #
  # Args
  #   param.u.str: a vector of structural parameters
  #   param.sieve: list of parameters for sieve
  #   x.bar.dat: list of matrices of covariates to predict Emax for data points.
  #   x.u.str.dat: list of list of covariate matrices for structural model for 
  #                data points.
  #   pl.dat: indicator for PL eligibility for data points.
  #   d: a matrix of choices (data)
  #   na: a vector of NA for CCP (data)
  #   x.bar.grid: list of matrices of covariates to predict Emax for grids.
  #   x.u.str.grid: list of list of covariate matrices for structural model for
  #                 grids.
  #   pl.grid: indicator for PL eligibility for grid
  #   xxx.grid: (X'X)^(-1)X for grids
  #
  # Returns

  # solve the model and find sieve parameters
  param.sieve <- UpdateSVFI(param.u.str = param.u.str, 
                            param.sieve = param.sieve,
                            x.bar = x.bar.grid, 
                            x.u.str = x.u.str.grid,
                            xxx=xxx.grid,
                            plelg=pl.grid,
                            beta=beta,
                            iterlim.svfi=iterlim.svfi)

  ## Emax
  Emax <- mapply(matmul.Xb, x.bar.dat, MoreArgs=list(b=param.sieve))

  ## adjusted value
  v <- AdjustValue(param.u.str, x.u.str.dat, beta, Emax)

  ## ccp
  ccp <- CalcCcpEmax(param.u.str, v, "ccp")
  
  if(is.null(d)) return(ccp)
  
  # likelihood
  lik <- ccp[cbind(1:nrow(ccp), d %*% c(1,2,3,4,4))]
  ## lik <- rowSums(ccp * d)
  lik[na] <- 1

  lik
}  

CalcWeightedLogLikCCP.SVFI <- function(param.u.str, param.sieve,
                                       x.bar.dat, x.u.str.dat, pl.dat, d, na,
                                       x.bar.grid, x.u.str.grid, pl.grid, xxx.grid,
                                       beta, iterlim.svfi, weight){
    ## calculate likelihood for choices using SVFI
    ##
    ## Args
    ##   param.u.str: a vector of structural parameters
    ##   param.sieve: list of parameters for sieve
    ##   x.bar.dat: list of matrices of covariates to predict Emax for data points.
    ##   x.u.str.dat: list of list of covariate matrices for structural model for 
    ##                data points.
    ##   pl.dat: indicator for PL eligibility for data points.
    ##   d: a matrix of choices (data)
    ##   na: a vector of NA for CCP (data)
    ##   x.bar.grid: list of matrices of covariates to predict Emax for grids.
    ##   x.u.str.grid: list of list of covariate matrices for structural model for
    ##                 grids.
    ##   pl.grid: indicator for PL eligibility for grid
    ##   xxx.grid: (X'X)^(-1)X for grids
    ##
    ## Returns

    ## CCP
    l.ccp <- mapply(CalcLikelihoodCCP.SVFI,
                    param.u.str = ConvParamUStr(param.u.str),
                    param.sieve = param.sieve,
                    x.bar.dat = x.bar.dat,
                    x.u.str.dat = x.u.str.dat,
                    x.bar.grid = x.bar.grid,
                    x.u.str.grid = x.u.str.grid, 
                    MoreArgs = list(
                        pl.dat = pl.dat,
                        d = d,
                        na = na,
                        pl.grid = pl.grid,
                        xxx.grid = xxx.grid,
                        beta = beta,
                        iterlim.svfi = iterlim.svfi))

    ## adjust for 0, NaN
    l.ccp[l.ccp < 1e-256] <- 1e-256
    l.ccp[is.nan(l.ccp)]  <- 1e-256

    ##
    out <- 0
    for(i in 1:Gn.type) out <- out + sum(weight[[i]] * log(l.ccp[,i]))
    -out
}

DiffWeightedLogLikCCP.SVFI <- function(param, step.size = 1e-4, ...) {

    fnval <- unlist( mclapply(0:length(param), fn.eps,
                              param=param, step.size=step.size,
                              fn=CalcWeightedLogLikCCP.SVFI, ...) )
    
    (fnval[-1] - fnval[1]) / step.size
}

CalcApprxLikelihoodCCP.SVFI <- function(param.new, param.old, A.B){
  # calculate approximated likelihood for choices using SVFI
  #
  # Args
  #   param.new: a vector of structural parameters for evaluating CCP
  #   param.old: a vector of structural parameters used for making A and B
  #   A.B: a list for A and B for approximate likelihood.
  #
  # Returns
  
  ccp <- A.B$A + A.B$B %*% (param.new - param.old)

  ccp[ccp < 1e-100 | ccp > (1-1e-100)] <- 1e-100
  ccp
}

fn.eps <- function(i, param, step.size, fn, ...) {

    if (i != 0) {
        param[i] <- param[i] + step.size
    }

    fn(param.u.str=param, ...)
}
