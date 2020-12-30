SimulateProfile <- function(out.EM1, out.EM2, policy1, policy2,
                            dat, eps.ys, eps.u, beta, sim.term,
                            along.prof, lab.prof, from.prof, to.prof, modelfit, irf) {
    ## simulate structural model and create a profile
    ##
    ## Args
    ##   out.EM1 : list of model parameters for scinario 1
    ##   out.EM2 : list of model parameters for scinario 2
    ##   policy1 : list of policy parameters
    ##   policy2 : list of policy parameters
    ##   dat: data frame to be matched.
    ##   eps.x.bar: random deviates for x.bar. list of Gn.type
    ##              each element is a list of sim.term.
    ##              each element is a list of 2 (b1 and ys).
    ##              each element is a list of length 4 (choice)
    ##              each element is a matrix of nrow(S) x nsim.svfi.
    ##   eps.ys: random deviates for ys. list of Gn.type
    ##            each element is a matrix of nrow(dat.ini) x (sim.term).
    ##   eps.u: random deviates for ys. list of Gn.type
    ##            each element is a matrix of nrow(dat.ini) x (sim.term).
    ##   beta: discount factor
    ##   nsim.svfi: number of simulations for making x-bar
    ##   sim.term: terminal period for simulation
    ##   along.prof: diminsion along which the profile is created.
    ##   lab.prof: labels of profiles to be matched.
    ##   from.prof: starting age of the age profile
    ##   to.prof: ending age of the age profile
    ##   modelfit: TRUE if checking model fit.
    ##   irf: TRUE if IRF is needed.
    ##
    ## Returns

    ## simulation
    mat.out.sim <- SimulateStrModel(out.EM1, out.EM2, policy1, policy2,
                                    dat, eps.ys, eps.u, beta, sim.term, modelfit, irf)
    
    ## profiles for simulation
    MakeProfile(mat.out.sim, lab.prof, from.prof, to.prof, along.prof)
}
