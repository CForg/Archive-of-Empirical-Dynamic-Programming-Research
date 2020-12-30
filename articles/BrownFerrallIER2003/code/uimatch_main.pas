program main(input,output);

const

   %include ./uimatch.con

type

   %include ./uimatch.typ

def

  %include ./var.def


%include ./uimatch.def

(******** PROCEDURES *********)

procedure setfiles;
var i : integer;
  stname,fname,data_path: string;

begin

     stname:= 'name=';   
     fname := 'filename.set';
     reset(infile,stname||fname);
     readln(infile,data_path);
     readln(infile,fname);
      fname_vec[momwgt_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[option_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[oldoff_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[newoff_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[oldacc_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[newacc_fname]:=data_path||fname;   
     readln(infile,fname);
      fname_vec[resk_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[indx_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[vwk_fname]:=data_path||fname;   
     readln(infile,fname);
      fname_vec[vnwk_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[checkvk_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[workopt_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[uiw_fname]:=data_path||fname;   
     readln(infile,fname);
      fname_vec[dec_fname]:=data_path||fname;   
     readln(infile,fname);
      fname_vec[perstat_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[genpers_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[rates_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[dump_fname]:=data_path||fname;  
     readln(infile,fname);
      fname_vec[lamprob_fname]:=data_path||fname;
     readln(infile,fname);
      fname_vec[accprob_fname]:=data_path||fname; 
     readln(infile,fname);
      fname_vec[simopt_fname]:=data_path||fname; 
     readln(infile,fname);
      fname_vec[momout_fname]:=data_path||fname; 
  close(infile);

 

     reset(infile,stname||'moments.raw');
     for i := 1 to 18 do readln(infile,act[i]);
     for i:= 1 to 18 do write(act[i]:4:4,' ');
     close(infile);

  rewrite(outfile,fname_vec[lamprob_fname]);     
  close(outfile);
  rewrite(outfile,fname_vec[accprob_fname]);
  close(outfile);
end;

procedure getminlike;
var i: integer;
    j: char;
begin
minlike:=1000;
reset(infile,'name=uimatch.max');
for i:= 1 to np do readln(infile);
for i:= 1 to 8 do read(infile,j);
readln(infile,minlike);
close(infile);
end;

procedure initialopt;
var kk : integer;
begin
for kk:= 1 to 50 do option[kk]:=0.0;
neps:=6;   (* were equal to 7 *)
nw:=6;
end;


function like;
var  mom : moment_type;
     lktmp : real;
     i : integer;
begin
  extremeval:=0;
  reset(infile,fname_vec[momwgt_fname]);
  for i:= 1 to n_moments do readln(infile, momwgt[i]);
  close(infile);
  mom:=sim_moments(inx);
  lktmp := 0.0;
  for i := 1 to n_moments do (* changed from np by lb, May 9/96 *) 
      lktmp := lktmp+momwgt[i]*(act[i]-mom[i])*(act[i]-mom[i])/(act[i]*act[i]);
  lktmp:=lktmp+(extremeval*option[49]);
  writeln('Likelihood value ',lktmp:6:4,' extremeval ',extremeval:3);
  like := lktmp;

end;

function vlike;
begin
 vlike := 0.0
end;

procedure doit; 
var
  fy : real;
(*  fff,g,finalpar : param_type;
  h : hessptr; *)
  i: integer;
  dum: moment_type; 
  finalpar : param_type;
begin

  setfiles;
  simcnt:=1;
  getminlike;
  initialopt;
  optsp2(fy,finalpar);

end;


begin

(* cmdstrng:= parms; readstr(cmdstr,fname); *)

/*
STARTING PARAMETERS ARE ACTUALLY READ IN, JUST INCLUDED HERE SO WE ARE CLEAR 
ON THE ARRAY ELEMENTS

par[1]:=0.97;   (* beta for worker *)
par[2]:=75;     (* money value of utility of remaining unemployed *)
par[3]:=5.24;   (* mean log wage *)
par[4]:=0.70;   (* var. log wage *)
par[5]:=0.0096; (* probability worker leaves economy *)
par[6]:=0.997;  (* beta for firm *)
par[7]:=60;     (* cost of hiring worker *)
par[8]:=0.125;  (* probability vacant job is destroyed *)
par[9]:=0.5;    (* share to firm of match value *)
par[10]:=25.0;  (* pi or prf[] -- the size of the aggregate shock *)
par[11]:=600;   (* maxep *)
 */

 doit;

end.

