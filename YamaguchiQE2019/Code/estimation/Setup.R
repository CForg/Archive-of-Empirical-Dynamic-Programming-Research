######################
## Define the model ##
######################

# Parameters for SVFI
Giterlim.svfi <- 6
Gbeta <- 0.95
Gret <- 65
Glogit <- TRUE

# parameters for simulation
Gnrep.fit <- 30
Gnrep.sim <- 1000
Gseed <- 654321
Glab.fit <- c("dh","dr","dn","dl","df","y","ys","nchild")
Glab.sim <- c("dw","dh","dr","dn","dl","df","y","ys","nchild","cons","emax")
Gsim.term <- 25
Gfrom.irf <- 2
Gto.irf <- 16
Gt.conception <- 5

## CC Price
Gcc.price <- c(43739, 40660, 38179, 34181)

## number of types
Gn.type <- 4

## labels for submodels (dl == 1 implies df == 1)
Glab.type <- c("c","scl","col","age","hh","hr","hn","age.hh","age.hr","age.hn",
               "ys","sq.nchild","yca.c","dr","dn","df")

Glab.ys <- c("c","age","agesq","ys","sq.nchild","yca.c",
             "dr","dn","dl","df","urate")

Glab.yr <- c("c","hr","hrsq","hn","hh10","hh10sq",
             "urate","ldhdl","ldn")
Glab.yn <- c("c","hn","hnsq","hr","hh10","hh10sq",
             "urate","ldhdl","ldr")

Glab.u.str <- list()
Glab.u.str$r <- c("c","sq.nchild","ldh","len","ldlr","urate",
                  "yca0","yca1","yca2","yca3","yca4")
Glab.u.str$n <- c("c","sq.nchild","ldh","ler","ldln","urate",
                  "yca0","yca1","yca2","yca3","yca4")
Glab.u.str$l <- c("c", "ler", "pllegcov.ler", "pllegcov.len", "ldlr.inelg", "ldln.inelg")
Glab.u.str$l <- c("c", "ler", "pllegcov", "ldl.inelg")
Glab.u.str$f <- c("c","age","agesq","sq.nchild",
                  "yca0","yca1","yca2","yca3","yca4",
                  "dr","dn")
Glab.u.str$cons  <- c("c","dr","dn","sq.nchild")
Glab.u.str$lambda <- c("l1","l2","l3","l4","a1") ## MUST BE LAST

## upper bounds for state variables
ub.ys     <- 50
ub.year   <- 2014
ub.hh     <- 50
ub.hr     <- 50
ub.hn     <- 50
ub.age    <- Gret
ub.edu    <- 18
ub.nchild <- 4
ub.yca    <- 18

jpsc <- CheckUB(jpsc)

## randomly chosen grid points
set.seed(1234, kind = "Mersenne-Twister")
Gsampled.states.raw <- SampleStateVariables(10000)
