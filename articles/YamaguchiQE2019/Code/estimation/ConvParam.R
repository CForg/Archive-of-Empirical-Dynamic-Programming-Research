ConvParamUStr <- function(param.u){
  
    ## length of parameters
    l.h    <- length(Glab.u.str$h)
    l.r    <- length(Glab.u.str$r)
    l.n    <- length(Glab.u.str$n)
    l.l    <- length(Glab.u.str$l)
    l.f    <- length(Glab.u.str$f)
    l.all  <- length(unlist(Glab.u.str))

    ## index of heterogeneous parameters
    idx.het.c <- c(1+l.h, 1+l.h+l.r, 1+l.h+l.r+l.n, 1+l.h+l.r+l.n+l.l)

    ## parameter matrix
    mat.param.u <- matrix(param.u[1:l.all], nrow = l.all, ncol = Gn.type,
                          dimnames = list(unlist(Glab.u.str), 1:Gn.type))
    
    ## parameters vary across type
    if(Gn.type > 1){
        mat.param.u[idx.het.c, 2:Gn.type] <- mat.param.u[idx.het.c, 2:Gn.type] +
            param.u[(1+l.all):length(param.u)]
    }

    ## return as list
    mat2list(mat.param.u)
}

ConvParamY <- function(param.y){
  # length of parameters
  len.y <- length(Glab.yr) + length(Glab.yn) + 1
  
  # earnings equations
  mat.param.y <- matrix(param.y[1:len.y], nrow = len.y, ncol = Gn.type)
  dimnames(mat.param.y) <- list(c(Glab.yr,Glab.yn,"sigma"), 1:Gn.type)

  if(Gn.type > 1){
    # intercept varies across type
    mat.param.y[c(1,1+length(Glab.yr)), 2:Gn.type] <- param.y[(1+len.y):length(param.y)]
  }

  # return as list
  mat2list(mat.param.y)
}

ConvParamYS <- function(param.ys){
    ## length of parameters
    len.ys <- length(Glab.ys) + 1
  
    ## earnings equations
    mat.param.ys <- matrix(param.ys[1:len.ys], nrow = len.ys, ncol = Gn.type,
                           dimnames = list(c(Glab.ys,"sigma"), 1:Gn.type))

    if(Gn.type > 1){
        ## intercept varies across type
        mat.param.ys[1, 2:Gn.type] <- param.ys[(1+len.ys):length(param.ys)]
    }

    ## return as list
    mat2list(mat.param.ys)
}

mat2list <- function(x) lapply(seq_len(ncol(x)), function(i) x[,i])
