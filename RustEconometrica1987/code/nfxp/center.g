/* CENTER.G: procedure for centering value function about 0
   Version 3, October, 2000. By John Rust, Yale University */

proc center(z);

   local y1;
   y1=-meanc(c)+bet*meanc(z);
   c=c+y1*(1-bet);
   retp(z-y1);

endp;
