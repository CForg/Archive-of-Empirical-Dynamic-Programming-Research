 /*  This segment takes the parameters from the estimation program and finds the corresponding  moments by running the model until convergence.
The list of filenames used in the running of the model are in the file:
   filename.set
The options used to direct the running of the model as a whole are in the file:
   option.set
The options used to control the worker model are in the file:
   workopt.set
The options which describe the unemployment insurance system are in the file:
   uiw.set
*/

segment sim_moments;

const

%include ./uimatch.con

type

%include ./uimatch.typ

ref
%include ./var.def

%include ./uimatch.def

function sim_moments;

var
  mominmain: moment_type;
  indxrec: indx_type; (* init. in worker *)
  gresk: resk0_type; (* init. in worker *)
  valnowk: vnwk_type;  (*  init. in main  *)
  valwk:  vwk_type;   (* init. in main *)
  decfrm: dec_type;    (* init. in firm *)
  wageall,pdwage:  wage_type;
  mxdff1,mxdff2,
  revr: real;
  praggs: TransArray;    (* in here *)
  wrdata: integer;
  revtol : real;
  lnewof,lnewac, loldof, loldac, 
  mnof, mnac  (* CF added 9/97 *)
    : prob_type;
  parchk: boolean;
(******** PROCEDURES *********)
procedure calctransition;
var j: integer;
begin
(* calculate the transition matrix using rho and kappa *)
(* note:  chi=0.00407158, cut off is 1/2 chi for y=y[h] or y=y[l] *)
praggs[-1,-1]:=rho;
praggs[-1,0]:=1-rho;
praggs[-1,1]:=0;
praggs[0,-1]:=0.5*(1-rho)/(kappa-1);
praggs[0,0]:=1-2*praggs[0,-1];
praggs[0,1]:=praggs[0,-1];
praggs[1,-1]:=0;
praggs[1,0]:=1-rho;
praggs[1,1]:=rho;
(* for j:= -1 to 1 do writeln('transition matrix row ',j:3,' ',
                   praggs[j,-1]:3,' ',palp[j,0]:3,' ',palp[j,1]:3);*)
end;

procedure translatepar;
begin
  betaw:=par[1];
  cw:=par[2];
  mu:=par[3];
  sigma:=par[4];
  lamd:=par[5];
  beta:=par[6];
  c:=par[7];  
  ld:=par[8];
  shm:=par[9];
  prf[1]:=par[10];
  prf[0]:=0;
  prf[-1]:=-prf[1];   (* CF, minus sign added feb 96 *)
  maxep:=par[11];
writeln('shm ', shm:4:4,'prf ', prf[1]:4:3,' c ',c:4:4,' cw ',cw:4:4,' maxep ',maxep:4);
writeln('ld ',ld:3:4,' lamd ',lamd:3:4,' mu ',mu:3:4,' sigma ',sigma:3:4,' betaw ',betaw:3:4,' betaf ',beta:3:4);
end;

procedure initialprob;
var s, i: integer;
begin
with beliefs do begin
 for s:= -1 to 1 do
   begin
   i:=1+(s+1)*4;
   loldof[i]:=lamr[s];
   i:=2+(s+1)*4;
   loldof[i]:=lamo[s];
   i:=3+(s+1)*4;
   loldof[i]:=lamj[s];
   i:=4+(s+1)*4;
   loldof[i]:=laml[s];
   i:=1+(s+1)*4;
   loldac[i]:=lo[s];
   i:=2+(s+1)*4;
   loldac[i]:=lr[s];
   i:=3+(s+1)*4;
   loldac[i]:=lq[s];
   i:=4+(s+1)*4;
   loldac[i]:=uew[s];
   end;
 for i := 1 to 12 do  (*CF added 9/97 *)
     begin
     mnof[i] := loldof[i];
     mnac[i] := loldac[i];
     end; 
end; (* with *)
end;

procedure initiallam;
var s,i: integer;
begin with beliefs do begin

reset(infile,fname_vec[oldoff_fname]);
readln(infile);
(* writeln('  s     lamr     lamo      lamj      laml'); *)
 for s := -1 to 1 do
     begin
     readln(infile,lamr[s],lamo[s],lamj[s],laml[s]);
  (* writeln(s:3,'   ',lamr[s]:2:5,'   ',lamo[s]:2:5,'   ',lamj[s]:2:5,'   ',laml[s]:2:5);  *)
     end;
close(infile);
  reset(infile,fname_vec[oldacc_fname]);
  readln(infile); (* read labels *)
 (*writeln('  s       lo        lr        lq       uew'); *)
  for s := -1 to 1 do
      readln(infile, lo[s], lr[s], lq[s],uew[s]);
   (* for s:=-1 to 1 do writeln(s:3,'   ', lo[s]:2:5,'   ', lr[s]:2:5,'   ', lq[s]:2:5,'   ',uew[s]:2:5);  *)
  close(infile); 
end; (* with *)
end;

procedure initialval;
var timet: time_type;
mm,
kk, (*: k_type;*)
tt, (*:  t1_type; *)
nn (* : nwk_type; *)
: integer;
ss: alpn_type;
begin
for ss:=-1 to 1 do
  for nn:=0 to yrwk do
    for tt:= 0 to yrwk do
      for kk:=1 to max_nw do
        begin
        for timet:= thisper to nextper do
          begin
          if nn>0 then valwk[timet,kk,tt,nn,ss]:=0.0;
          valnowk[timet,kk,tt,nn,ss]:=0.0;
          end;
        for mm:= 0 to 1 do gresk[mm,kk,tt,nn,ss]:=max_nw;
        indxrec[kk,tt,nn,ss]:=0;
        end;
end;

procedure initialdecfrm;
var 
dd,
kk,
tt,
nn,
ss: integer;
begin 
  for ss:= -1 to 1 do
   for nn:= 1 to max_neps do
    for kk:= 1 to max_nw do 
      for dd:= -1 to 1 do
       decfrm[dd,kk,nn,ss]:=0;
end;

procedure readworkoption;
var rr: integer;
begin
 reset(infile,fname_vec[workopt_fname]);
 for rr:=11 to 19 do 
  begin
  read(infile,option[rr]);
  readln(infile,opt_def[rr]);
  (* write(rr,' ',option[rr]:4:4,' '); *)
  end;
  (* writeln;*)
close(infile) ;
  reset(infile,fname_vec[uiw_fname]);
   for rr:=20 to 30 do
     begin
     read(infile,option[rr]);
     readln(infile,opt_def[rr]);
     (* write(rr,' ',option[rr]:4:4,' '); *)
     end;
   (*writeln;*)
   close(infile);

end;

procedure trackoffaccprob(ii: integer);  (* changed may 26/96 lb *)
var j: integer;
dis: string;
begin
dis:=', disp=mod';
 rewrite(outfile,fname_vec[lamprob_fname]||dis);
  if ii=0 then writeln('starting new simulation');
  write(outfile,'new off ');
  for j:= 1 to 12 do write(outfile,lnewof[j]:3:6,' ');
  writeln(outfile);
  write(outfile,'old off ');
  for j:= 1 to 12 do write(outfile,loldof[j]:3:6,' ');
  writeln(outfile);
 close(outfile);
 rewrite(outfile,fname_vec[accprob_fname]||dis);
  if ii=0 then writeln('starting new simulation');
 writeln(outfile,'new acc ');
 for j:= 1 to 12 do write(outfile,lnewac[j]:3:6,' '); 
 writeln(outfile);
 writeln(outfile,'old acc ');
 for j:= 1 to 12 do write(outfile,loldac[j]:3:6,' '); 
 writeln(outfile);
 close(outfile);
end;


procedure readprob;
 var j: integer;
   dis: string;
begin
dis :=' , disp=mod';
 for j:= 1 to 12 do loldof[j]:=0;
 for j:= 1 to 12 do lnewof[j]:=0;
 for j:= 1 to 12 do loldac[j]:=0;
 for j:=1 to 12 do lnewac[j]:=0;
 reset(infile,fname_vec[newoff_fname]);
 readln(infile);
 for j:= 1 to 12 do read(infile,lnewof[j]);
 close(infile);
 reset(infile,fname_vec[oldoff_fname]);
 readln(infile);
 for j:= 1 to 12 do read(infile,loldof[j]);
 close(infile);
 reset(infile,fname_vec[newacc_fname]);
 readln(infile);
 for j:= 1 to 12 do read(infile,lnewac[j]);
 close(infile);
 reset(infile,fname_vec[oldacc_fname]);
 readln(infile); (* read labels *)
 for j:= 1 to 12 do read(infile,loldac[j]);
 close(infile);
end;

procedure translamtoprob;
var i,j: integer;
begin with beliefs do begin
 for j:= -1 to 1 do
   begin
   i:=1+(j+1)*4;
   lnewof[i]:=lamr[j];
   i:=2+(j+1)*4;
   lnewof[i]:=lamo[j];
   i:=3+(j+1)*4;
   lnewof[i]:=lamj[j];
   i:=4+(j+1)*4;
   lnewof[i]:=laml[j];
   i:=1+(j+1)*4;
   lnewac[i]:=lo[j];
   i:=2+(j+1)*4;
   lnewac[i]:=lr[j];
   i:=3+(j+1)*4;
   lnewac[i]:=lq[j];
   i:=4+(j+1)*4;
   lnewac[i]:=uew[j];
   end;
end; (*with *)
end;

procedure reviseprob;
var j,mxj1,mxj2: integer;
begin 
with beliefs do 
begin
   (* for j:= 1 to 12 do write(loldof[j]:2:4,' ');
   writeln;
   writeln(' option 9 is ',option[9]); *)
(* add 1 to numerator and denominator to avoid division by zero *)
 mxdff1 := 0.0;
 for j:=1 to 12 do 
     if  (abs(loldof[j]-lnewof[j]) > mxdff1) then 
        begin mxdff1 := abs(loldof[j]-lnewof[j]); mxj1 := j; end;
 if mxdff1>revtol then parchk:=false;
 mxdff2 := 0.0;
 mxj2 := 0;
 for j:=1 to 12 do 
     if (NOT (j in [4,8,12])) AND (abs(loldac[j]-lnewac[j])>mxdff2) then
        begin mxdff2 := abs(loldac[j]-lnewac[j]); mxj2 := j; end;
 if mxdff2>revtol then parchk:=false;
 (* write(mxj1:2,':',mxdff1:8:7,' ',mxj2:2,':',mxdff2:8:7,' '); *)
    for j:=1 to 12 do 
        if (mnof[j]>0) then
           loldof[j]:=mnof[j]+(lnewof[j]-mnof[j])*revr 
        else loldof[j]:=lnewof[j];
   for j:=1 to 12 do 
       if (mnac[j]>0) then 
          loldac[j]:=mnac[j]+(lnewac[j]-mnac[j])*revr
       else loldac[j]:=lnewac[j];
 for j:= -1 to 1 do
   begin
   lamr[j]:=loldof[1+(j+1)*4];
   lamo[j]:=loldof[2+(j+1)*4];
   lamj[j]:=loldof[3+(j+1)*4];
   laml[j]:=loldof[4+(j+1)*4];
    end;
  for j:= -1 to 1 do
       begin
       lo[j]:=loldac[1+(j+1)*4];
       lr[j]:=loldac[2+(j+1)*4];
       lq[j]:=loldac[3+(j+1)*4];
       uew[j]:=loldac[4+(j+1)*4];
       end;

end; (* with *)
end;

procedure checkextremes;
var j: integer;
begin
 with beliefs do begin
for j:=-1 to 1 do
 if uew[j]>=.99999 then extremeval:=extremeval+1; 
 if lamo[j]<=0.000005 then extremeval:=extremeval+1; 
 if laml[j]>=0.99999 then extremeval:=extremeval+1; 
 if laml[j]<=0.000005 then extremeval:=extremeval+1; 
 if lq[j]>=0.99999 then extremeval:=extremeval+1; 
 if lq[j]<=0.000005 then extremeval:=extremeval+1; 
 if lamj[j]<=0.000005 then extremeval:=extremeval+1; 
 if lamr[j]<=0.000005 then extremeval:=extremeval+1; 
 if lr[j]<=0.000005 then extremeval:=extremeval+1; 
 if lo[j]<=0.000005 then extremeval:=extremeval+1; 
if extremeval>option[47] then parchk:=true; 
end; (* with *)

end;

procedure writeprob;
var   j: integer;
begin with beliefs do begin

 rewrite(outfile,fname_vec[oldoff_fname]);
    writeln(outfile,'    lamr         lamo        lamj     laml');  
 write('0 ');
 for j:=0 to 2 do
   begin
    writeln(outfile,loldof[1+4*j]:8:7,' ',loldof[2+4*j]:8:7,' ',
    loldof[3+4*j]:8:7, ' ',loldof[4+4*j]:8:7); 
    write(' ',loldof[1+4*j]:8:7,' ',loldof[2+4*j]:8:7,' ',
    loldof[3+4*j]:8:7, ' ',loldof[4+4*j]:8:7); 
   end;
 close(outfile);
 rewrite(outfile,fname_vec[oldacc_fname]);
 writeln(outfile,' lo                 lr                     lq                    uew');
 write(' 1 ');
for j:=0 to 2 do
   begin
    writeln(outfile,loldac[1+4*j]:8:7,' ',loldac[2+4*j]:8:7,' ',
    loldac[3+4*j]:8:6,' ', loldac[4+4*j]:8:7); 
    write(' ',loldac[1+4*j]:8:7,' ',loldac[2+4*j]:8:7,' ',
          loldac[3+4*j]:8:6,' ', loldac[4+4*j]:8:7); 
   end;
 writeln(' ',mxdff1:8:7,' ',mxdff2:8:7);
close(outfile);
end; (* with *)
end;

procedure readoptions;
var
  s,j: integer;
begin
(* allow for 50 options at most, 1 - 10 overall, 11-30 worker, 31-40
firm,41 - 50 simulation *)
   if round(option[4])=1 then wrdata:=1 else
   wrdata:=0;
  reset(infile,fname_vec[simopt_fname]);
for j:= 31 to 33 do
  begin
  read(infile,option[j]); (* firm options *)
  readln(infile);
  end;
for j:= 41 to 49 do
  begin
  read(infile,option[j]);
  readln(infile);
  end;
  close(infile);
  reset(infile,fname_vec[option_fname]);
  for j:= 1 to 10 do
    begin
    read(infile,option[j]);
    readln(infile,opt_def[j]);
    end;
   close(infile);
   nw:=round(option[1]);
   neps:=round(option[2]);
  if wrdata=1 then option[5]:=1;
  readworkoption;
end;

function calcwage(i: integer; minwg: real): real;
begin
calcwage:=minwg+exp(mu+sigma*(invn((i-0.5)/nw)));
end;

procedure setupmodel;
var i: integer;
  minwage: real;
begin
  translatepar;  (*CF feb96, moved from worker and firm segments *)
  readoptions;
  minwage:=option[21];
  for i:=1 to nw do 
     begin
     wageall[i]:=calcwage(i,minwage);  (* lb 06/96 moved from work,firm & sim segments *)
     if wageall[i]<option[28] then pdwage[i]:=option[28]
        else pdwage[i]:=wageall[i];
      end;
  if ((simcnt=1) or (option[6]=1)) then initiallam;
  initialprob;
     revtol:=option[8];
   revr:=option[10]; (* revision of lambda's and l's *)
   if round(option[20])=1 then writeln('revr ',revr:4:4); 
   for i:= 1 to n_moments do mominmain[i]:=0.0;
    initialval;
   initialdecfrm;
end;



procedure wrmoment(var tmplk: real);
var i1, j1, i2,i3: integer;
begin
rewrite(outfile,fname_vec[momout_fname]);
writeln(outfile,'beta-worker-cost Elnwage  Vlnwage lmabdaD beta--firm--C-hire prjo b gonefirmmatch share  rho  maxep ' );
for i1:= 1 to np do
write(outfile,par[i1]: 5:4,' ');
writeln(outfile);
writeln(outfile,'Simcnt ',simcnt:5,'Lowest like val ',minlike:4:5,' this run ',tmplk:4:5);
writeln(outfile);
writeln(outfile,'          MEAN  FOLLOWED BY  STANDARD DEVIATION   ');
writeln(outfile,'State          U.E.          U.I.recip.             Wage');
writeln(outfile,'Simulation');
for j1:=-1 to 1 do
  begin
   write(outfile,' ',j1,' ');
    i2:= (j1+1)*2+1;
   write(outfile,mominmain[i2]:5:4,' ',mominmain[i2+1]:4:4,' ',mominmain[i2+6]:4:5,' ', mominmain[i2+7]:4:5,' ',mominmain[i2+12]:4:4,' ',mominmain[i2+13]:4:4);
   writeln(outfile);
  end;

writeln(outfile,'Actual');
for j1:=-1 to 1 do
  begin
   write(outfile,' ',j1,' ');
    i2:= (j1+1)*2+1;
   write(outfile,act[i2]:5:4,' ',act[i2+1]:4:4,' ',act[i2+6]:4:5,' ',act[i2+7]:4:5,' ' ,act[i2+12]:4:4, ' ',act[i2+13]:4:4);
   writeln(outfile);
  end;
writeln(outfile);
close(outfile);
end;



procedure checkmoment;
var i,j: integer;
tmplk: real;
begin
  tmplk := 0.0;
  for i := 1 to n_moments do
      tmplk := tmplk+momwgt[i]*(act[i]-mominmain[i])*(act[i]-mominmain[i])/(act[i]*act[i]);
tmplk:= tmplk+extremeval*option[49];
if ((tmplk<minlike) and (extremeval=0)) then
  begin
  minlike:=tmplk;
  writeprob;
  wrmoment(tmplk);
  end
  else if round(option[44])>0 then wrmoment(tmplk);
if extremeval>=option[48] then 
   begin
   initiallam;
   writeln('Extremeval is ',extremeval:4);
   end;

end;

procedure iteratemodel;
var iii,i: integer;
begin
iii:=0;
repeat   
   worker(gresk,indxrec,valnowk, valwk, praggs,pdwage);
  parchk:=true;
  firm(decfrm, praggs, wageall, pdwage);
  simulate(gresk, indxrec,decfrm, praggs,mominmain, wrdata, pdwage); 
  if round(option[45])=1 then trackoffaccprob(iii);
  if round(option[7])=1 then 
   readprob 
  else 
   translamtoprob;
  reviseprob;
  for i := 1 to 12 do (*CF added 9/97 *)
     begin
     mnof[i] := (mnof[i]*(iii+1)+loldof[i])/(iii+2);
     mnac[i] := (mnac[i]*(iii+1)+loldac[i])/(iii+2);
     end;
  extremeval:=0;
(* Problem:  If the program goes to extreme values, it get stuck.  Even if I send it to the main with a high value of the likelihood function, it just keeps
coming back, going back to the extreme values, and getting stuck again.  I have
to figure out a way to fix this.  Basically, we need to keep a file that contains probabilities that do not contain extreme values and restart using it with the
new parameters, we also have to let it get really stuck to be sure that we are not trying to prevent a problem that is not about to get worse. *)

  checkextremes; 
  if round(option[9])=1 then writeprob;
  iii:=iii+1; 
until (((parchk=true) or (round(option[5])=1)) or  (iii>=option[3]));
(* option[5] forces the last run *)  
writeln(' iterations till convergence ',iii, ' option[5] ',option[5]);
end;

 
procedure dofinalsim;
var 
opt5set: integer;
begin
  if round(option[5])=0 then 
     begin 
     option[5]:=1;
     opt5set:=1;
     end;
  if round(option[9])=1 then writeprob;
  simulate(gresk,indxrec, decfrm, praggs,mominmain,wrdata,pdwage);
  if opt5set=1 then 
    begin
    option[5]:=0;
    opt5set:=0;
    end;
end;


procedure dolastrun;
(* with option[4] = 1 this run uses final parameters to solve model and 
print simulation *)
begin
   worker(gresk,indxrec, valnowk, valwk, praggs, pdwage);
  firm(decfrm, praggs,wageall,pdwage);
  option[5]:=1;
   simulate(gresk,indxrec, decfrm, praggs,mominmain,wrdata,pdwage);
end;

begin
writeln('starting simulation');
  calctransition;
  setupmodel;
  simcnt:=simcnt+1;  (* initialized in main *)
  if wrdata=0 then 
    begin
    iteratemodel;
    dofinalsim;
    end
    else dolastrun;  
  checkmoment; 
  writeln('leaving sim_moments  simcnt',simcnt:5);
  sim_moments:=mominmain;
end;
.
