MakePolyLD <- function(x, param.ys=NULL){
    ## construct polynomial of state variables
    ##
    ## Args
    ##   x: matrix of state variables
    ##   param.ys (optional): parameters for husband's income 
    ##
    ## Return
    ##   orthogonal polynomial of state variables
    ##
    
    ## additional dummy
    ldlr <- x[,"ldl"] * x[,"ler"]
    ldln <- x[,"ldl"] * x[,"len"]

    ## index for retiree
    index0 <- ifelse(x[,"age"] >= Gret, 1, 0)

    ## index for childless women
    index1 <- ifelse(x[,"nchild"] == 0 & x[,"age"] < Gret, 1, 0)

    ## index for women with a new born
    index2 <- ifelse(x[,"nchild"] > 0 & x[,"yca"] == 0 & x[,"age"] < Gret, 1, 0)

    ## index for women with older children
    index3 <- ifelse(x[,"nchild"] > 0 & x[,"yca"] > 0 & x[,"age"] < Gret, 1, 0)

    ## continuous variables
    year   <- x[,"year"] - 1994
    hh     <- x[,"hh"]
    hn     <- x[,"hn"]
    hr     <- x[,"hr"] 
    age    <- x[,"age"]
    nchild <- x[,"nchild"]
    yca    <- x[,"yca"]
    ys     <- x[,"ys"]

    if(is.null(param.ys)) {
        ys.sq <- ys^2
        ys.cu <- ys^3
    } else {
        ys.sq <- ys^2 + param.ys["sigma"]^2
        ys.cu <- ys^3 + 3*ys*param.ys["sigma"]^2
    }

    ## special variables to account for nonlinearity
    hh1 <- ifelse(hh == 1, 1, 0)
    hh2 <- ifelse(hh == 2, 1, 0)
    hh3 <- ifelse(hh == 3, 1, 0)
    hh4 <- ifelse(4 <= hh & hh <= 5, 1, 0)
    hh5 <- ifelse(hh <= 6, 1, 0)
    yca2 <- ifelse(yca == 2, 1, 0)
    yca3 <- ifelse( 3 <= yca & yca <= 5, 1, 0)
    yca4 <- ifelse( 6 <= yca & yca <=11, 1, 0)
    yca5 <- ifelse(12 <= yca, 1, 0)

    ## base polynomial
    x.base <- poly(cbind(year, hh, hn, hr, age, ys, nchild, yca), degree=2, raw=TRUE)
    x.base[,"0.0.0.0.0.2.0.0"] <- ys.sq

    col1 <- grep("............0.0", colnames(x.base))
    col2 <- grep("..............0", colnames(x.base))

    ## covariates for childless women
    x.poly1 <- cbind(1, x.base[,col1],
                     year^3, hh^3, hn^3, hr^3, age^3, ys.cu,
                     hh1, hh2, hh3, hh4, hh5,
                     age^2*year, age^2*hh, age^2*hn, age^2*hr, age^2*ys)
    
    ## covariates for woman with a new born
    x.poly2 <- cbind(1, x.base[,col2],
                     year^3, hh^3, hn^3, hr^3, age^3, ys.cu, nchild^3,
                     hh1, hh2, hh3, hh4, hh5,
                     age^2*year, age^2*hh, age^2*hn, age^2*hr, age^2*ys, age^2*nchild)
    
    ## covariates for woman with older children
    x.poly3 <- cbind(1, x.base,
                     year^3, hh^3, hn^3, hr^3, age^3, ys.cu, nchild^3, yca^3,
                     hh1, hh2, hh3, hh4, hh5, yca2, yca3, yca4, yca5,
                     age^2*year, age^2*hh, age^2*hn, age^2*hr, age^2*ys, age^2*nchild, age^2*yca)

    ## base covariates
    x.poly <- cbind(1*index0, x.poly1*index1, x.poly2*index2, x.poly3*index3)

    ## add dummy variables
    out <- cbind(x.poly*x[,"ldh"], x.poly*x[,"ldr"], x.poly*x[,"ldn"],
                 x.poly*ldlr, x.poly*ldln)

    as(out, "sparseMatrix")
}
