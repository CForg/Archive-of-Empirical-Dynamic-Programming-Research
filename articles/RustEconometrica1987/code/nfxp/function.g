/*FUNCTION.G: parameter update for cost function and its derivatives
  Version 5, October, 2000. By John Rust, Yale University */

proc (0)=function;

    local c1,c2,c3,c4;


  /* PHASE 1: UPDATE PARAMETERS CORRESPONDING TO CHOSEN MODEL */

    tr=q[1];
    c1=q[2];

    if modnum[2~4] == 2|0;
       c2=q[3];
    elseif modnum[2~4] == 3|0;
       c2=q[3];
       c3=q[4];
    elseif modnum[2~4] == 4|0;
       c2=q[3];
       c3=q[4];
       c4=q[5];
    elseif modnum[2~4] == 1|1;
       bet=1/(1+exp(q[3]));
    elseif modnum[2~4] == 2|1;
       c2=q[3];
       bet=1/(1+exp(q[4]));
    elseif modnum[2~4] == 3|1;
       c2=q[3];
       c3=q[4];
       bet=1/(1+exp(q[5]));
    elseif modnum[2~4] == 4|1;
       c2=q[3];
       c3=q[4];
       c4=q[5];
       bet=1/(1+exp(q[6]));
    endif;

    if modnum[3] /= 1;
       p[1:modnum[5],1]=q[dm-modnum[5]-modnum[7]+1:dm-modnum[7],1];
    endif;

/* PHASE 2: UPDATE TRANSITION PROBABILITIES FOR FULL LIKELIHOOD */

    lnp=ln(p);
    invp=zeros(modnum[5],modnum[5]);
    invp=diagrv(invp,exp(-lnp[1:modnum[5]]));
    invp=invp|-exp(-lnp[1+modnum[5]])*ones(1,modnum[5]);

/*  EVALUATE c(x) AND DERIVATIVE WRT (c1,..,c4) AT NEW PARAMETERS */

    if modnum[2] == 2;

       if modnum[1] == 1;
           c=.01*c1*ogrid+.0001*c2*ogrid^2;
           dc=(.01*ogrid)~(.0001*ogrid^2);
       elseif modnum[1] == 2;
           c=.001*c1*ogrid+.000001*c2*ogrid^2;
           dc=(.001*ogrid)~(.000001*ogrid^2);
       elseif modnum[1] == 3;
           c=c1*ogrid^(.001*c2);
           dc=(c/c1)~(.001*ln(ogrid).*c);
       elseif modnum[1] == 4;
           c=c2/ogrid+.01*c1*(ogrid^(.5));
           dc=(.01*(ogrid^(.5)))~(1/ogrid);
       elseif modnum[1] == 5;
           c=c2/((ogrid)^(.5))+c1*ogrid^(.5);
           dc=(ogrid^(.5))~(1/(ogrid^(.5)));
       elseif modnum[1] == 6;
           c=c2/((ogrid)^2)+c1*ogrid^(.5);
           dc=(ogrid^(.5))~(1/(ogrid^2));
       elseif modnum[1] == 7;
           c=c1*exp(.001*c2*ogrid);
           dc=(c/c1)~(.001*ogrid.*c);
       endif;

    elseif modnum[2] == 1;

       if modnum[1] == 1;
           c=c1*ogrid;
           dc=ogrid;
       elseif modnum[1] == 2;
           c=.001*c1*ogrid;
            dc=.001*ogrid; 
       elseif modnum[1] == 3;
           c=c1*ogrid^(.5);
           dc=(ogrid^(.5));
       elseif modnum[1] == 4;
           c=c1/(ogrid);
           dc=(1/(ogrid));
       elseif modnum[1] == 5;
           c=.001*c1*ogrid^(.5);
           dc=c/c1;
       endif;

    elseif modnum[2] == 3;

       if modnum[1] == 1;
           c=.01*c1*ogrid+.0001*c2*ogrid^2+.000001*c3*ogrid^3;
           dc=(.01*ogrid)~(.0001*(ogrid^2))~(.000001*(ogrid^3));
       elseif modnum[1] == 2;
           c=c1*ogrid.*(ogrid .< 150)+
             ((c1*150+c2*(ogrid-150)).*(150 .<= ogrid).*(ogrid .< 300))+
	     (((c1+c2)*150+c3*(ogrid-300)).*(300 .<= ogrid));
         dc=(ogrid.*(ogrid .< 150)+150*(ogrid .>= 150))~
            ((ogrid-150).*(ogrid .>= 150).*(ogrid .< 300)+150*(ogrid .>= 300))~
	    ((ogrid-300).*(ogrid .>= 300));
       endif;

    elseif modnum[2] == 4;

       if modnum[1] == 1;
           c=.01*c1*ogrid+.0001*c2*ogrid^2+.000001*c3*ogrid^3
	      +.000000001*c4*ogrid^4;
           dc=(.01*ogrid)~(.0001*(ogrid^2))~
              (.000001*(ogrid^3))~(.00000001*(ogrid^4));
       else;
           c=c1*ogrid.*(ogrid .< 100)+((c1*100+c2*(ogrid-100)).*
             (100 .<= ogrid).*(ogrid .< 200))+
	     (((c1+c2)*100+c3*(ogrid-200)).*(200 .<= ogrid).*(ogrid .< 300))+
	     (((c1+c2+c3)*100+c4*(ogrid-300)).*(300 .<= ogrid));
         dc=(ogrid.*(ogrid .< 100)+100*(100 .<= ogrid))~
	    ((ogrid-100).*(100 .<= ogrid).*(ogrid .< 200)+100*(ogrid .>= 200))~
	    ((ogrid-200).*(ogrid .>= 200).*(ogrid .< 300)+100*(ogrid .>= 300))~
	    ((ogrid-300).*(ogrid .>= 300));

       endif;

    endif;

endp;

