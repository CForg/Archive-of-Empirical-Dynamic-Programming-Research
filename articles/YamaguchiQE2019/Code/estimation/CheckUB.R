CheckUB <- function(S) {
    ## Enforce upper bounds for state variables
    ##
    ## Arg:
    ##    S: input matrix of state variables
    ##
    ## Return:
    ##    a matrix of state variables

    S[S[,"ys"] > ub.ys, "ys"] <- ub.ys
    S[S[,"year"] > ub.year, "year"] <- ub.year
    S[S[,"hh"] > ub.hh, "hh"] <- ub.hh
    S[S[,"hr"] > ub.hr, "hr"] <- ub.hr
    S[S[,"hn"] > ub.hn, "hn"] <- ub.hn
    S[S[,"age"] > ub.age, "age"] <- ub.age
    S[S[,"edu"] > ub.edu, "edu"] <- ub.edu
    S[S[,"nchild"] > ub.nchild, "nchild"] <- ub.nchild
    S[S[,"yca"] > ub.yca, "yca"] <- ub.yca

    S
}
