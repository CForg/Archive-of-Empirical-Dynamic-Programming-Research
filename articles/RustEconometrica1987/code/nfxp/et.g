@ ET.PRC: Procedure to compute transpose of conditional expectation operator@
@ By John Rust, University of Wisconsin, September, 1987                    @
@                                                                           @
proc et(p); local r,q; q=modnum[1,5];  r=zeros(1,n);
r[1,1:m]=p[1,1:m]*(q11[.,1:m].*pk[1:m,1]');
r[1,1]=p[1,m+1:n]*(1-sumc((q22.*pk[m+1:n,1]')'))
+p[1,1:m]*(1-sumc((q11[.,2:m+q].*pk[2:m+q,1]')'));
r[1,m+1:n]=p[1,m+1:n]*(q22.*pk[m+1:n,1]');
r[1,m+1:m+q]=r[1,m+1:m+q]+p[1,1:m]*(q11[.,m+1:m+q].*pk[m+1:m+q,1]');
retp(r); endp;

