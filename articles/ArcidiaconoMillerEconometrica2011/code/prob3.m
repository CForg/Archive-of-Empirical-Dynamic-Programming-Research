function [p]=prob3(Util,trans)

%Util is written as:
%(1:4) low state low pstate monopoly incumbent, high state low pstate monopoly incumbent, low state 
%high pstate monopoly incumbent, high state high pstate monopoly incumbent
%(5:8) same as above but entrant instead of incumbent

eul=.5772;
EV=.25;
beta=.9;
p=exp(Util+beta*EV)./(1+exp(Util+beta*EV));
p0=[zeros(8,1)];

v=zeros(8,1);
v2=v;
%calculating the probability of making various choices given the current
%state

while abs(max(abs(p0-p)))>.000001;
    p0=p;
    EV(1)=-eul+trans(1,1)*log(1-p(1))+trans(1,2)*log(1-p(2));
    EV(2)=-eul+trans(2,1)*log(1-p(1))+trans(2,2)*log(1-p(2));    
    EV(3)=-eul+trans(1,1)*log(1-p(3))+trans(1,2)*log(1-p(4));
    EV(4)=-eul+trans(2,1)*log(1-p(3))+trans(2,2)*log(1-p(4));
    v2(1)=Util(1)-beta*EV(1);
    v2(2)=Util(2)-beta*EV(2);
    v2(3)=Util(3)-beta*EV(3);
    v2(4)=Util(4)-beta*EV(4);
    v2(5)=Util(5)-beta*EV(1);
    v2(6)=Util(6)-beta*EV(2);
    v2(7)=Util(7)-beta*EV(3);
    v2(8)=Util(8)-beta*EV(4);
    p=exp(v2)./(1+exp(v2));

end


