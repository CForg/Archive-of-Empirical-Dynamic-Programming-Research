source("Initialize.R")
require(boot)

## function to calculate descriptive stats
CalcMeans <- function(dat) {

    ## take needed variables
    dat.sub <- dat[,c("age","edu","hh","hr","hn","nchild",
                      "ys","y","dh","dr","dn","dl","df")]
    
    ## update lables
    colnames(dat.sub) <- c("Age","Education","Years in Home","Years in Reg Work",
                           "Years in Non-Reg Work",
                           "No. of Children","Husband's Earnings","Earnings",
                           "Home","Reg Work","Non-Reg Work","PL","Pregnancy")
    
    ## summary stats for pooled data
    x1 <- cbind("Mean"      = apply(dat.sub, 2, mean, na.rm=T),
                "Std. Dev." = apply(dat.sub, 2, sd,   na.rm=T),
                "Min."      = apply(dat.sub, 2, min,  na.rm=T),
                "Max."      = apply(dat.sub, 2, max,  na.rm=T))
    
    ## sample size of pooled data
    x2 <- c("No. of Obs. (Person-Year)" = nrow(dat.sub),
            "No. of Persons" = length(unique(dat$id)))
    
    ## summary stats by age
    x3 <- cbind("30" = apply(subset(dat.sub, Age==30), 2, mean, na.rm=T),
                "35" = apply(subset(dat.sub, Age==35), 2, mean, na.rm=T),
                "40" = apply(subset(dat.sub, Age==40), 2, mean, na.rm=T),
                "45" = apply(subset(dat.sub, Age==45), 2, mean, na.rm=T))
    
    ## sample size by age
    x4 <- c(paste("N=", sum(dat.sub$Age == 30), sep=""),
            paste("N=", sum(dat.sub$Age == 35), sep=""),
            paste("N=", sum(dat.sub$Age == 40), sep=""),
            paste("N=", sum(dat.sub$Age == 45), sep=""))
    
    ## output
    list(stats.pooled = x1,
         nobs.pooled  = x2,
         stats.by.age = x3,
         nobs.by.age  = x4)
}

## tables for descriptive stats (pooled)
x.desstats <- CalcMeans(jpsc)

dummy <- latex(round(x.desstats$stats.pooled, 3),
               file="tab-sumstats.tex", title="", table.env=FALSE,
               n.rgroup = c(8,5),
               rgroup=c("Individual Characteristics",
                        "Employment and Fertility Choices"))

dummy <- latex(x.desstats$nobs.pooled,
               file="tab-nobs.tex", title="", table.env=FALSE, colheads=FALSE)

## table for age profiles
CalcMeans.boot <- function(x, i, dat){
    ## resample by individual ID
    x <- do.call("c", mclapply(i, function(n) which(x[n] == dat$id)))
    ## create data
    as.vector(CalcMeans(dat[x,])$stats.by.age[c("Home","Reg Work","Non-Reg Work",
                                               "PL","Pregnancy","Earnings",
                                               "No. of Children",
                                               "Husband's Earnings"),])
}

x <- boot(data = unique(jpsc$id),
          statistic = CalcMeans.boot,
          R = 1000,
          dat=jpsc)

out.ageprof <- NULL

for(i in 1:32) out.ageprof <- c(out.ageprof, round(x$t0[i], 3),
                                paste("(", round(sd(x$t[,i]), 3), ")", sep=""))

out.ageprof <- matrix(out.ageprof, ncol=4)

out.ageprof[c(8,10),4] <- "(----)"

colnames(out.ageprof) <- c("30","35","40","45")
rownames(out.ageprof) <- c("Home","","Reg Work","","Non-Reg Work","",
                           "PL","","Pregnancy","","Earnings","",
                           "No. of Children","","Husband's Earnings","")

dummy <- latex(out.ageprof,
               file="tab-choice-by-age.tex", title="", table.env=FALSE,
               extracolheads=x.desstats$nobs.by.age, cgroup = "Age", n.cgroup = 4)

## table for transition matrix
MakeTransitionMatrix.boot <- function(x, i, dat){
    ## resample by individual ID
    x <- do.call("c", mclapply(i, function(n) which(x[n] == dat$id)))
    ## create data
    as.vector(MakeTransitionMatrix(dat[x,]))
}

x <- boot(data = unique(subset(jpsc, ini==0)$id),
          statistic = MakeTransitionMatrix.boot,
          R = 1000,
          dat=subset(jpsc, ini==0))

out.trmat <- NULL

for(i in 1:16) out.trmat <- c(out.trmat, round(x$t0[i], 3),
                              paste("(", round(sd(x$t[,i]), 3), ")", sep=""))

out.trmat <- matrix(out.trmat, ncol=4)

out.trmat[2,4] <- "(----)"

colnames(out.trmat) <- c("Home","Reg","Non-Reg","PL")
rownames(out.trmat) <- c("Home","", "Reg","", "Non-Reg","", "PL","")

dummy <- latex(out.trmat, file="tab-trmat.tex", table.env=FALSE,
               title="", 
               n.rgroup = 8, rgroup = "Choice in $t-1$",
               n.cgroup = 4, cgroup = "Choice in $t$")

## table for PL take-up
CalcPLTakeUp.boot <- function(x, i, dat){
    ## resample by individual ID
    x <- do.call("c", mclapply(i, function(n) which(x[n] == dat$id)))
    ## create data
    CalcPLTakeUp(dat[x,])
}

x <- boot(data = unique(subset(jpsc, ini==0)$id),
          statistic = CalcPLTakeUp.boot,
          R = 1000,
          dat=subset(jpsc, ini==0))

x <- cbind(apply(x$t, 2, mean), apply(x$t, 2, sd))

colnames(x) <- c("Mean","Std. Error")
rownames(x) <- c("(1) Eligible for PL",
                 "(2) Quit and Stay Home",
                 "(3) Take Up PL",
                 "(4) Work",
                 "(5) Employed")

dummy <- latex(round(x,3),
               file = "tab-pl-takeup.tex", title="", table.env=FALSE,
               n.rgroup = c(1,3,1),
               rgroup = c("Among Those Who Give Birth",
                          "Among Those Who Are Eligible for PL",
                          "Among Those Who Took PL Last Year"))

## PL take up rate by policy params
out.regtakeup <- RegTakeUp(subset(jpsc, ini==0))

lab.columns <- c("(1) All",
                 "(2) Worked",
                 "(3) Reg",
                 "(4) Non-Reg","(5) Non-Reg","(6) Non-Reg")

lab.coefs <- c("Eligibility", "Repl. Rate")

print(screenreg(out.regtakeup, omit.coef="(Intercept)|(factor)|h|ys|age", digits=3,
                stars = c(0.01, 0.05, 0.1), include.rmse = FALSE,
                include.adjrs = FALSE,
                custom.coef.names = lab.coefs, custom.model.names = lab.columns))

texreg(file="tab-pl-takeup-reg.tex",
       out.regtakeup, omit.coef="(Intercept)|(factor)|h|ys|age|urate", digits=3,
       stars = c(0.01, 0.05, 0.1), include.rmse = FALSE, include.adjrs = FALSE,
       custom.coef.names = lab.coefs, custom.model.names = lab.columns, table=FALSE)

## correlation between assets
require(lmtest)
jpsc.asset <- MakeCovariatesAll(jpsc)
jpsc.asset <- as.data.frame(jpsc.asset)
jpsc.asset$asset <- jpsc.asset$asset / 10000

fml.asset <- dh ~ scl + col + ini_age +
    age + agesq + hr + hrsq + hn + hnsq + hh10 + hh10sq + ldr + ldn + ldlr + ldln +
    plelg + pllegcov +
    sq.nchild + yca0 + yca1 + yca2 + yca3 + yca4 +
    ys + I(ys^2) + urate

out.ftest <- matrix(0, 2, 5)

out.dh0 <- lm(fml.asset, data=jpsc.asset, subset=ini==0 & !is.na(asset))
out.dh1 <- update(out.dh0, . ~ . + asset + I(asset^2))
out.dr0 <- update(out.dh0, dr ~ .)
out.dr1 <- update(out.dr0, . ~ . + asset + I(asset^2))
out.dn0 <- update(out.dh0, dn ~ .)
out.dn1 <- update(out.dn0, . ~ . + asset + I(asset^2))
out.dl0 <- update(out.dh0, dl ~ .)
out.dl1 <- update(out.dl0, . ~ . + asset + I(asset^2))
out.db0 <- update(out.dh0, db ~ .)
out.db1 <- update(out.db0, . ~ . + asset + I(asset^2))

out.waldtest.dh <- waldtest(out.dh0, out.dh1)
out.waldtest.dr <- waldtest(out.dr0, out.dr1)
out.waldtest.dn <- waldtest(out.dn0, out.dn1)
out.waldtest.dl <- waldtest(out.dl0, out.dl1)
out.waldtest.db <- waldtest(out.db0, out.db1)

out.asset <- matrix(
    c(summary(out.dh1)$coef["asset",1:2],
      summary(out.dh1)$coef["I(asset^2)",1:2],
      out.waldtest.dh[[3]][2], out.waldtest.dh[[4]][2],
      summary(out.dr1)$coef["asset",1:2],
      summary(out.dr1)$coef["I(asset^2)",1:2],
      out.waldtest.dr[[3]][2], out.waldtest.dr[[4]][2],
      summary(out.dn1)$coef["asset",1:2],
      summary(out.dn1)$coef["I(asset^2)",1:2],
      out.waldtest.dn[[3]][2], out.waldtest.dn[[4]][2],
      summary(out.dl1)$coef["asset",1:2],
      summary(out.dl1)$coef["I(asset^2)",1:2],
      out.waldtest.dl[[3]][2], out.waldtest.dl[[4]][2],
      summary(out.db1)$coef["asset",1:2],
      summary(out.db1)$coef["I(asset^2)",1:2],
      out.waldtest.db[[3]][2], out.waldtest.db[[4]][2]), nrow=6)

colnames(out.asset) <- c("Home", "Regular", "Non-Regular", "PL", "Childbearing")
rownames(out.asset) <- c("Asset", "", "Asset-Sq.", "", "F-statistic", "p-value")

x <- formatC(out.asset, format="f", digit=3)
x2 <- formatC(out.asset, format="e", digits=2)
x[1:4, 5] <- x2[1:4, 5]

for(i in c(2,4)) {
    for(j in 1:5) {
        x[i,j] <- paste("(", x[i,j], ")", sep="")
    }
}

dummy <- latex(x, file="tab-asset.tex", title="", table.env=FALSE, dcolumn=TRUE,
               n.rgroup=c(4,2), rgroup=c("Coefficients", "Significance"))


## descriptive stats for husband's work
x0 <- subset(jpsc, ini == 0)
x1 <- subset(jpsc, year < 2005 & ini == 0)
x2 <- subset(jpsc, year > 2005 & ini == 0)

x <- c(mean(x0$hrswk_s == 1, na.rm=TRUE),
       mean(x0$hrswk2_s, na.rm=TRUE),
       mean(x0$ys, na.rm=TRUE),
       mean(x1$hrswk_s == 1, na.rm=TRUE),
       mean(x1$hrswk2_s, na.rm=TRUE),
       mean(x1$ys, na.rm=TRUE),
       mean(x2$hrswk_s == 1, na.rm=TRUE),
       mean(x2$hrswk2_s, na.rm=TRUE),
       mean(x2$ys, na.rm=TRUE))

x <- matrix(x, nrow=3)
colnames(x) <- c("1994-2011", "Before 2005", "After 2005")
rownames(x) <- c("Work 15 or Fewer Hours Per Week", "Average Hours/Week",
                 "Annual Earnings (in mil. JPY $\\approx$ 10,000 USD)")

dummy <- latex(round(x, 3), file="tab-husband_LS.tex",
               title="", table.env=FALSE)
