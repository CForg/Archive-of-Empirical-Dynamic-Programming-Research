UpdateEM <- function(out.EM, dat, grid, iterlim.svfi, beta, lik.only=FALSE, optim.ctrl=NULL) {
    ## Args
    ##   out.EM: last output from EM iteration.
    ##   dat: data frame
    ##
    ## Returns
    ##   loglik: loglikelihood 
    ##   diff.param: change in parameters
    ##   diff.loglik: change in loglikelihood
    ##   type: BFGS output for type prob.
    ##   ys: parameters for husband's earnings.
    ##   y: parameters for own earnings.
    ##   u: BFGS output for choice

    ####################
    ## preparing data ##
    ####################

    ## objects used for SVFI
    out.prep.svfi.grid <- PrepSVFI(out.EM, grid, TRUE, ifelse(lik.only, FALSE, TRUE))
    out.prep.svfi.data <- PrepSVFI(out.EM, dat, FALSE, ifelse(lik.only, FALSE, TRUE))

    ## ID and indicator for initial observations.
    id <- dat[,"id"]
    ini <- dat[,"ini"]

    ## X for outcomes other than choice
    x.all.dat <- MakeCovariatesAll(dat)
    X.type <- x.all.dat[ini == 1, Glab.type]
    X.ys <- x.all.dat[, Glab.ys]
    X.yr <- x.all.dat[, Glab.yr]
    X.yn <- x.all.dat[, Glab.yn]

    ## Y for all outcomes
    Y.ys <- dat[,"fys"]
    Y.y <- dat[,"y"]
    Y.ccp <- as.matrix(dat[, c("dh","dr","dn","dl","df")])

    ## NA index
    na.ys <- is.na(rowSums(X.ys) + Y.ys)
    na.y <- is.na(rowSums(X.yr) + rowSums(X.yn) + Y.y) |
        (Y.ccp[,"dr"]+Y.ccp[,"dn"]) == 0 | ini == 1
    na.ccp <- is.na(rowSums(out.prep.svfi.data$x.u.str[[1]][, c(Glab.u.str$h, Glab.u.str$r,
                                                                Glab.u.str$n, Glab.u.str$l)]) +
                    rowSums(Y.ccp)) | ini == 1
    
    ###########################
    ## likelihood evaluation ##
    ###########################

    ## likelihood by type
    lik.is <- CalcLikelihoodAll(out.EM$type$par,
                                out.EM$ys$par,
                                out.EM$y$par,
                                out.EM$u$par, 
                                X.type, X.ys, X.yr, X.yn,
                                Y.ys, Y.y, Y.ccp,
                                na.ys, na.y, na.ccp, id,
                                out.EM$param.sieve,
                                out.prep.svfi.data$x.bar, out.prep.svfi.data$x.u.str, out.prep.svfi.data$plelg,
                                out.prep.svfi.grid$x.bar, out.prep.svfi.grid$x.u.str, out.prep.svfi.grid$plelg,
                                out.prep.svfi.grid$xxx, beta, iterlim.svfi)

    ## likelihood at individual level
    lik.i <- rowSums(lik.is)

    if(lik.only) return(lik.i)

    ## check zero probability
    if(any(is.na(lik.i))) {
        cat("WARNING: lik.i has NA (see UpdateEM). replaced by a small number.\n")
        lik.i[ is.na(lik.i) ] <- 1e-256
    } else if(any(is.nan(lik.i))) {
        cat("WARNING: lik.i has NaN (see UpdateEM). replaced by a small number.\n")
        lik.i[ is.nan(lik.i) ] <- 1e-256
    } else if(any(lik.i == 0)){
        cat("WARNING: zero probability in lik.i (see UpdateEM). replaced by a small number.\n")
        lik.i[ lik.i == 0 ] <- 1e-256
    }

    ###########################
    ## posterior probability ##
    ###########################
    
    ## posterior probability of type at individual level
    q.i <- lik.is / lik.i
    
    ## posterior probability of type at observation level
    q <- q.i[ match(id, id[ini==1]), ]

    ## list version of q
    list.q <- mat2list(q)

    #######################
    ## update parameters ##
    #######################

    ## type
    M.type <- optim(out.EM$type$par,
                    CalcWeightedLogLikType, 
                    DiffWeightedLogLikType, 
                    x=X.type, q=q[ini==1,], 
                    method = c("BFGS"),
                    control = optim.ctrl)
  
    ## spouse's earnings
    M.ys <- optim(out.EM$ys$par,
                  CalcWeightedLogLikYS, 
                  DiffWeightedLogLikYS, 
                  x=X.ys, y=Y.ys, na=na.ys, weight=list.q, 
                  method = c("BFGS"),
                  control = optim.ctrl)

    ## earnings
    M.y <- optim(out.EM$y$par,
                 CalcWeightedLogLikY, 
                 DiffWeightedLogLikY, 
                 xr=X.yr, xn=X.yn, d=Y.ccp[,c("dr","dn")], y=Y.y, na=na.y, weight=list.q, 
                 method = c("BFGS"),
                 control = optim.ctrl)

    ## CCP
    M.u <- optim(out.EM$u$par,
                 CalcWeightedLogLikCCP.SVFI,
                 DiffWeightedLogLikCCP.SVFI,
                 param.sieve = out.EM$param.sieve,
                 x.bar.dat = out.prep.svfi.data$x.bar,
                 x.u.str.dat = out.prep.svfi.data$x.u.str,
                 pl.dat = out.prep.svfi.data$plelg,
                 d = Y.ccp, na = na.ccp,
                 x.bar.grid = out.prep.svfi.grid$x.bar,
                 x.u.str.grid = out.prep.svfi.grid$x.u.str,
                 pl.grid = out.prep.svfi.grid$plelg,
                 xxx.grid = out.prep.svfi.grid$xxx,
                 beta = beta,
                 iterlim.svfi = iterlim.svfi,
                 weight = list.q,
                 method = c("L-BFGS-B"),
                 control = optim.ctrl)

    ## update sieve param
    new.param.sieve <- mcmapply(UpdateSVFI,
                                param.u.str = ConvParamUStr(M.u$par),
                                param.sieve = out.EM$param.sieve,
                                x.bar = out.prep.svfi.grid$x.bar,
                                x.u.str = out.prep.svfi.grid$x.u.str,
                                MoreArgs = list(
                                    xxx=out.prep.svfi.grid$xxx,
                                    plelg=out.prep.svfi.grid$plelg,
                                    beta=beta,
                                    iterlim.svfi=iterlim.svfi),
                                SIMPLIFY = FALSE)

    ####################
    ## output objects ##
    ####################

    ## compare new and old parameters
    p.old <- c(out.EM$type$par, out.EM$ys$par, out.EM$y$par, out.EM$u$par)
    
    p.new <- c(M.type$par, M.ys$par, M.y$par, M.u$par)

    diff.param <- max(abs(p.old - p.new))

    ## compare new and old sieve parameters
    diff.param.sieve <- max(abs(unlist(out.EM$param.sieve)
                                - unlist(new.param.sieve)))

    ## likelihood under new parameters (by type)
    lik.is.new <- CalcLikelihoodAll(M.type$par,
                                    M.ys$par,
                                    M.y$par,
                                    M.u$par, 
                                    X.type, X.ys, X.yr, X.yn, 
                                    Y.ys, Y.y, Y.ccp,
                                    na.ys, na.y, na.ccp, id,
                                    out.EM$param.sieve,
                                    out.prep.svfi.data$x.bar,
                                    out.prep.svfi.data$x.u.str,
                                    out.prep.svfi.data$plelg,
                                    out.prep.svfi.grid$x.bar,
                                    out.prep.svfi.grid$x.u.str,
                                    out.prep.svfi.grid$plelg,
                                    out.prep.svfi.grid$xxx, beta, iterlim.svfi)
    lik.i.new <- rowSums(lik.is.new)
    
    ## compare loglikelihood
    new.loglik <- -sum(log(lik.i.new))
    diff.loglik <- -(new.loglik - (-sum(log(lik.i))))
    
    ## label parameters for readability
    names(M.type$par) <- rep(Glab.type, Gn.type-1)
    
    names(M.ys$par) <- c(Glab.ys, "sigma", rep("c", Gn.type-1))
    
    names(M.y$par) <- c(Glab.yr, Glab.yn, "sigma",
                             rep(c("cr","cn"), (Gn.type-1)))

    names(M.u$par) <- c(unlist(Glab.u.str), rep(c("cr","cn","cl","cf"), (Gn.type-1)))
    
    ## output
    list(loglik      = new.loglik,
         diff.param  = diff.param,
         diff.param.sieve  = diff.param.sieve,
         diff.loglik = diff.loglik,
         type = M.type, 
         ys   = M.ys,
         y    = M.y,
         u    = M.u,
         param.sieve = new.param.sieve)
}
