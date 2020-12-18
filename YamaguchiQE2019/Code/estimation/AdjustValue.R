AdjustValue <- function(param.u.str, x.u.str, beta, Emax) {
    ## adjust values for PL eligibility, infecundity, retirement, etc.
    ##
    ## Args
    ##   param.u.str: a vector of structural parameters
    ##   x.u.str: list of list of covariate matrices for structural model
    ##   beta: discount factor
    ##   Emax: continuation value
    ##
    ## Returns
    ##   v: N x 8 matrix of values

    ## pre-adjustment values
    v <- CalcUtil(x.u.str, param.u.str) + beta * Emax

    ## PL eligibility
    v[x.u.str[,"plelg"] == 0, c(4,8)] <- -Inf

    ## infecundity
    v[x.u.str[,"age"] >= 45, 5:8] <- -Inf

    ## retirement
    v[x.u.str[,"age"] >= Gret,] <- 0

    v
}
