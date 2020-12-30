function llv=logitCCPu(b,Y,X,FV,PType)

v1=X*b+FV;

llv=PType'*(log(1+exp(v1))-Y.*v1);

