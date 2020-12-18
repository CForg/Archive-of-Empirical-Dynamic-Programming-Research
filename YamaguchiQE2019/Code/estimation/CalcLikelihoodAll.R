CalcLikelihoodAll <- function(param.type, param.ys, param.y, param.u, 
                              X.type, X.ys, X.yr, X.yn, Y.ys, Y.y, Y.ccp,
                              na.ys, na.y, na.ccp, id,
                              param.sieve, x.bar.dat, x.u.str.dat, pl.dat,
                              x.bar.grid, x.u.str.grid, pl.grid, xxx.grid, beta, iterlim.svfi){  
    ## likelihood for type
    if(Gn.type == 1){
        l.type <- 1
    } else if(Gn.type > 1){
        l.type <- CalcLikelihoodType(param.type, X.type)
    }
    
    ## likelihood for earnings
    l.ys <- sapply(ConvParamYS(param.ys), CalcLikelihoodYS, x=X.ys, y=Y.ys, na=na.ys)

    ## likelihood for earnings
    l.y <- sapply(ConvParamY(param.y), CalcLikelihoodY, xr=X.yr, xn=X.yn,
                  d=Y.ccp[,c("dr","dn")], y=Y.y, na=na.y)

    ## likelihood for choice
    l.ccp <- mapply(CalcLikelihoodCCP.SVFI,
                    param.u.str = ConvParamUStr(param.u),
                    param.sieve = param.sieve,
                    x.bar.dat = x.bar.dat,
                    x.u.str.dat = x.u.str.dat,
                    x.bar.grid = x.bar.grid,
                    x.u.str.grid = x.u.str.grid, 
                    MoreArgs = list(
                        pl.dat = pl.dat,
                        d = Y.ccp,
                        na = na.ccp,
                        pl.grid = pl.grid,
                        xxx.grid = xxx.grid,
                        beta = beta,
                        iterlim.svfi = iterlim.svfi))
    
    ## likelihood at observation level (for each type)
    lik.its <- l.ys * l.y * l.ccp

    ## likelihood at individual level (for each type)
    l.type * apply(lik.its, 2, function(x) tapply(x, id, prod))
}
