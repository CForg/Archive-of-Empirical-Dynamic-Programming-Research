function Likemp=updataCCPu2stage(b,Firm2,State2,PState2,LFirm2,PType,p)

Likemp=zeros(size(Firm2,1),1);

i=1;

while i<3
   
    j=1;
    
    while j<3
        
        k=1;
        
        while k<3
            index=(LFirm2==(2-i)).*(PState2==(j-1)).*(State2==(k-1));

            xitemp=(PType(index==1)'*Firm2(index==1))./sum(PType(index==1));
 
            xi2(k+2*(j-1)+4*(i-1))=xitemp;
            
            Likemp(index==1)=Firm2(index==1).*xitemp+(1-Firm2(index==1)).*(1-xitemp);
            
            k=k+1;
        end
        j=j+1;
    end
    i=i+1;
end
