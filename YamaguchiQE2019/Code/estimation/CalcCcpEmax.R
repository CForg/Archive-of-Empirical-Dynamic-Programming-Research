CalcCcpEmax <- function(param.u.str, v, ccp.or.emax){
    ## Args
    ##   param.u.str: a vector of structural parameters
    ##   v: matrix of instantaneous utility
    ##   ccp.or.emax: character string that indicates what to return.
    ##
    ## Returns
    ##   

    ## dissimilarity parameters
    i2 <- length(param.u.str)
    i1 <- i2 - length(Glab.u.str$lambda) + 1

    p <- param.u.str[i1:i2]
    if(Glogit) p <- exp(p) / (1+exp(p))
    
    lambda <- p[1:4]

    ## share parameters
    a.f <- p[5]
    a.e <- 1-p[5]

    ## exp(v) for f=0
    exp.v.lambda1 <- cbind((a.f * exp(v[,1]))^(1/lambda[1]),
                           (a.f * exp(v[,2]))^(1/lambda[1]),
                           (a.f * exp(v[,3]))^(1/lambda[1]),
                           (a.f * exp(v[,4]))^(1/lambda[1]))

    ## exp(v) for f=1
    exp.v.lambda2 <- cbind((a.f * exp(v[,5]))^(1/lambda[2]),
                           (a.f * exp(v[,6]))^(1/lambda[2]),
                           (a.f * exp(v[,7]))^(1/lambda[2]),
                           (a.f * exp(v[,8]))^(1/lambda[2]))

    ## exp(v) for e=0
    exp.v.lambda3 <- cbind((a.e * exp(v[,1]))^(1/lambda[3]),
                           (a.e * exp(v[,4]))^(1/lambda[3]),
                           (a.e * exp(v[,5]))^(1/lambda[3]),
                           (a.e * exp(v[,8]))^(1/lambda[3]))
    
    ## exp(v) for e=1
    exp.v.lambda4 <- cbind((a.e * exp(v[,2]))^(1/lambda[4]),
                           (a.e * exp(v[,3]))^(1/lambda[4]),
                           (a.e * exp(v[,6]))^(1/lambda[4]),
                           (a.e * exp(v[,7]))^(1/lambda[4]))
    
    ## value of each nest
    sum.exp.v1 <- rowSums(exp.v.lambda1)
    sum.exp.v2 <- rowSums(exp.v.lambda2)
    sum.exp.v3 <- rowSums(exp.v.lambda3)
    sum.exp.v4 <- rowSums(exp.v.lambda4)
    
    ## H function
    H <- sum.exp.v1^lambda[1] + sum.exp.v2^lambda[2] + sum.exp.v3^lambda[3] + sum.exp.v4^lambda[4]

    if(ccp.or.emax == "ccp"){

        sum.exp.v1.lambda <- sum.exp.v1^(lambda[1]-1)
        sum.exp.v2.lambda <- sum.exp.v2^(lambda[2]-1)
        sum.exp.v3.lambda <- sum.exp.v3^(lambda[3]-1)
        sum.exp.v4.lambda <- sum.exp.v4^(lambda[4]-1)

        ## CCP
        ccp <- cbind(exp.v.lambda1[,1] * sum.exp.v1.lambda + exp.v.lambda3[,1] * sum.exp.v3.lambda,
                     exp.v.lambda1[,2] * sum.exp.v1.lambda + exp.v.lambda4[,1] * sum.exp.v4.lambda,
                     exp.v.lambda1[,3] * sum.exp.v1.lambda + exp.v.lambda4[,2] * sum.exp.v4.lambda,
                     exp.v.lambda1[,4] * sum.exp.v1.lambda + exp.v.lambda3[,2] * sum.exp.v3.lambda,
                     exp.v.lambda2[,1] * sum.exp.v2.lambda + exp.v.lambda3[,3] * sum.exp.v3.lambda,
                     exp.v.lambda2[,2] * sum.exp.v2.lambda + exp.v.lambda4[,3] * sum.exp.v4.lambda,
                     exp.v.lambda2[,3] * sum.exp.v2.lambda + exp.v.lambda4[,4] * sum.exp.v4.lambda,
                     exp.v.lambda2[,4] * sum.exp.v2.lambda + exp.v.lambda3[,4] * sum.exp.v3.lambda) / H

        ## adjustment for indeterminate ("0 * Inf" occurs when infecund)
        ## ccp[exp.v.lambda == 0] <- 0
        ccp[is.nan(ccp)] <- 0

        ## outcome
        ccp
        
    } else if(ccp.or.emax == "emax"){

        ## Emax
        log(H)
    }
}
