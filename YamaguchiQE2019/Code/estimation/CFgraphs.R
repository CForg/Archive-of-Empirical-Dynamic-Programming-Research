## graphs for job protection
pdf(file = "fig-jp-dw.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dw[1:3,1:12]), type="l", main="(a) Work", xlab="Years Since Birth", ylab="Probability", lwd=3, col=c(1,2,4))
legend("topright", legend=c("None","1-Yr","3-Yr"), lwd=3, col=c(1,2,4), lty=1:3)
dev.off()

pdf(file = "fig-jp-dl.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dl[1:3,1:12]), type="l", main="(b) PL Take-Up", xlab="Years Since Birth", ylab="Probability", lwd=3, col=c(1,2,4))
legend("topright", legend=c("None","1-Yr","3-Yr"), lwd=3, col=c(1,2,4), lty=1:3)
dev.off()

pdf(file = "fig-jp-dr.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dr[1:3,1:12]), type="l", main="(c) Regular Work", xlab="Years Since Birth", ylab="Probability", lwd=3, col=c(1,2,4))
legend("topright", legend=c("None","1-Yr","3-Yr"), lwd=3, col=c(1,2,4), lty=1:3)
dev.off()

pdf(file = "fig-jp-dn.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dn[1:3,1:12]), type="l", main="(d) Non-Regular Work", xlab="Years Since Birth", ylab="Probability", lwd=3, col=c(1,2,4))
legend("bottomright", legend=c("None","1-Yr","3-Yr"), lwd=3, col=c(1,2,4), lty=1:3)
dev.off()

pdf(file = "fig-jp-df.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$df[1:3,1:12]), type="l", main="(e) Pregnancy", xlab="Years Since Birth", ylab="Probability", lwd=3, col=c(1,2,4))
legend("topright", legend=c("None","1-Yr","3-Yr"), lwd=3, col=c(1,2,4), lty=1:3)
dev.off()

pdf(file = "fig-jp-nchild.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$nchild[1:3,1:12]), type="l", main="(f) No. of Children", xlab="Years Since Birth", ylab="Children", lwd=3, col=c(1,2,4))
legend("bottomright", legend=c("None","1-Yr","3-Yr"), lwd=3, col=c(1,2,4), lty=1:3)
dev.off()

## graphs for cash benefit
pdf(file = "fig-cb-dw.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dw[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="Prob. of Work", lwd=3, col=c(1,2,4))
dev.off()

pdf(file = "fig-cb-dl.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dl[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="Prob. of PL Take-Up", lwd=3, col=c(1,2,4))
dev.off()

pdf(file = "fig-cb-dr.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dr[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="Prob. of Reg.", lwd=3, col=c(1,2,4))
dev.off()

pdf(file = "fig-cb-dn.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$dn[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="Prob. of Non-Reg.", lwd=3, col=c(1,2,4))
dev.off()

pdf(file = "fig-cb-y.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$y[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="Earnings (mil. JPY)", lwd=3, col=c(1,2,4))
dev.off()

pdf(file = "fig-cb-df.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$df[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="Prob. of Pregnancy", lwd=3, col=c(1,2,4))
dev.off()

pdf(file = "fig-cb-nchild.pdf", paper="special", width=5, height=4, pointsize=12)
par(mar = c(5,4,1,1))
matplot(-1:10, t(tab.base$nchild[c(2,5,7),1:12]), type="l", xlab="Years Since Birth", ylab="No. of Children", lwd=3, col=c(1,2,4))
dev.off()
