/* E.PRC: conditional expectation operator for Markov transition matrix
   Version 3, October 2000. By John Rust, Yale University
*/

proc e(z);

   local i,j,k,m,sp,r,y1,y2,y3,p0,p1,p2,p3,p4;
   local y1t,y2t;

   m=modnum[5];
   r=cols(z);

   y1=p[1]*z[1:n-m,.];
   y2=zeros(m,1);
   y2[m,.]=z[n,.];

   i=1; do until i > m;

       y1=y1+p[i+1]*z[i+1:n-m+i,.];
       j=1; do until j > m-1;
          y3=zeros(1,r);
	  sp=0;
          k=1; do until k > m-j;
	    sp=sp+p[k];
	    y3=y3+p[k]*z[n-m+k+(j-1),.];
          k=k+1; endo;
	  y3=y3+(1-sp)*z[n,.];
          y2[j,.]=y3;
       j=j+1; endo;

   i=i+1; endo;

/* The  above code implements as a nested series of do-loops
   the following explicit code for the conditional expectation of next
   period value function on the assumption that the bus engine is
   not replaced in the next period. This is in turn equivalent to
   multiplying the value function (argument z, and nxk matrix where
   n is the number of states) by an (nxn) banded matrix Q  whose
   below-diagonal elements are all zero and whose above-diagonal elements for
   row i are given by

       Q[i,i+j]=p[j],  if i+j < n, j <= m, where m=number of rows of p,
		       where p[j] is the probability a bus travels in 
		       mileage category j, and m is the upper bound on
		       the monthly mileage.

       Note that i+j > m when i > n-m. For these last rows, we simply
       put the residual probability on state n (i.e. it is treated as
       an absorbing state) so that for i=n-m+1 we have

       Q[i,n]=1-p[1]- ... - p[m-1]

       and so on until we have

       Q[n,n]=1  


       The code above computes this quickly, but is not very
       transparent. The explicit code below shows how this is
       done a bit more clearly, but is not general, i.e. separate
       code must be written for each value of m. The do loop above
       works for any m < n   


   p0=p[1];

   if modnum[1,5] == 1;

       y1=(p0*z[1:n-1,.])+((1-p0)*z[2:n,.]);
       y2=z[n,.];

   elseif modnum[1,5] == 2;

       p1=p[2,1];
       y1=(p0*z[1:n-2,.])+(p1*z[2:n-1,.])+((1-p0-p1)*z[3:n,.]);
       y2=(p0*z[n-1,.]+(1-p0)*z[n,.])|z[n,.];

   elseif modnum[1,5] == 3;

       p1=p[2,1];
       p2=p[3,1];
       y1=(p0*z[1:n-3,.])+(p1*z[2:n-2,.])+(p2*z[3:n-1,.])+
          ((1-p0-p1-p2)*z[4:n,.]);
       y2=(p0*z[n-2,.]+p1*z[n-1,.]+(1-p0-p1)*z[n,.])|
          (p0*z[n-1,.]+(1-p0)*z[n,.])|z[n,.];

   elseif modnum[1,5] == 4;

       p1=p[2,1];
       p2=p[3,1];
       p3=p[4,1];
       y1=(p0*z[1:n-4,.])+(p1*z[2:n-3,.])+(p2*z[3:n-2,.])+
          (p3*z[4:n-1,.])+
          ((1-p0-p1-p2-p3)*z[5:n,.]);
       y2=(p0*z[n-3,.]+p1*z[n-2,.]+p2*z[n-1,.]+(1-p0-p1-p2)*z[n,.])|
          (p0*z[n-2,.]+p1*z[n-1,.]+(1-p0-p1)*z[n,.])|
          (p0*z[n-1,.]+(1-p0)*z[n,.])|z[n,.];

   elseif modnum[1,5] == 5;

       p1=p[2,1];
       p2=p[3,1];
       p3=p[4,1];
       p4=p[5,1];
       y1=(p0*z[1:n-5,.])+(p1*z[2:n-4,.])+(p2*z[3:n-3,.])+
          (p3*z[4:n-2,.])+
          (p4*z[5:n-1,.])+((1-p0-p1-p2-p3-p4)*z[6:n,.]);
       y2=(p0*z[n-4,.]+p1*z[n-3,.]+p2*z[n-2,.]+p3*z[n-1,.]+
          (1-p0-p1-p2-p3)*z[n,.])|
          (p0*z[n-3,.]+p1*z[n-2,.]+p2*z[n-1,.]+(1-p0-p1-p2)*z[n,.])|
          (p0*z[n-2,.]+p1*z[n-1,.]+(1-p0-p1)*z[n,.])|
          (p0*z[n-1,.]+(1-p0)*z[n,.])|z[n,.];

   endif;

*/

   retp(y1|y2);

endp;
