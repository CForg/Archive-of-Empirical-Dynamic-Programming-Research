segment firm;


(* this program is substantially changed to correct errors and to prepare 
output of a decision array to be used in the economy simulation *)

const

% include ./uimatch.con

type

%include ./uimatch.typ

ref
%include ./var.def

%include ./uimatch.def

procedure firm;

static

  val : val_type;
  dectime:  dectime_type;

  deco,       (* prob. outside offer is made (endogenous) as fn of state *)
  ue       : StateArray;
  ewage, epdwg, (* expected value of the wage *)
  adjw,  (* adjust wage after normalization *)
  tau  (* tax rate on UI that will be removed in simulation *)
    : real; 
  
  eps,       (* vector of idiosyncratic shocks *)
  pep        (* probability of shocks *)
        : epsArray;
  next, now, dum : m_ind_type;
  evt : real;
   k,k1: k_type;
  rwdec: integer;

(*********** Procedures **************)

procedure iterate;
(*   perform one iteration on value function *)
var
   old : 0..1;
   dd,k,k1 : integer;
  s, s1 : stt_ind_type;
   ep, ep1        : eps_ind_type;
   vv, v0,v1,v2,v3 : real;
begin
 with beliefs do 
  begin
    (* loop over aggregate states today *)
for s := -1 to 1 do
    begin
    deco[s] := 0.0;
        (* loop over idiosyncratic shocks today *)
(* so, we loop over today's shocks, for each of today's state and shock (and k)
there is an optimal choice.  This choice takes into account the expected value
of next year's shock and state.  But next year's status of employment and wage
 is the optimal value of the best choice given tomorrow's shocks.
Contrasted to the worker's problem, the firm  makes a decision, and then, once the 
max is chosen, there is a probability of an outcome .  It is closer to the
situation where the worker has a recall than when the worker has a job offer *)

(* k:=nw; *)
k1:=nw; (* initialize , ktemp, k1 when shm=1 *)
  for ep := 1 to neps do
    for k := 1 to nw do  
        begin
            (* m= 0 *)
        v0 := 0.0;                      (* job remains unfilled *)
        v1 := (1/shm*wage[k]-(1-tau)*pdwg[k]+prf[s]+eps[ep])*lr[s];  
                           (* recall attempted no offer posted*)
(* following changed by lb june 17/96 added v1 instead of (ewagepart)*lr[s] *)
     v2 := (1/shm*ewage-(1-tau)*epdwg+prf[s]+eps[ep])*(lo[s])-c;
     v3 :=  (1/shm*ewage-(1-tau)*epdwg+prf[s]+eps[ep])*((1-lr[s])*lo[s])-c*(1-lr[s])+v1;
   
                                        (* recall attempted and offer 
                                           posted if necessary *)

(*  if ((s=-1) and (k=2) and (ep=7)) then *)
(* if dum=0 then
begin  
  writeln('outer lp k ',k:3,' ep ',ep:3,' s ',s:3,'v0 ',v0:5:3,' v1 ',v1:5:3,' v2 ',v2:5:3);
   writeln('prf ',prf[s]:4:4,' eps ',eps[ep]:4:4,' lr ',lr[s]:4:4,' lo ',lo[s]:4:4,' (1-shm)M ',(1-shm)/shm*wage[k]:3:3,' ld ',ld:3:3);   
end; *)
              (* calculate expected value over tomorrow's states *)

        for s1 := -1 to 1 do
          for ep1 :=  1 to neps do 
            begin
(* v0 is the profit of an unfilled job *)
            v0 := v0 + beta*ps[s,s1]*pep[ep1]*val[next,0,k,ep1,s1]*(1-ld);
 (* if ((s=-1) and (ep>3)) then writeln(' v0 ',v0:5:3,' ps ',ps[s,s1]:3:3,' pep ',pep[ep1]:3:3,
' valnx0 ',val[next,0,k,ep1,s1]:5:3,' 1-ld ',1-ld); *)
(* v1 is the profit of a job filled by recall *)
(* changed v2 09/05/95 by lb to add part for when recall is accepted *)
(* changed v1 and v2 18/06/96 lb from lamd+(1-.. to lamd+(1-lamd)(1-.. *) 
            v1 := v1 + beta*ps[s,s1]*pep[ep1]
                    *(lr[s]*val[next,1,k,ep1,s1]*(1-lamd)
                    + (lamd+(1-lamd)*(1-lr[s]))*val[next,0,k,ep1,s1]*(1-ld));
(* v2 is the profit of a job filled by an offer *)
           for k1:= 1 to nw do   
(* NOTE:  if looping over k need to multiply beta by (1/nw), if not, must take
that out! *)
            v2 := v2 + beta*1/nw*ps[s,s1]*pep[ep1]
                     *( lo[s]*val[next,1,k1,ep1,s1]*(1-lamd)
             +(lamd+(1-lamd)*(1-lo[s]))*val[next,0,k,ep1,s1]*(1-ld));

            v3 := v3 + beta*1/nw*ps[s,s1]*pep[ep1]
                       *(lr[s]*val[next,1,k,ep1,s1]*(1-lamd)
                     +lo[s]*(1-lr[s])*val[next,1,k1,ep1,s1]*(1-lamd)
             +(lamd+(1-lamd)*(1-lo[s])*(1-lr[s]))*val[next,0,k,ep1,s1]*(1-ld));

(* if s=-1 then writeln('in loop k ',k:3,' ep1 ',ep1:3,' s ',s:3,'v0 ',v0:5:3,' v1 ',v1:5:3,' v2 ',v2:5:3); *)
           end;
            (* find optimal choice *)
      if ((v0 >= v1) and (v0>=v2) and (v0>=v3)) then
         begin
         vv := v0;
         dd := 0;
         end
        else
         begin
         if ((v1 >= v0) and (v1 >= v2) and (v1>=v3)) then
            begin
            vv := v1;
            dd :=1;
            end
          else
           begin
           if ((v3>= v0) and (v3 >= v1) and (v3>=v2)) then
              begin
              vv := v3;
              deco[s] := deco[s]+pep[ep];
              dd :=3;
              end
             else
              begin
              vv := v2;
              deco[s] := deco[s]+pep[ep];
              dd :=2;
              end;
           end;
         end;
        val[now,0,k,ep,s] := vv;      (* updated value function *)
        dectime[now][0,k,ep,s] := dd;    (* updated decision array *)
(* if ((k=10) and (ep=10) and (s=1)) then *)
(* if ((rwdec=1) and (dum=0))  then writeln(' now next  1 ',' k ',k:3,' ep ',ep:3,' s ',s:3,' dec ',
dectime[now][1,k,ep,s]:3,' ',dectime[next][1,k,ep,s]:3,' val ',val[now,1,k,ep,s]:7:0,' ',val[next,1,k,ep,s]:7:0);  *)

        (* m = 1 *)
        v0 := 0.0;                         (* layoff worker - job unfilled *)
        v1 := (prf[s]+1/shm*wage[k]-(1-tau)*pdwg[k]+eps[ep])*(1-lq[s]);  (* retain worker who might quit *)
            (* calculate expected value *)
(* changed v1 18/06/96 by lb from lamd+lq to lamd+(1-lamd)*lq *)
        for s1 := -1 to 1 do
          for ep1 :=  1 to neps do
            begin
            v0 := v0 + beta*pep[ep1]*ps[s,s1]*((val[next,0,k,ep1,s1])*(1-ld));
            v1 := v1 + beta*pep[ep1]*ps[s,s1]
                       *((lamd+(1-lamd)*lq[s])*val[next,0,k,ep1,s1]*(1-ld)
                       + (1-lq[s])*(1-lamd)*val[next,1,k,ep1,s1]);
            end;
            (* calculate optimal choice when job filled *)
       if (v0>v1) then
           begin
           vv := v0;
        (*   laml[s] := laml[s]+pep[ep]; *)
           dd:=0;
           end
        else
           begin
           vv := v1;
           dd:=1;
           end;
        val[now,1,k,ep,s] := vv;    (* updated value function *)
        dectime[now][1,k,ep,s] := dd;    (* updated decision array *)
      (* if ((s=1) and (ep>7) and (k>2)) *)
(* if ((k=10) and (ep=10) and (s=1)) then *)
(* if ((rwdec=1) and (dum=0))  then writeln(' now next  1 ',' k ',k:3,' ep ',ep:3,' s ',s:3,
' dec ',dectime[now][1,k,ep,s]:3,' ',dectime[next][1,k,ep,s]:3,' val ',val[now,1,k,ep,s]:7:0,' ',val[next,1,k,ep,s]:7:0); *)

        (* new jobs *)

        (* m= -1 *)
        v0 := 0.0;                      (* job remains unfilled *)
        v2:= (1/shm*ewage-(1-tau)*epdwg+prf[s]+eps[ep])*lo[s]-c;

       (* calculate expected value over tomorrow's states *)
        
        for s1 := -1 to 1 do
          for ep1 :=  1 to neps do 
            begin
(* v0 is the profit of an unfilled job changed by lb 09/05/95 -1 not 0 for m!*)
            v0 := v0 + beta*ps[s,s1]*pep[ep1]*val[next,-1,k,ep1,s1]*(1-ld);

(* v2 is the profit of a job filled by an offer *)
(* if looping over k1 need to  beta * (1/nw), if not, take out 1/nw *)
            for k1 := 1 to nw do   
           v2 := v2 + beta*1/nw*ps[s,s1]*pep[ep1]
                    *((1-lamd)*lo[s]*val[next,1,k1,ep1,s1]
                   +(lamd+(1-lamd)*(1-lo[s]))*val[next,-1,k,ep1,s1]*(1-ld));
           end;

          (* find optimal choice *)
        if (v0>=v2) then
           begin
           vv := v0;
           dd := 0;
           end
        else
          begin
          vv := v2;
          dd := 2;
          end;

        val[now,-1,k,ep,s] := vv;      (* updated value function *)
        dectime[now][-1,k,ep,s] := dd;      (* updated decision array *)
(* if ((k=10) and (ep=10) and (s=1)) then *)
(* if ((rwdec=1) and (dum=0))  then writeln(' now next  -1 ',' k ',k:3,' ep ',ep:3,' s ',s:3,' dec ',
dectime[now][1,k,ep,s]:3,' ',dectime[next][1,k,ep,s]:3,' val ',val[now,1,k,ep,s]:7:0,' ',val[next,1,k,ep,s]:7:0);  *)
    end;
   end;

  end; (* with *)

end;

procedure deciswrt;
var 
      m,ktemp,ep,s: integer;
begin
for m:= -1 to 1 do
for ep:= 1 to neps do
for ktemp:= 1 to nw do
for s:= -1 to 1 do
writeln(' m ktemp ep s dec ',m:4,' ',ktemp:4,' ',ep:4,' ',s:4,' ',dectime[now][m,ktemp,ep,s]:6,' ',val[now,m,ktemp,ep,s]:7:4);
end;

procedure doiter;
var
      m,ktemp,ep,s: integer;
      swap,
      i,xx,xmax,xmaxmax, wrdec     : integer;
      decmat : boolean;
      df, dftest, convcrit, varwage,ewg    : real;
      wg: wage_type;
begin

  with beliefs do begin
      (* initialize next periods value function *)
  xx:=0;
  xmax:=0;
   dftest:=0;
   tau:=option[29];
   convcrit:=option[31];
   wrdec:=round(option[32]);
   xmaxmax:=round(option[33]);
   for s := -1 to 1 do
     for ep := 1 to neps do
       for ktemp := 1 to nw do
           for m := -1 to 1 do
               begin
               val[next,m,ktemp,ep,s] := 0.0;
               val[now,m,ktemp,ep,s]:=0.0;
               dec[m,ktemp,ep,s]:=0;
               end;
     dectime[now]:=dec;
     dectime[next]:=dec;
       (* calculate wages *)
      /* NOT NORMALIZING WAGE!!! TRYING TO FIND SHOCKS RIGHT SIZE TO MATCH WAGE DISTRIBUTION
      varwage:=0;
      for i:=1 to nw do varwage:=varwage+(wg[i]-ewage)*(wg[i]-ewage)/nw;
      for i:=1 to nw do wage[i]:=(wg[i]-ewage)/sqrt(varwage);
      for i:=2 to nw do wage[i]:=(wage[i]+(0-wage[1]))*adjw;
      ewage:=(0-wage[1])*adjw; (* for equil3 change from *2 to *1.5 *)
      varwage:=0;
      for i:=1 to nw do varwage:=varwage+((wage[i]-ewage)*(wage[i]-ewage))/nw;

      wage[1]:=0;
      */
      decmat:=true;
(*     writeln;
 for i:=1 to nw do write(' w[i] ',wage[i]); *)
  i:=1;
   df:=1;
       (* iterate until convergencec *)
     repeat
       iterate;
       xx:=xx+1;
(* check for convergence after 1000 iterations, call it quits after 4000 *) 
      if ((xx=200) and (xmax<xmaxmax)) then 
        begin
        xmax:=xmax+1;
        xx:=0;
       df:= 0.0;
       s:=-1;
       repeat
         ktemp:=1;
         repeat
           ep:=1;
           repeat
             m:=-1;
             repeat
               df := df + abs(val[next,m,ktemp,ep,s]-val[now,m,ktemp,ep,s]);
               dftest:=df/(6*neps);
          (* use above one, because it handles zeros.  It is Chris's original 
            convergence test *)
               m:=m+1;
             until ((m>1) or (dftest > convcrit) or (decmat=false)); 
             ep:=ep+1;
          until ((ep>neps) or (dftest > convcrit) or (decmat=false)); 
          ktemp:=ktemp+1;
        until ((ktemp>nw) or (dftest > convcrit) or (decmat=false)); 
        s:=s+1;
      until ((s>1) or (dftest > convcrit) or (decmat=false));
     end; (* if *)
     i:=i+1;
     swap:= next;
     next:=now;
     now:=swap;
    until ((xmax>=xmaxmax) or ((df <= convcrit) and (decmat=true))); (* or (i>25)); *)

  end; (* with *)
if wrdec=1 then deciswrt;
end;



procedure setup2;
  (* read parameters in from a file *)
var
  s1,
  i : integer;
begin
(* readpar; *)
    ewage:=0;
    epdwg:=0;
    for i:= 1 to nw do 
      begin
      ewage:=ewage+wage[i]/nw;
      epdwg:=epdwg+pdwg[i]/nw;
      end;

  for s1 := 1 to neps do (* CHANGED June 15/96 lb approx mean 0 profits *)
     begin
      eps[s1] := -(1-shm)/shm*ewage-(maxep/2) + maxep*(s1-1)/(neps-1);
      pep[s1] := 1/neps;
 (* writeln(' eps wage ',s1:3,' ',eps[s1]:7:5,' ',wage[s1]:6:5,' ',pdwg[s1]:6:5,' ',maxep:6,' ',ewage:5:3,' ',epdwg:5:3,' ',shm:3:4); *)
      end;
  dum:=0;
  now:=1;
  next:=0;
  rwdec:=round(option[15]);
end;


procedure run2;
   (* use setup 2 and simulate one value *)
var
   m,k1 : integer;
begin
setup2;
 doiter;
 dec:=dectime[now];
 if rwdec =1 then
   begin 
    rewrite(filed,fname_vec[dec_fname]); 
    write(filed,dec); 
    close(filed); 
   end;
end;

begin
 run2; 
end; (* firm *)
.

