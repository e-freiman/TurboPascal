Program Boa;
uses Crt,Graph;
const Up=#72;
      Down=#80;
      Left=#75;
      Right=#77;
      Esc=#27;
var CoorBoaX,CoorBoaY:array[1..100]of real;
    GraphDriver,GraphMode,ErrorCode:integer;
    Vx,Vy,x,y,AppalX,AppalY:real;
    Key:char;
    Scare,i:byte;

Procedure Apples;
Begin
  if(x=AppalX)and(y=AppalY)then
  BEGIN
    AppalX:=(Random(GetMaxX div 10)+1)*10;
    AppalX:=(Random(GetMaxY div 10)+1)*10;
    SetColor(12);
    Circle(trunc(AppalX),trunc(AppalY),5);
    SetColor(15);
    Inc(Scare);
  END;
End;

Procedure ShiftBoa;
Begin
  for i:=Scare downto 2 do CoorBoaX[i]:=CoorBoaX[i-1];
  for i:=Scare downto 2 do CoorBoaY[i]:=CoorBoaY[i-1];
  SetColor(0);
  Line(trunc(CoorBoaX[Scare-1]),trunc(CoorBoaY[Scare-1]),trunc(CoorBoaX[Scare]),trunc(CoorBoaY[Scare]));
  CoorBoaX[1]:=x;
  CoorBoaY[1]:=y;
  SetColor(15);
End;

Procedure MoveBoa;
Begin
  repeat
    if KeyPressed then Key:=ReadKey;
    x:=GetX;y:=GetY;
    Case Key of
      Left: if Vx<>10  then begin Vx:=-10 ;Vy:=0;  end;
      Up:   if Vy<>10  then begin Vx:=0   ;Vy:=-10;end;
      Down: if Vy<>-10 then begin Vx:=0   ;Vy:=10; end;
      Right:if Vx<>-10 then begin Vx:=10  ;Vy:=0;  end;
    end;
  Delay(100);
  x:=x+Vx;
  y:=y+Vy;
  ShiftBoa;
  LineTo(trunc(x),trunc(y));
{  Apples;}
  until Key=Esc;
End;

Begin
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'TP\BGI');
  ErrorCode:=GraphResult;
  if ErrorCode=grOK then
  BEGIN
    Randomize;
    SetLineStyle(0,0,3);
    Scare:=10;
    MoveBoa;
    CloseGraph;
  END
  else begin Writeln('Graphics error: ',GraphErrorMSG(ErrorCode));ReadKey;end;
End.

