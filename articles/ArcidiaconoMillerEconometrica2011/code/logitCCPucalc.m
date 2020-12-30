function Like=logitCCPucalc(b,Y,X,FV,b2,Y2,X2,var)

v1=X*b+FV;

LikeC=(exp(v1).^Y)./(1+exp(v1));

Eprice=X2*b2;

LikeP=normpdf(Y2-Eprice,0,var);

Like=LikeC.*LikeP;

