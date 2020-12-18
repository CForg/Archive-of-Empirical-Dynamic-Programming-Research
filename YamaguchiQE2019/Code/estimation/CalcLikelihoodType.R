CalcLikelihoodType <- function(param.type, x){

  mat.param.type <- matrix(param.type, ncol=Gn.type-1)

  exp.y <- cbind(1, exp(x %*% mat.param.type))

  exp.y / rowSums(exp.y)
}

CalcWeightedLogLikType <- function(param.type, x, q){
  ## likeilhood for type
  pi <- CalcLikelihoodType(param.type, x)
  
  ## weighted loglikelihood
  wm.loglik <- -1 * sum(q * log(pi))
  
  ## gradient
  q.pi <- q[,-1] - pi[,-1]

  if(Gn.type == 2) q.pi <- matrix(q.pi, ncol = 1)

  attr(wm.loglik, "gradient") <- -1 * apply(q.pi, 2, function(a) colSums(a * x))

  wm.loglik
}

DiffWeightedLogLikType <- function(param.type, x, q){
  attr(CalcWeightedLogLikType(param.type, x, q), "gradient")
}

    