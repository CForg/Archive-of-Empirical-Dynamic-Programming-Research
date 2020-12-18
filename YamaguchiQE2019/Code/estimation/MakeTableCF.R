require(Hmisc)

tab.base.bonus <- tab.base
for(i in 1:length(tab.base)){
    tab.base.bonus[[i]] <- tab.base[[i]][c(7,9:12), ]
    tab.base[[i]] <- tab.base[[i]][1:8, ]
}

c.idx <- c(0:4, 6, 11) + 1
r.lab <- c("JP:0, RR:0\\%", "JP:1, RR:0\\%", "JP:3, RR:0\\%",
           "JP:0, RR:50\\%", "JP:1, RR:50\\%", "JP:3, RR:50\\%",
           "JP:1, RR:50\\% + Need to Take PL", "JP:3, RR:50\\% + Need to Take PL")
c.lab <- c.idx - 2

tab.base.tex <- tab.base

for(i in 1:length(tab.base)){
    tab.base.tex[[i]] <- tab.base[[i]][, c.idx]
    dimnames(tab.base.tex[[i]]) <- list(r.lab, c.lab)
}


tab.base.emp <- rbind(tab.base.tex$dw, tab.base.tex$dl,
                      tab.base.tex$dr, tab.base.tex$dn,
                      tab.base.tex$y)

dummy <- latex(round(tab.base.emp,2), title="",
               file="tab-cf-base-emp.tex", table.env=FALSE,
               n.rgroup = c(8,8,8,8,8), n.cgroup = length(c.idx),
               rgroup=c("Work","On PL","Reg. Work","Non-Reg. Work",
                        "Earnings (mil. JPY)"),
               cgroup="Years Since Birth")

tab.base.fertility <- rbind(tab.base.tex$df, tab.base.tex$nchild)
    
dummy <- latex(round(tab.base.fertility,2), title="",
               file="tab-cf-base-fertility.tex", table.env=FALSE,
               n.rgroup = c(8,8), n.cgroup = length(c.idx),
               rgroup=c("Pregnancy","Number of Children"),
               cgroup="Years Since Birth")

## income, consumption, and utility
pv.y <- tab.base$y[,2]
for(i in 2:16) pv.y <- pv.y + 1.05^(2-i) * tab.base$y[,i]

pv.cons <- tab.base$cons[,2]
for(i in 2:16) pv.cons <- pv.cons + 1.05^(2-i) * tab.base$cons[,i]

tab.base.welfare <- cbind(Income = round(pv.y,2),
                          Consumption = round(pv.cons,2),
                          "Utility (Rank)" = paste(round(tab.base$emax[,2],2),
                                          " (",9-rank(tab.base$emax[,2]),")",sep=""))

rownames(tab.base.welfare) <- c("(1) JP:0, RR:0\\%", "(2) JP:1, RR:0\\%", "(3) JP:3, RR:0\\%",
                                "(4) JP:0, RR:50\\%", "(5) JP:1, RR:50\\%", "(6) JP:3, RR:50\\%",
                                "(7) JP:1, RR:50\\% + Need to Take PL", "(8) JP:3, RR:50\\% + Need to Take PL")

dummy <- latex(tab.base.welfare, title="",
               file="tab-cf-base-welfare.tex", table.env=FALSE)

## cash benefits
tab.cb.emp <- rbind(c(tab.base$dl[2,2], tab.base$dl[c(5,7), 2] - tab.base$dl[c(2,5), 2]),
                    c(tab.base$dw[2,7], tab.base$dw[c(5,7), 7] - tab.base$dw[c(2,5), 7]),
                    c(tab.base$y[2,7],  tab.base$y[c(5,7), 7]  - tab.base$y[c(2,5), 7]),
                    c(tab.base$nchild[2,12], tab.base$nchild[c(5,7), 12] - tab.base$nchild[c(2,5), 12]))

dimnames(tab.cb.emp) <- list(c("On PL in $t=0$",
                               "Work in $t=5$",
                               "Earnings in $t=5$",
                               "No of Children in $t=10$"),
                             c("No Benefit",
                               "0\\%$\\rightarrow$50\\%",
                               "\\shortstack{50\\%$\\rightarrow$\\\\50\\% + `Need to Take PL'}"))

dummy <- latex(round(tab.cb.emp,2), title="",
               file="tab-cf-cb.tex", table.env=FALSE,
               n.cgroup=c(1,2), cgroup=c("Mean","Policy Effects"))

## Abenomics
tab.abe <- rbind(c(tab.base$dl[7, 2], tab.base$dl[8, 2] - tab.base$dl[7, 2]),
                 c(tab.base$dw[7, 7], tab.base$dw[8, 7] - tab.base$dw[7, 7]),
                 c(tab.base$y[7, 7],  tab.base$y[8, 7]  - tab.base$y[7, 7]),
                 c(tab.base$nchild[7, 12], tab.base$nchild[8, 12] - tab.base$nchild[7, 12]))

dimnames(tab.abe) <- list(c("On PL in $t=0$",
                            "Work in $t=5$",
                            "Earnings in $t=5$",
                            "No of Children in $t=10$"),
                          c("1Yr + 50% + `Need to Take PL'",
                            "\\shortstack{1Yr + 50\\% + `Need to Take PL'$\\rightarrow$\\\\3Yr + 50\\% + `Need to Take PL'}"))


dummy <- latex(round(tab.abe,2), title="",
               file="tab-cf-abe.tex", table.env=FALSE,
               n.cgroup=c(1,1), cgroup=c("Mean","Policy Effects"))

## environment
tab.pe <- function(x, r1, r2){
    c(x$dl[r2,2]     - x$dl[r1,2],
      x$dw[r2,7]     - x$dw[r1,7],
      x$y[r2,7]      - x$y[r1,7],
      x$nchild[r2,12] - x$nchild[r1,12])
}

tab.env <- rbind(cbind(c(tab.base$dl[1,2], tab.base$dw[1,7],
                         tab.base$y[1,7], tab.base$nchild[1,12]),
                       tab.pe(tab.base, 1, 2), tab.pe(tab.NoHCDep, 1, 2),
                       tab.pe(tab.LowEntCost, 1, 2)),
                 cbind(c(tab.base$dl[7,2], tab.base$dw[7,7],
                         tab.base$y[7,7], tab.base$nchild[7,12]),
                       tab.pe(tab.base, 7, 8), tab.pe(tab.NoHCDep, 3, 4),
                       tab.pe(tab.LowEntCost, 3, 4)))

rownames(tab.env) <- rep(c("On PL in $t=0$",
                           "Work in $t=5$",
                           "Earnings in $t=5$",
                           "No of Children in $t=10$"),2)

colnames(tab.env) <- c("\\shortstack{(1) Before\\\\Change}","(2) Baseline",
                       "\\shortstack{(3) No HC\\\\Depreciation}",
                       "\\shortstack{(4) Low\\\\Entry Cost}")
           
dummy <- latex(round(tab.env,2), title="",
               file="tab-cf-env.tex", table.env=FALSE,
               n.rgroup=c(4,4),
               rgroup=c("No PL $\\rightarrow$ 1-Yr JP (w/ No Benefit)",
                        "1-Yr JP $\\rightarrow$ 3-Yr JP (w/ 50\\% + PL Take-Up)"),
               n.cgroup=c(1,3),
               cgroup=c("Mean","Policy Effects"))

## baby bonus
tab.bonus <- rbind(tab.base.bonus$dl[,2],
                   tab.base.bonus$dw[,7],
                   tab.base.bonus$y[,7],
                   tab.base.bonus$nchild[,12])

dimnames(tab.bonus) <- list(c("On PL in $t=0$",
                              "Work in $t=5$",
                              "Earnings in $t=5$",
                              "No of Children in $t=10$"),
                            c("",
                              "1 Mil. JPY",
                              "3 Mil. JPY",
                              "5 Mil. JPY",
                              ""))

dummy <- latex(round(tab.bonus,2), title="",
               file="tab-cf-babybonus.tex", table.env=FALSE,
               n.cgroup=c(1,3,1),
               cgroup=c("Baseline", "Baby Bonus", "\\shortstack{Free\\\\Childcare}"))
