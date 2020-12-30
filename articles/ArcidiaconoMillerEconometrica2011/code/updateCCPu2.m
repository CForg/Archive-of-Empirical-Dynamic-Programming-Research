function [FV,xi2]=updateCCPu2(b,Firm2,State2,PState2,LFirm2,trans,xi);

%Util is written as:
%(1:4) low state low pstate monopoly incumbent, high state low pstate monopoly incumbent, low state 
%high pstate monopoly incumbent, high state high pstate monopoly incumbent
%(5:8) same as above but entrant instead of incumbent

Util=zeros(8,1);
Util(1)=b(1);
Util(2)=b(1)+b(2); %b(2) is the high transitory state
Util(3)=b(1)+b(3); %b(3) is the high permanent state
Util(4)=b(1)+b(2)+b(3); 
Util(5:8)=Util(1:4)-b(4); %b(4) is the entry cost

eul=.5772;

beta=.9;

v=zeros(8,1);
v2=v;
%calculating the probability of making various choices given the current
%state

    EV(1)=-eul+trans(1,1)*log(1-xi(1))+trans(1,2)*log(1-xi(2));
    EV(2)=-eul+trans(2,1)*log(1-xi(1))+trans(2,2)*log(1-xi(2));    
    EV(3)=-eul+trans(1,1)*log(1-xi(3))+trans(1,2)*log(1-xi(4));
    EV(4)=-eul+trans(2,1)*log(1-xi(3))+trans(2,2)*log(1-xi(4));
    v2(1)=Util(1)-beta*EV(1);
    v2(2)=Util(2)-beta*EV(2);
    v2(3)=Util(3)-beta*EV(3);
    v2(4)=Util(4)-beta*EV(4);
    v2(5)=Util(5)-beta*EV(1);
    v2(6)=Util(6)-beta*EV(2);
    v2(7)=Util(7)-beta*EV(3);
    v2(8)=Util(8)-beta*EV(4);
    xi2=exp(v2)./(1+exp(v2));




FV=zeros(50000,1);


i=1;

while i<3
   
    j=1;
    
    while j<3
        
        index(:,1)=(PState2==(j-1)).*(State2==(i-1));
        FV(index==1)=EV(i+2*(j-1));

        j=j+1;
    end
    i=i+1;
end


beta=.9;
FV=-beta*(FV);