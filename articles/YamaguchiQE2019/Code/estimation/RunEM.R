source("Initialize.R")
load("input.RData")

########################
## start EM algorithm ##
########################
for(i in 1:200){
    ## control options for optim.
    if(i < 100){
        Goptim.ctrl <- list(maxit = 100)
    } else {
        Goptim.ctrl <- list(maxit = 1000)
    }

    ## update params
    t.start <- proc.time()
    Gout.EM <- UpdateEM(Gout.EM, jpsc, Gsampled.states.raw,
                        iterlim.svfi = Giterlim.svfi,
                        beta = Gbeta, optim.ctrl = Goptim.ctrl)
    t.end <- proc.time()
    
    ## report progress
    cat(i, (t.end-t.start)[3], unlist(Gout.EM[1:4]), "\n")
    save(Gout.EM, file="output.RData")

    ## exit if converged
    if(Gout.EM$diff.param < 1e-5) break
}

## print results.
print(Gout.EM)
