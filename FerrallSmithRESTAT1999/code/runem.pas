segment runem;
function runem(var pid : integer): integer; external;

function runem;
var pstr : string(3);
begin
  initseed := 5111113+1000000*(2*pid+1);
  writestr(pstr,pid:1);
  runem := pid;
  writeln('processor ',pid,' finished ');
end;
