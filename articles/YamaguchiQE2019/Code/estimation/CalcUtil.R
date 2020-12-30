CalcUtil <- function(x, param.u.str, param.only=FALSE){
    ## calculate instantaneous utility for a given type
    ##
    ## Args
    ##   x: matrix of covariates
    ##   param.u.str: structural parameters
    ##
    ## Returns
    ##   instantaneous utility matrix of 4 X N

    ## index for sub-parameters
    i.end.r  <- length(Glab.u.str$r)
    i.end.n  <- i.end.r + length(Glab.u.str$n)
    i.end.l  <- i.end.n + length(Glab.u.str$l)
    i.end.f  <- i.end.l + length(Glab.u.str$f)
    i.end.c  <- i.end.f + length(Glab.u.str$cons)
    i.end.ll <- i.end.c + length(Glab.u.str$lambda)
    
    ## parameters
    param.r <- param.u.str[1:i.end.r]
    param.n <- param.u.str[(i.end.r+1):i.end.n]
    param.l <- param.u.str[(i.end.n+1):i.end.l]
    param.f <- param.u.str[(i.end.l+1):i.end.f]
    param.c <- param.u.str[(i.end.f+1):i.end.c]
    param.ll <- param.u.str[(i.end.c+1):i.end.ll]
    
    if (param.only) {
        return(list(r=param.r, n=param.n, l=param.l, f=param.f, c=param.c, ll=param.ll))
    }

    ## marginal utility of cons
    muc <- x[, Glab.u.str$cons[4:length(Glab.u.str$cons)], drop=FALSE] %*%
        param.c[4:length(Glab.u.str$cons)]

    muc.hf0 <- param.c[1]+muc
    muc.rf0 <- param.c[1]+param.c[2]+muc
    muc.nf0 <- param.c[1]+param.c[3]+muc
    muc.lf0 <- muc.hf0
    muc.hf1 <- muc.hf0
    muc.rf1 <- muc.rf0
    muc.nf1 <- muc.nf0
    muc.lf1 <- muc.lf0
    
    ## non-pecuniary utility of work choices
    ur <- x[, Glab.u.str$r]%*%param.r
    un <- x[, Glab.u.str$n]%*%param.n
    ul <- x[, Glab.u.str$l]%*%param.l

    ## non-pecuniary utility of pregnancy
    uf <- x[, Glab.u.str$f[1:(length(Glab.u.str$f)-2)]] %*%
        param.f[Glab.u.str$f[1:(length(Glab.u.str$f)-2)]]
    ufr <- uf + param.f[Glab.u.str$f[length(Glab.u.str$f)-1]]
    ufn <- uf + param.f[Glab.u.str$f[length(Glab.u.str$f)-0]]

    ## returns
    cbind(uhf0 = muc.hf0*x[,"cons.h"],
          urf0 = muc.rf0*x[,"cons.r"] + ur,
          unf0 = muc.nf0*x[,"cons.n"] + un,
          ulf0 = muc.lf0*x[,"cons.l"] + ul,
          uhf1 = muc.hf1*x[,"cons.h"]      + uf,
          urf1 = muc.rf1*x[,"cons.r"] + ur + ufr,
          unf1 = muc.nf1*x[,"cons.n"] + un + ufn,
          ulf1 = muc.lf1*x[,"cons.l"] + ul + uf)
}
