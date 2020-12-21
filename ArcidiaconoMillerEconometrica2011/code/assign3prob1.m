clear
load dataassign32

%first getting transitions on State

[N,T]=size(State)
LState=State(:,1:T-1);

LState2=reshape(LState,N*(T-1),1);
State2=reshape(State(:,2:T),N*(T-1),1);

p=[mean(State2(LState2==0)==0) mean(State2(LState2==0)==1);mean(State2(LState2==1)==0) mean(State2(LState2==1)==1)]

%now getting the CCP's

State2=reshape(State,N*T,1);

LFirm=[zeros(N,1) Firm1(:,1:T-1)];

LFirm2=reshape(LFirm,N*T,1);
Firm2=reshape(Firm1,N*T,1);
PState2=kron(ones(T,1),PState(:,1));

i=1;

while i<3
    
    j=1;
    
    while j<3
        
        k=1;
        
        while k<3
            
            xi2(k+2*(j-1)+4*(i-1))=mean(Firm2(LFirm2==(2-i)&PState2==(j-1)&State2==(k-1)));
            
            k=k+1;
        end
        j=j+1;
    end
    i=i+1;
end

%creating future value terms

eul=.5772;

    EV(1)=-eul+p(1,1)*log(1-xi2(1))+p(1,2)*log(1-xi2(2));
    EV(2)=-eul+p(2,1)*log(1-xi2(1))+p(2,2)*log(1-xi2(2));    
    EV(3)=-eul+p(1,1)*log(1-xi2(3))+p(1,2)*log(1-xi2(4));
    EV(4)=-eul+p(2,1)*log(1-xi2(3))+p(2,2)*log(1-xi2(4));
    
FV=EV(1).*(1-PState2).*(1-State2)+EV(2).*State2.*(1-PState2)+EV(3).*(1-State2).*PState2+EV(4).*State2.*PState2;
beta=.9;
FV=-beta*(FV);

b=zeros(4,1);

[b,l,e,o,g,h]=fminunc('logitCCP',b,[],Firm2,[ones(size(Firm2,1),1) State2 PState2 1-LFirm2],FV);
