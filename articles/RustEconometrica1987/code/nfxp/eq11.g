/* EQ11.G: parameter update of markov transition probability matrix Q11
           Version 3, October 2000 By John Rust, Yale University */

proc (1)=eq11; 

   local l,m;
   m=floor(n/2);
   q11=zeros(m,m+modnum[5]);
   l=1; do until l > m;

      q11[l,l:l+modnum[5]]=p';

   l=l+1; endo;

retp(q11);

endp;
