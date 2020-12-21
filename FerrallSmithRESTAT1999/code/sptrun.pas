segment runem;

const
%include ./sport11.con

type
%include ./sport11.typ

def 
%include ./sport11.var

%include ./sport11.def
     
function runem(pid :integer): integer; external;

function runem;
begin
  initseed := 5111113+1000000*(2*pid+1);
  writestr(pstr,pid:1);
  reset(in_file,'NAME=runpar.raw');
  init;
  dosport(simorest);
  writeln('processor ',pid,' finished ');
  runem := pid;
end;

.


