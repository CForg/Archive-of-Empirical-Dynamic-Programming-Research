
function [prior,PType,flike]=typeprob0806p(prior,N,T,S,FUN,varargin);

%the program takes as inputs:
%1) the distribution of initial conditions (1 x S)
%2) the number of observations in the data set (N), the number of time
%periods (T), and the number of unobserved states (S)
%3) the likelihood function (FUN) the returns an (N x T x S) x 1 matrix
%4) all variables related to calculating the likelihood

%
%the program returns:
%1) the updated prior 
%2) the conditional probability of each observation being in one of the
%unobserved states, PType ((N x T) x S)
%3) the updated FV terms

[Like]=feval(FUN,varargin{:});

Like2=reshape(Like,N,T,S);

base=squeeze(prod(Like2,2));

s=1;

while s<S+1

    PType(:,s)=(prior(s)*base(:,s))./(base*(prior'));
    
    s=s+1;
end

prior=mean(PType);

%PType=reshape(PType,N*S,1);

PType=kron(ones(T,1),PType);

PType=reshape(PType,(N*T*S),1);

flike=PType'*log(Like);
