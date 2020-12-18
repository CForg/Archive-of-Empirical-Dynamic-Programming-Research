PrepSVFI <- function(out.EM, state, need.xxx, parallel.xbar, ...) {
    ## construct covariates for SVFI
    ##
    ## Args
    ##   out.EM: output from out.EM
    ##   state: data frame of states
    ##   ...: arguments to be passed to MakeCovariatesAll
    ##
    ## Returns
    ##   xxx: used for SVFI
    ##   x.bar: mean of x.poly in the next period.
    ##   x.u.str: covariates for the structural model.
    ##   plelg: PL eligibility indicator

    ## construct covariates for state
    x.all.state <- MakeCovariatesAll(state, ...)

    ## construct XXX
    if (need.xxx) {
        x.poly <- MakePolyLD(x.all.state)
        xxx    <- solve(t(x.poly)%*%x.poly) %*% t(x.poly)
    } else {
        xxx <- NULL
    }

    ## construct X.bar
    x.bar <- mapply(UpdateXbar, 
                    param.ys=ConvParamYS(out.EM$ys$par),
                    MoreArgs=list(x=x.all.state, parallel=parallel.xbar),
                    SIMPLIFY=FALSE)

    ## covariates for instantaneous utility
    x.u.str <- lapply(ConvParamY(out.EM$y$par),
                      MakeCovariatesUtilStr,
                      mat.cov.all = x.all.state,
                      list.lab.u=Glab.u.str,
                      lab.yr=Glab.yr, lab.yn=Glab.yn)
    
    ## return output
    list(x.bar = x.bar, x.u.str = x.u.str, plelg = x.all.state[,"plelg"], xxx = xxx)

}
