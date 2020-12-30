#!/bin/sh

nohup R CMD BATCH RunEM.R
nohup R CMD BATCH CalcSE.R
nohup R CMD BATCH MakeTableParam.R
nohup R CMD BATCH CheckModelFit.R
nohup R CMD BATCH RunCF.R
nohup R CMD BATCH CFgraphs.R
nohup R CMD BATCH MakeTableCF.R
nohup R CMD BATCH CalcDesStats.R
