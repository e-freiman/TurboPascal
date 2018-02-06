Program Cards;
uses CRT;
type tCard=record
             M,R:byte;
           end;
     tMasCards=array[1..36]of tCard;
var Player1,Player2,MasCards:tMasCards;

Procedure Write123Cards(var Mas:tMasCards);
var iR,iM,i:byte;
Begin
  i:=0;
  for iM:=1 to 4 do
    for iR:=6 to 14 do
    begin
      Inc(i);
      Mas[i].M:=iM;
      Mas[i].R:=iR;
    end;
End;

Procedure RandomCards(var Mas:tMasCards);

 Procedure Swap(var a,b:byte);
 var c:byte;
 Begin
   c:=a;
   a:=b;
   b:=c;
 End;
var i:integer;
    n,m:byte;
Begin
  Randomize;
  for i:=1 to Random(1000)+100 do
  begin
    n:=Random(36)+1;
    m:=Random(36)+1;
    Swap(Mas[n].M,Mas[m].M);
    Swap(Mas[n].R,Mas[m].R);
  end;
End;

Procedure GivCards2P(Mas:tMasCards;var Player1,Player2:tMasCards);
var i:byte;
Begin
  for i:=1 to 6 do
  begin
    Player1[i].R:=Mas[i].R;
    Player1[i].M:=Mas[i].M;
  end;
  for i:=7 to 12 do
  begin
    Player2[i-6].R:=Mas[i].R;
    Player2[i-6].M:=Mas[i].M;
  end;

End;

Procedure ShowCards(Player1,Player2:tMasCards);
var i:byte;
Begin
  TextColor(15);
  Write('Player1: ');
  for i:=1 to 6 do
  begin
    TextColor(Player1[i].M);
    case Player1[i].R of
      10:Write(' D');
      11:Write(' J');
      12:Write(' Q');
      13:Write(' K');
      14:Write(' A');
      else Write(' ',Player1[i].R);
    end;
  end;
  WriteLn;
  WriteLn;
  TextColor(15);
  Write('Player2: ');
  for i:=1 to 6 do
  begin
    TextColor(Player2[i].M);
    case Player2[i].R of
      10:Write(' D');
      11:Write(' J');
      12:Write(' Q');
      13:Write(' K');
      14:Write(' A');
     else Write(' ',Player2[i].R);
    end;
  end;
  WriteLn;
  WriteLn;
End;

Begin
  Write123Cards(MasCards);
  RandomCards(MasCards);
  GivCards2P(MasCards,Player1,Player2);
  ShowCards(Player1,Player2);
  ReadLn;
End.