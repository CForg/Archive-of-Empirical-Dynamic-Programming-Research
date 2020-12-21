 segment simulate; 

/* availu[ii] and availw[ii] all initialized at avail[ii]:=obs
in setup.  Loops go from 1 to actobs, so error should only occur if
we are trying to use an array element that has not been set */

const

%include ./uimatch.con

type
%include ./uimatch.typ

ref
%include ./var.def


%include ./uimatch.def


(********START PROCEDURE **********)

procedure simulate;

 static  


mxper, actobs, momwrite,
 totavu,totavw, totunemp,totemp,
rwresk,rwlambda,
t1,t1prime,
n1,n1prime,
 ue,ui,newue,emp,newemp,finalrun,
 quitpen, maxuid,
 startcnt,cntoff: integer; (* the number of iterations before start counting *)


  ben,lam0,lam1,salp,
 recallp,offup,offep,layp,offuap,offeap,recaccp,
  poffau,poffae,poffu,poffe,
noffa,noffu,noffe,
prec,precu,preca,
 nquit,nquit2,pquit,
pquitue,pquitnj,play,
 meandu,meande,meankr,meankru,meank,
 wmin,  meanw: real;

rectot,recacc,quit,offacc,offun,offem,lay,uirs,mws,
 stdue,stdui,stdmw: areal_type;


 aggs: alpn_type;

 availu, availw: avail_type;
 update,giveoff,pers: job_type;
 corr: corr_type;
 emp1: m2_type;

 k1,k2,kres,k1prime,kjob, 
 kminb,kmaxb: k_type;
 
 empstat: emp_type;
 duru,
 dure,
 wr: warr_type;
 eco_state: eco_type;
 chkcyc,perrec0,peroff0,peremp0,perue0: aint_type;
 
 state: state_type;
 fstat: fstat_type;


 dur: dur_type;
 today,last,swap: time_type;


 uerate,uirate, mwper,newuer,newer,noue,noemp: rate_type;


 
 jj, ent, rxben, reppen,  wmaxb : integer; 

var 
 per, ff,f1,f2: integer;


(******** PROCEDURES ***********)

(********Transition functions **********)

procedure m0prime0;
begin
(* t2:=0;
 if t2=0 then 
    begin
     t2prime:=0;
*)
     if (t1<=0) then 
        begin
          t1prime:=0;
          if (n1<yrwk) then n1prime:=n1+1
          else n1prime:=yrwk;
        end
    else 
        begin
           t1prime:=t1-1;
           n1prime:=0;
         end;
 (*   end
  else 
   begin
     t1prime:=t1;
     n1prime:=0;
     if (t2>0) then t2prime:=t2-1
     else t2prime:=0;
   end;
k1prime:=k1;
*)
if (((t1prime=0) and (t1=1)) (* and ((t2prime=0) or (t2=1)) *) ) then
n1prime:=1;
end; (*   m0prime0 *)

(* moprime1: k1 must be found,k2p=k1,t1p=1,t2p=t1-, always ,n1p=n1+1 or
26 *)

procedure m0prime1;
begin
(* t2stp:=0;
 *)        (* if ((t1>crit2) or ((s<=t1) and (t1>1))) then begin
            t2stp:=1;
           end;*)

t1prime:=1; 
(* if (t1>0) then t2prime:=t1-1;
*)
n1prime:=n1+1;
if (n1prime>yrwk) then n1prime:=yrwk;
end; 

procedure m1prime0(notlay: integer);
begin
(* k2:=1; *)
(* t2:=0;
*)
if k1<kminb then t1prime:=0
else
begin
  if (t1<=6) then
   begin
    t1prime:=(t1+rxben);
    if ((n1>=yrwk) and (t1<=ent)) then t1prime:=0;
    if ((n1<yrwk) and
       (t1<=(ent+reppen))) then t1prime:=0; 
   end
  else t1prime:=6+round((t1-6)/2+rxben); 
  if (t1prime>maxuid) then t1prime:=maxuid 
   else
   begin
    if t1prime<=0 then 
      begin
      t1prime:=0;
      k1prime:=k1
      end
      else 
      k1prime:=k1;
   end;
end;
(* if t2>0 then begin
   t2prime:=t2-1;
   k2prime:=k2 
end
else begin
  t2prime:=0;
   k2prime:=k2 
end;
*)
n1prime:= n1+1;
k1prime:=k1;
if n1prime>yrwk then n1prime:=yrwk;
(* try the quit penalty  july 11/96 lb *)
if ((quitpen=1) and (notlay=1)) then t1prime:=0; 
if (t1prime>0) then n1prime:=0; 
end; 


procedure m1prime1;
begin
if (t1<yrwk) then t1prime:=t1+1 else t1prime:=yrwk;
       (* if (((t2start=1) or (t1>10)) and (t2prime>0)) then
t2prime:=t2-1
          else t2prime:=t2;
          if t2prime>mxper-(s+1) then begin
             t2stp:=1; 
             t2prime:=mxper-(s+1);
           end;
          if t2prime<=0 then begin
             k2prime:=1;
             t2stp:=0;
             end
             else begin
              k2prime:=k2; 
             t2stp:=t2start;
          end; *)
n1prime:=n1+1;
if n1prime>yrwk then n1prime:=yrwk;
if (t1>=ent+reppen) then n1prime:=yrwk;
          (* while debugging, need n1max1 instead of entreq, DELETE
AFTER *)
(* if (t1>=10) then n1prime:=yrwk; *)
end; 


function getk(win: integer): k_type;
var temp: integer;
begin
if win>wmin then
temp:=round(0.5+nw*cdfn((ln(win-wmin)-mu)/sigma))
else temp:=1;
if temp>=nw then getk:=nw
 else 
if temp<=1 then getk:=1
 else getk:=temp;
end;


procedure getminmax; (* ch May19/96 lb removed yr*)
(* maximum weekly insurable earnings *)
(* 1988  1989  1990  1991 *)
(*  565   605   640   680 *)
(* benefits *)
(*  339   363   384   408 *)
(* minimum is 20 % of maximum *)
(* year week *)
(* for cwr calculation *)
(*  0    1-26  27-54  55-78 *)
(* s=1 => 4592-4593, s=27 =>4644-4645, s=55 =>4696-4697 *)
(* for estimation *)
(*   1-27 28-53  54-78 *)  
(*s=1=>4538-4539,s=27 => 4590-4591, s=54 => 4644-4645, s=78 =>
4694-4695 *)

begin
(* if (yr=88) then 
  begin
   kminb:=getk(round(565*0.2));
   kmaxb:=getk(565);
  end
  else
  if (yr=89) then 
   begin
     kminb:= getk(round(605*0.2));
     kmaxb:= getk(605);
   end
 else  *)   (* if statements changed by Chris 7/28/94, *)
         (* numbers & weeks changed by Laura 17/9/94 *)
(* if  (yr=90) then 
   begin
     kminb:= getk(round(640*0.2));
      kmaxb:= getk(640);
   end
 else
   begin
     kminb:= getk(round(680*0.2));
     kmaxb:= getk(680);
   end;

writeln(s,kminb,kmaxb); *)
kminb:=getk(round(wmaxb*0.2));
(* kminb:=1; removed Feb 97 lb *)
kmaxb:=getk(wmaxb);
end;


function genwage: k_type; (* changed May 19/96 lb to match k2 *)
begin
genwage:=round((random(0)*nw)+0.5);
end;

procedure perslvec;
begin
if per>=startcnt then
  begin
  pers[jj]:=pers[jj]+1;
  end;
if ((per>=startcnt) and (dur[jj,1,0]=0) and (pers[jj]=1)) then 
  dur[jj,1,0]:=1;
end;


procedure leaveecon;
var frm, mn: integer;
(* added mn and relating conditions may 30/96 lb ... worker must be attached
and working for firm to lose its worker *)
begin
with state[today,jj] do
begin
  mn:=m0;
  frm:=fn; 
  m0:=0;
  k:=1;
  t:=0;
  n:=1;
  fn:=0;
  end;
if ((frm<>0) and (mn=1)) then
  begin
  if fstat[today,frm].m=1 then fstat[today,frm].m:=0;
(*  ue:=ue+1;  (* added Oct 96  lb *)
(*  emp:=emp-1;   removed Oct 96 lb *)
  end;
  if finalrun=1 then perslvec;
end;

procedure perskpjb;
begin
 if ((per>=startcnt) and (dur[jj,1,0]>0) and (pers[jj]=1)) then 
   begin
   if dur[jj,4,1]=0 then (* dur(4) is just a yes/no counter to say if have
                           already info on first 3 jobs/attachments *)
     begin
   if dur[jj,3,1]>0 then dur[jj,3,1]:=dur[jj,3,1]+1
     else if dur[jj,2,1]>0 then dur[jj,2,1]:=dur[jj,2,1]+1
     else if dur[jj,1,1]>0 then dur[jj,1,1]:=dur[jj,1,1]+1;
      end;
   if dur[jj,4,2]=0 then
    begin
    if dur[jj,3,2]>0 then dur[jj,3,2]:=dur[jj,3,2]+1
     else if dur[jj,2,2]>0 then dur[jj,2,2]:=dur[jj,2,2]+1
     else if dur[jj,1,2]>0 then dur[jj,1,2]:=dur[jj,1,2]+1;
    end;
   end;
end;


procedure keepjob;
begin
 m1prime0(1);

 if t1prime>0 then empstat[today,jj]:=3 else empstat[today,jj] := 2;
 m1prime1;
 with state[today,jj] do
   begin
   m0:=1;
   t:=t1prime;
   k:=k1;
   n:=n1prime;
   fn:=state[last,jj].fn;
   end;
 update[jj]:=1;
  if finalrun=1 then perskpjb;
end;

procedure perslvjb;
begin
 if ((per>=startcnt) and (dur[jj,1,0]>0) and (pers[jj]=1)) then
   begin
   if (dur[jj,4,0]=0) then 
   begin
   if dur[jj,3,0]>0 then dur[jj,4,0]:=1
    else if dur[jj,2,0]>0 then dur[jj,3,0]:=1
     else dur[jj,2,0]:=1;
   end;
   if (dur[jj,4,2]=0) then
    begin
    if dur[jj,3,2]>0 then dur[jj,3,2]:=dur[jj,3,2]+1
    else if dur[jj,2,2]>0 then dur[jj,2,2]:=dur[jj,2,2]+1
    else dur[jj,1,2]:=dur[jj,1,2]+1;
    end;
   end;
 end;

procedure leavejob(nlay: integer);
begin
    m1prime0(nlay);
   if t1prime>0 then empstat[today,jj]:=1 else empstat[today,jj]:=0;
   with state[today,jj] do
     begin
     m0:=0;
     t:=t1prime;
     k:=k1;
     n:=n1prime;
     fn:=ff;
     end;
  (* if person leaves job this period, they are eligible for a recall
  this period and in future periods *)
  if finalrun=1 then perslvjb;
end;

procedure perschjb;
begin
 if ((per>=startcnt) and (dur[jj,1,0]>0) and (pers[jj]=1)) then 
   begin
   if dur[jj,4,1]=0 then (* dur(4)  yes/no counter *) 
     begin
      if dur[jj,3,1]>0 then dur[jj,3,1]:=dur[jj,3,1]+1
      else if dur[jj,2,1]>0 then dur[jj,2,1]:=dur[jj,2,1]+1
      else dur[jj,1,1]:=dur[jj,1,1]+1;
     end; 
   if dur[jj,4,2]=0 then
     begin
     if dur[jj,3,2]>0 then dur[jj,4,2]:=1
     else if dur[jj,2,2]>0 then dur[jj,3,2]:=1
     else dur[jj,2,2]:=1;
     end;
   end;
end;


procedure changejob;
  var fold: integer;
begin
  poffae:=poffae+1;
  m1prime0(0);
   if t1prime>0 then empstat[today,jj]:=3 else empstat[today,jj] := 2;
  m1prime1;
     t1:=t1prime;
     n1:=n1prime;
  kjob:=k2;
     fold:=state[last,jj].fn;
     fstat[today,fold].m:=0;
(* person has left old job, therefore even if not layed off before, old job
is now empty *)
   with state[today,jj] do
     begin
     m0:=1;
     t:=t1;
     k:=kjob;
     n:=n1;
     fn:=ff;
     end;
       with fstat[today,ff] do
        begin
         m:=1;
         k:=kjob;
         wn:=jj;
        end;
  if finalrun=1 then perschjb;
end;

procedure persstue;
begin
 if ((per>=startcnt) and (dur[jj,1,0]>0) and (pers[jj]=1)) then 
  begin
   if dur[jj,4,0]=0 then
     begin
      if dur[jj,3,0]>0 then dur[jj,3,0]:=dur[jj,3,0]+1
      else if dur[jj,2,0]>0 then dur[jj,2,0]:=dur[jj,2,0]+1
      else dur[jj,1,0]:=dur[jj,1,0]+1;
     end;
      if dur[jj,3,2]>0 then dur[jj,3,2]:=dur[jj,3,2]+1
      else if dur[jj,2,2]>0 then dur[jj,2,2]:=dur[jj,2,2]+1
      else if dur[jj,1,2]>0 then dur[jj,1,2]:=dur[jj,1,2]+1;
   end;
 end;


procedure stayue;
begin
  m0prime0;
  if t1prime>0 then empstat[today,jj]:=1 else empstat[today,jj]:=0;
  with state[today,jj] do
     begin
     m0:=0;
     t:=t1prime;
     k:=k1;
     n:=n1prime;
     fn:=state[last,jj].fn;
     end;
     update[jj]:=1;
  if finalrun=1 then persstue;
end;

procedure perstkjb;
begin
 if ((per>=startcnt) and (dur[jj,1,0]>0) and (pers[jj]=1)) then 
   begin
   if dur[jj,4,1]=0 then
     begin
      if dur[jj,3,1]>0 then dur[jj,4,1]:=1
      else if dur[jj,2,1]>0 then dur[jj,3,1]:=1
      else if dur[jj,1,1]>0 then dur[jj,2,1]:=1
      else dur[jj,1,1]:=1;
     end;
   if dur[jj,4,2]=0 then
     begin
      if dur[jj,3,2]>0 then dur[jj,4,2]:=1
      else if dur[jj,2,2]>0 then dur[jj,3,2]:=1
      else if dur[jj,1,2]>0 then dur[jj,2,2]:=1
      else dur[jj,1,2]:=1;
     end;
   end;
end;

procedure takejob;
begin
  poffau:=poffau+1;
  m0prime0; (* added by lb May 19/96 *)
  if t1prime>0 then empstat[today,jj]:=3 else empstat[today,jj]:=2;
  m0prime1;
  k1:=k2;
  kjob:=k2;
  n1:=n1prime;
   with state[today,jj] do
     begin
     m0:=1;
     t:=1;
     k:=k1;
     n:=n1prime;
     fn:=ff;
     end;
    with fstat[today,ff] do
     begin
     m:=1;
     k:=k1;
     wn:=jj;
     end;
  if finalrun=1 then perstkjb;
end;

procedure persrtjb;
begin
 if ((per>=startcnt) and (dur[jj,1,0]>0) and (pers[jj]=1)) then
  begin
   if dur[jj,4,1]=0 then
     begin
      if dur[jj,3,1]>0 then dur[jj,4,1]:=1
      else if dur[jj,2,1]>0 then dur[jj,3,1]:=1
      else dur[jj,2,1]:=1;
     end;
   if dur[jj,4,2]=0 then
     begin
      if dur[jj,3,2]>0 then dur[jj,3,2]:=dur[jj,3,2]+1
      else if dur[jj,2,2]>0 then dur[jj,2,2]:=dur[jj,2,2]+1
      else if dur[jj,1,2]>0 then dur[jj,1,2]:=dur[jj,1,2]+1;
    end;
  end;
end;

procedure retjob;
begin
m0prime0; (* see if would still receive ui if stayed unemployed lb may28/96 *)
if t1prime>0 then empstat[today,jj]:=3 else empstat[today,jj]:=2;
m0prime1;
  with state[today,jj] do
   begin
    m0:=1;
    t:=1;
    k:=k1;
    n:=n1prime;
    fn:=ff;
   end;
  with fstat[today,ff] do
   begin
    m:=1;
    k:=k1;
    wn:=jj;
   end;
(* if accept recall not eligible for future recall *)
   preca:=preca+1;
  if finalrun=1 then persrtjb;
end;

procedure nochange;
begin
fstat[today,ff].m:=fstat[last,ff].m;
fstat[today,ff].k:=fstat[last,ff].k;
fstat[today,ff].wn:=fstat[last,ff].wn;
end;

procedure recall(var acc:integer);
var ml: m_type;
begin
(* jj:=fstat[last,ff].wn; *)
acc:=0;
 if (state[last,jj].m0=1) then ml:=1
    else ml:=0;
 if ml=1 then writeln('person matches but is employed !!! fn ff', f1:4,ff:4,' mf ',fstat[last,ff].m:3); 
  if ((ml=0) and (f1=ff)) then  
    begin
(* program should not get here if person is reemployed.
*)
     if indxf[k1,t1,n1,aggs]=1 then 
       begin
       retjob; 
       acc:=1;
       fstat[today,ff].m:=1;
       fstat[today,ff].k:=fstat[last,ff].k;
       fstat[today,ff].wn:=fstat[last,ff].wn;
       update[jj]:=3;  (* show that person jj is not available for an offer *)
       end 
     else
       begin
       stayue;
       update[jj]:=2; (* show that pers jj received,rejected a recall *)
       fstat[today,ff].m:=0;
       fstat[today,ff].k:=fstat[last,ff].k;
       fstat[today,ff].wn:=fstat[last,ff].wn;
       end;
    end;

end;

procedure layoffworker;
 begin
  play:=play+1;
  leavejob(0);
  update[jj]:=2;
  fstat[today,ff].m:=0;
  fstat[today,ff].k:=fstat[last,ff].k;
  fstat[today,ff].wn:=fstat[last,ff].wn;
 end;

procedure firmquit;
  begin
   fstat[today,ff].m:=0;
   fstat[today,ff].k:=fstat[last,ff].k;
   fstat[today,ff].wn:=fstat[last,ff].wn;
  end;

procedure offeru;
var
ms: alpn_type;
begin
poffu:=poffu+1;
k2:=genwage;
  k1:=state[last,jj].k;
  t1:=state[last,jj].t;
  n1:=state[last,jj].n; 
  f1:=state[last,jj].fn;
ms:=0;
(*  m0prime0(k1prime,t1prime,n1prime);*)
 kres:=resk[ms,k1,t1,n1,aggs];
  meankru:=meankru+wage[kres];
  if kres<=k2 then 
   begin
     takejob;
     update[jj]:=5;
   end
  else 
   begin
    stayue;
    nochange;
    update[jj]:=4;
    end;
end;

procedure offerw;
var ms: alpn_type;
begin
ms:=1;
poffe:=poffe+1;
k2:=genwage;
  k1:=state[last,jj].k;
  t1:=state[last,jj].t;
  n1:=state[last,jj].n; 
  f1:=state[last,jj].fn;
 kres:=resk[ms,k1,t1,n1,aggs];
 meankr:=meankr+wage[kres]; 
  if update[jj]=2 then  (* person is layed off *)
    begin
    if k2>=kres then 
     begin
      changejob;
 update[jj]:=3; (* person is updated, and can't get anymore offers *)
     end   (* Jan 97 9 lines added to match base simulation *)
    end
   else 
   if update[jj]=0 then (* person quit 9 lines added sep 96 by lb *)
    begin
    if k2>=kres then
     begin
     changejob;
     nquit:=nquit-1;
     nquit2:=nquit2+1;
     end;
     update[jj]:=3;
   end 
   else  (* not layed off *)
    if k2>k1 then  
      begin
       changejob;
       nquit2:=nquit2+1;
 update[jj]:=5; (* person is updated, and can't get anymore offers *)
      end
      else 
       if update[jj]=0 then update[jj]:=4
       else
        begin
        nochange;
        keepjob;
 update[jj]:=4; (* person is updated, and can't get anymore offers *)
       end;
   if update[jj]<3 then update[jj]:=4; (* only 1 offer per period *)
end;

procedure finduew; 
var found,d: integer;  
begin
  found:=0;
  while ((found=0) and (totavu>0)) do 
     begin
      d:=trunc(random(0)*totavu)+1; (* offer random, max b is 0.499,*2 spans sample *)
      jj:=availu[d];
(* NOTE:  still have some people who accepted recalls because it is a waste of 
a loop to do this when giving out recalls *)
      if ((update[jj]<3) and (jj>0)) then 
         begin
          found:=1;
          offeru;
         end;
          availu[d]:=availu[totavu];
          update[availu[d]]:=update[availu[totavu]];
          totavu:=totavu-1; 
     end; (* while *)
end;

procedure findempw;
var found,d: integer;
begin  (* a=1 *)
    found:=0;
  while ((found=0) and (totavw>0)) do 
     begin
      d:=trunc((random(0))*totavw)+1; 
      jj:=availw[d]; 
      if update[jj]<3 then found:=1
       else
       begin
        availw[d]:=availw[totavw];
        update[availw[d]]:=update[availw[totavw]];
        totavw:=totavw-1;
       end;
     end;
     if jj=0 then writeln(' jj is zero! ',jj:3,' d ',d:3);
     offerw;
     if totavw>0 then
      begin
       availw[d]:=availw[totavw];
       update[jj]:=update[availw[totavw]];
       totavw:=totavw-1;
      end;
end;

procedure startoffer;
var a: integer;
     b: real;
begin

 b:=random(0);
 a:=round(b);
  if (a=0)  then  (* 1/2 of jobs goes to unemployed person *)
   begin
    finduew;     (* if all ue persons have received an offer already,
                         the offer goes to an employed person *)
  end
  else
  begin
   findempw;
  end;
end;

procedure firmdec1;
var mf,acc,xx,j: integer;
kf: k_type;
uep: eps_type;
begin
acc:=0; (* added dec 97 lb *)
with fstat[last,ff] do
  begin
  mf:=m;
  kf:=k;
  jj:=wn;
  end;
 xx:=(trunc(random(0)*neps)+1);
  uep:=xx;
fstat[today,ff].e:=uep;
with state[last,jj] do
   begin
   k1:=k;
   t1:=t;
   n1:=n;
   f1:=fn;
   end;
  if mf=-1 then 
    begin (* 1 *)
    (* the following could be the last command sequence in the previous period
        instead of the first this period, it doesn't matter, but may if we are
     keeping track of firm deaths and births *)
  (*  if fstat[last,ff].m=-1 then
      begin 
the above two statements seem totally redundant, since mf:=fstat[last,ff].m 
*)
      nochange; (* both with/out offer need update *)
      if dec[mf,kf,uep,aggs]=2 then
         begin (* 2 *)
         cntoff:=cntoff+1;
         giveoff[cntoff]:=ff; 
         end (* 2 *)
         else
          begin (* 2 *) 
          if ((state[last,jj].fn=ff) and (state[last,jj].m0=0)) then 
                begin (* 3 *)
                 stayue;
                 end; (* 3 *)
          end;(* 2 *)
    (*  end; *)
    end;(* 1 *)
  (* now can have the job disappear, as last thing last period or first 
  this one, so can enter period as new job *)

(* look at recalls and layoffs, then send out *)
  if (mf=0) then 
     begin (* 1 *)
      nochange;
     if dec[0,kf,uep,aggs]=0 then  (* no offer or recall *)
       begin  (* 2 *)
        if (f1=ff) then stayue;
       end;   (* 2 *)
       (* recall and/or recall and offer *)
      if ((dec[0,kf,uep,aggs]=1) or (dec[0,kf,uep,aggs]=3))  then  
        begin (* 7 *)
         prec:=prec+1; (* recall counts for lr even if person not reachable *)
         if (f1=ff) then 
          begin (* 3 *)
          recall(acc);
          precu:=precu+1; (* only recalls to ue persons affect lamr *)
          if acc=1 then   (* recall is accepted *)
            begin (* 4 *)
             (* cntacc:=cntacc+1; *)
             acc:=0;
            end (* 4 *)
            else 
            begin (* 5 recall is rejected *)
             stayue;
             acc:=2;
            end; (* 5 *)
          end; (* 3 *)
         if ((acc=2) or (ff<>f1))
          then  
          begin  (* 4 *)
           if (dec[0,kf,uep,aggs]=3) then   (* firm will also issue an offer *)
            begin (* 5 *)
             cntoff:=cntoff+1;
             giveoff[cntoff]:=ff;
            end; (* 5 *)
          end; (* 4 *)
        end; (* 7 *)
        if dec[0,kf,uep,aggs]=2 then  (* firm issues offer only lb DEC
96 *)
         begin (* 6 *)
          cntoff:=cntoff+1;
          giveoff[cntoff]:=ff;
         end; (* 6 *)
   end (* 1 *)
   else
   if mf=1 then 
     begin  (* 1 *)
       if (dec[1,kf,uep,aggs]=0) then 
         begin
         layoffworker ;
         update[jj]:=2;
          end
       else (* if not layed off, then see if quit into ue *)
        if resk[1,k1,t1,n1,aggs]<=state[last,jj].k then 
         begin
          nochange;
          keepjob; (* do all emps now, change only those who acc offers later *)
         end
         else 
         begin
          leavejob(1);
          firmquit;
          update[jj]:=0; (* same as layoff because same kres choice *)
          nquit:=nquit+1;
         end;
     end;
end;


procedure firmdec2;
var mf: alpn_type; 
   kf: k_type;
   uep: eps_type;
     r: real;
begin (* 1 *)
  mf:=fstat[last,ff].m;
  kf:=fstat[last,ff].k;
  uep:=fstat[today,ff].e; 
   if mf=-1 then
     begin (* 2 *)
     if dec[-1,kf,uep,aggs]=0 then 
       begin (* 3 *)
       nochange;
       end (* 3 *)
      else
      if ((totavu>0) and (totavw>0)) then 
        begin (* 3 *)
          startoffer;
         end (* 3 *)
        else 
          begin (* 3 *)
          if (totavu=0) then findempw 
          else if (totavw=0) then finduew;
          end; (* 3 *)
    end(* 2 *)
    else if mf=0 then 
    if ((dec[0,kf,uep,aggs]>1) and (fstat[today,ff].m=0)) then 
      begin (* 2 *)
      if ((totavu>0) and (totavw>0)) then startoffer
      else
        begin (* 3 *)
          if (totavu=0) then findempw 
          else if (totavw=0) then finduew;
     end;(* 3 *)
     end; (* 2 *)
 
(* if dec[0,kf,eps,aggs] is less than 2 then no offer is sent out, update already
   done for nooffer or recall refused *)
end; (* 1 *)


procedure putobsinf;
var mnow,ml: m_type; (* m changed to mnow lb may 26/96 *)
    kres: k_type;
    j1,f0: integer;
    lde,lamde: real;
begin
  f0:=0;
  for j1:=1 to actobs do
  begin
   jj:=j1;
   ml:=state[last,j1].m0;
(* next line changed by lb may28/96 so that persons who rejected a recall 
are updated -- update[jj]=2 *)
   if ((ml=0) and ((update[jj]=0) (* or (update[jj]=2)*) )) then 
     begin
      with state[last,jj] do
       begin
        mnow:=m0;
        k1:=k;
        t1:=t;
        n1:=n;
        f1:=fn;
       end;
       stayue;
     end;
  mnow:=state[today,jj].m0;
  k1:=state[today,jj].k;
  t1:=state[today,jj].t;
  if mnow=1 then 
    begin
     emp:=emp+1;
     meanw:=meanw+wage[k1];
     dure[today,jj] := dure[last,jj] + 1;
     duru[today,jj] := 0;
     meande:=meande+dure[today,jj];
     if (ml=0) then newemp:=newemp+1;
    end else
    begin
     ue:=ue+1;
     if t1>0 then ui:=ui+1;
     dure[today,jj] := 0;
     duru[today,jj] := duru[last,jj] + 1;
     meandu:=meandu+duru[today,jj];
     if (ml=1) then newue:=newue+1;
    end;
  meank:=meank+wage[k1];
  wr[today,jj]:=wage[k1];
  if fstat[today,jj].m=0 then
    begin
    lde:=random(0);
    if lde<=ld then fstat[today,jj].m:=-1;
    end;
  lamde:=random(0);
   if lamde<=lamd then 
   leaveecon;
  if state[today,jj].fn=0 then f0:=f0+1;
  end;
end;

procedure perreset;
var ii: integer;
begin
  cntoff:=0;
    ue:=0;
    ui:=0;
    emp:=0;
    newue:=0;
    newemp:=0;
    meank:=0;
    meankru:=0;
    meankr:=0;
    meanw:=0;
    meandu:=0;
    meande:=0;
    aggs:=eco_state[per];
    offep:=0;
    offup:=0;
    prec:=0;
    precu:=0;
    poffu:=0;
    poffe:=0;
    play:=0;
    preca:=0;
    poffau:=0;
    poffae:=0;
    pquit:=0;
    pquitue:=0;
    pquitnj:=0;
    nquit:=0;
    nquit2:=0;
    totavu:=0;
    totavw:=0;
    totemp:=0;
    recallp:=0;
    layp:=0;
    recaccp:=0;
    offuap:=0;
    offeap:=0;
    for ii:=1 to actobs do
     begin
      if state[last,ii].m0=0 then
       begin
     totavu:=totavu+1;
     availu[totavu]:=ii;
       end else 
       begin
     totavw:=totavw+1;
     availw[totavw]:=ii;
       end;
      giveoff[ii]:=0;
      update[ii]:=0;
     end;
     totemp:=totavw;
     totunemp:=totavu;
end;

procedure calcmeans;
var i,emp2: integer;
begin
    uirate[per]:=ui/(ue+emp);
    uirs[aggs]:=uirs[aggs]+uirate[per];
  if ue>0 then
    begin
    newuer[per]:=newue/ue;
    meandu:=meandu/ue;
    meankru:=meankru/totunemp;
    noue[per]:=0;
    end else
    begin
    newuer[per]:=0;
    meandu:=0;
    meankru:=0;
    perue0[aggs]:=perue0[aggs]+1;
    noue[per]:=1;
    end;
  if emp>0 then
    begin
    newer[per]:=newemp/emp;
    meande:=meande/emp;
    meanw:=meanw/emp;
    meankr:=meankr/totemp; 
    noemp[per]:=0;
    end else
    begin
    meande:=0;
    meanw:=0;
    meankr:=0;
    peremp0[aggs]:=peremp0[aggs]+1;
    noemp[per]:=1;
    end;
  mwper[per]:=meanw;
  mws[aggs]:=mws[aggs]+mwper[per];
  meank:=meank/(emp+ue);

 if ((wrpersrate=1) and (per > mxper-900)) then 
   begin
   write(fileout1,per:4,' ',aggs:3,' ',ue:4,' ',emp:4,' ');
   write(fileout1,uerate[per]:1:3,' ',newuer[per]:1:3, ' ',newer[per]:1:3,' ');
   write(fileout1,offup:1:3,' ',offep:1:3,' ', offuap:1:3,' ',offeap:1:3,' ');
   write(fileout1,recallp:1:3,' ', recaccp:1:3,' ',pquitue:1:3,' ');
   write(fileout1, pquitnj:1:3,' ', ' ',meanw:4:1,' ',meankr:4:1,' ');
   writeln(fileout1, meank:4:1,' ',meankru:4:1,' ',meande:4:1,' ',meandu:4:1); 
   end;
if (( wrpersrate=1) and (per > mxper-260))  then
  begin
    for i := 1 to actobs do
      begin
      emp1:=empstat[today,i];
       for emp2:= 0 to 3 do
       if (empstat[last,i]=emp2) then corr[emp1,emp2]:=corr[emp1,emp2]+1;
       writeln(fileout,i:4,' ',aggs:1,' ',per:4,' ',empstat[today,i]:1,' ',
       wr[today,i]:5:2,' ',duru[today,i]:5:1,' ',dure[today,i]:5:1); 
      end;
  end;
end;


procedure putperinf;
var i: integer;
    pu,pe: real;
begin 
    if totemp>0 then
      begin
       pquit:=(nquit+nquit2)/totemp;
       pquitue:=nquit/totemp;
       pquitnj:=nquit2/totemp;
      end
     else 
      begin
        pquit:=0;
        pquitue:=0;
         pquitnj:=0;
       end;
    if (per>=startcnt) then
      begin
       chkcyc[aggs]:=chkcyc[aggs]+1;
       if ((preca/prec>1) or (preca/prec<0)) then writeln('probability of recall>1 ',aggs:3,per:4);
       if prec>0 then 
         begin
         recaccp:=preca/prec;
         recacc[aggs]:=preca/prec+recacc[aggs];
         end 
        else 
         begin
          perrec0[aggs]:=perrec0[aggs]+1;
          recaccp:=0;
         end;
       if totunemp>0 then recallp:=precu/totunemp else recallp:=0;
       if totunemp>0 then rectot[aggs]:=precu/totunemp+rectot[aggs];
       quit[aggs]:=pquit+quit[aggs];
       if (play/totemp)>1 then writeln('problem with layoffs in per ',per:4);
       if totemp>0 then 
         begin
         layp:=play/totemp;
         lay[aggs]:=(play/totemp)+lay[aggs];
         end
         else layp:=0;
       if (poffau+poffae)<=(poffu+poffe) then
         begin
         if poffu>0 then offuap:=poffau/poffu else offuap:=0;
         if poffe>0 then offeap:=poffae/poffe else offeap:=0;
         offacc[aggs]:=offacc[aggs]+0.5*(offuap+offeap);
         if (totunemp-preca<1) then  (* <1 or =0 for whole positive number *) 
           begin
           if offem[aggs]>0 then offun[aggs]:=1+offun[aggs];
           if offem[aggs]=0 then offun[aggs]:=0+offun[aggs];
           offup:=0;
           end
         else 
           begin
           offup:=poffu/(totunemp-preca);
           offun[aggs]:=poffu/(totunemp-preca)+offun[aggs];
           end;
         if (totemp<1) then
           begin
           if offun[aggs]>0 then offem[aggs]:=1+offem[aggs];
           if offun[aggs]=0 then offem[aggs]:=0+offem[aggs];
           offep:=0;
           end
         else 
           begin
           offep:=poffe/totemp;
           offem[aggs]:=offep+offem[aggs]; 
           end;
         end
      else if (poffu+poffe=0) then peroff0[aggs]:=peroff0[aggs]+1;   
     with beliefs do  if (emp>0) then uew[aggs]:=uew[aggs]+ue/(ue+emp)
       else uew[aggs]:=uew[aggs]+1;
      uerate[per]:=ue/(ue+emp);
      if ((finalrun=1) or (momwrite=1)) then calcmeans;
    end;
end;

procedure setup;
var i,j,l,k0,ms,x,y,z: integer;
    a: array[1..2] of integer;
    qq: real;
begin 
  getminmax;  (* added May 19/96 lb *)
  qq:=random(seed);
  today:=thisper;
  last:=nextper;
 
 for i:= -1 to 1 do 
   begin
   perue0[i]:=0;
   peremp0[i]:=0;
   perrec0[i]:=0;
   peroff0[i]:=0;
   chkcyc[i]:=0;
   lay[i]:=0;
   offun[i]:=0;
   offem[i]:=0;
   rectot[i]:=0;
   recacc[i]:=0;
   offacc[i]:=0;
   quit[i]:=0; 
   beliefs.uew[i]:=0;
   uirs[i]:=0;
   mws[i]:=0;
   stdue[i]:=0;
   stdui[i]:=0;
   stdmw[i]:=0;
  end;
x:=round(1/(1-ps[-1,-1]));
y:=round(1/(1-ps[0,0]));
z:=round(1/(1-ps[1,1]));
i:=1;
l:=1;
j:=1;
while (l<=mxper) do (* changed from l<mxper may30/96 lb *)
  begin
  noue[l]:=0;
  noemp[l]:=0;
  uerate[l]:=0;
  uirate[l]:=0;
  mwper[l]:=0;
  newuer[l]:=0;
  newer[l]:=0;
   while ((l<=mxper) and (i>(x+y+z)*(j-1)) and (i<=(x+y+z)*(j-1)+y*j)) do
     begin
     eco_state[l]:=0;
     i:=i+1;
     l:=l+1;
     end;
   while ((l<=mxper) and (i>(x+y+z)*(j-1)) and (i<=(x+y+z)*(j-1)+(y+x)*j)) do
     begin
     eco_state[l]:=-1;
     i:=i+1;
     l:=l+1;
     end;
   while ((l<=mxper) and (i>(x+y+z)*(j-1)+x*j) and (i<=(x+y+z)*(j-1)+(x+2*y)*j)) do 
     begin
     eco_state[l]:=0;
     i:=i+1;
     l:=l+1;
     end;
  while ((l<=mxper) and (i>(x+y+z)*(j-1) +(x+y)*j) and (i<=(x+2*y+z)*j) ) do
     begin
     eco_state[l]:=1;
     i:=i+1;
     l:=l+1;
     end;
   i:=1;
  end;
a[1]:=round(actobs*0.12);
a[2]:=actobs-a[1];
totavu:=a[1];
totavw:=a[2];
totemp:=totavw; (* needed unchanged at end of period *)
l:=0;
for i:= 1 to 2 do
  for j:= 1 to a[i] do 
   begin
   ms:=i-1;
   l:=j+a[1]*(i-1);
   duru[last,l]:=0;
   dure[last,l]:=0;
   duru[today,l]:=0;
   dure[today,l]:=0;
   k1:=genwage;
   pers[l]:=0;
   fstat[last,l].m:=ms;
   fstat[last,l].k:=k1;
   fstat[last,l].wn:=l;
   if ms=0 then
      begin  (* all occurences of 26 changed to yrwk may 31/96 lb*) 
       t1:=trunc(random(0)*(yrwk+1));
       if t1=0 then 
         begin
         n1:=trunc(random(0)*yrwk)+1;
         empstat[last,l]:=0; 
         end
        else
         begin
         n1:=0;
         empstat[last,l]:=1;
         end;
      end
    else  (* changed from if m=1 may30/96 lb *)
      begin
       t1:=trunc(random(0)*yrwk)+1;
      if t1=0 then writeln('t1 is zero!!!');
       (* following ch. from 26 - t1 to 26-t1+1 May 30/96 lb *)
       if t1<=(ent+reppen) then n1:=trunc(random(0)*(yrwk-t1+1))+t1
         else n1:=yrwk;
       (* else changed from following line may30/96 lb *)   
  (*     if (((t1>=10) or  (t1>round((ent)+3))) then n1:=26; *)

       if t1>n1 then t1:=n1; (* line moved down 1 in sequence May 30/96 lb *)
       if (n1=yrwk) then empstat[last,l]:=3
       else empstat[last,l]:=2; (* changed from if n1<26 may30/96 lb *)
       if n1=0 then writeln('m is 1 n1 is 0 !!! ',ms,k1,t1,n1,l); 
       end;
    with state[last,l] do
       begin
       m0:= ms;
       k:=k1;
       t:=t1;
       n:=n1;
       fn:=l;
       end;
 end;
(* initialize duration data *)
for i:=1 to actobs do
  for j:= 1 to 4 do
    for l:= 0 to 2 do
        dur[i,j,l]:=0;
if rwresk=1 then 
  begin
  reset(filek,fname_vec[resk_fname]);
  read(filek,resk);
  close(filek);
  reset(filei,fname_vec[indx_fname]);
  read(filei,indxf);
  close(filei);
  end;
end;



procedure translateopt;
begin
  finalrun:= round(option[5]);
  rwlambda:= round(option[9]);
  rwresk:= round(option[15]);
  quitpen:=round(option[20]);
  wmin:= option[21];
  rxben:=round(option[23]);
  ent:=round(option[24]);
  wmaxb:=round(option[25]);
  reppen:=round(option[27]);
  maxuid:=round(option[30]);
  actobs:=round(option[41]);
  mxper:=round(option[42]);
  startcnt:= round(option[43]);
  momwrite:= round(option[44]);
if wrpersrate=1 then finalrun:=1;
end;

procedure writels;
var aa: alpn_type;
begin with beliefs do begin

 (* writeln('Got to write in eqsim');*) 
 rewrite(outfile,fname_vec[newacc_fname]); 
writeln(outfile,'       lo        lr        lq       uew'); 
for aa:=-1 to 1 do
  begin
 writeln(outfile,offacc[aa]:8:6,' ',recacc[aa]:8:6,' ',quit[aa]:8:6,
' ',uew[aa]:8:6); 
  end;
 close(outfile); 
 rewrite(outfile,fname_vec[newoff_fname]); 
 writeln(outfile,'      lamr     lamo      lamj      laml'); 
for aa:=-1 to 1 do
  begin
   writeln(outfile,lamr[aa]:8:6,' ',lamo[aa]:8:6,' ',lamj[aa]:8:6,
      ' ',laml[aa]:8:6); 
  (* writeln(lamr[aa]:5:6,' ',lamo[aa]:5:6,' ',lamj[aa]:5:6,' ',laml[aa]:5:6);*)
  end;
  close(outfile); 
end; (* with *)
end;

procedure setextremes;
var aa: alpn_type;
begin with beliefs do begin

for aa:= -1 to 1 do 
  begin
  if (offacc[aa]=1) then offacc[aa]:=0.999999;
  if (offacc[aa]=0) then offacc[aa]:=0.000001;
  if (recacc[aa]=1) then recacc[aa]:=0.999999;
  if (recacc[aa]=0) then recacc[aa]:=0.000001;
  if (quit[aa]=1) then quit[aa]:=0.999999;
  if (quit[aa]=0) then quit[aa]:=0.000001;
  lo[aa]:=offacc[aa];
  lr[aa]:=recacc[aa];
  lq[aa]:=quit[aa];
  if (uew[aa]=1) then uew[aa]:=0.999999;
  if (uew[aa]=0) then uew[aa]:=0.000001;
  if (laml[aa]=1) then laml[aa]:=0.999999;
  if (laml[aa]=0) then laml[aa]:=0.000001;
  if (lamr[aa]=1) then lamr[aa]:=0.999999;
  if (lamr[aa]=0) then lamr[aa]:=0.000001;
  if (lamo[aa]=1) then lamo[aa]:=0.999999;
  if (lamo[aa]=0) then lamo[aa]:=0.000001;
  if (lamj[aa]=1) then lamj[aa]:=0.999999;
  if (lamj[aa]=0) then lamj[aa]:=0.000001;
  end;
  if (rwlambda=1)  then writels;

end; (* with *)
end;


procedure putnewpar;
var i: integer;
begin with beliefs do begin
(* writeln('in putnewpar'); *)
for i:= -1 to 1 do
  begin
  if (chkcyc[i]>perrec0[i]) then
  recacc[i]:=recacc[i]/(chkcyc[i]-perrec0[i])
  else
  recacc[i]:=0.0;
   if (chkcyc[i]>peroff0[i]) then
    offacc[i]:=offacc[i]/(chkcyc[i]-peroff0[i])
    else offacc[i]:=0.0;
 quit[i]:=quit[i]/chkcyc[i];
  uew[i]:=uew[i]/chkcyc[i];
  lamr[i]:=rectot[i]/chkcyc[i];
  lamo[i]:=offun[i]/chkcyc[i];
  lamj[i]:=offem[i]/chkcyc[i];
  laml[i]:=lay[i]/chkcyc[i];
  end;
end; (* with *)
end;

procedure calcmom;
var i, j,i1, j1: integer;
minmeanw,maxmeanw: real;
sumuesq, sumuisq, summwsq: areal_type;
begin 

with beliefs do begin

(* uew is already a mean for the state, uirs and mws are still totals *)
minmeanw:=10000;
maxmeanw:=0;
for i:= -1 to 1 do
  begin
  uirs[i]:=uirs[i]/chkcyc[i];
  if (chkcyc[i]-peremp0[i])>0 then
     mws[i]:=mws[i]/(chkcyc[i]-peremp0[i])
  else mws[i]:=0;
  j:=1+(i+1)*2;
  moments[j]:=uew[i];
  j:=j+6;
  moments[j]:=uirs[i];
  j:=j+6;
  moments[j]:=mws[i];
  sumuesq[i]:=0;
  sumuisq[i]:=0;
  summwsq[i]:=0;
  end;
j1:=0;
i1:=0; 
for j:= startcnt to mxper do
      begin
      j1:=j1+1;  
      i:=eco_state[j];
      sumuesq[i]:=sumuesq[i]+(uerate[j]-uew[i])*(uerate[j]-uew[i]);
      sumuisq[i]:=sumuisq[i]+(uirate[j]-uirs[i])*(uirate[j]-uirs[i]);
      if noemp[j]=0 then 
        begin
          i1:= i1+1;
        summwsq[i]:=summwsq[i]+(mwper[j]-mws[i])*(mwper[j]-mws[i]);
        if mwper[j]<minmeanw then minmeanw:=mwper[j];
        if mwper[j]>maxmeanw then maxmeanw:=mwper[j];
        end;
      end;
for i:= -1 to 1 do
  begin
  stdue[i]:=sqrt(sumuesq[i]/chkcyc[i]);
  stdui[i]:=sqrt(sumuisq[i]/chkcyc[i]);
  if (chkcyc[i]-peremp0[i])>0 then
    stdmw[i]:=sqrt(summwsq[i]/(chkcyc[i]-peremp0[i]))
   else stdmw[i]:=0;
  j:=2+(i+1)*2;
  moments[j]:=stdue[i];
  j:=8+(i+1)*2;
  moments[j]:=stdui[i];
  j:=14+(i+1)*2;
  moments[j]:=stdmw[i];
  end;
end; (* with *)
end;

procedure readresindx;
begin
reset(filek,fname_vec[resk_fname]);
read(filek,resk);
close(filek);
reset(filei,fname_vec[indx_fname]);
read(filei,indxf);
close(filei);
reset(filed,fname_vec[dec_fname]);
read(filed,dec);
close(filed);
end;

procedure setfiles;
 begin
rewrite(fileout,fname_vec[genpers_fname]);
rewrite(fileout1,fname_vec[rates_fname]);
rewrite(filedump,fname_vec[dump_fname]); 
end;


(****** MAIN :  if segment, main body of procedure simulate *********)
begin
setfiles;
  translateopt; (* translates from option vec to names used in segment *)
setup;
 for per:= 2 to mxper do
  begin
  perreset;
  for ff:= 1 to actobs do
    begin
(* reset offavail, then send out offers, choose randomly who receives it *) 
   firmdec1;  (* recalls and layoffs, count firms/people available for offers *)
    end;
  if cntoff>0 then
  for f2:= 1 to cntoff do
    begin
    ff:=giveoff[f2];
    firmdec2; (* send out offers, deal with new jobs *)
    end;
  putobsinf;
 putperinf;
  swap:=today;
  today:=last;
  last:=swap;
  end;
  putnewpar;
  if ((finalrun=1) or (momwrite=1)) then calcmom;
  setextremes; (* also rename probabilities to l's *)

close(fileout);
close(fileout1);
close(filedump);
end; 

.  (* end segment *)

