function llv=logitCCP(b,Y,X,FV)

v1=X*b+FV;

llv=sum(log(exp(v1)+1)-Y.*v1);