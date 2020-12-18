UpdateState <- function(param.ys, dat, d, eps.ys1, d.year=0) {
    ## Args
    ##   param.ys: parameter for spousal earnings (given type)
    ##   dat: data matrix with all covariates
    ##   choice: matrix for choice.
    ##   eps.ys1: random deviates for ys 
    ##   d.year: change in year. in subjective expectation, this is 0.
    ##
    ## Returns
    ##   
    
    ## covariate matrix
    x.ys <- cbind(dat, d)[, Glab.ys]

    ## predicted ys
    ys.hat <- CalcLikelihoodYS(param.ys, x.ys)

    ## simulate ys
    ys1 <- ys.hat + qnorm(eps.ys1) * param.ys["sigma"]

    ## update all state variables
    S1 <- dat
    S1[,"hh"] <- dat[,"hh"] + d[,"dh"] + d[,"dl"]
    S1[,"hr"] <- dat[,"hr"] + d[,"dr"]
    S1[,"hn"] <- dat[,"hn"] + d[,"dn"]
    S1[,"ys"] <- ys1
    S1[,"nchild"] <- dat[,"nchild"] + d[,"df"]
    S1[,"age"] <- dat[,"age"] + 1
    S1[S1[,"nchild"] == 0,           "yca"] <- -1
    S1[S1[,"nchild"]  > 0 & d[,"df"] == 1, "yca"] <- 0
    S1[S1[,"nchild"]  > 0 & d[,"df"] == 0, "yca"] <- dat[S1[,"nchild"]  > 0 & d[,"df"] == 0, "yca"] + 1
    S1[,"ldh"] <- d[,"dh"]
    S1[,"ldr"] <- d[,"dr"]
    S1[,"ldn"] <- d[,"dn"]
    S1[,"ldl"] <- d[,"dl"]
    S1[,"ler"] <- d[,"dr"] + d[,"dl"]*dat[,"ler"]
    S1[,"len"] <- d[,"dn"] + d[,"dl"]*dat[,"len"]
    S1[,"ldf"] <- d[,"df"]

    ## assume individuals expect regime remains the same.
    S1[,"year"] <- dat[,"year"] + d.year

    ## check upper bounds
    CheckUB(S1)
}
