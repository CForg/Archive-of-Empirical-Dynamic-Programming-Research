%this program is a shell program that allows for differences in intercept
%terms over time which are unobserved to the econmetrician.  The first set
%of lines allow the user to change
%1) the number of observations per time period,
%2) the number of time periods, 
%3) the number of unobserved states which for now needs to be set at 2, 
%4) the coefficients on the unobserved states,
%5) the transitions on the unobserved states, and
%6) the initial conditions
%7) the number of times the user wants to run the simulation
%throughout the variance on the epsilon's is set to 1
clear
N=5000;
T=5;
S=2;
b=[7;1;-.3;-.7;-.5;-1;.3;1.5];
p2=[.8 .2;.3 .7];
prior2=.8;
Nsim=1;
Util=zeros(8,1);
Util(1)=b(5);
Util(2)=b(5)+b(6); %b(6) is the high transitory state
Util(3)=b(5)+b(7); %b(7) is the high permanent state
Util(4)=b(5)+b(6)+b(7); 
Util(5:8)=Util(1:4)-b(8); %b(8) is the entry cost

%Now taking the entries above and finding what the probabilities of
%entering and exiting are for each of the states

%Util is written as:
%(1:4) low state low pstate monopoly incumbent, high state low pstate monopoly incumbent, low state 
%high pstate monopoly incumbent, high state high pstate monopoly incumbent
%(5:8) same as above but entrant instead of incumbent

EV=.25;
beta=.9;
xi=exp(Util+beta*EV)./(1+exp(Util+beta*EV));

xi=prob3(Util,p2);

bfin=[];

p=p2;

%now taking the entries above and creating the data
%First creating the data on the states    
Draw=rand(N,T);
State=zeros(N,T);
State(:,1)=Draw(:,1)>sum(prior2);

t=2;
while t<T+1
    State(:,t)=Draw(:,t)<(p(1,2)+State(:,t-1)*(p(2,2)-p(1,2)));
    t=t+1;
end

PState=(rand(N,1)>.5)*ones(1,T);

%Now creating the data on the entry/exit decisions
Firm1=zeros(N,T);

draws1=rand(N,T);

tic

n=1;
while n<N+1;
    
Firm1(n,1)=(draws1(n,1)<xi(5+State(n,1)+2*PState(n,1)));

n=n+1;
end

toc

tic
%Firm1c=getfirm(State(:,1),PState(:,1),xi,draws1(:,1));
toc
%Now Creating the code to map from the possible states to the data

LFirm1=[zeros(N,1) Firm1(:,1:T-1)];

n=1;
while n<N+1
    
    t=2;
    while t<T+1;
        
        Firm1(n,t)=(draws1(n,t)<xi(5+State(n,t)+2*PState(n,1)-4*LFirm1(n,t)));
        if t<T
        LFirm1(n,t+1)=Firm1(n,t);
        end
        t=t+1;
    end
    
    n=n+1;
end

%Now creating the price variable
Epsilon=randn(N,T);
Y=b(1)+b(2)*State+b(3)*PState+b(4)*Firm1+Epsilon;
PState=PState(:,1);
save dataassign32 Firm1 PState State Y


