MakeCovariatesAll <- function(dat, policy=NULL){
    ## Construct all the covariates except for the ones for initial conditions.
    ##
    ## Args:
    ##   dat: data frame of state variables
    ##   policy: list of policy parameters
    ## Returns:
    ##   a matrix with additional variables
  
    dat$c <- 1
    dat$hhsq <- dat$hh^2/100
    dat$hrsq <- dat$hr^2/100
    dat$hnsq <- dat$hn^2/100
    dat$nchild0 <- ifelse(dat$nchild == 0, 1, 0)
    dat$nchild1 <- ifelse(dat$nchild == 1, 1, 0)
    dat$nchild2 <- ifelse(dat$nchild == 2, 1, 0)
    dat$nchild3 <- ifelse(dat$nchild >= 3, 1, 0)
    dat$nchild2plus <- ifelse(dat$nchild >= 2, 1, 0)
    dat$sq.nchild <- sqrt(dat$nchild)
    dat$age30lin <- ifelse(dat$age >= 30, 1, 0) * (dat$age - 30)
    dat$agesq <- dat$age^2/100
    dat$agecu <- dat$age^3/1000

    dat$yca.c <- dat$yca
    dat$yca.c[dat$nchild == 0] <- 0

    dat$yca0 <- ifelse(dat$yca == 0 & dat$nchild > 0, 1, 0)
    dat$yca1 <- ifelse(dat$yca == 1 & dat$nchild > 0, 1, 0)
    dat$yca2 <- ifelse(dat$yca == 2 & dat$nchild > 0, 1, 0)
    dat$yca3 <- ifelse( 3 <= dat$yca & dat$yca <= 5 & dat$nchild > 0, 1, 0)
    dat$yca4 <- ifelse( 6 <= dat$yca & dat$yca <=11 & dat$nchild > 0, 1, 0)
    dat$yca5 <- ifelse(12 <= dat$yca                & dat$nchild > 0, 1, 0)

    dat$yca.x <- dat$yca + 1
    dat$yca.x[dat$nchild == 0] <- 1000

    dat$hh10 <- dat$hh
    dat$hh10[dat$hh10 > 10] <- 10

    dat$hh10sq <- dat$hh10^2/100

    dat$age.hh <- dat$age * dat$hh / 100
    dat$age.hr <- dat$age * dat$hr / 100
    dat$age.hn <- dat$age * dat$hn / 100

    dat$ldlr <- dat$ldl * dat$ler
    dat$ldln <- dat$ldl * dat$len
    dat$ldhdl <- dat$ldh + dat$ldl

    if(is.null(dat$dh) == FALSE){
        dat$dh93 <- dat$dh * ifelse(dat$year == 1993, 1, 0)
        dat$dr93 <- dat$dr * ifelse(dat$year == 1993, 1, 0)
        dat$dn93 <- dat$dn * ifelse(dat$year == 1993, 1, 0)
    }
    
    dat$yca.sq.nchild <- dat$yca * dat$sq.nchild

    ## education
    dat$scl <- ifelse(12 < dat$edu & dat$edu < 16, 1, 0)
    dat$col <- ifelse(dat$edu >= 16, 1, 0)
    
    ## unemployment rate
    dat$urate <- 0
    dat$urate[ dat$year == 1993 ] <- 2.5
    dat$urate[ dat$year == 1994 ] <- 2.9
    dat$urate[ dat$year == 1995 ] <- 3.2
    dat$urate[ dat$year == 1996 ] <- 3.4
    dat$urate[ dat$year == 1997 ] <- 3.4
    dat$urate[ dat$year == 1998 ] <- 4.1
    dat$urate[ dat$year == 1999 ] <- 4.7
    dat$urate[ dat$year == 2000 ] <- 4.7
    dat$urate[ dat$year == 2001 ] <- 5.0
    dat$urate[ dat$year == 2002 ] <- 5.4
    dat$urate[ dat$year == 2003 ] <- 5.3
    dat$urate[ dat$year == 2004 ] <- 4.7
    dat$urate[ dat$year == 2005 ] <- 4.4
    dat$urate[ dat$year == 2006 ] <- 4.1
    dat$urate[ dat$year == 2007 ] <- 3.9
    dat$urate[ dat$year == 2008 ] <- 4.0
    dat$urate[ dat$year == 2009 ] <- 5.1
    dat$urate[ dat$year == 2010 ] <- 5.1
    dat$urate[ dat$year == 2011 ] <- 4.6
    dat$urate[ dat$year == 2012 ] <- 4.3
    dat$urate[ dat$year == 2013 ] <- 4.0
    dat$urate[ dat$year == 2014 ] <- 3.6

    ## weaker eligibility rule by employers
    dat$plelg <- 0
    dat$plelg[(0 <= dat$yca & dat$yca <= 2) &
                  (dat$ler == 1 | dat$len == 1)  ] <- 1

    ######################
    ## policy variables ##
    ######################

    if (is.null(policy)) {## no counterfactual
        ## RR (1. must have worked last year, 2. must have a newborn)
        dat$rr.h <- 0
        dat$rr.l <- 0
        dat$rr.l[ 1995 <= dat$year & dat$year <= 2000 &
                  dat$yca == 0 &  dat$ldr == 1         ] <- 0.25
        dat$rr.l[ 2001 <= dat$year & dat$year <= 2004 &
                  dat$yca == 0 &  dat$ldr == 1         ] <- 0.40
        dat$rr.l[ 2005 <= dat$year & dat$year <= 2006 &
                  dat$yca == 0 & (dat$ldr+dat$ldn) == 1] <- 0.40
        dat$rr.l[ 2007 <= dat$year &
                  dat$yca == 0 & (dat$ldr+dat$ldn) == 1] <- 0.50

        ## legal coverage for PL
        dat$pllegcov <- ifelse((dat$yca == 0 & dat$ler == 1) | 
                               (dat$yca == 0 & dat$len == 1 & dat$year >=  2005), 1, 0)

        ## CC subsidy
        dat$freeCC <- 0

        ## baby bonus
        dat$baby.bonus <- 0
    } else {## counterfactual
        ## RR
        dat$rr.h <- 0
        dat$rr.l <- 0
        if(policy$no.return) {
            dat$rr.h[ dat$yca == 0 & (dat$ldr+dat$ldn) == 1] <- policy$rr
        }
        dat$rr.l[ dat$yca == 0 & (dat$ldr+dat$ldn) == 1] <- policy$rr
        
        ## duration of job protection
        dat$pllegcov <- 0
        if(policy$jp.reg == 1) dat$pllegcov[0 == dat$yca & dat$ler == 1] <- 1
        if(policy$jp.reg == 2) dat$pllegcov[0 <= dat$yca & dat$yca <= 1 & dat$ler == 1] <- 1
        if(policy$jp.reg == 3) dat$pllegcov[0 <= dat$yca & dat$yca <= 2 & dat$ler == 1] <- 1
        if(policy$jp.nonreg == 1) dat$pllegcov[0 == dat$yca & dat$len == 1] <- 1
        if(policy$jp.nonreg == 2) dat$pllegcov[0 <= dat$yca & dat$yca <= 1 & dat$len == 1] <- 1
        if(policy$jp.nonreg == 3) dat$pllegcov[0 <= dat$yca & dat$yca <= 2 & dat$len == 1] <- 1

        ## CC subsidy
        if(policy$freeCC){
            dat$freeCC <- 1
        } else {
            dat$freeCC <- 0
        }

        ## baby bonus
        dat$baby.bonus <- policy$baby.bonus
    }
    
    ## interactions
    dat$ldl.inelg <- dat$ldl * (1-dat$pllegcov)
    
    ## initial observations
    dat$plelg[dat$ini == 1] <- 0
    
    as.matrix(dat)
}
