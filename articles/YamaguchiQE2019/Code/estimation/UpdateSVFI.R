UpdateSVFI <- function(param.u.str, param.sieve, x.u.str, xxx, x.bar, plelg,
                       beta, iterlim.svfi){
    ## initialization
    na.emax <- FALSE
    overflow <- FALSE
    underflow <- FALSE

    ## return immediately if no iteration is requested.
    if (iterlim.svfi == 0) return(param.sieve)

    for(i in 1:iterlim.svfi){
        ## Emax
        Emax <- mapply(matmul.Xb, x.bar, MoreArgs=list(b=param.sieve))

        ## value
        v <- AdjustValue(param.u.str, x.u.str, beta, Emax)
        
        ## emax
        new.emax <- CalcCcpEmax(param.u.str, v, "emax")

        ## adjust for NA, overflow, and underflow
        if(any(is.na(new.emax))) {
            new.emax[is.na(new.emax)] <- 0
            na.emax <- TRUE
        } else {
            if(any(new.emax == Inf)){
                new.emax[ new.emax == Inf ] <- 700
                overflow <- TRUE
            } else if (any(new.emax == -Inf)) {
                new.emax[ new.emax == -Inf ] <- -700
                underflow <- TRUE
            }
        }

        ## update the coefficients
        updated.param.sieve <- xxx %*% new.emax
        
        ## check progress
        diff.param.sieve <- max(abs(updated.param.sieve - param.sieve))

        ## update param.sieve
        param.sieve <- as(updated.param.sieve, "vector")
        attr(param.sieve, "niter") <- i
        attr(param.sieve, "NA") <- na.emax
        attr(param.sieve, "overflow") <- overflow
        attr(param.sieve, "underflow") <- underflow
        
        ## stop iteration if param.sieve includes NA or NaN
        if(any(is.na(diff.param.sieve))) return(param.sieve)
        
        ## stop iteration if converged.
        if(diff.param.sieve < 1e-4) return(param.sieve)
    }

    ## return result
    param.sieve
}
