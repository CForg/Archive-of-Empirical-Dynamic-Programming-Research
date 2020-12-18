MakeCovariatesUtilStr <- function(mat.cov.all, list.lab.u, lab.yr, lab.yn, param.y, policy=NULL){
    ## For a given type, calculate a matrix of variables used for structural model
    ##
    ## Args:
    ##   mat.cov.all: a matrix of all covariates.
    ##   list.lab.u: a list of length 4. Each element is a label for reduced-form
    ##               utility function.
    ##   lab.yr: label for covariates for earnings function in reg sector.
    ##   lab.yn: label for covariates for earnings function in non-reg sector.
    ##   param.y: parameter for a given type
    ##
    ## Returns:
    ##   a matrix of variables used for structural model
    
    ## predicted earnings
    yhat <- exp(CalcLikelihoodY(param.y, mat.cov.all[,lab.yr], mat.cov.all[,lab.yn]))
    
    ## pre-leave earnings less bonus payment 
    yhat1 <- (12/15 * mat.cov.all[,"ldr"] * yhat[,1]) +
             (12/13 * mat.cov.all[,"ldn"] * yhat[,2])

    ## maximum is 426000 per month (= 5.112 mil per year)
    yhat1[yhat1 > 5.112] <- 5.112
    
    ## childcare cost
    CC <- (mat.cov.all[,"yca0"] * Gcc.price[1] + mat.cov.all[,"yca1"] * Gcc.price[2] +
           mat.cov.all[,"yca2"] * Gcc.price[3] + mat.cov.all[,"yca3"] * Gcc.price[4]) * 12 / 1000000

    CC[mat.cov.all[,"freeCC"] == 1] <- 0

    ## baby bonus
    baby.bonus <- mat.cov.all[,"baby.bonus"] * mat.cov.all[,"yca0"]

    ## consumption
    cons.h <- mat.cov.all[,"ys"] + mat.cov.all[,"rr.h"] * yhat1 + baby.bonus
    cons.r <- mat.cov.all[,"ys"] + yhat[,1] - CC + baby.bonus
    cons.n <- mat.cov.all[,"ys"] + yhat[,2] - CC + baby.bonus
    cons.l <- mat.cov.all[,"ys"] + mat.cov.all[,"rr.l"] * yhat1 + baby.bonus
    
    ## returns
    cbind(mat.cov.all,
          cons.h = cons.h, cons.r = cons.r, cons.n = cons.n, cons.l = cons.l)
}
