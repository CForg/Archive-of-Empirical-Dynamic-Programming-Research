source("Initialize.R")
load("output.RData")

Glogit <- FALSE
idx.g <- match(c("l1","l2","l3","l4","a1"), names(Gout.EM$u$par))
Gout.EM$u$par[idx.g] <- exp(Gout.EM$u$par[idx.g]) / (1 + exp(Gout.EM$u$par[idx.g]))

## functions
StripParam <- function(out.EM){

    p.type <- out.EM$type$par
    p.ys   <- out.EM$ys$par
    p.y    <- out.EM$y$par
    p.u    <- out.EM$u$par

    p.loc1 <- c(1,
                1 + length(p.type),
                1 + length(c(p.type,p.ys)),
                1 + length(c(p.type,p.ys,p.y)))
    
    p.loc2 <- c(length(p.type),
                length(c(p.type,p.ys)),
                length(c(p.type,p.ys,p.y)),
                length(c(p.type,p.ys,p.y,p.u)))
    
    list(param = c(p.type, p.ys, p.y, p.u), loc1 = p.loc1, loc2 = p.loc2)
}

loglik.nfxp.eps <- function(i, out.EM, step.size){

    if(i != 0){
        sp <- StripParam(out.EM)

        sp$param[i] <- sp$param[i] + step.size
        
        out.EM$type$par <- sp$param[sp$loc1[1]:sp$loc2[1]]
        out.EM$ys$par   <- sp$param[sp$loc1[2]:sp$loc2[2]]
        out.EM$y$par    <- sp$param[sp$loc1[3]:sp$loc2[3]]
        out.EM$u$par    <- sp$param[sp$loc1[4]:sp$loc2[4]]
    }

    log(UpdateEM(out.EM, jpsc, Gsampled.states.raw, 1000, Gbeta, TRUE))
}

CalcScoreLikNFXP <- function(out.EM, step.size){
    ## number of all the parameters
    sp <- StripParam(out.EM)

    ## likelihood
    list.lik <- mclapply(0:sp$loc2[4], loglik.nfxp.eps, out.EM, step.size)
    
    ## matrix to store jacobian
    jacob.out.EM <- matrix(0, length(list.lik[[1]]), length(list.lik)-1)
    
    ## derivative by finite difference
    for(i in 1:ncol(jacob.out.EM)){
        jacob.out.EM[,i] <- (list.lik[[i+1]] - list.lik[[1]]) / step.size
    }
    
    jacob.out.EM
}

## calculate score
score.nfxp <- CalcScoreLikNFXP(Gout.EM, 1e-4)

## covariance matrix
covmat.nfxp <- solve(t(score.nfxp) %*% score.nfxp)

## parameter conversion
param.nfxp <- StripParam(Gout.EM)

## table with estimates and standard errors
param.nfxp <- StripParam(Gout.EM)

tab.param <- cbind(estimates = param.nfxp$param, std.error = sqrt(diag(covmat.nfxp)))

tab.param.type <- tab.param[param.nfxp$loc1[1]:param.nfxp$loc2[1],]
tab.param.ys   <- tab.param[param.nfxp$loc1[2]:param.nfxp$loc2[2],]
tab.param.y    <- tab.param[param.nfxp$loc1[3]:param.nfxp$loc2[3],]
tab.param.u    <- tab.param[param.nfxp$loc1[4]:param.nfxp$loc2[4],]

cat("type\n")
print(round(tab.param.type, 3))
cat("ys\n")
print(round(tab.param.ys, 3))
cat("y\n")
print(round(tab.param.y, 3))
cat("u\n")
print(round(tab.param.u, 3))
