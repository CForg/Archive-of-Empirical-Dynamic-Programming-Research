/* CONTRACT.G procedure to compute contraction operator
   Version 3, October, 2000. By John Rust, Yale University */

proc contract(z);
     local y2,zmax;
     zmax=maxc(-c+bet*z);
     y2=exp(-tr-c[1,1]+bet*z[1,1]-zmax);
     retp(zmax+e(ln(exp(-c+bet*z-zmax)+y2)));
endp;
