/*DISPLAY.G: displays menu of available cost function specifications
  Version 5, October, 2000. By John Rust, Yale University */

proc (3)=display(modnum);

  local i,nvec,cstr;

  if modnum[1] > 0;
    "cost function ";;
  else;
    "enter specification code for cost function or 0 to show menu";;
     modnum[1]=con(1,1);
  endif;

  if modnum[2] == 1;
     goto mod1;
  elseif modnum[2] == 2;
     goto mod2;
  elseif modnum[2] == 3;
     goto mod3;
  else;
     goto mod4;
  endif;


mod2:

  if modnum[1] == 0;
     "code 1: c(x)=.01*c1*x+.0001*c2*x^2";
     "code 2: c(x)=.001*c1*x+.000001*c2*x^2";
     "code 3: c(x)=c1*x^(.001*c2)";
     "code 4: c(x)=c2/(91-x)+.01*c1*x^(.5)";
     "code 5: c(x)=c2/((91-x)^(.5))+c1*x^(.5)";
     "code 6: c(x)=c2/((91-x)^2)+c1*x^(.5)";
     "code 7: c(x)=c1*exp(.001*c2*x)";
     "enter code number";; modnum[1,1]=con(1,1);
  endif;

  if modnum[1] == 0;
     goto mod2;
  elseif modnum[1] == 1;
     cstr="c(x)=.01*c1*x+.0001*c2*x^2";
  elseif modnum[1] == 2;
     cstr="c(x)=.001*c1*x+.000001*c2*x^2";
  elseif modnum[1] == 3;
     cstr="c(x)=c1*x^(.001*c2)";
  elseif modnum[1] == 4;
     cstr="c(x)=c2/(n+1-x)+.01*c1*x^(.5)";
  elseif modnum[1] == 5;
     cstr="c(x)=c2/((n+1-x)^(.5))+c1*x^(.5)";
  elseif modnum[1] == 6;
     cstr="c(x)=c2/((n+1-x)^2)+c1*x^(.5)";
  elseif modnum[1] == 7;
     cstr="c(x)=c1*exp(.001*c2*x)";
  endif;

  $cstr;
  goto modend;

mod1:

  if modnum[1] == 0;
       "code 1: c(x)=c1*x";
       "code 2: c(x)=.001*c1*x";
       "code 3: c(x)=c1*x^(.5)";
       "code 4: c(x)=c1/(91-x)";
       "code 5: c(x)=.001*c1*x^(.5)";
       "enter desired code";; modnum[1]=con(1,1);
  endif;

  if modnum[1] == 0;
       goto mod1;
  elseif modnum[1] == 1;
       cstr="c(x)=c1*x";
  elseif modnum[1] == 2;
       cstr="c(x)=.001*c1*x";
  elseif modnum[1] == 3;
       cstr="c(x)=c1*x^(.5)";
  elseif modnum[1] == 4;
       cstr="c(x)=c1/(n+1-x)";
  elseif modnum[1] == 5;
       cstr="c(x)=.001*c1*x^(.5)";
  endif;

  $cstr;
  goto modend;

mod3:

  if modnum[1] == 0;
       "code 1: c(x)=.01*c1*x+.0001*c2*x^2+.000001*c3*x^3";
       "code 2: c(x)=linear spline with knots at 150k and 300k miles";
       "enter code number";; modnum[1]=con(1,1);
  endif;

  if modnum[1] == 0;
       goto mod3;
  elseif modnum[1] == 1;
       cstr="c(x)=.01*c1*x+.0001*c2*x^2+.000001*c3*x^3";
  elseif modnum[1] == 2;
       cstr="c(x)=linear spline with knots at 150k and 300k miles";
  endif;

  $cstr;
  goto modend;

mod4:

  if modnum[1] == 0;
  "code 1: c(x)=.01*c1*x+.0001*c2*x^2+.000001*c3*x^3+.000000001*c4*x^4";
  "code 2: c(x)=linear spline with knots at 100k, 200k, and 300k miles";
  "enter code number";; modnum[1]=con(1,1);
  endif;

  if modnum[1] == 0;
       goto mod4;
  elseif modnum[1] == 1;
   cstr="c(x)=.01*c1*x+.0001*c2*x^2+.000001*c3*x^3+.000000001*c4*x^4";
  elseif modnum[1] == 2;
   cstr="c(x)=linear spline with knots at 100k, 200k, and 300k miles";
  endif;

  $cstr;

modend:

  "objective function parameters are: ";;
      if modnum[2~4] == 1|0; dm=2;  let nvec[2,1]=tr c1;
  elseif modnum[2~4] == 2|0; dm=3;  let nvec[3,1]=tr c1 c2;
  elseif modnum[2~4] == 3|0; dm=4;  let nvec[4,1]=tr c1 c2 c3;
  elseif modnum[2~4] == 4|0; dm=5;  let nvec[5,1]=tr c1 c2 c3 c4;
  elseif modnum[2~4] == 1|1; dm=3;  let nvec[3,1]=tr c1 bet;
  elseif modnum[2~4] == 2|1; dm=4;  let nvec[4,1]=tr c1 c2 bet;
  elseif modnum[2~4] == 3|1; dm=5;  let nvec[5,1]=tr c1 c2 c3 bet;
  elseif modnum[2~4] == 4|1; dm=6;  let nvec[6,1]=tr c1 c2 c3 c4 bet;
  endif;

  $nvec;

  if modnum[3] == 2;

     "mileage process parameters are   : ";;
     dm=dm+modnum[5];

     i=1; do until i > modnum[5];
         if (i < 10);
         nvec=nvec|"p"$+ftos(i-1,"*.*lf",1,0); 
	 else;
         nvec=nvec|"p"$+ftos(i-1,"*.*lf",2,0); 
	 endif;
     i=i+1; endo;
         $nvec[dm-modnum[5]+1:dm,1]';

  endif;

  if modnum[7] == 1;
     "last coefficient is lagged control i(t-1)";
     dm=dm+1;   nvec=nvec|"i(t-1)";
  endif;

  "total dimension of parameter vector q= ";; dm; 

  retp(modnum,nvec,cstr);

endp;


