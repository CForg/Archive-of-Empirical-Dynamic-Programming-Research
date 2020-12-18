require(checkpoint)
checkpoint("2018-03-29")

## load libraries, function, and data.
source("LoadAll.R")

## define the model and prepare for estimation.
source("Setup.R")

## parameters for parallel derivative
options("mc.cores" = detectCores())
