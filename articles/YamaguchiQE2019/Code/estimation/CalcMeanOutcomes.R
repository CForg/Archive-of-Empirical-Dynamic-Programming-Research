CalcMeanOutcomes <- function(simout, by, lab.by, lab.outcomes){

    out <- matrix(0, length(lab.by), length(lab.outcomes),
                  dimnames = list(lab.by, lab.outcomes))

    simout <- simout[, c(by, lab.outcomes, "weight")]

    for(i in 1:length(lab.by)){

        x <- simout[simout[,by] == lab.by[i], ]

        for(j in 1:length(lab.outcomes)){

            out[i,j] <- weighted.mean(x[,lab.outcomes[j]], x[,"weight"])

        }

    }

    t(out)

}

