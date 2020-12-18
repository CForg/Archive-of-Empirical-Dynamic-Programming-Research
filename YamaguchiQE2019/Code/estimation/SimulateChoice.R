SimulateChoice <- function(ccp, eps.u) {
    ## simulate choice
    ##
    ## Args
    ##    ccp: matrix of N * 4. choice probability
    ##    eps.u: vector of N. random deviates
    ##
    ## Returns
    ##    a vector of N. choice index.

    d1 <- ifelse(                              eps.u < ccp[,1],            1, 0)
    d2 <- ifelse(ccp[,1]            <= eps.u & eps.u < rowSums(ccp[,1:2]), 1, 0)
    d3 <- ifelse(rowSums(ccp[,1:2]) <= eps.u & eps.u < rowSums(ccp[,1:3]), 1, 0)
    d4 <- ifelse(rowSums(ccp[,1:3]) <= eps.u & eps.u < rowSums(ccp[,1:4]), 1, 0)
    d5 <- ifelse(rowSums(ccp[,1:4]) <= eps.u & eps.u < rowSums(ccp[,1:5]), 1, 0)
    d6 <- ifelse(rowSums(ccp[,1:5]) <= eps.u & eps.u < rowSums(ccp[,1:6]), 1, 0)
    d7 <- ifelse(rowSums(ccp[,1:6]) <= eps.u & eps.u < rowSums(ccp[,1:7]), 1, 0)
    d8 <- ifelse(rowSums(ccp[,1:7]) <= eps.u & eps.u < rowSums(ccp[,1:8]), 1, 0)

    dh <- d1 + d5
    dr <- d2 + d6
    dn <- d3 + d7
    dl <- d4 + d8
    df <- d5 + d6 + d7 + d8

    cbind(dh=dh, dr=dr, dn=dn, dl=dl, df=df)
}
