UpdateXbar <- function(param.ys, x, parallel=FALSE){
    ## Update covariates X.bar for a given choice and type (see ABBJ)
    ##
    ## Args:
    ##   param.ys: parameter for spousal earnings (given type)
    ##   x: data matrix
    ##   parallel: if TRUE, simulation is parallel. consumes more memory
    ##
    ## Returns
    ##   A list of covariates for 4 choices

    ## calculate Xbar
    if (parallel) {
        X.bar <- mclapply(1:8, coreUpdateXbar, param.ys=param.ys, x=x)
    } else {
        X.bar <- lapply(1:8, coreUpdateXbar, param.ys=param.ys, x=x)
    }
    
    ## return result
    names(X.bar) <- c("h0","r0","n0","l0","h1","r1","n1","l1")
    X.bar
}

coreUpdateXbar <- function(index.d, param.ys, x){
    ## Update covariates X.bar for a given choice and type (see ABBJ)
    ##
    ## Args:
    ##   param.ys: parameter for spousal earnings (given type)
    ##   x: data matrix
    ##   parallel: if TRUE, simulation is parallel. consumes more memory
    ##
    ## Returns
    ##   A matrix of covariates given choice

    ## matrix for the decision variable
    d <- matrix(0, nrow=nrow(x), ncol=5,
                dimnames = list(NULL, c("dh","dr","dn","dl","df")))

    if (index.d <= 4) {
        d[, index.d] <- 1
    } else{
        index.d <- index.d - 4
        d[, c(index.d, 5)] <- 1
    }

    ## update state variables given the choice
    S1 <- UpdateState(param.ys=param.ys, dat=x, d=d, eps.ys1=0.5, d.year=0)

    ## construct polynomial
    MakePolyLD(S1, param.ys)
}
