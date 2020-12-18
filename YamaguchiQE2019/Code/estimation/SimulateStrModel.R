SimulateStrModel <- function(out.EM, policy, dat, beta, sim.term, modelfit) {
    ## simulate structural model and create a profile
    ##
    ## Args
    ##   out.EM : list of model parameters
    ##   policy: a list of policy parameters.
    ##   dat: data frame to be matched.
    ##   beta: discount factor
    ##   sim.term: terminal period for simulation
    ##   modelfit: TRUE if checking model fit.

    dat.ini <- subset(dat, ini == 1)

    dat.ini <- dat.ini[,c("id",
                          "year", "hh", "hr", "hn", "ys", "nchild", 
                          "age", "yca", "edu", "ldh", "ldr", "ldn",
                          "ldl", "ldf", "ler", "len",
                          "dh", "dr", "dn", "dl", "df", "y")]

    ## covariates for the initial conditions
    dat.ini <- MakeCovariatesAll(dat.ini, policy)

    ## simulation for all types
    out.sim <- mapply(SimulateStrModelCore,
                      param.ys    = ConvParamYS(out.EM$ys$par),
                      param.y     = ConvParamY(out.EM$y$par),
                      param.u.str = ConvParamUStr(out.EM$u$par),
                      param.sieve = out.EM$param.sieve,
                      MoreArgs = list(
                          policy     = policy,
                          beta       = beta,
                          dat.ini    = dat.ini,
                          sim.term   = sim.term),
                      SIMPLIFY = FALSE)

    ## type weight
    type.weight <- CalcLikelihoodType(out.EM$type$par, dat.ini[,Glab.type])

    ## one large matrix that stuck simulations for all types
    mat.out.sim <- cbind(out.sim[[1]], weight = type.weight[,1], type = 1)

    for (j in 2:Gn.type) {
        mat.out.sim <- rbind(mat.out.sim, 
                             cbind(out.sim[[j]], weight = type.weight[,j], type = j))
    }

    if(modelfit) {
        ## match simulation and data.
        dat.nonini <- subset(dat, ini == 0)
        obs.id.dat <- paste(dat.nonini[,"id"], dat.nonini[,"age"], sep=".")
        obs.id.sim <- paste(mat.out.sim[,"id"], mat.out.sim[,"age"], sep=".")
        index.match.dat.sim <- ifelse(match(obs.id.sim, obs.id.dat) > 0, TRUE, FALSE)
    } else {
        index.match.dat.sim <- TRUE
    }

    return(na.omit(mat.out.sim[index.match.dat.sim, ]))
    
}
