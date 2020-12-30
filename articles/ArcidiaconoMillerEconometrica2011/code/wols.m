function [b,sigma]=wols(y,x,PType,N)

b=inv((PType*ones(1,size(x,2)).*x)'*x)*(x'*(PType.*y));

sigma=PType'*((y-x*b).^2)./N;
sigma=sigma.^.5;

