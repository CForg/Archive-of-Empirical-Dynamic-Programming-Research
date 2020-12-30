function FV=updataCCPu(b,Firm2,State2,PState2,LFirm2,PType,p)

i=1;

while i<3
   
    j=1;
    
    while j<3
        
        k=1;
        
        while k<3
            index=(LFirm2==(2-i)).*(PState2==(j-1)).*(State2==(k-1));

            xi2(k+2*(j-1)+4*(i-1))=(PType(index==1)'*Firm2(index==1))./sum(PType(index==1));
            
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