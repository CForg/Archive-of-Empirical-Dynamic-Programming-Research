require(Hmisc)

## type
lt <- length(Glab.type)

tab.param.type2 <- tab.param.type[1:lt, ]

for(i in 2:(Gn.type-1)) {
    tab.param.type2 <- cbind(tab.param.type2, tab.param.type[(1+lt*(i-1)):(lt*i), ])
}

## husband's earnings
idx.ys <- c(which(rownames(tab.param.ys) == "c"), which(rownames(tab.param.ys) != "c"))
tab.param.ys2 <- tab.param.ys[idx.ys,]

## own earnings
lr <- length(Glab.yr)
ln <- length(Glab.yn)

tab.param.yr <- tab.param.y[c(which(rownames(tab.param.y) == "cr"), 1:lr), ]
tab.param.yn <- tab.param.y[c(which(rownames(tab.param.y) == "cn"), (1:ln)+lr), ]

tab.param.yr <- rbind(tab.param.yr[1:7,],
                      "hnsq"=c(NA, NA),
                      tab.param.yr[8:(nrow(tab.param.yr)-1),],
                      "ldr"=NA,
                      tab.param.yr[nrow(tab.param.yr),,drop=FALSE])
tab.param.yn <- rbind(tab.param.yn[c(1:4,7),],
                      "hrsq"=c(NA, NA),
                      tab.param.yn[c(5:6,8:nrow(tab.param.yn)),],
                      "ldn"=NA)

tab.param.y2 <- cbind(tab.param.yr, tab.param.yn)

## utility
x <- unique(unlist(Glab.u.str[1:4]))
tab.param.u2 <- matrix(NA, length(x) + Gn.type-1, 6)
rownames(tab.param.u2) <- c(x, rep("c",Gn.type-1))
colnames(tab.param.u2) <- rep(colnames(tab.param.u), 3)

lr <- length(Glab.u.str$r)
ll <- length(Glab.u.str$l)
lf <- length(Glab.u.str$f)
lc <- length(Glab.u.str$cons)
lg <- length(Glab.u.str$lambda)

idx.r <- c(which(rownames(tab.param.u) == "cr"), 1:(lr))
idx.n <- c(which(rownames(tab.param.u) == "cn"), (lr+1):(lr*2))
idx.l <- c(which(rownames(tab.param.u) == "cl"), (lr*2+1):(lr*2+ll))
idx.f <- c(which(rownames(tab.param.u) == "cf"), (lr*2+ll+1):(lr*2+ll+lf))
idx.c <- (lr*2+ll+lf+1):(lr*2+ll+lf+lc)
idx.g <- (lr*2+ll+lf+lc+1):(lr*2+ll+lf+lc+lg)

tab.param.r <- tab.param.u[idx.r,]
tab.param.n <- tab.param.u[idx.n,]
tab.param.l <- tab.param.u[idx.l,]
tab.param.f <- tab.param.u[idx.f,]
tab.param.c <- tab.param.u[idx.c,]
tab.param.g <- tab.param.u[idx.g,]

## summarize in one table
lab.npu <- c(rep("c",Gn.type-1), unique(unlist(Glab.u.str[1:4])))

tab.param.u2 <- matrix(NA, length(lab.npu), 8)
dimnames(tab.param.u2) <- list(lab.npu, rep(c("estim","se"), 4))

tab.param.u2[match(row.names(tab.param.r), lab.npu, 1), 1:2] <- tab.param.r

idx.r2 <- c(1:Gn.type, match(row.names(tab.param.r)[-(1:Gn.type)], lab.npu, 1))
idx.n2 <- c(1:Gn.type, match(row.names(tab.param.n)[-(1:Gn.type)], lab.npu, 1))
idx.l2 <- c(1:Gn.type, match(row.names(tab.param.l)[-(1:Gn.type)], lab.npu, 1))
idx.f2 <- c(1:Gn.type, match(row.names(tab.param.f)[-(1:Gn.type)], lab.npu, 1))

tab.param.u2[idx.r2, 1:2] <- tab.param.r
tab.param.u2[idx.n2, 3:4] <- tab.param.n
tab.param.u2[idx.l2, 5:6] <- tab.param.l
tab.param.u2[idx.f2, 7:8] <- tab.param.f

## print out parameters
cat("type\n")
print(round(tab.param.type2, 3))
cat("ys\n")
print(round(tab.param.ys2, 3))
cat("y\n")
print(round(tab.param.y2, 3))
cat("u (work and PL)\n")
print(round(tab.param.u2, 3))
cat("u (cons)\n")
print(round(tab.param.c, 3))
cat("GNL\n")
print(round(tab.param.g, 3))

## re-order tables
tab.param.ys2 <- tab.param.ys2[c(which(row.names(tab.param.ys2) == "c"),
                                 which(row.names(tab.param.ys2) != "c")),]

tab.param.y2 <- rbind(tab.param.y2[4,,drop=F], tab.param.y2[-4,])

tab.param.u2 <- rbind(tab.param.u2[4,,drop=F], tab.param.u2[-4,])

tab.param.ys2 <- rbind(tab.param.ys2[1:4,],
                       tab.param.ys2[c("ys","age","agesq","sq.nchild",
                                       "yca.c","dr","dn","dl","df","urate","sigma"),])

tab.param.y2 <- rbind(tab.param.y2[1:4,],
                      tab.param.y2[c("hr","hrsq","hn","hnsq","hh10","hh10sq",
                                     "ldhdl","ldr","ldn","urate"),])

tab.param.u2 <- rbind(tab.param.u2[1:4,],
                      tab.param.u2[c("dr","dn","ldh","ldlr","ldln","ler","len","pllegcov","ldl.inelg",
                                     "sq.nchild","yca0","yca1","yca2","yca3","yca4",
                                     "age","agesq","urate"),])

## latex table
lab.type <- c("Intercept","Some College","4-Yr College",
              "Age","Years in Home","Years in Reg.","Years in Non-Reg.",
              "Age $\\times$ Years in Home","Age $\\times$ Years in Reg.",
              "Age $\\times$ Years in Non-Reg.",
              "Husband's Earnings","Sqrt. of No. Children",
              "Age of Youngest Child",
              "Reg. in 1st Year","Non-Reg. in 1st Year","Conceived in 1st Year")

lab.ys <- c("Intercept (Type 1)","Intercept (Type 2)",
            "Intercept (Type 3)","Intercept (Type 4)",
            "Husband's Earnings","Age","Age-sq",
            "Sqrt. of No. Children","Age of Youngest Child",
            "Reg.","Non-Reg.","PL","Conception",
            "Unempl. Rate",
            "Std. Dev. of Error Term")

lab.y <- c("Intercept (Type 1)", "Intercept (Type 2)",
           "Intercept (Type 3)", "Intercept (Type 4)",
           "Years in Reg.","Square of Years in Reg. / 100",
           "Years in Non-Reg.","Square of Years in Non-Reg. / 100",
           "Years in Home","Square of Years in Home / 100",
           "Lagged Home or On-Leave", "Lagged Reg", "Lagged Non-Reg.",
           "Unempl. Rate")

lab.u <- c("Intercept (Type 1)", "Intercept (Type 2)",
           "Intercept (Type 3)", "Intercept (Type 4)",
           "Reg.","Non-Reg.","Lagged Home",
           "Lagged PL in Reg.","Lagged PL in Non-Reg.",
           "Lagged Reg. Empl.",
           "Lagged Non-Reg. Empl.","PL Legally Eligible","Lagged PL * Ineligible",
           "Sqrt. of No. Children",
           "Child Age 0","Child Age 1","Child Age 2",
           "Child Age 3-5","Child Age 6-11",
           "Age","Age-sq","Unempl. Rate")

lab.c <- c("Home or On-Leave","Reg.","Non-Reg.",
           "Sqrt. of No. Children")

lab.g <- c("$\\lambda_1$","$\\lambda_2$","$\\lambda_3$","$\\lambda_4$","$\\mu_1$")

dimnames(tab.param.type2) <- list(lab.type, rep(c("Estimate","S.E."), 3))
dimnames(tab.param.ys2) <- list(lab.ys, c("Estimate","S.E."))
dimnames(tab.param.y2) <- list(lab.y, rep(c("Estimate","S.E."),2))
dimnames(tab.param.u2) <- list(lab.u, rep(c("Estimate","S.E."),4))
dimnames(tab.param.c) <- list(lab.c, rep(c("Estimate","S.E."),1))
dimnames(tab.param.g) <- list(lab.g, rep(c("Estimate","S.E."),1))
              
x <- latex(round(tab.param.type2, 3), title="",
           file="tab-param-type.tex", table.env=FALSE,
           n.cgroup = c(2,2,2), cgroup = c("Type 2","Type 3","Type 4"))

x <- latex(round(tab.param.ys2, 3), title="",
           file="tab-param-ys.tex", table.env=FALSE)

x <- latex(round(tab.param.y2, 3), title="",
           file="tab-param-y.tex", table.env=FALSE,
           n.cgroup = c(2,2), cgroup = c("Reg.","Non-Reg."))

x <- latex(round(tab.param.u2, 3), title="",
           file="tab-param-u.tex", table.env=FALSE,
           n.cgroup = c(2,2,2,2), cgroup = c("Reg.","Non-Reg.","PL","Fertility"))

x <- latex(round(tab.param.c, 3), title="",
           file="tab-param-c.tex", table.env=FALSE)

x <- latex(round(tab.param.g, 3), title="",
           file="tab-param-g.tex", table.env=FALSE,
           n.rgroup = c(4,1), rgroup = c("Dissimilarity Parameter","Allocation Parameter"))



x <- MakeCovariatesAll(jpsc)
x <- x[x[,"ini"] == 1, Glab.type]
x <- CalcLikelihoodType(Gout.EM$type$par, x)
x <- colMeans(x)
x <- matrix(x, nrow=1)
colnames(x) <- c("Type 1", "Type 2", "Type 3", "Type 4")
rownames(x) <- c("Share")
x <- latex(round(x, 3), title="",
           file="tab-dist-type.tex", table.env=FALSE)
