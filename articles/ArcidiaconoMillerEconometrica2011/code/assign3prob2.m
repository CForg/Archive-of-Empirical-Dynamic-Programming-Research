clear
load dataassign32



%first getting transitions on State

[N,T]=size(State)
LState=State(:,1:T-1);

LState2=reshape(LState,N*(T-1),1);
State2=reshape(State(:,2:T),N*(T-1),1);

p=[mean(State2(LState2==0)==0) mean(State2(LState2==0)==1);mean(State2(LState2==1)==0) mean(State2(LState2==1)==1)]

%now getting the CCP's

State2=kron(ones(2,1),reshape(State,N*T,1));

LFirm=[zeros(N,1) Firm1(:,1:T-1)];

LFirm2=kron(ones(2,1),reshape(LFirm,N*T,1));
Firm2=kron(ones(2,1),reshape(Firm1,N*T,1));
PState2=[zeros(N*T,1);ones(N*T,1)];

%means of updating the CCP's: 1=data, 2=likelihood

update=1

while update<3

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

b2=[7;1;-.5;-.7];
b=[-.5;-1;.6;1.5];
var=1;

X2=[ones(N*T*2,1) State2 PState2 1-LFirm2];
Y2=kron(ones(2,1),reshape(Y,N*T,1));
X22=[ones(N*T*2,1) State2 PState2 Firm2];

prior=[.5 .5];

PType=.5*ones(N*T*2,1);
oPType=zeros(N*T*2,1);

j=1;
while (max(abs(PType-oPType)))>.00001

    oPType=PType;
    
        [prior,PType]=typeprob0806p(prior,N,T,2,'logitCCPucalc',b,Firm2,X2,FV,b2,Y2,X22,var);
        
        if update==1
            [FV]=updateCCPu(b,Firm2,State2,PState2,LFirm2,PType,p);
            if j==1
               FVu=FV;
            end
        end
        if update==2
            [FV,xi2]=updateCCPu2(b,Firm2,State2,PState2,LFirm2,p,xi2);
            if j==1
                FVu=FV;
            end
        end
            
        [b2,var]=wols(Y2,X22,PType,N*T);

    [b]=fminunc('logitCCPu',b,[],Firm2,X2,FV,PType);

    j=j+1;
%    (max(abs(PType-oPType)))

end

if update==1
bd=b;
bd2=b2;
vard=var;
jd=j;
end
update=update+1
end

[b bd]

[bd2 b2]

[vard var]