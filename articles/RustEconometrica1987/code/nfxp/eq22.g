/* EQ22.G: parameter update of markov transition probability matrix Q22
           Version 2, October 2000 By John Rust, Yale University */

proc eq22; 

   local l,m;

   m=floor(n/2);
   q22=zeros(n-m,n-m);
   l=1;

   do until l > m;
      if l < m-modnum[5]+1;           
         q22[l,l:l+modnum[5]]=p';
      elseif l < m;
         q22[l,l:m]=(p[1:m-l]')~(1-sumc(p[1:m-l]));
      else;
         q22[l,l]=1;
      endif;
   l=l+1; endo;

   if n > 2*m; 
       q22[m+1,m+1]=1;
       q22[m,m:m+1]=p[1]~(1-sumc(p[1]));
   endif;

   retp(q22);

endp;
