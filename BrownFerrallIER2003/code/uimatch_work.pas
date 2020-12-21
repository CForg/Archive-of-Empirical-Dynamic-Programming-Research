segment worker;
(* important kjr changed 03/04/95 now can have kjr=1 *)

const

%include ./uimatch.con

type

%include ./uimatch.typ

ref

%include ./var.def

%include ./uimatch.def

procedure worker;
  (* copied to sim6.pas on Nov. 2 1994, only change is to valunemp and valwk
   to make the job change or accept job only if vwk>vnwk, not vwk=vnwk, and 
   ditto for job change 
   
    copied from sim6 to sim7 on Nov 3. 1994, change is to valunemp, 
     making sequential recall and offer, also, change resk to 3xkxtxnxs 
     array 
 
    program update OCT. 26 1994 - includes an extra calculation of kres
    looping for t1=yrwk and t1prime=yrwk, because kres, before, was undefined
    for t1=yrwk, which caused a problem for people who became unemployed 
    with 26 weeks ui 

    this program solves for all states, and creates a file of all states 
     to be used to pick a random sample for `sim1.do', a revised version of 
     cwr6.do. It should only be solved for a number of periods, to make
     sure the changes made in both this file and cwrsim1.pas work.  It
     need not be used for the infinite horizon solution.

     this programs solve the search model for three states of the
     economy, denoted by the parameter alpn=alpha, which can be high, medium
     or low - important changes are: 1- the model solves until the 
     reservation values of k converge. 2- there are two extra dimensions
      to resk - was (m,k,t,n), is (time,m,k,t,n,a)
       where time=today,next,swap and  a = low,med,hi.
       3- similarly there is an extra dimension to v - was
       (time,m,k,t,n) is (time,m,k,t,n,a) while solving backward the
      expected value for the next period is a weighted average of
       EV(next,m,k,t,n,low),EV(next,m,k,t,n,med),EV(next,m,k,t,n,hi) - so,
      vnwk[low, med or high]<>vnwk[next,m,k,t,n,low med or high ] but
     p(low)*vnwk[low]+p(med) *vnwk[med]+p(high)*vnwk[high].  We therefore
     need the ALP loop inside the (m,k,t,n) loops. 

  this programs contains the possibility of getting a job offer on the
  job whether or not a layoff occurs,
  kminb is set to 1, may need to change this, wmin is 200, may also be
  too high with 32 hrs minimum for full-time employment  

*)

(* const   - moved to uewcon by CF feb 96 *)

var 
  wa,vlay: real;
  wrarray, wrval, ignoreval, checkvk, quitpen, maxuid: integer;
  kcheck,vcheck,kcheck2: boolean;
  rr,ben,tol,wmin : real;
  tstar_do,rundx,wmaxb : integer;
  today,next,swap: time_type;
  alpnb: alpn_type;
  dump,txx,tmax,tin,tmaxmax,tmins: integer;
  
  mprime: m_type;
  t2stp,t2start: m_type; 
  t1prime,t2prime,t2: integer; (* ST t2 included here *)
  n1prime: integer; (* can't use n_type because n1max|m=1<>n1max|m=0 *)
  kres,kjres: ak_type;
  kdat,kminb,kmaxb,k1prime: k_type;
  k2,k2prime: k_type; 
  s,stopn1,stopt1: integer;
  readv,ent,rxben,reppen,penqt,stopt2,stopk2,whp: integer; 
  vtwk,dwage: wage_type;
  v0,v0all,vtemp,valwr,valwres: areal_type;
  vwkn: real;
      (* on Chris's machine: for vn: use t_type, for vwk, use 1..26 (no 0) *)
  vnwknext: vnwk_type;
  vwknext: vwk_type;
(* needed for infinite model *)
   tresk: tresk_type;
   indx: am_type; 

m,t1, n1, k1: integer;
alpn, alpha: alpn_type;

(******** SECTION 2: PROCEDURES *********)


(************** 2.1 TRANSITIONS FUNCTIONS ***********)
(* t1 *)


procedure mm0prime0;
begin
t2:=0;
 if t2=0 then 
    begin
     t2prime:=0;
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
         end
    end
    else 
    begin
     t1prime:=t1;
     n1prime:=0;
     if (t2>0) then t2prime:=t2-1
     else t2prime:=0;
   end;

k2prime:=k2;
k1prime:=k1;
if (((t2prime=0) and (t1prime=0)) and ((t1=1) or (t2=1))) then n1prime:=1;
(* writeln(state_file,t1,t1prime,t2,t2prime,n1,n1prime);   *)
end; (*   mm0prime0 *)

(* moprime1: k1 must be found,k2p=k1,t1p=1,t2p=t1-, always ,n1p=n1+1 or 26 *)

procedure mm0prime1(var n1pr: integer);
begin
t2stp:=0;
         (* if ((t1>crit2) or ((s<=t1) and (t1>1))) then begin
            t2stp:=1;
           end;*)

(*???? when does t2prime get set??? *)
 
(* if (t1>0) then t2prime:=t1-1;
if t2prime<=0 then begin
  t2prime:=0;
  k2prime:=1 
end
else k2prime:=k2;
*)
n1pr:=n1+1;
if (n1pr>yrwk) then n1pr:=yrwk;
t1prime:=1;
end; 

procedure mm1prime0(nlay: integer);
(* make entreq and be read in at the right frequency *)
begin
if k1<kminb then t1prime:=0 
else
begin
  if (t1<=6) then (* first 26 weeks (here 4X6) get 1 week ui for each worked*)
    begin
    t1prime:=(t1+rxben);
    if ((n1>=yrwk) and (t1<=ent)) then t1prime:=0;
    if ((n1<yrwk)  and
       (t1<=(ent+reppen))) then t1prime:=0; (* need 8 wks extra if repeater really it's 6 *)
    end
    else t1prime:=6+round((t1-6)/2+rxben); (* if worked more than 6 per
                               get a half period for each period worked *)
(*    if ((tstar-(s+1)-t2) < t1prime) then t1prime:=tstar-(s+1)-t2; *)
    if (t1prime>maxuid) then t1prime:=maxuid
    else
     if t1prime<0 then 
       t1prime:=0;
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
if ((quitpen=1) and (nlay=1)) then t1prime:=0;
if ((t1prime>0)) (* not needed : and (k1>=kminb)) (* or ((t2prime>0) and (k2>kminb))) *)
then n1prime:=0;
end; 


procedure mm1prime1;
begin
if (t1<yrwk) then t1prime:=t1+1 else t1prime:=yrwk;
       (* if (((t2start=1) or (t1>10)) and (t2prime>0)) then t2prime:=t2-1
          else t2prime:=t2;
          if t2prime>tstar-(s+1) then begin
             t2stp:=1; 
             t2prime:=tstar-(s+1);
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
          (* while debugging, need n1max1 instead of entreq, DELETE AFTER *)
(* if (t1>=10) then n1prime:=yrwk; *)
end; 

(************* 2.2 CALCULATING RESERVATION WAGES *******)


  
function distwage(wage1: real): real;
begin
if wage1>wmin then
    distwage:=cdfn( (ln(wage1-wmin)-mu)/sigma )
  else distwage:=0;
end;


function getk(win: real):k_type; (* changed May 19/96 lb from int to k_type *)
var temp: integer;
begin
(* writeln(win:4:4,' ',wmin,' ',distwage(win):3:4); *)
temp:=round(0.5+nw*distwage(win));
(* writeln(temp); *)
getk:=temp;
end;



/*  
(* expected value of not working at Tstar *)
(* equation is : E(VT)=1/(1-b) [[lamo[alpn]+(1-lamo)F(wkr)]wkr+ *)
                            (*    (1-lamo)sum[kr to nw](pk wkr)] *)
*/

procedure reswT(var krest: k_type;
                var valtnw: real; alp11: alpn_type);
(* calculating reswage at T* using V(0) instead of EV(0) if person becomes
unemployed *)
var x,k,krestnew: integer;
    bott,part1,sumpk,fw,wrest,wrestnew: real;
begin with beliefs do begin

(* writeln(cw:6,lamo[alp11]:8,laml[alp11]:8,wmin:8); *)
sumpk:= 0;
krest:= 2;
wrestnew:= wage[krest];

  (* for k:=1 to nw do writeln(' w[',k:1,'] ', wage[k]);
      writeln;  *)
if alp11<>-1 then if alp11>0 then if alp11<>1 then writeln('ERROR ALPN ',alpn);
part1:= cw*(1-betaw*(1-laml[alp11]));
repeat
  x:=x+1;
  wrest:=wrestnew;
  sumpk:=0;
  for k:=(krest+1) to nw do sumpk:=sumpk+(1/nw)*wage[k];
  bott:=1-betaw*((1-laml[alp11])-lamo[alp11]*(nw-(krest))/nw);
  wrestnew:=(part1+betaw*lamo[alp11]*sumpk)/bott;
  if (wrestnew<wmin) then wrestnew:= wmin;
  fw:=distwage(wrestnew);
  if x<51 then krestnew:=round(nw*fw+0.5)
  else krestnew:=round(nw*fw+0.5);
  (*  wrestnew:=wage[krestnew];*)
  if krestnew>krest then krest:=krest+1;
  if krestnew<krest then krest:=krest-1;
  wrestnew:=wage[krest];
until (((krest*0.9999<krestnew) and (krest*1.0001>krestnew)) or (x>500));
 (*writeln(' kfinal ',krestnew,' wres ',wrestnew);*)
valtnw:= wrestnew/(1-betaw);
(*writeln(' Val(T) ',valtnw);*)
(* if x>500 then writeln('TOO MANY ITERATIONS ON WREST!!!!!!!!!!!');*)

end; (* with *) 
end;

function valtwk(wagein,val0t: real; al11: alpn_type): real;
var bott,top: real;
begin with beliefs do begin
  bott:= 1-betaw*(1-laml[al11]);
  top:= betaw*laml[al11]*val0t;
  valtwk:= (wagein+top)/bott;
end; (* with *)
end;

procedure getbenw( wage1, wage2: real;
                var ben: real); 
(* need only to calculate for t1=1 and keep for t1>1 if t2=0
and calc for t2=1 and keep for t2>1*)
begin
ben:=0;
t2:=0;
if t2=0 then begin     (*if statements changed by Chris 7/28/94 *)
   if ((t1=0) or (k1<kminb)) then 
      ben:=0
   else
      begin
      if (k1<=kmaxb) then ben:=wage1*rr
      else  ben:= wage[kmaxb]*rr;
      end;
 end  
 else begin
      if (k2<kminb) then  
         ben:= 0
      else
         begin
         if (k2<=kmaxb) then ben:= wage2*rr
         else ben:= wage[kmaxb]*rr;
         end;
end; 
end;


procedure getminmaxw;
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
(*s=1=>4538-4539,s=27 => 4590-4591, s=54 => 4644-4645, s=78 => 4694-4695 *)

begin
(* FOR NOW SET KMINB AT K:=2, WE MAY WANT TO KEEP IT AT K:=1 
  FOREVER, BY SETTING WMIN HIGH ENOUGH *)
/* if (s<27) then begin
   kminb:= getk((605*0.2));
   kmaxb:= getk(605.0);
end
else     (* if statements changed by Chris 7/28/94, *)
         (* numbers & weeks changed by Laura 17/9/94 *)
   begin
   if  (s<55) then 
     begin
     kminb:= getk((640*0.2));
     kmaxb:= getk(640.0);
     end
   else
     begin
     kminb:= getk((680*0.2));
     kmaxb:= getk(680.0);
     end;
   end;*/
KMINB:=getk((wmaxb*0.2));
(* kminb:=1; removed Feb 97 lb *)
kmaxb:=getk(wmaxb);
if dump=1 then  writeln(filedump,kminb,kmaxb);  
end;

procedure valunemp( valn0: real;
                   var v0: real;var k1res: k_type;var arec: m_type);

var refrec,sump,temp1,part1,part2,part3,part4: real;
k1p : integer;
k2p: k_type;
t1p,n1p: t1_type;
t2st: m_type;

begin with beliefs do begin

    k1p:=nw; (* set k1p to nw to start loop countdown *)
    sump:=0; 
      (* valn0 comes from last calculation of valunemp? without the benefit *)
    if t1>0 then getbenw(wage[k1], wage[k2], ben)
     else ben:=0;
     if ((t1>0) and (dump=1)) then writeln(filedump,k1:3,' ben ',ben:4); 
       (* k1 don't know,k2=k1,t1=1,t2p=t1 *)
    mm0prime1(n1p);
    repeat                                             (* find w* new offer *)
          (* k1p:=k1p-1 moved because if valn0>vwk[1] then kr=2,
            with k1p at top and until k1p=1 or.. would get kr=1 *)
          temp1:= 1/nw*vwk[next,k1p,1,n1p,alpn];
           sump:= 1/nw*vwk[next,k1p,1,n1p,alpn]+sump;
   (*   if ((n1=0) and (k1=1)) then writeln(' k1 ',k1:3,' k1p ',k1p:3,' valn0 ',valn0:6:2,' vwk[k1p] ',vwk[next,k1p,1,n1p,alpn]:6:2); *)
          k1p:=k1p-1;(* moved May 17/95 *)
    until ((k1p=0) or (valn0>vwk[next,k1p,1,n1p,alpn]));       
(*    sump:= k1p/nw*valn0+(sump-temp1);*)
    sump:= (k1p)/nw*valn0+sump; (* change May 7, 1995, go with acc kr *)
    k1res := k1p+1;
                                              (* point to w* *)
 (*THINK! if it is lamo[alpn]*Ev0[alpn]+(1-lamo[alpn]v0[alpn] do I need to sum over all states, or do I just do this one, since when I make the decision I know which state I am in.  I think it is 2. *)
     refrec:=lamo[alpn]*sump+(1-lamo[alpn])*valn0; (* expected value of offer *)
    
 (*   if (refrec<vwk[next,k1,1,n1p,alpn]) then            take recalled job *)
     if (refrec<=vwk[next,k1,1,n1p,alpn]) then (* May 7/95 take recalled job *)
      begin                  (* if accept recall can't take job *)
        (* if concurrent offer&recall have 
                           lr*lo*(k1/nw*vwk[next,k1,1,n1p,alpn]) *)   
       part4 := lamr[alpn]*vwk[next,k1,1,n1p,alpn];
       part3 := 0;  (* changed lb 17/6/96 before had lamr(1-lamo+lamo) split *)
       arec:=1;     
       end
    else   (* if statement is indicator function  don't take recall *)
       begin
       part4 := lamr[alpn]*lamo[alpn]*(sump);
       part3 := (1-lamo[alpn])*lamr[alpn]*valn0;
       arec:=0;
       end;
    part2:= lamo[alpn]*(1-lamr[alpn])*sump;
    part1:= (1-lamo[alpn]) * (1-lamr[alpn]) * valn0;
    v0:= cw+ben+betaw*(part1+part2+part3+part4)*(1-lamd);
(* if (( k1=1) and (n1=0) and (t1<3)) then writeln('k1  ',k1:3,' ',' t1 ',t1:3,' n1p ',n1p:3,' kres ',k1res:3,' valn0 ',valn0:5:3,' vwkn ',vwk[next,k1,1,n1p,alpn]:5:3); *)
end; (* with *)
end; (* valunemp *)


procedure valwk(vwkp,w: real; vnwkp:real; vnwkl: real; var kjr : k_type; var workd: m_type; var valwork: real);
            (* use this for wres and valwk using vwk>=vnwk, not vwk>vnwk *)
var
  temp1,
  maxpart,maxw,maxwj,
  sump,sumjo,sumjl,
  part1,part2,part3,part4,
  v1: real;
  kj,kjl : integer;
begin with beliefs do begin
(* if ((n1<3) and (k1=1) and (t1<4)) then writeln(' in valwk t1 ',t1:3,' vwkp vnwkp ',vwkp:6
:2,'
 ',vnwkp:6:2,' wage ',w:5:2); *)
    if vwkp>=vnwkp then (* these represent the vwk,vnwk for each alpha *)
      begin
      maxpart:=vwkp;
      workd:=1;
      end
     else
       begin           (* first determine if would quit or not *)
       maxpart:=vnwkp;
       workd:=0;
       end;
    sumjo:=0;
    kj:=nw;
    repeat
        sumjo:=sumjo + 1/nw*vwk[next,kj,t1prime,n1prime,alpn];
        temp1:= 1/nw*vwk[next,kj,t1prime,n1prime,alpn];
      (* if ((k1=1) and (n1=1) and (t1<4)) then writeln(' kj ',kj:3,' t1 ',t1:3,' vwknext ',
vwk[next,kj,t1prime,n1prime,alpn]); *)
          kj := kj - 1;
    until (kj<1) or (maxpart>=vwk[next,kj+1,t1prime,n1prime,alpn]);
    if vwkp>=vnwkp then (* added lb DEC 96 to handle quit/no quit difference *)
    begin
    maxw:=(kj+1)/nw*maxpart;  (* if keep job, then at kr don't change job *)
    sump:=sumjo-temp1;
    sumjl:=(sumjo-temp1); (* sumjl is ev of offer on job greater than existing wage *)
    end
    else
    begin      (* if quit, then at kr take job *)
    maxw:=kj/nw*maxpart;  (* if kj=0 then maxw = 0 *)
    sump:=sumjo;
    sumjl:=(sumjo); (* sumjl is ev of offer >= non-wage income *)
    end;

(* kj+1 must be >= than k1 ? *)
if kj+1<k1 then writeln('k = 0 ');
   kj:=kj+1;
           (* kj has been decrease by 1, without the sum incremented *)
    kjl:=kj;  (* kj is res wage if choose to quit, kjl is res wage if
                 choose to keep job rather than quit, i.e. res wage if
                 face a forced layoff *)
    if ((vwkp>=vnwkp) and (kjl>0)) then  (* changed from 1 to 0 dec 96 lb *)
      begin
        repeat
         v1 := vwk[next,kjl,t1prime,n1prime,alpn];  (* value of taking job *)
         kjl:=kjl-1;
         sumjl:=sumjl + 1/nw*v1;
        until (kjl<1) or (vnwkp>=v1);  (* changed JULY 96 so that kjl okay *)
        kjl:=kjl+1;
      end;
    maxwj:=(kjl-1)/nw*vnwkp; (* moved outside if Aug 31/96 lb *)
    part1:=laml[alpn]*lamj[alpn]*(maxwj+sumjl); (* take new job or unemployment *)
    part2:= laml[alpn]*(1-lamj[alpn])*vnwkp; (* become unemployed *)
    part3:= (1-laml[alpn])*lamj[alpn]*(maxw+sump); (* keep job, quit or new job *)
    part4:= (1-laml[alpn])*(1-lamj[alpn])*maxpart; (* keep job or quit *)
    valwork:=w+betaw*(part1+part2+part3+part4)*(1-lamd);
    (* if kres>k1, then person will quit job,
    if kres<k1, then person will not quit but if
    layed off, will accept job as low as kres *)
(*    if (kjl<nw) then kjr := kjl+1
    else kjr:=nw; *)  (* point to res. wage, can't equal nw *)
(*   kjr:=kjl+1;(* change 03/04/95 from kjl+1 so kjr can equal 1 at times  *)
              (* changed back July 96 *)
 (* if kjr=1 then writeln('at end of valwk kjr, kjl ',kjr:3,kjl:3);*)
     kjr:=kjl;
end; (* with *)
end;






/*
procedure reswage;

(* ST var  k,k1l,k2l,k3l,t1l,t2l,n1l: integer; *)
var  k,k1j,k2,k3,t1j,t2,n1j: integer;

begin
for n1j:= 0 to yrwk do begin
  for k1j:=1 to nw do begin
          k:= 1;
          for t1j:=0 to yrwk do begin
               (* ST     while ((k<=nw) and
                  (vnwk[today,k1j,k2,t1j,t2,n1j,alpn]>vwk[today,k,k1j,1,t1j,n1j,0,alpn])) do *)
              mm0prime1(n1prime); 
              while ((k<=nw) and (vnwk[today,k1j,t1j,n1j,alpn]>vwk[today,k,1,n1prime,alpn])) do
                  k:= k+1;
              tresk[today][m,k1j,t1j,n1j,alpn]:=k-1;     (* resk[k1,k2,t1,t2,n1]:=k-1; *)
              if k>1 then k:= k-1; (* start next loop at kres for t1old *)
           end;
  end;      
end;
end; (*reswage*)
*/



function comparev: boolean;
var 
compk: boolean;
al1,al: alpn_type;
mm: m_type;
kk,tt,nn: integer;
i1: integer;
begin
compk:=true;
nn:=0;
 repeat 
  tt:=0;
  repeat
    kk:=1;
    repeat
      for al1 := -1 to 1 do
        begin
        if ((tt>0) and (nn>0) and ((tt<=10) or (nn=yrwk))) then 
          if (nn>=tt) then
          begin
          mm:=1;
         if ((vwk[today,kk,tt,nn,al1]/vwk[next,kk,tt,nn,al1]<(1-tol)) or
           (vwk[today,kk,tt,nn,al1]/vwk[next,kk,tt,nn,al1]>(1+tol))) then
           begin
            if dump=1 then
writeln(filedump,mm:3,kk:3,tt:3,nn:3,' ',vwk[today,kk,tt,nn,al1],' ', vwk[next,kk,tt,nn,al1]);   
            compk:=false;
            end;
          end;
        if ( (tt<=stopt1) and (compk=true) and ( ((tt>0) and (nn=0)) or
         ((tt=0) and (nn>0)) ) ) then 
          begin
          mm:=0;
          if ((vnwk[today,kk,tt,nn,al1]/vnwk[next,kk,tt,nn,al1]<0.9995) or
            (vnwk[today,kk,tt,nn,al1]/vnwk[next,kk,tt,nn,al1]>1.0005))
             then begin
            if dump=1 then 
writeln(filedump,mm:3,kk:3,tt:3,nn:3,' ',vnwk[today,kk,tt,nn,al1],' ', vnwk[next,kk,tt,nn,al1]);  
             compk:=false; 
             end;
          end;
        end;

          kk:=kk+1;
        until ((kk > nw) or (compk=false));
     tt:=tt+1;
    until ((tt > yrwk) or (compk=false));
    nn:=nn+1;
  until ((compk<>true) or (nn>yrwk));

(* writeln(filedump,tmins,' ',mm:3 ,kk:3, tt:3, nn:3,' ',kminb:3,kmaxb:3); *)
comparev:=compk;
end;

procedure meanv;
var
al1,al: alpn_type;
mm: m_type;
kk,kk2,tt,nn: integer;
begin
  for kk:=1 to nw do
    for tt:= 1 to yrwk do
       for nn:= 0 to yrwk do
         for al:= -1 to 1 do
           begin
           vnwk[today,kk,tt,nn,al]:=vnwk[next,kk,tt,nn,al]+vnwk[today,kk,tt,nn,al]/2;
          if nn>0 then vwk[today,kk,tt,nn,al]:=vwk[next,kk,tt,nn,al]+vwk[today,kk,tt,nn,al]/2;
           end;
end;


function comparek: boolean;
var 
compk: boolean;
al1,al: alpn_type;
mm: m_type;
kk,kk2,tt,nn: integer;
i1: integer;
begin
compk:=true;
nn:=0;
 repeat 
  tt:=0;
  repeat
    kk:=1;
    repeat
      for al1 := -1 to 1 do
        begin
        if ((tt>0) and (nn>0) and ((tt<=10) or (nn=yrwk))) then 
          if (nn>=tt) then
          begin
          mm:=1;
             if tresk[today][mm,kk,tt,nn,al1]=nw then kk2:=nw;
          if tresk[today][mm,kk,tt,nn,al1]<>tresk[next][mm,kk,tt,nn,al1] then
            begin
if dump=1 then  writeln(filedump,mm:3,kk:3,tt:3,nn:3,' ',tresk[today][mm,kk,tt,nn,al1],' ', tresk[next][mm,kk,tt,nn,al1]);    
            compk:=false;
            end;
          end;
        if ( (tt<=stopt1) and (compk=true) and ( ((tt>0) and (nn=0)) or
         ((tt=0) and (nn>0)) ) ) then 
          begin
          mm:=0;
          if tresk[today][mm,kk,tt,nn,al1]=nw then kk2:=nw;       
          if (tresk[today][mm,kk,tt,nn,al1]<>tresk[next][mm,kk,tt,nn,al1])
            then begin
              if dump=1 then 
  writeln(filedump,mm:3,kk:3,tt:3,nn:3,' ',tresk[today][mm,kk,tt,nn,al1],' ', tresk[next][mm,kk,tt,nn,al1]);    
             compk:=false; 
             end;
          end;
        end;
          kk:=kk+1;
        until ((kk > nw) or (compk=false));
     tt:=tt+1;
    until ((tt > yrwk) or (compk=false));
    nn:=nn+1;
  until ((compk<>true) or (nn>yrwk));
(* writeln(filedump,tmins,' ',mm:3 ,kk:3, tt:3, nn:3,' ',kminb:3,kmaxb:3); *)
(* writeln('kcheck',compk); *)
comparek:=compk;
end;


procedure lastperiod;
var al1, alpn2 : alpn_type;
  kk1,tt1,nn1: integer;
begin
(* In the last period, we solve for values of kres for each state,
  this is nw * 3 for m=1, 3 for m=0  *)
  for al1:= -1 to 1 do 
    begin
    valwres[al1]:=0;
    v0all[al1]:=0;
    end;
  for al1:= -1 to 1 do
   begin
 (*  we are assuming at this point that we remain in same state forever.  If we don't, we have to iterate till I dont' know when.  We may just want to set kres=1 and go until it doesn't matter, since
we are solving until it doesn't matter anyway. *)

   reswT(kres[al1],valwr[al1],al1); (* at this point valwr is (v|alpn2) *)
     for alpn2:= -1 to 1 do
      valwres[alpn2]:=valwres[alpn2]+palp[alpn2,al1]*valwr[al1];
    (* writeln(filedump,'valwres ',valwres[al1],' v|a ',valwr[al1]); *)
   end;
(*   for al1:= -1 to 1 do writeln(filedump,'valwres ',valwres[al1],' v|a ',valwr[al1]); *)
  for kk1 := 1 to nw do
      begin 
       for tt1 := 0 to yrwk do
          for nn1 := 0 to yrwk do
            for al1:= -1 to 1 do
              begin
              vnwk[next,kk1,tt1,nn1,al1] := valwres[al1];
              vnwk[today,kk1,tt1,nn1,al1] := valwres[al1];
              end;
      for alpn2:= -1 to 1 do v0all[alpn2]:=0;
      for al1:= -1 to 1 do
         begin
          vtemp[al1]:=valtwk(wage[kk1],valwres[al1],al1);
           (* use v0all because don't need it till next period, coult
              or should call it v1all *)
          for alpn2 := -1 to 1 do
           v0all[alpn2]:=v0all[alpn2]+palp[alpn2,al1]*vtemp[al1];
         end;
      for al1:= -1 to 1 do
         begin
          vwk[next,kk1,1,1,al1]:=v0all[al1];
         (*  writeln(filedump,'vwk ',vwk[next,kk1,1,1,al1],' k1 ',kk1); *)
           for tt1 := 1 to yrwk do
              for nn1 := 1 to yrwk do
                  begin
                   vwk[next,kk1,tt1,nn1,al1]:=vwk[next,kk1,1,1,al1];
                  end;
         end;
       end;
end; (* last period *)


procedure translateopt;
begin
  tin:=round(option[11]);
  tol:=option[12];
  readv:=round(option[13]);
  tmaxmax:=round(option[14]);
  wrarray:=round(option[15]);
  wrval:=round(option[16]);
  ignoreval:=round(option[17]);
  checkvk:=round(option[18]);
  dump:=round(option[19]);
  quitpen:=round(option[20]);
  wmin:=option[21];
  rr:=option[22];
  rxben:=round(option[23]);
  ent:=round(option[24]);
  wmaxb:=round(option[25]);
  reppen:=round(option[27]);
  maxuid:=round(option[30]);
end;


procedure readval;
  begin
  reset(filev,fname_vec[vwk_fname]);
  read(filev,vwk);
  close(filev);
  reset(filevn,fname_vec[vnwk_fname]);
   read(filevn,vnwk);
 close(filevn);
  end;

procedure writearray;
var aa,nn,kk,mm,tt: integer;
begin
(* if dump=1 then  *)
   for mm:= 0 to 1 do
     for nn:= 0 to yrwk do
       for kk:= 1 to nw do
        for aa:=-1 to 1 do
           begin
           write('m ',mm:2,' k ',kk:2,' n ',nn:2,' s ',aa:2,' '); 
           for tt:= 0 to yrwk do
           write(resk[mm,kk,tt,nn,aa]:3,' '); 
           writeln;
           end; 
rewrite(filek,fname_vec[resk_fname]);
write(filek,resk);
close(filek);
rewrite(filei,fname_vec[indx_fname]);
write(filei,indxf);    
close(filei);
end;

procedure writeval;
begin
rewrite(filev,fname_vec[vwk_fname]);
write(filev,vwk);
close(filev);
rewrite(filevn,fname_vec[vnwk_fname]);
write(filevn,vnwk);
close(filevn);
end;


(* MAIN PART OF SEGMENT *)

begin with beliefs do begin

  rewrite(filedump,fname_vec[dump_fname]);
  kcheck:=false;
  vcheck:=false;
(*   choosepar;  not used in calibrated model *)
  translateopt;
  tmax:=tin;
  t2:=0;
  k2:=1;
  today := thisper;
  next := nextper;
  tresk[today]:=resk;
  tresk[next]:=resk;
  for k1:=1 to nw do begin
      dwage[k1]:=distwage(wage[k1]);
      end;

if (readv=1) then readval; 
(* trying to initialize in main instead of here 
readval else  lastperiod ; <-- old command *)

getminmaxw;
(************* Remainder of time periods **************)
(* need to use tstar-s instead of s,because must count forward *)
Tmins:=0;
repeat
 tmins:=tmins+1;
 (*for Tmins:= 1 to tstar_do -1 do  
    begin *)
 stopt1:=yrwk;
 if ((tmins<yrwk) (* and (readv=0) *)) then 
   stopt1:=tmins
    else stopt1:=yrwk;
 for n1:=0 to yrwk do 
    begin
    for t1:= 0 to stopt1 do 
      begin
      for k1:=1 to nw do 
        begin

(* IMPORTANT:  I have overlooked this several times:
 mm0prime0 MUST be called before each VALWRES, and before assigning KRES !
 the values of t1prime, n1prime are changed in valunemp *) 
              (* mm0prime0 gives pointer for evnwk, we know mprime=0 *)
              (* mm0prime1 used in function valunemp, not here *)
              if ( (t1<=stopt1) and ( ((t1>0) and (n1=0)) or
                ((t1=0) and (n1>0)) ) ) then 
                begin
                 m:=0;
                 (* initialize v0all[alpn] before each m,k,t,n calculation *)
                 for alpn:= -1 to 1 do v0all[alpn]:=0;
                 for alpn:= -1 to 1 do
                   begin
                    mm0prime0;
                    valwres[alpn]:=vnwk[next,k1,t1prime,n1prime,alpn];
                    valunemp(valwres[alpn],v0[alpn],kres[alpn],indx[alpn]);
                    for alpha:= -1 to 1 do
                       v0all[alpha]:=v0all[alpha]+palp[alpha,alpn]*v0[alpn];
                   end;
                 for alpn:= -1 to 1 do
                   begin
                    vnwk[today,k1,t1,n1,alpn]:=v0all[alpn];
                    (* mm0prime0(k1prime,k2prime,t1prime,t2prime,n1prime);*)
                    (* for infinite solution only *)
                    indxf[k1,t1,n1,alpn]:=indx[alpn]; 
                    tresk[today][m,k1,t1,n1,alpn]:=kres[alpn]; 
                   end;
                 (* if t1=stopt1 then
                   for alpn:= -1 to 1 do
                     begin
                    mm0prime0(k1prime,k2prime,t1prime,t2prime,n1prime);
                     t1prime:=t1;
                     valwres[alpn]:=vnwk[next,k1,t1prime,n1prime,alpn];
                     valunemp(valwres[alpn],v0[alpn],kres[alpn],indx[alpn]);
                     indxf[k1,t1,n1,alpn]:=indx[alpn];
                     tresk[today][m,k1,t1prime,n1prime,alpn]:=kres[alpn]; *)
       (* if tmins>tmax then  writeln(filedump,m:3,k1:3,t1:3,n1:3,t1prime:3,  
      n1prime:3,' vnwk ',v0all[alpn]:8:4,' ',' kres ',kres[alpn]:3,
                         tresk[next][m,k1,t1prime,n1prime,alpn]:3); *)
    (*                 end;   *)
                (* if s=10 then
                   begin
                    mm0prime0(k1prime,k2prime,t1prime,t2prime,n1prime); 
                    writeln(state_file,rundx:3,' ',betaw:4:3,' ',c:5:1,
                          ' ',lamo[alpn]:4:3,' ',laml[alpn]:4:3,' ',lamj[alpn]:4:3,' ',mu:5:4,' ',sigma:3:4,
                          ' ',s:2,' 0 ',k1:2,' ',t1:2,' ',n1:2,
                          ' ',vnwk[today,k1,t1,n1,alpn]:7:1,' ',s+1:2,
				  ' ',t1prime:2,' ',n1prime:2,' ',kres:2,
				  ' ',ben:4:1,' ',valwres[alpn],' .'); 
			   end; *)
	         end; (* if loop for m=0 *)
		      (* if condition changed from ((t1<=10) or (n1<=n1max1))
			to what is shown below, by Laura, Sept. 27,94 *)
                   (* entreq changed to ent 3 to 2 may31/96 to reppen 17/06/96*)
		     if ((t1>=1) and (n1>=1) and ((t1<=ent+reppen) 
			   or (n1=yrwk))) then 
			if (n1>=t1) then
			begin
			 m:=1;
			 for alpn:= -1 to 1 do v0all[alpn]:=0;
			 for alpn := -1 to 1 do
			  begin
			    mm1prime0(1);
		   valwres[alpn]:=vnwk[next,k1,t1prime,n1prime,alpn];
                            mm1prime0(0);
                   vlay:=vnwk[next,k1,t1prime,n1prime,alpn];
	   if valwres[alpn]=0 then writeln(filedump,k1,t1prime,n1prime);
			   mm1prime1;
			   vwkn:=vwk[next,k1,t1prime,n1prime,alpn];
             (* writeln(' in main bef valwk k1 ',k1:3,' wage ',wage[k1]:5:3); *)
	   valwk(vwkn,wage[k1],valwres[alpn],vlay,kjres[alpn],indx[alpn],v0[alpn]);
		   for alpha:= -1 to 1 do
		     v0all[alpha]:=v0all[alpha]+palp[alpha,alpn]*v0[alpn];
			 end;
			 mm1prime1;
			 for alpn:= -1 to 1 do
			  begin
			   (*writeln(m:3,k1:3,t1:3,n1:3); *)
			   vwk[today,k1,t1,n1,alpn]:=v0all[alpn];
			  resk[m,k1,t1,n1,alpn] := kjres[alpn];
			   tresk[today][m,k1,t1,n1,alpn]:= kjres[alpn]; 
			  end;
(* if tmins> tmax  then writeln(filedump,m:3,k1:3,t1:3,n1:3,t1prime:3,n1prime:3,
 ' vnwk ',valwres[alpn]:7:3,' vwkold ',vwk[next,k1,t1prime,n1prime,alpn]:7:3,
		     ' vwk ',v0all[alpn]:7:3,' ',' kjres ',kjres[alpn]:3,
			       tresk[next][m,k1,t1,n1,alpn]:3); *)
		    (*   if s=10 then
			   begin
   if want to check the solution method with this specification, need alpnn
 in regr.raw, but don't need it for sample because will always solve for all
  three states, since need them for previous value function, and once one is
  solved for, the other two are trivial *)
		   (*   writeln(state_file,rundx:3,' ',betaw:4:3,' ',cw:5:1,
		   ' ',lamo[alpn]:4:3,' ',laml[alpn]:4:3,' ',lamj[alpn]:4:3,
	   ' ',mu:3:4,' ',sigma:3:4,' ',s:2,' 1 ',k1:2,' ',t1:2,' ',n1:2,' ',
			   ' ',vwk[today,k1,t1,n1]:7:1,' ',s+1:2,   
			   ' ',t1prime:2,' ',n1prime:2,' ',kjres:2,
			   ' ',wage[k1],' ',valwres:6:1,' ',vwkn:6:1); 
			   end; *)
                      end;
		  end;
	       end;
	    end; (* for n1:= 0 to yrwk ST *)

	  if tmins>=tmax then
	    begin
	    kcheck:=comparek;
	    vcheck:=comparev; 
	    if ((vcheck=false) and (tmax<tmaxmax)) then 
	      begin
	       tmax:=tmax+tin;
	       (* writeln('augmented tmax, now tmax = ',tmax); *)
	       end;
	    if ((vcheck=false) and (tmax<=tmaxmax)) then
		meanv;
	    end;
	  swap:=next;
	  next:=today;
	  today:=swap;
	until (((vcheck=true) (*and (kcheck=true)*) ) or (tmins>tmaxmax));
	(*  writeln('filedump ','kcheck ',kcheck,' vcheck ',vcheck,' tmins ',tmins,'tmax',tmax);*)
	close(filedump);
        resk:=tresk[today];
	if wrarray=1 then writearray;
	if wrval=1 then writeval;
	if checkvk=1 then 
          begin
          rewrite(outfile,fname_vec[checkvk_fname]);
       	  write(outfile,kcheck);
	  write(outfile,vcheck);
	  close(outfile);
          end;
	end; (* with *)
	end;
	.
	(* END PROGRAM *)


