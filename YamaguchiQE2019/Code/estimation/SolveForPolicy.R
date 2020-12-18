SolveForPolicy <- function(policy, out.EM, grid, beta){
    ## NOTE: internally use parallel algorithm
    ##
    ## Args:
    
    ## numerical solution to the model for a given policy scenario

    ## covariates for SVFI
    out.prep.svfi.grid <- PrepSVFI(out.EM, grid, need.xxx = TRUE, parallel.xbar = FALSE, policy)

    ## new sieve parameters
    out.EM$param.sieve <- mapply(UpdateSVFI,
                                 param.u.str = ConvParamUStr(out.EM$u$par),
                                 param.sieve = out.EM$param.sieve,
                                 x.bar = out.prep.svfi.grid$x.bar,
                                 x.u.str = out.prep.svfi.grid$x.u.str,
                                 MoreArgs = list(
                                     xxx=out.prep.svfi.grid$xxx,
                                     plelg=out.prep.svfi.grid$plelg,
                                     beta=beta,
                                     iterlim.svfi=1000),
                                 SIMPLIFY = FALSE)
    
    out.EM
}
