####################
## Initialization ##
####################
source("Initialize.R")
load("output.RData")

## functions
SimulateTimeProf <- function(out.EM, policy, dat, beta, sim.term){
    simout <- SimulateStrModel(out.EM, policy, dat, beta, sim.term, modelfit=FALSE)
    MakeProfile2(simout, "time", 0:sim.term, Glab.sim)
}

mcSimulateTimeProf <- function(out.EM, policy, dat, beta, sim.term, sim.rep, seed){

    set.seed(seed, kind = "L'Ecuyer-CMRG")

    simout <- mclapply(1:sim.rep, function(i, ...) SimulateTimeProf(...),
                       out.EM = out.EM, policy = policy,
                       dat = dat, beta = beta, sim.term = sim.term)

    TakeAveList(simout)
}

make.tab.cf <- function(simout, lab.policies, lab.time){

    list.tab <- list()

    for(i in 1:ncol(simout[[1]])){
        list.tab[[i]] <- matrix(0, length(lab.policies), length(lab.time),
                                dimnames = list(lab.policies, lab.time))
        
        for(j in 1:length(lab.policies)){
            list.tab[[i]][j,] <- round(simout[[j]][lab.time,i], 3)
        }
    }

    names(list.tab) <- colnames(simout[[1]])

    list.tab
}

simulateCF <- function(out.EM, policy, dat, beta, sim.term, sim.rep, seed){

    list.out.EM <- mcmapply(SolveForPolicy, policy,
                            MoreArgs=list(out.EM=out.EM, grid=Gsampled.states.raw, beta=Gbeta),
                            SIMPLIFY=FALSE)

    list.simout <- mapply(mcSimulateTimeProf, list.out.EM, policy,
                          MoreArgs=list(dat=dat, beta=beta, sim.term=sim.term,
                                        sim.rep=sim.rep, seed=seed),
                          SIMPLIFY=FALSE)

    make.tab.cf(list.simout, names(policy), as.character(0:sim.term))
}

## initial conditions
jpsc.plelg <- subset(jpsc, year == 2009 & age <= 34 & df == 1 & (dr == 1 | dn == 1))
jpsc.plelg$ini <- 1

## specify policies
policies <- list()
policies$"JP:0,RR:0%"  <- list(jp.reg=0, jp.nonreg=0, rr=0,  no.return=FALSE, freeCC=FALSE, baby.bonus=0)
policies$"JP:1,RR:0%"  <- list(jp.reg=1, jp.nonreg=1, rr=0,  no.return=FALSE, freeCC=FALSE, baby.bonus=0)
policies$"JP:3,RR:0%"  <- list(jp.reg=3, jp.nonreg=3, rr=0,  no.return=FALSE, freeCC=FALSE, baby.bonus=0)
policies$"JP:0,RR:50%" <- list(jp.reg=0, jp.nonreg=0, rr=.5,  no.return=TRUE, freeCC=FALSE, baby.bonus=0)
policies$"JP:1,RR:50%" <- list(jp.reg=1, jp.nonreg=1, rr=.5, no.return=TRUE, freeCC=FALSE, baby.bonus=0)
policies$"JP:3,RR:50%" <- list(jp.reg=3, jp.nonreg=3, rr=.5, no.return=TRUE, freeCC=FALSE, baby.bonus=0)
policies$"JP:0,RR:50%+RTW" <- list(jp.reg=0, jp.nonreg=0, rr=.5, no.return=FALSE, freeCC=FALSE, baby.bonus=0)
policies$"JP:1,RR:50%+RTW" <- list(jp.reg=1, jp.nonreg=1, rr=.5, no.return=FALSE, freeCC=FALSE, baby.bonus=0)
policies$"JP:3,RR:50%+RTW" <- list(jp.reg=3, jp.nonreg=3, rr=.5, no.return=FALSE, freeCC=FALSE, baby.bonus=0)
policies$"JP:1,RR:50%+RTW,bonus1" <- list(jp.reg=1, jp.nonreg=1, rr=.5, no.return=FALSE, freeCC=FALSE, baby.bonus=1)
policies$"JP:1,RR:50%+RTW,bonus3" <- list(jp.reg=1, jp.nonreg=1, rr=.5, no.return=FALSE, freeCC=FALSE, baby.bonus=3)
policies$"JP:1,RR:50%+RTW,bonus5" <- list(jp.reg=1, jp.nonreg=1, rr=.5, no.return=FALSE, freeCC=FALSE, baby.bonus=5)
policies$"JP:1,RR:50%+RTW,freeCC" <- list(jp.reg=1, jp.nonreg=1, rr=.5, no.return=FALSE, freeCC=TRUE, baby.bonus=0)

## baseline 
tab.base <- simulateCF(Gout.EM, policies, jpsc.plelg, Gbeta, 15, Gnrep.sim, Gseed)
print(tab.base)

## No HC depreciation
Gout.EM.NoHCDep <- Gout.EM

i.hh10   <- which("hh10" == names(Gout.EM$y$par))
i.hh10sq <- which("hh10sq" == names(Gout.EM$y$par))
i.ldhdl   <- which("ldhdl" == names(Gout.EM$y$par))

Gout.EM.NoHCDep$y$par[c(i.hh10, i.hh10sq, i.ldhdl)] <- 0

tab.NoHCDep <- simulateCF(Gout.EM.NoHCDep, policies[c(1,2,7,8)], jpsc.plelg, Gbeta, 15, Gnrep.sim, Gseed)
print(tab.NoHCDep)

## Low Entry Costs
Gout.EM.LowEntCost <- Gout.EM

i.ldh   <- which("ldh" == names(Gout.EM$u$par))
i.ler   <- which("ler" == names(Gout.EM$u$par))[1]
i.len   <- which("len" == names(Gout.EM$u$par))[1]

Gout.EM.LowEntCost$u$par[c(i.ldh, i.ler, i.len)] <- Gout.EM$u$par[c(i.ldh, i.ler, i.len)] * 0.5

tab.LowEntCost <- simulateCF(Gout.EM.LowEntCost, policies[c(1,2,7,8)], jpsc.plelg, Gbeta, 15, Gnrep.sim, Gseed)
print(tab.LowEntCost)

## High CC Price
Gout.EM.HighCCPrice <- Gout.EM

tmp.ccprice <- Gcc.price
Gcc.price <- c(169550, 99740, 99740, 47770)
tab.HighCCPrice <- simulateCF(Gout.EM.HighCCPrice, policies[c(1,2,7,8)], jpsc.plelg, Gbeta, 15, Gnrep.sim, Gseed)
Gcc.price <- tmp.ccprice

print(tab.HighCCPrice)
