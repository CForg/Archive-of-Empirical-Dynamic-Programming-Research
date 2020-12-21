/* CDTP.PRC: computation of derivatives of contraction operator with
             respect to transition probability parameters
             Version 3. October, 2000. By John Rust, Yale University */

proc (0)=cdtp(z);

   dtp=ln(exp(-c+bet*z)+exp(-tr-c[1,1]+bet*z[1,1]));

   if modnum[1,5] == 2;
      dtp=((dtp[1:n-2,1]-dtp[3:n,1])|(dtp[n-1,1]-dtp[n,1])|0)~
      ((dtp[2:n-1,1]-dtp[3:n,1])|0|0);
   elseif modnum[1,5] == 1;
      dtp=((dtp[1:n-1,1]-dtp[2:n,1])|0);
   elseif modnum[1,5] == 3;
      dtp=((dtp[1:n-3,1]-dtp[4:n,1])|
          (dtp[n-2,1]-dtp[n,1])|(dtp[n-1,1]-dtp[n,1])|0)~
          ((dtp[2:n-2,1]-dtp[4:n,1])|(dtp[n-1,1]-dtp[n,1])|0|0)~
          ((dtp[3:n-1,1]-dtp[4:n,1])|0|0|0);
   elseif modnum[1,5] == 4;
      dtp=((dtp[1:n-4,1]-dtp[5:n,1])|(dtp[n-3,1]-dtp[n,1])|
          (dtp[n-2,1]-dtp[n,1])|
          (dtp[n-1,1]-dtp[n,1])|0)~((dtp[2:n-3,1]-dtp[5:n,1])|
          (dtp[n-2,1]-dtp[n,1])|
          (dtp[n-1,1]-dtp[n,1])|0|0)~((dtp[3:n-2,1]-dtp[5:n,1])|
          (dtp[n-1,1]-dtp[n,1])|0|0|0)~
          ((dtp[4:n-1,1]-dtp[5:n,1])|0|0|0|0);
   elseif modnum[1,5] == 5;
      dtp=((dtp[1:n-5,1]-dtp[6:n,1])|(dtp[n-4,1]-dtp[n,1])|
          (dtp[n-3,1]-dtp[n,1])|
          (dtp[n-2,1]-dtp[n,1])|
          (dtp[n-1,1]-dtp[n,1])|0)~((dtp[2:n-4,1]-dtp[6:n,1])|
          (dtp[n-3,1]-dtp[n,1])|
          (dtp[n-2,1]-dtp[n,1])|(dtp[n-1,1]-dtp[n,1])|0|0)~
          ((dtp[3:n-3,1]-dtp[6:n,1])|
          (dtp[n-2,1]-dtp[n,1])|(dtp[n-1,1]-dtp[n,1])|0|0|0)~
          ((dtp[4:n-2,1]-dtp[6:n,1])|(dtp[n-1,1]-dtp[n,1])|0|0|0|0)~
          ((dtp[5:n-1,1]-dtp[6:n,1])|0|0|0|0|0);
   endif;

endp;
