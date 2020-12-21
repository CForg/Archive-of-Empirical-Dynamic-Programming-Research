/*FPMX.G: parameter update of markov transition probability matrix
  Version 4, October 2000. By John Rust, Yale University */

proc (0)=fpmx;

   local p0,p1,p2,p3,p4;

   p0=p[1,1];
   l=1;

   if modnum[1,5] <= 2;

       p1=p[2,1];
       a3=p0~p1~(1-p0-p1);
       a2=p0~(1-p0);

       do until l > m;
          if l < m-1;
             q11[l,l:l+2]=a3;
             q22[l,l:l+2]=a3;
          elseif l == m-1;
             q22[l,l:m]=a2;
             q11[l,l:l+2]=a3;
          elseif l == m;
             q22[l,l:m]=1;
             if modnum[1,5] == 2;
                  q11[l,l:l+2]=a3;
             else;
                  q11[l,l:l+1]=a3[1,1:2];
             endif;
          endif;
       l=l+1; endo;

       if n > 2*m;
          q22[m+1,m+1]=1;
          q22[m,m:m+1]=a2;
          q22[m-1,m-1:m+1]=a3;
       endif;

   elseif modnum[1,5] == 5;

       p1=p[2,1];
       p2=p[3,1];
       p3=p[4,1];
       p4=p[5,1];
       a6=p0~p1~p2~p3~p4~(1-p0-p1-p2-p3-p4);
       a5=p0~p1~p2~p3~(1-p0-p1-p2-p3);
       a4=p0~p1~p2~(1-p0-p1-p2);
       a3=p0~p1~(1-p0-p1);
       a2=p0~(1-p0);

       do until l > m;

          if l < m-4;
             q11[l,l:l+5]=a6;
             q22[l,l:l+5]=a6;
          elseif l == m-4;
             q22[l,l:m]=a5;
             q11[l,l:l+5]=a6;
          elseif l == m-3;
             q22[l,l:m]=a4;
             q11[l,l:l+5]=a6;
          elseif l == m-2;
             q22[l,l:m]=a3;
             q11[l,l:l+5]=a6;
          elseif l == m-1;
             q22[l,l:m]=a2;
             q11[l,l:l+5]=a6;
          elseif l == m;
             q22[l,l]=1;
             q11[l,l:l+5]=a6;
          endif;

       l=l+1; endo;

       if n > 2*m;
          q22[m+1,m+1]=1;
          q22[m,m:m+1]=a2;
          q22[m-1,m-1:m+1]=a3;
          q22[m-2,m-2:m+1]=a4;
          q22[m-3,m-3:m+1]=a5;
          q22[m-4,m-4:m+1]=a6;
       endif;

   elseif modnum[1,5] == 4;

       p1=p[2,1];
       p2=p[3,1];
       p3=p[4,1];
       a5=p0~p1~p2~p3~(1-p0-p1-p2-p3);
       a4=p0~p1~p2~(1-p0-p1-p2);
       a3=p0~p1~(1-p0-p1);
       a2=p0~(1-p0);

       do until l > m;

          if l < m-3;
             q22[l,l:l+4]=a5;
             q11[l,l:l+4]=a5;
          elseif l == m-3;
             q22[l,l:m]=a4;
             q11[l,l:l+4]=a5;
          elseif l == m-2;
             q22[l,l:m]=a3;
             q11[l,l:l+4]=a5;
          elseif l == m-1;
             q22[l,l:m]=a2;
             q11[l,l:l+4]=a5;
          elseif l == m;
             q22[l,l]=1;
             q11[l,l:l+4]=a5;
          endif;

       l=l+1; endo;

       if n > 2*m;
          q22[m+1,m+1]=1;
          q22[m,m:m+1]=a2;
          q22[m-1,m-1:m+1]=a3;
          q22[m-2,m-2:m+1]=a4;
          q22[m-3,m-3:m+1]=a5;
       endif;

   elseif modnum[1,5] == 3;

       p1=p[2,1];
       p2=p[3,1];
       a4=p0~p1~p2~(1-p0-p1-p2);
       a3=p0~p1~(1-p0-p1);
       a2=p0~(1-p0);

       do until l > m;

          if l < m-2;
             q22[l,l:l+3]=a4;
             q11[l,l:l+3]=a4;
          elseif l == m-2;
             q22[l,l:m]=a3;
             q11[l,l:l+3]=a4;
          elseif l == m-1;
             q22[l,l:m]=a2;
             q11[l,l:l+3]=a4;
          elseif l == m;
             q22[l,l]=1;
             q11[l,l:l+3]=a4;
          endif;

       l=l+1; endo;

       if n > 2*m;
          q22[m+1,m+1]=1;
          q22[m,m:m+1]=a2;
          q22[m-1,m-1:m+1]=a3;
          q22[m-2,m-2:m+1]=a4;
       endif;

   endif;

endp;
