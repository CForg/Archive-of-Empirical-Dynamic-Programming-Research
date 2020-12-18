CalcLikelihoodY <- function(param.y, xr, xn, d=NULL, y=NULL, na=NULL){

  # predicted earnings by sector
  yhat.r <- xr %*% param.y[1:length(Glab.yr)]
  yhat.n <- xn %*% param.y[(1+length(Glab.yr)):length(c(Glab.yr, Glab.yn))]
  
  # prediction/likelihood
  if (is.null(y)) {
  
    # prediction
    cbind(yhat.r, yhat.n)
  
  } else {
    
    # likelihood
    p <- dnorm(log(y), yhat.r*d[,1]+yhat.n*d[,2], param.y[length(param.y)])
    
    # adjust for NA
    p[na] <- 1
    
    p
  }
}  

CalcWeightedLogLikY <- function(param.y, xr, xn, d, y, na, weight){

    ## likelihood
    l.y <- mapply(CalcLikelihoodY,
                   param.y = ConvParamY(param.y),
                   MoreArgs = list(
                       xr = xr,
                       xn = xn,
                       d = d,
                       y = y,
                       na = na))

    ## weighted mean of log-likelihood
    out <- 0
    for(i in 1:Gn.type) out <- out + sum(weight[[i]] * log(l.y[,i]))
    -out
}

DiffWeightedLogLikY <- function(param, step.size = 1e-4, ...) {

    fnval <- unlist( mclapply(0:length(param), fn.eps.y,
                              param=param, step.size=step.size,
                              fn=CalcWeightedLogLikY, ...) )
    
    (fnval[-1] - fnval[1]) / step.size
}

fn.eps.y <- function(i, param, step.size, fn, ...) {

    if (i != 0) {
        param[i] <- param[i] + step.size
    }

    fn(param.y=param, ...)
}
