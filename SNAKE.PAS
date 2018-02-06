Program Snake;
uses Crt,Graph;
var CoorBoaX,CoorBoaY:array[1..1000]of real;
    GraphDriver,GraphMode,ErrorCode,DDD,CAX,CAY,Count,i,A:integer;
    Vx,Vy,x,y:real;
    Key:char;

Procedure EgaVga_Driver; external;
{$L EGAVGA.OBJ}


Procedure Apple;
Begin
  if(x<CAX+10)and(x>CAX-10)and(y<CAY+10)and(y>CAY-10)then
  BEGIN
    SetColor(3);
    OutTextXY(trunc(CAX),trunc(CAY),'O');
    Sound(200);Delay(3*DDD);NoSound;
    Repeat
      CAX:=(Random(GetMaxX div 5)+1)*5;
      CAY:=(Random(GetMaxY div 5)+1)*5;
    Until(CAY>10)and(CAY<GetMaxY-10)and(CAX>10)and(CAX<GetMaxX-10);
    SetColor(10);
    Inc(Count);
    OutTextXY(trunc(CAX),trunc(CAY),'O');
  END;
  MoveTo(trunc(x),trunc(y));
End;

Procedure Move;
Begin
  repeat
    if KeyPressed then Key:=ReadKey;
    x:=GetX;y:=GetY;
    Apple;
    Case Key of
      #75:if Vx<>5  then begin Vx:=-5 ;Vy:=0; end;
      #72:if Vy<>5  then begin Vx:=0  ;Vy:=-5;end;
      #80:if Vy<>-5 then begin Vx:=0  ;Vy:=5; end;
      #77:if Vx<>-5 then begin Vx:=5  ;Vy:=0; end;
    end;
    Delay(DDD);
    x:=x+Vx;
    y:=y+Vy;
    for i:=Count downto 2 do CoorBoaX[i]:=CoorBoaX[i-1];
    for i:=Count downto 2 do CoorBoaY[i]:=CoorBoaY[i-1];
    SetColor(3);
    Line(trunc(CoorBoaX[Count-1]),trunc(CoorBoaY[Count-1]),trunc(CoorBoaX[Count]),trunc(CoorBoaY[Count]));
    CoorBoaX[1]:=x;
    CoorBoaY[1]:=y;
    SetColor(15);
    LineTo(trunc(x),trunc(y));
    for i:=2 to Count do if((CoorBoaX[1]=CoorBoaX[i])and(CoorBoaY[1]=CoorBoaY[i]))then Exit;
  until(Key=#27)or(x<4)or(y<4)or(x>GetMaxX-4)or(y>GetMaxY-4);
End;

Begin
  TextColor(15);
  WriteLn('Snake                                                     Freyman Eugene');
  Write('Enter speed: (0<x<1000) ');ReadLn(DDD);
  DDD:=1000-DDD;
  GraphDriver:=Detect;
  A := RegisterBGIdriver(@EgaVga_Driver);
  InitGraph(GraphDriver,GraphMode,'');
  ErrorCode:=GraphResult;
  if ErrorCode=grOK then
  BEGIN
   MoveTo(10,10);
   Key:=#77;
   CAX:=10;CAY:=10;
   Count:=50;
   SetLineStyle(0,0,3);
   SetBkColor(7);
   SetColor(4);
   Rectangle(2,2,GetMaxX-2,GetMaxY-2);
   SetColor(5);
   Move;
   CloseGraph;
  END
  else begin Writeln('Graphics error: ',GraphErrorMSG(ErrorCode));ReadKey;end;
End.
