SampleStateVariables <- function(smpl.size){
  # Sample state points for Sieve approximation
  # 
  # Args:
  #   smpl.size: sample size
  # 
  # Returns:
  #   data frame of sampled states
  
  ys   <- runif(smpl.size, 0, ub.ys)

  year <- sample(1994:ub.year, smpl.size, replace=TRUE)
  
  hh   <- sample(0:ub.hh, smpl.size, replace=TRUE,
                 prob = c(rep(0.1, 6), rep(0.4/(ub.hh-6+1), ub.hh-6+1)))
                 
  hr   <- sample(0:ub.hr, smpl.size, replace=TRUE)
  
  hn   <- sample(0:ub.hn, smpl.size, replace=TRUE)
  
  age  <- sample(25:ub.age, smpl.size, replace=TRUE)
  
  edu  <- sample(9:ub.edu, smpl.size, replace=TRUE)
  
  nchild <- sample(0:ub.nchild, smpl.size, replace=TRUE)
                   
  yca    <- sample(0:ub.yca, smpl.size, replace=TRUE,
                   prob = c(0.15, 0.15, 0.15, 0.05, 0.05, 0.05,
                            rep(0.6/(ub.yca-6+1), ub.yca-6+1)))
  
  ld <- sample(1:5, smpl.size, replace=TRUE)
  ldh <- ifelse(ld == 1, 1, 0)
  ldr <- ifelse(ld == 2, 1, 0)
  ldn <- ifelse(ld == 3, 1, 0)
  ldl <- ifelse(ld == 4 | ld == 5, 1, 0)
  ldf <- ifelse(yca == 0, 1, 0)
  ler <- ifelse(ld == 2 | ld == 4, 1, 0)
  len <- ifelse(ld == 3 | ld == 5, 1, 0)
  
  data.frame(year, hh, hr, hn, ys, nchild, age, yca, edu,
             ldh, ldr, ldn, ldl, ldf, ler, len)
}
