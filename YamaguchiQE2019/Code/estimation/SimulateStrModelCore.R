SimulateStrModelCore <- function(param.ys, param.y, param.u.str, param.sieve, policy, 
                                 beta, dat.ini, sim.term) {
    ## for a given type, simulate structural model
    ##
    ## Args
    ##   param.ys: vector of parameters for husband's earnings
    ##   param.y: vector of parameters for earnings
    ##   param.u.str: vector of structural parameter for choice
    ##   param.sieve: sieve parameter if wish to provide rather than calculate it
    ##                using the model parameters.
    ##   policy: a list of policy parameters.
    ##   beta: discount factor
    ##   dat.ini: matrix of initial conditions with all covariates.
    ##   sim.term: terminal period for simulation
    ##   irf: TRUE if IRF is needed.
    ##
    ## Returns

    ## random deviates
    eps.ys <- matrix(runif(nrow(dat.ini) * sim.term), ncol = sim.term)
    eps.u  <- matrix(runif(nrow(dat.ini) * sim.term), ncol = sim.term)

    ## make all covariates for initial conditions
    S <- dat.ini
    d <- dat.ini[, c("dh","dr","dn","dl","df")]

    ## initial conditions
    out <- cbind(time = 0, d, dw=d[,"dr"]+d[,"dn"],
                 MakeCovariatesAll(as.data.frame(S), policy),
                 cons = 0, emax = 0)

    ## simulate for T period
    for(i in 1:sim.term) {
        ## update state variables
        S <- UpdateState(param.ys, S, d, d.year = 1, eps.ys = eps.ys[,i])

        ## covariates corresponding to the new policy
        S <- MakeCovariatesAll(as.data.frame(S), policy)

        ## covariates for structural model
        x.u.str <- MakeCovariatesUtilStr(S, Glab.u.str, Glab.yr, Glab.yn, param.y, policy)

        ## construct X.bar
        x.bar <- UpdateXbar(param.ys, S)

        ## Emax
        Emax <- mapply(matmul.Xb, x.bar, MoreArgs=list(b=param.sieve))

        ## value
        v <- AdjustValue(param.u.str, x.u.str, beta, Emax)

        ## ccp
        ccp <- CalcCcpEmax(param.u.str, v, "ccp")

        ## emax (only for t = 1)
        if(i == 1) {
            emax <- CalcCcpEmax(param.u.str, v, "emax")
        } else {
            emax <- 0
        }
        
        ## simulate choice
        d <- SimulateChoice(ccp, eps.u[,i])

        ## potential earnings
        yhat <- exp(CalcLikelihoodY(param.y, S[,Glab.yr], S[,Glab.yn]) +
                        param.y[length(param.y)]^2 / 2)    
                                                                      
        ## realized earnings
        S[,"y"] <- rowSums(yhat * d[,c("dr","dn")])

        ## realized consumption
        cons <- rowSums(x.u.str[,c("cons.h","cons.r","cons.n","cons.l")] *
                        d[,c("dh","dr","dn","dl")])

        ## outcomes
        out <- rbind(out, cbind(time = i, d, dw=d[,"dr"]+d[,"dn"],
                                S, cons=cons, emax=emax))
    }
    ## return output
    out
}
