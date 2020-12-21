
function [prior,trans2,PType]=typeprob0806(prior,trans,N,T,S,FUN,inc,INITIALC,varargin);

%the program takes as inputs:
%1) the distribution of initial conditions (N x S)
%2) the transition matrix on the unobservables (S x S)
%3) the number of observations in the data set (N), the number of time
%periods (T), and the number of unobserved states (S)
%4) the likelihood function (FUN) the returns an N x T x S matrix
%5) a flag (inc) for whether there is a program that allows the initial conditions to vary across states
%(INITIALC)
%6) all variables related to calculating the likelihood and allowing the initial conditions to vary

%
%the program returns:
%1) the updated initial conditions and the updated unobservable transition
%matrix
%2) the conditoin probability of each observation being in one of the
%observed states, PType (N x T x S)

%First getting the likelihoods.
[Like]=feval(FUN,varargin{:});
Like=reshape(Like,N,T,S);
%In order to update the type probabilities at time t, need to be able to
%incorporate information from periods after t and from periods before t
%
%pback gives the contribution from periods after t

pback=ones(N,T,S);
pback(:,T,:)=Like(:,T,:);


t=T-1;
while t>0
    s1=1;
    while s1<S+1
        temp=0;
        s2=1;
        while s2<S+1
            temp=temp+pback(:,t+1,s2)*trans(s1,s2);
            s2=s2+1;
        end
        pback(:,t,s1)=temp.*Like(:,t,s1);
        s1=s1+1;
    end
    t=t-1;
end

%pfor gives the contribution from periods before t

pfor=ones(size(Like));

s=1;
while s<S+1
    pfor(:,1,s)=prior(:,s).*Like(:,1,s);
    s=s+1;
end

t=2;
while t<T+1
    s2=1;
    while s2<S+1;
        temp=0;
        s1=1;
        while s1<S+1;
            temp=temp+pfor(:,t-1,s1)*trans(s1,s2);
            s1=s1+1;
        end
        pfor(:,t,s2)=temp.*Like(:,t,s2);
        s2=s2+1;
    end
    t=t+1;
end

%Using pfor and pack we can now calculate the conditional probability of
%being in each unobserved state for each observation

PType=zeros(size(Like));

dem=sum(pfor.*pback./Like,3);

s=1;
while s<S+1
    PType(:,:,s)=(pfor(:,:,s).*pback(:,:,s)./Like(:,:,s))./dem;
    s=s+1;
end

%Now we update the transition probabilities following Hamilton (1990)
%page 54.  The numerator for the update for the (j,k) term in the
%transition matrix multiplies two terms 1) the probability of being in
%unobserved state k conditional on all past and future choices and
%conditional on being in state j at time t-1 2) the probability of being in
%the unobserved state j at time t-1 conditional on all past and future
%choices. These calculations are made for each individual at each time
%period and then summed.  The denominator then sums across all individuals
%and all time periods the expression in 2).  "All time periods" here actually
%refers to all time periods besides the first.

trans2=trans;

s1=1;
while s1<S+1
    dem=0;
    s2=1;
    while s2<S+1
        dem=dem+trans(s1,s2)*pback(:,2:T,s2);
        s2=s2+1;
    end
    s2=1;
    while s2<S+1
        trans2(s1,s2)=sum(sum(PType(:,1:(T-1),s1).*(trans(s1,s2)*pback(:,2:T,s2)./dem),2))./sum(sum(PType(:,1:(T-1),s1),2));
        s2=s2+1;
    end
    s1=s1+1;
end

%The last step is to update the initial conditions the program INITIALC
%must return an N x S matrix

basep=squeeze(PType(:,1,:));
if inc==1
    prior=feval(INITIALC,basep,varargin{:});
else
    prior=mean(basep);
end


PType=reshape(PType,(N*T*S),1);
