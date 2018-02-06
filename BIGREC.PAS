Program BigRec;
type Link=^Item;
     Item=record
            Volgende:Link;
            Getal:integer;
          end;
var Basis,Pyl:Link;
    i:integer;
Begin
  Basis:=NIL;
  for i:=1 to 5 do
  begin
    New(Pyl);
    Pyl^.Getal:=i;
    Pyl^.Volgende:=Basis;
    Basis:=Pyl;
  end;
   for i:=1 to 5 do
   begin
    WriteLn(Pyl^.Getal:2);
    Pyl:=Pyl^.Volgende;
  end;
End.
