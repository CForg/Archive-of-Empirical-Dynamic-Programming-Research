####################
## Initialization ##
####################
source("Initialize.R")
load("output.RData")

## function for simulation
SummarizeSimOut <- function(out.EM, policy, dat, beta, sim.term, modelfit){
    simout <- SimulateStrModel(out.EM, policy, dat, beta, sim.term, modelfit)
    SummarizeOut(simout)
}

## function to calculate descriptive stats
SummarizeOut <- function(dat) {
    list(trmat  = MakeTransitionMatrix(dat),
         age    = MakeProfile2(dat, "age", 26:48, Glab.fit),
         takeup = CalcPLTakeUp(dat),
         takeup.reg = SelectRegTakeUp(dat),
         diff2005 = CalcDiff2005(dat))
}

## function to select results for PL take-up regression
SelectRegTakeUp <- function(dat) {
    x <- RegTakeUp(dat)
    
    c(x[[2]]$coef[c("pllegcov","rr.l")],
      x[[3]]$coef[c("rr.l")],
      x[[6]]$coef[c("pllegcov","rr.l")])
}

## simulate for model fit
set.seed(Gseed, kind = "L'Ecuyer-CMRG")
list.SumSimOut <- mclapply(1:Gnrep.fit, function(i, ...) SummarizeSimOut(...),
                           out.EM = Gout.EM, policy = NULL,
                           dat = jpsc, beta = Gbeta, sim.term = Gsim.term,
                           modelfit = TRUE)

## average over simulations
trmat.sim    <- list.SumSimOut[[1]]$trmat / Gnrep.fit
prof.age.sim <- list.SumSimOut[[1]]$age   / Gnrep.fit
takeup.sim   <- list.SumSimOut[[1]]$takeup / Gnrep.fit
takeup.reg.sim   <- list.SumSimOut[[1]]$takeup.reg / Gnrep.fit
diff2005.sim   <- list.SumSimOut[[1]]$diff2005 / Gnrep.fit

for(i in 2:Gnrep.fit){
    trmat.sim    <- trmat.sim    + list.SumSimOut[[i]]$trmat / Gnrep.fit
    prof.age.sim <- prof.age.sim + list.SumSimOut[[i]]$age   / Gnrep.fit
    takeup.sim    <- takeup.sim    + list.SumSimOut[[i]]$takeup / Gnrep.fit
    takeup.reg.sim    <- takeup.reg.sim    + list.SumSimOut[[i]]$takeup.reg / Gnrep.fit
    diff2005.sim    <- diff2005.sim    + list.SumSimOut[[i]]$diff2005 / Gnrep.fit
}

## descriptive stats from data
list.SumDat <- SummarizeOut(subset(jpsc, ini==0))

trmat.dat    <- list.SumDat$trmat
prof.age.dat <- list.SumDat$age  
takeup.dat    <- list.SumDat$takeup
takeup.reg.dat    <- list.SumDat$takeup.reg
diff2005.dat    <- list.SumDat$diff2005

## transition matrix
print(round(trmat.dat, 3))
print(round(trmat.sim, 3))

## profiles
print(round(prof.age.dat, 3))
print(round(prof.age.sim, 3))

## PL take-up
print(round(takeup.dat, 3))
print(round(takeup.sim, 3))

## PL take-up
print(round(takeup.reg.dat, 3))
print(round(takeup.reg.sim, 3))

## before and after 2005
print(round(diff2005.dat, 3))
print(round(diff2005.sim, 3))


## plot modelfit along age
pdf("modelfit.pdf")
for(i in 1:ncol(prof.age.dat)) {
  matplot(26:48, cbind(prof.age.dat[,i], prof.age.sim[,i]), 
          type='l', ylab=colnames(prof.age.dat)[i])
}
dev.off()

## drawing graphs for presentation/paper
vec.main <- c("Home","Regular Work","Non-Regular Work","PL Take-Up","Pregnancy",
              "Own Earnings","Husband's Earnings","No. of Children")
vec.ylab <- c("Probability","Probability","Probability","Probability","Probability",
              "Million Yen","Million Yen","Children")
vec.age.pdf.file <- c("fig-mf-age-h.pdf", "fig-mf-age-r.pdf",
                      "fig-mf-age-n.pdf", "fig-mf-age-l.pdf", "fig-mf-age-f.pdf",
                      "fig-mf-age-y.pdf", "fig-mf-age-ys.pdf",
                      "fig-mf-age-nchild.pdf")

for(i in 1:length(vec.age.pdf.file)) {
    pdf(file = vec.age.pdf.file[i],
        paper="special", width=5, height=4, pointsize=11)
    par(mar = c(5,4,1,0))
    matplot(seq(26, 48), 
            cbind(prof.age.dat[,i], prof.age.sim[,i]),
            type='l', xlab = "Age", ylab = vec.ylab[i], main = vec.main[i], lwd = 4)
    dev.off()
}    

## latex table for modelfit to transition matrix
dummy <- latex(round(rbind(trmat.dat, trmat.sim), 3), title="",
               file="tab-modelfit-trmat.tex",
               table.env=FALSE, n.rgroup = c(4,4), rgroup = c("Data","Model"))

## latex table for modelfit to PL take-up.
x <- cbind(takeup.dat, takeup.sim)

colnames(x) <- c("Data","Model")

rownames(x) <- c("(1) Eligible for PL",
                 "(2) Quit and Stay Home",
                 "(3) Take Up PL",
                 "(4) Work",
                 "(5) Employed")

dummy <- latex(round(x,3),
               file = "tab-modelfit-pl-takeup.tex", title="", table.env=FALSE,
               n.rgroup = c(1,3,1),
               rgroup = c("Among Those Who Give Birth",
                          "Among Those Who Are Eligible for PL",
                          "Among Those Who Took PL Last Year"))

## latex table for modelfit to PL take-up regression.
x <- cbind(takeup.reg.dat[1:2],
           takeup.reg.sim[1:2],
           c(NA,takeup.reg.dat[3]),
           c(NA,takeup.reg.sim[3]),
           takeup.reg.dat[4:5],
           takeup.reg.sim[4:5])
           
colnames(x) <- rep(c("Data","Model"), 3)
rownames(x) <- c("Eligibility","Repl. Rate")

dummy <- latex(round(x,3),
               file = "tab-modelfit-pl-takeup-reg.tex", title="", table.env=FALSE,
               n.cgroup = c(2,2,2),
               cgroup = c("Worked","Reg","Non-Reg"))

## latex table for before and after 2005
x <- cbind(diff2005.dat[,1],
           diff2005.sim[,1],
           diff2005.dat[,2],
           diff2005.sim[,2])

colnames(x) <- rep(c("Data","Model"), 2)
rownames(x) <- c("Take Up PL", "Employed in Any Sector", "Employed in Non-Reg. Sector")

dummy <- latex(round(x,3),
               file = "tab-modelfit-diff2005.tex", title="", table.env=FALSE,
               n.cgroup = c(2,2),
               cgroup = c("Before 2005","After 2005"),
               n.rgroup = c(1,2),
               rgroup = c("Among Those Who Give Birth",
                          "Among Those Who Took PL Last Year"))
