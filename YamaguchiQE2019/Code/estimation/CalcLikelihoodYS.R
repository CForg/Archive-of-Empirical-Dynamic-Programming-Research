CalcLikelihoodYS <- function(param.ys, x, y=NULL, na=NULL){
    ## predicted earnings by sector
    yhat <- x %*% param.ys[-length(param.ys)]
  
    ## prediction/likelihood
    if(is.null(y)){
        ## prediction
        yhat
    } else {
        ## likelihood
        p <- dnorm(y, yhat, param.ys[length(param.ys)])
        p[na] <- 1
        p
    }
}

CalcWeightedLogLikYS <- function(param.ys, x, y, na, weight){

    ## likelihood
    l.ys <- mapply(CalcLikelihoodYS,
                   param.ys = ConvParamYS(param.ys),
                   MoreArgs = list(
                       x = x,
                       y = y,
                       na = na))

    ## weighted mean of log-likelihood
    out <- 0
    for(i in 1:Gn.type) out <- out + sum(weight[[i]] * log(l.ys[,i]))
    -out
}

DiffWeightedLogLikYS <- function(param, step.size = 1e-4, ...) {

    fnval <- unlist( mclapply(0:length(param), fn.eps.ys,
                              param=param, step.size=step.size,
                              fn=CalcWeightedLogLikYS, ...) )
    
    (fnval[-1] - fnval[1]) / step.size
}

fn.eps.ys <- function(i, param, step.size, fn, ...) {

    if (i != 0) {
        param[i] <- param[i] + step.size
    }

    fn(param.ys=param, ...)
}
