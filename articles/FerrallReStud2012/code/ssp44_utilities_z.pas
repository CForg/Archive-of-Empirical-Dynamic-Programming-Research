

 (*  operator _to_ (a,b : real): real;  *)

  function spow; begin with pgmpar^ do if a > smexp then spow:=exp(b*ln(a)) else spow := 0.0;end;

  procedure difference;
  const half = 0.5;
  var ma, ob , mo:  momarrayptr;
      masks,obs,prd : pointer;
      nv : var_range;
  begin with sr do begin
    masks := moms[mask]; obs := moms[observed]; prd := moms[predicted];
    ma := masks;ob:=obs;mo:=prd;
    for nv := 1 to Nmoments do  
        if ma^[nv] > half then
           begin
           inc(added);
           simpath[added] := (ob^[nv]-mo^[nv]);
           end;
  end; end;

  function cumsum;
  var re, vwght :  momarrayptr; 
      nv : var_range;
  begin 
      vwght := invwght; re := indiff;
      for nv := 1 to Nmoments do  cumtot := cumtot + scwght * vwght^[nv] * sqr(re^[nv]);
  end;

  procedure product; var mx,my,re : momarrayptr; nv : var_range;
  begin mx := m1; my := m2; re := result;for nv := 1 to Nmoments do re^[nv] := mx^[nv]*my^[nv]; end;

  function sum;var mx : momarrayptr; nv : var_range; tsum:real;
   begin mx:=mm; tsum:=0.0; for nv := 1 to Nmoments do tsum:=tsum+mx^[nv]; sum:=tsum; end;

  procedure scalarmult;var mx : momarrayptr; nv : var_range;
   begin mx:=mm; for nv := 1 to Nmoments do mx^[nv] := sc*mx^[nv]; end;

  procedure zedmom; var mx : momarrayptr; nv : var_range;
   begin mx:=mm; for nv := 1 to Nmoments do mx^[nv] := 0.0; end;

  procedure zedmom_exp; var mx : osolveptr; nv : integer;
   begin mx:=mm; for nv := 1 to solve_sz do mx^[nv] := 0.0; end;
  
  procedure zedall_eval; var mv : oevalptr; nv : integer;
   begin mv:=mm; for nv := 1 to eval_sz do mv^[nv] := 0.0; end;

  procedure zedall_inagg; var mv : gradvecptr; nv : integer;
   begin mv:=mm; for nv := 1 to n_allev do mv^[nv] := 0.0; end;

  procedure zedhist; var i : integer;
   begin with hist do begin
   for i:= 1 to N do hgo[i]:=0;
   for i:= 1 to X do hgx[i]:=0;
   for i:= 1 to Z do hgz[i]:=0;
   for i:= 1 to H do hgh[i]:=0;
   end; end;


  procedure ptrass (p : pointer; var pp : pointer); begin pp:=p; end;

  procedure mom_mask;
  const mp1 = missing+1; half = 0.5;
  begin with pgmpar^, moms[mask]^, money, lforce, aux do begin
    earn       :=  ord((bigmask.money.earn    >half) AND (moms[observed]^.money.earn    > mp1));
    earnsq     :=  ord((bigmask.money.earnsq  >half) AND (moms[observed]^.money.earnsq  > mp1));
    welfare    :=  ord((bigmask.money.welfare >half) AND (moms[observed]^.money.welfare > mp1));
    welfsq     :=  ord((bigmask.money.welfsq  >half) AND (moms[observed]^.money.welfsq  > mp1));
    subsidy    :=  ord((bigmask.money.subsidy >half) AND (moms[observed]^.money.subsidy > mp1));
    onwelf     :=  ord((bigmask.lforce.onwelf >half) AND (moms[observed]^.lforce.onwelf > mp1));
    minwg      :=  ord((bigmask.lforce.minwg  >half) AND (moms[observed]^.lforce.minwg  > mp1));
    lostjb     :=  ord((bigmask.lforce.lostjb >half) AND (moms[observed]^.lforce.lostjb > mp1));
    leftjb     :=  ord((bigmask.lforce.leftjb >half) AND (moms[observed]^.lforce.leftjb > mp1));
    fulltm     :=  ord((bigmask.lforce.fulltm >half) AND (moms[observed]^.lforce.fulltm > mp1));
    parttm     :=  ord((bigmask.lforce.parttm >half) AND (moms[observed]^.lforce.parttm > mp1));
    onXem      :=  ord((bigmask.lforce.onXem  >half) AND (moms[observed]^.lforce.onXem  > mp1));
    transfer   :=  ord((bigmask.aux.transfer   >half) AND (moms[observed]^.aux.transfer   > mp1));
    utility    :=  ord((bigmask.aux.utility   >half) AND (moms[observed]^.aux.utility   > mp1));
    pdv        :=  ord((bigmask.aux.pdv       >half) AND (moms[observed]^.aux.pdv       > mp1));
    leakage    :=  ord((bigmask.leakage       >half) AND (moms[observed]^.leakage       > mp1));
  end;end;

  procedure slinit; begin with sl do begin head:=nil; tail:=nil; stcnt:=0; end; end;

  procedure stnew; begin new(s); s^.next:=nil; end;

  procedure stdispose;  begin dispose(s); s := nil; end;

  procedure sldispose; var t : stateptr;
  begin with slst do
    if (head<>nil) then with head^ do if (nid<>perm_state) then
        while (head<>nil) do begin t:= head; head:=head^.next; dispose(t); end;
    slinit(slst);
  end;

  procedure inittlreal;
  var ns : real_range; ast : a_range;
  begin
  for ns := low_real to hi_real do
    begin
    for ast := 1 to Asize do with tlreal[ns,ast] do
        if head<>nil then begin head^.nid:=1; sldispose(tlreal[ns,ast]); end;
    end;
  end;

 procedure smove(p : stateptr;var targ : statelist_type;perm:boolean);
 var tmp1 : stateptr;
 begin with targ do begin
 tmp1:=head;
 stnew(head);
 head^:=p^;
 with head^ do
    begin
    if (not perm) AND (nid=perm_state) then nid := One;
    next:=tmp1;
    end;
 if tail=nil then tail:=head;
 stcnt:=succ(stcnt);
 end; end;


 procedure Sset;
   begin
   with st do
   ind := 1 + pred(nD)*cD + pred(nO)*cO + pred(nU)*cU+ pred(nX)*cX+pred(nZ)*cZ+pred(nH)*cH + pred(nT)*cT
            + ord(nF<reality)*(pred(nF)*cF + pred(nY)*cY)
            + ord(nF=reality)*pred(G)*cY;    { Added Feb. 2006 to separate SSP & SSP+ during treatment, otherwise ne written over}
   end;

 procedure smpset;
 begin with smp do begin
 thind := 1       + (nG-min(nG,One))*cG
                 + (nE-min(nE,One))*cE;
 emind := thind   + (nC-min(nC,One))*cC
                 + (nR-min(nR,One))*cR;
 pbind := emind   + (nL-min(nL,One))*cL;
 dpind := 1 + (pbind - thind) DIV cC;
 obind := 1 + (emind - thind) DIV cC;
 end; end;

procedure sspdecode;
var tt : integer;
begin with smp, call do begin
   smp := isample;
   nL := untyp;
   tt := pred(rstyp);
   nR := succ(tt DIV (cR DIV Thsize));
   tt := tt-pred(nR)*(cR DIV Thsize);
   nC := succ(tt DIV (cC DIV Thsize));
   nG := Zed;
   nE := Zed;
   smpset(smp);
end;end;

procedure invSset;
var tt : integer;
begin with st do begin
  ind := nind; tt := pred(nind);
  if ind < low_real then
     begin
     ny  := succ(tt DIV cy); tt := tt-pred(ny)*cy;     { Feb. 2006 g applies only in experiment }
     nf  := succ(tt DIV cf); tt := tt-pred(nf)*cf;
     end
  else
     begin
     ny := One; nf := reality;      { Feb. 2006 g = y applies only in experiment }
     tt := tt-pred(G)*cy;
     end;
  nt  := succ(tt DIV ct); tt := tt-pred(nt)*ct;
  nh  := succ(tt DIV ch); tt := tt-pred(nh)*ch;
  nz  := succ(tt DIV cz); tt := tt-pred(nz)*cz;
  nx  := succ(tt DIV cx); tt := tt-pred(nx)*cx;
  nu  := succ(tt DIV cu); tt := tt-pred(nu)*cu;
  no  := succ(tt DIV co); tt := tt-pred(no)*co;
  nd  := succ(tt DIV cd);
  end; end;

function equivalent;
var curclk : clock_type;
begin with curclk do begin
  invSset(curclk,sind);
  if (nd=One) then nd:=D;
  if (nu<contue) then nu := contue;
  if (nu<=contue) AND (no<N) then no:=N;
  Sset(curclk);
  equivalent:=ind;
end;end;

procedure invAset;
var tt : integer;
begin with act do begin
  tt := pred(nind);
  nw := succ(tt DIV cw); tt:= tt-pred(nw)*cw;
  nm := succ(tt DIV cm);
end;end;
