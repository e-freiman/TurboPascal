Program TwoRnd;
uses CRT;
const Max=1000000;
var i,Result:Longint;
    S1,S2:byte;
begin
  Randomize;
  repeat
    Result:=0;
    for i:=1 to Max do
    begin
      S1:=Random(2);
      S2:=Random(2);
      if S1=S2 then Inc(Result);
    end;
    WriteLn(Result,' in ',Max,'  (',Result/Max*100:0:2,'%)');
  until KeyPressed;
end.