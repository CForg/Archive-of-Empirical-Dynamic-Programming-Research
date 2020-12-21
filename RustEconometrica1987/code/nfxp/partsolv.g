/* PARTSOLV.G: solution of linear systems by partitioned elimination
   Version 3, October 2000. By John Rust, Yale University */

proc partsolv(z);

    local cq,cy,y1,y2,q12,q21;

    y1=z[1:m,.];
    y2=z[m+1:n,.];
    cy=cols(y1);
    cq=modnum[5];

    q21=(y2~(bet-sumc((q22.*(bet.*pk[m+1:n,1])')')))/
        (eye(n-m)-(q22.*(bet*pk[m+1:n,1])'));

    q12=(q11[.,m+1:m+cq].*(bet*pk[m+1:m+cq,1])')*q21[1:cq,.];

    y1=(y1+q12[.,1:cy])/
       (eye(m)-((bet-sumc((q11[.,2:m+cq].*(bet*pk[2:m+cq,1])')')
       +q12[.,cy+1])~(q11[.,2:m].*(bet*pk[2:m,1])')));

    y2=q21[.,1:cy]+q21[.,1+cy].*y1[1,1:cy];

    retp(y1|y2);

endp;
