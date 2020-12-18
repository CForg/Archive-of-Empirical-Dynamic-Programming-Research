## function to calculate desstats for PL take-up
CalcPLTakeUp <- function(dat) {

    ## if weight is missing, give one.
    if ( all(colnames(dat) != "weight")) {
        dat <- cbind(dat, weight = 1)
    }

    ## convert to data frame
    dat <- as.data.frame(dat)

    ## vector for output
    out <- numeric(5)

    ## PL legal eligibility
    dat$pllegcov <- ifelse((dat$ldr == 1 |
                         (dat$ldn == 1 & dat$year >= 2005)) & dat$yca == 0, 1, 0)
    
    ## PL ineligible but worked
    dat$plinelgwork <- ifelse(dat$ldn == 1 & dat$year < 2005 & dat$yca == 0, 1, 0)
    
    ## among those who give birth
    x1 <- subset(dat, yca == 0)
    out[1] <- weighted.mean(x1$pllegcov, x1$weight, na.rm=TRUE)

    ## among those who are eligible for PL
    x2 <- subset(dat, pllegcov == 1)
    out[2] <- weighted.mean(x2$dh, x2$weight, na.rm=TRUE)
    out[3] <- weighted.mean(x2$dl, x2$weight, na.rm=TRUE)
    out[4] <- weighted.mean(x2$dr, x2$weight, na.rm=TRUE) +
              weighted.mean(x2$dn, x2$weight, na.rm=TRUE)
    
    ## among those who took PL last year
    x4 <- subset(dat, ldl == 1)
    out[5] <- 1 - weighted.mean(x4$dh, x4$weight, na.rm=TRUE)
    
    out
}

## function for regression of PL take-up
RegTakeUp <- function(dat, covariates=TRUE) {

    ## if weight is missing, give one.
    if ( all(colnames(dat) != "weight")) {
        dat <- cbind(dat, weight = 1)
    }

    ## convert to data frame
    dat <- as.data.frame(dat)
    
    ## create variables 
    dat$pllegcov <- ifelse((dat$ldr == 1 |
                          (dat$ldn == 1 & dat$year >= 2005)) & dat$yca == 0, 1, 0)
    dat$rr.l <-
        dat$pllegcov * .25 * ifelse(dat$year >= 1995 & dat$year <= 2000, 1, 0) +
        dat$pllegcov * .40 * ifelse(dat$year >= 2001 & dat$year <= 2006, 1, 0) +
        dat$pllegcov * .50 * ifelse(dat$year >= 2007 & dat$year <= 2011, 1, 0)

    ## formula
    fml <- list()
    fml[[1]] <- dl ~ pllegcov
    fml[[2]] <- dl ~ rr.l
    fml[[3]] <- dl ~ pllegcov + rr.l

    if(covariates) {
        for(i in 1:3) fml[[i]] <- update(fml[[i]], . ~ . + age + hh + hn + hr + ys +
                                                       factor(nchild) + factor(edu))
    }
    
    ## run regression
    out.lm <- list()
    out.lm[[1]] <- lm(fml[[3]], dat, yca == 0, weight)
    out.lm[[2]] <- lm(fml[[3]], dat, yca == 0 & (ldr == 1 | ldn == 1), weight)
    out.lm[[3]] <- lm(fml[[2]], dat, yca == 0 & ldr == 1, weight)
    out.lm[[4]] <- lm(fml[[1]], dat, yca == 0 & ldn == 1, weight)
    out.lm[[5]] <- lm(fml[[2]], dat, yca == 0 & ldn == 1, weight)
    out.lm[[6]] <- lm(fml[[3]], dat, yca == 0 & ldn == 1, weight)

    out.lm
}

## compare pre- and post-2005 behavor
CalcDiff2005 <- function(dat) {
    ## if weight is missing, give one.
    if ( all(colnames(dat) != "weight")) {
        dat <- cbind(dat, weight = 1)
    }
    
    ## convert to data frame
    dat <- as.data.frame(dat)
    
    ## vector for output
    out <- numeric(6)

    ## PL take-up before and after 2005 (among child bearers)
    dat.pre  <- subset(dat, year < 2005 & dat$yca == 0)
    dat.post <- subset(dat, year > 2005 & dat$yca == 0)

    out[1] <- weighted.mean(dat.pre$dl,  dat.pre$weight,  na.rm=TRUE)
    out[2] <- weighted.mean(dat.post$dl, dat.post$weight, na.rm=TRUE)
    
    ## employment choices before and after 2005 (a year after childbearing)
    dat.pre  <- subset(dat, year < 2005 & dat$ldl == 1)    
    dat.post <- subset(dat, year > 2005 & dat$ldl == 1)

    out[3] <- 1 - weighted.mean(dat.pre$dh,  dat.pre$weight,  na.rm=TRUE)
    out[4] <- 1 - weighted.mean(dat.post$dh, dat.post$weight, na.rm=TRUE)
    out[5] <- weighted.mean(dat.pre$dn,  dat.pre$weight,  na.rm=TRUE)
    out[6] <- weighted.mean(dat.post$dn, dat.post$weight, na.rm=TRUE)
    
    t(matrix(out, nrow=2))
}
