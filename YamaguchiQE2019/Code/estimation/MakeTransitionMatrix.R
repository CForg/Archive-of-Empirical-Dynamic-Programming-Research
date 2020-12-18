MakeTransitionMatrix <- function(dat){

    ## check if weight is provided
    if ( all(colnames(dat) != "weight")) {
        dat <- cbind(dat, weight = 1)
    }

    ## construct output matrix
    trmat <- matrix(0, 4, 4,
                    dimnames = list(c("Home","Reg","Non-Reg","PL"),
                                    c("Home","Reg","Non-Reg","PL")))

    ## prep
    lab1 = c("ldh","ldr","ldn","ldl")
    lab2 = c("dh","dr","dn","dl")
    
    ## loop
    for(i in 1:4) {

        ## take relevant variables
        sub.dat <- dat[dat[,lab1[i]]==1, c(lab2, "weight")]

        ## omit NA
        sub.dat <- na.omit(sub.dat)
        
        for(j in 1:4) {
            ## calculate weighted mean
            trmat[i,j] <- sum(sub.dat[,lab2[j]] * sub.dat[,"weight"]) / sum(sub.dat[,"weight"])
        }

        ## normalization
        trmat[i,] <- trmat[i,] / sum(trmat[i,])

    }

    trmat
}
