MakeProfile2 <- function(dat, x, lab1, lab2){
    ## make age profiles
    ##
    ## Args
    ##   dat: data matrix (simulation or real data)
    ##
    ## Returns
    ##   matrix of age profiles
    
    ## if weight is missing, give one.
    if ( all(colnames(dat) != "weight")) {
        dat <- cbind(dat, weight = 1)
    }

    ## take needed columns only.
    dat <- dat[, c(x, lab2, "weight")]
    
    ## construct output matrix
    out <- matrix(0, length(lab1), length(lab2), dimnames=list(lab1,lab2))
    
    ## loop over variable & age
    for(i in lab1) {
        for(j in lab2) {
            
            ## take relevant variables
            sub.dat <- dat[dat[,x] == i, c(j, "weight")]
            
            ## omit NA
            sub.dat <- na.omit(sub.dat)
            
            ## calculate weighted mean
            out[match(i,lab1), j] <- weighted.mean(sub.dat[,j], sub.dat[,"weight"])
        }
    }
    out
}

## function to calculate age profiles
MakeProfile <- function(dat, x, from, to, along){
    ## make age profiles
    ##
    ## Args
    ##   dat: data matrix (simulation or real data)
    ##   x: labels of variables 
    ##   from: starting age
    ##   to: ending age
    ##
    ## Returns
    ##   matrix of age profiles
    
    ##
    if ( all(colnames(dat) != "weight")) {
        dat <- cbind(dat, weight = 1)
    }
    
    ## construct output matrix
    out <- matrix(0, to - from + 1, length(x),
                  dimnames=list(seq(from, to, 1), x))
    
    ## loop over variable & age
    for(i in 1:length(x)) {
        for(j in 1:nrow(out)) {
      
            ## take relevant variables & age
            sub.dat <- dat[dat[,along] == (j+from-1), c(x[i], "weight")]
            
            ## omit NA
            sub.dat <- na.omit(sub.dat)
            
            ## calculate weighted mean
            out[j,i] <- sum(sub.dat[,x[i]] * sub.dat[,"weight"]) / 
                sum(sub.dat[,"weight"])
            
        }
    }
    
    out
}
