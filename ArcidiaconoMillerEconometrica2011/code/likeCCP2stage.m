function Like=likeCCP2stage(LikeC,b2,Y2,X2,var)


Eprice=X2*b2;

LikeP=normpdf(Y2-Eprice,0,var);

Like=LikeC.*LikeP;

