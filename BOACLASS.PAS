Program BoaClass;
uses Crt,Graph;
const Up=#72;
      Down=#80;
      Left=#75;
      Right=#77;
      Esc=#27;
var CoorBoaX,CoorBoaY,MAX,MAY,MMX,MMY:array[1..39]of real;
    GraphDriver,GraphMode,ErrorCode,t,DDD,A,B,App,Rabb,Urc:integer;
    Vx,Vy,x,y,CRX,CRY,CAX,CAY,MX,MY:real;
    Key:char;
    Go:Longint;
    Scare,i,Level,Live,TM,TA:byte;
    S,S1,S2,S3,S4,S5,S6,S7:string;

Procedure Apples;
Begin
  for i:=1 to 10 do if (x<MAX[i]+10)and(x>MAX[i]-10)and(y<MAY[i]+10)and(y>MAY[i]-10)then
  BEGIN
    SetColor(0);
    OutTextXY(trunc(MAX[i]),trunc(MAY[i]),'@');
    Sound(200);Delay(3*DDD);NoSound;
    Inc(App);
    Repeat
      CAX:=(Random(GetMaxX div 10)+1)*10;
      CAY:=(Random(GetMaxY div 10)+1)*10;
    Until(CAY>80)and(CAY<GetMaxY-20)and(CAX>20)and(CAX<GetMaxX-20);
    MAX[i]:=CAX;MAY[i]:=CAY;
    SetColor(15);
    Inc(Scare);
    OutTextXY(trunc(CAX),trunc(CAY),'@');
    if t>800 then t:=t-10;
  END;
  Inc(TA);
  if TA>100 then
  begin
    SetColor(0);
    for i:=1 to 10 do OutTextXY(trunc(MAX[i]),trunc(MAY[i]),'@');
    for i:=1 to 10 do
    BEGIN
      Repeat
        CAX:=(Random(GetMaxX div 10)+1)*10;
        CAY:=(Random(GetMaxY div 10)+1)*10;
      Until(CAY>80)and(CAY<GetMaxY-20)and(CAX>20)and(CAX<GetMaxX-20);
    MAX[i]:=CAX;MAY[i]:=CAY;
    SetColor(15);
    OutTextXY(trunc(CAX),trunc(CAY),'@');
    TA:=0;
    END;
  end;
  MoveTo(trunc(x),trunc(y));
End;

Procedure MM;
Begin
  for i:=1 to 10 do if (x<MMX[i]+10)and(x>MMX[i]-10)and(y<MMY[i]+10)and(y>MMY[i]-10)then
  BEGIN
    Inc(Urc);
    SetColor(0);
    OutTextXY(trunc(MMX[i]),trunc(MMY[i]),'*');
    Sound(500);Delay(5*DDD);NoSound;
    Dec(Live);
    Repeat
      MX:=(Random(GetMaxX div 10)+1)*10;
      MY:=(Random(GetMaxY div 10)+1)*10;
    Until(MY>80)and(MY<GetMaxY-20)and(MX>20)and(MX<GetMaxX-20);
    MMX[i]:=MX;MMY[i]:=MY;
    SetColor(13+128);
    OutTextXY(trunc(MX),trunc(MY),'*');
    t:=16*DDD;
  END;
  Inc(TM);
  if TM>250 then
  begin
    SetColor(0);
    for i:=1 to 10 do OutTextXY(trunc(MMX[i]),trunc(MMY[i]),'*');
    for i:=1 to 10 do
    BEGIN
      Repeat
        MX:=(Random(GetMaxX div 10)+1)*10;
        MY:=(Random(GetMaxY div 10)+1)*10;
      Until(MY>80)and(MY<GetMaxY-20)and(MX>20)and(MX<GetMaxX-20);
    MMX[i]:=MX;MMY[i]:=MY;
    SetColor(13);
    OutTextXY(trunc(MX),trunc(MY),'*');
    TM:=0;
    END;
  end;
  MoveTo(trunc(x),trunc(y));
End;

Procedure Rabbit;
Begin
  if(x<CRX+5)and(x>CRX-5)and(y<CRY+5)and(y>CRY-5)then
  BEGIN
    SetColor(0);
    OutTextXY(trunc(CRX),trunc(CRY),'');
    Repeat
      CRX:=(Random(GetMaxX div 10)+1)*10;
      CRY:=(Random(GetMaxY div 10)+1)*10;
    Until(CRY>80)and(CRY<GetMaxY-20)and(CRX>20)and(CRX<GetMaxX-20);
    SetColor(12);
    OutTextXY(trunc(CRX),trunc(CRY),'');
    SetColor(15);
    Inc(Rabb);
    Scare:=Scare+10;
    Live:=Live+5;
    Sound(200);Delay(3*DDD);NoSound;
    if t>8*DDD then t:=t-(DDD div 10);
    MoveTo(trunc(x),trunc(y));
  END;
  SetColor(0);
  OutTextXY(trunc(CRX),trunc(CRY),'');
  Case Random(4) of
    0:if CRY<GetMaxY-20 then CRY:=CRY+10;
    1:if CRX<GetMaxX-20 then CRX:=CRX+10;
    2:if CRX>20         then CRX:=CRX-10;
    3:if CRY>80         then CRY:=CRY-10;
  end;
  SetColor(12);
  OutTextXY(trunc(CRX),trunc(CRY),'');
  MoveTo(trunc(x),trunc(y))
End;

Procedure Victory;
Begin
  SetColor(0);
  SetLineStyle(0,0,3);
  MoveTo(trunc(CoorBoaX[1]),trunc(CoorBoaY[1]));
  for i:=2 to 38 do LineTo(trunc(CoorBoaX[i]),trunc(CoorBoaY[i]));
  SetLineStyle(1,0,3);
  Inc(Level);
  Scare:=6;
  SetColor(9);
  SetTextStyle(1,0,10);
  OutTextXY(20,80,'Victory');
  Live:=Live+10;
  ReadKey;
  SetColor(0);
  OutTextXY(20,80,'Victory');
  SetTextStyle(10,0,10);
  MoveTo(trunc(x),trunc(y));
End;


Procedure Parametr;
Begin
  Randomize;
  SetLineStyle(0,0,3);
  Live:=19;
  Level:=1;
  SetTextStyle(1,0,6);
  SetColor(13);
  OutTextXY(310,10,'Boa Classic');
  SetTextStyle(10,0,0);
  SetColor(3);
  OutTextXY(320,10,'(C)2000 Freiman Eugene   11.06.2000');
  SetColor(10);
  Line(300,2,300,70);
  Rectangle(2,2,GetMaxX-2,GetMaxY-2);
  Line(2,70,GetMaxX-2,70);
  OutTextXY(10,10,'Scare :');
  OutTextXY(10,30,'Speed :');
  OutTextXY(10,50,'Live  :');
  OutTextXY(110,10,'Rabbit:');
  OutTextXY(110,30,'Snail :');
  OutTextXY(210,30,'Level :');
  OutTextXY(110,50,'Time  :');
  OutTextXY(210,10,'Urchin:');
  TA:=101;
  TM:=251;
  Urc:=0;
  Scare:=5;
  MoveTo(10,80);
  Key:=Right;
  t:=16*DDD;
  CRX:=10;CRY:=80;
  x:=10;y:=80;
  Rabbit;
End;

Procedure Result;
Begin
  SetTextStyle(10,0,3);
  SetColor(0);
  OutTextXY(60,10,S);
  OutTextXY(60,30,S1);
  OutTextXY(170,10,S2);
  OutTextXY(170,30,S6);
  OutTextXY(270,30,S4);
  OutTextXY(60,50,S5);
  OutTextXY(170,50,S3);
  OutTextXY(270,10,S7);


  Str(Scare,S);
  Str(16-t div DDD,S1);
  SetColor(14);
  Str(Rabb,S2);
  Str(Go,S3);
  Str(Level,S4);
  Str(Live,S5);
  Str(App,S6);
  Str(Urc,S7);

  SetColor(14);
  OutTextXY(60,10,S);
  OutTextXY(60,30,S1);
  OutTextXY(170,10,S2);
  OutTextXY(170,30,S6);
  OutTextXY(270,30,S4);
  OutTextXY(60,50,S5);
  OutTextXY(170,50,S3);
  OutTextXY(270,10,S7);

  MoveTo(trunc(x),trunc(y));
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
    Rabbit;
    if KeyPressed then Key:=ReadKey;
    x:=GetX;y:=GetY;
    Case Key of
      Left: if Vx<>10  then begin Vx:=-10 ;Vy:=0;  end;
      Up:   if Vy<>10  then begin Vx:=0   ;Vy:=-10;end;
      Down: if Vy<>-10 then begin Vx:=0   ;Vy:=10; end;
      Right:if Vx<>-10 then begin Vx:=10  ;Vy:=0;  end;
    end;
    if Scare>100 then Victory;
    Apples;
    MM;
    Delay(t);
    x:=x+Vx;
    y:=y+Vy;
    ShiftBoa;
    LineTo(trunc(x),trunc(y));
    Inc(Go);
    Result;
    for i:=2 to Scare do if((CoorBoaX[1]=CoorBoaX[i])and(CoorBoaY[1]=CoorBoaY[i]))or
    ((x<4)or(x>GetMaxX-4)or(y<73)or(y>GetMaxY-4))then
    begin
      Dec(Live);
      Sound(500);Delay(5*DDD);NoSound;
      MoveTo(20,80);
      Key:=Right;
      Exit;
    end;
  until(Key=Esc)or(Live=0);
End;

{Procedure EgaVgaDriver; external;
{$L EGAVGA.OBJ}
{Procedure Trip_Font; external;
{$L trip.obj}


Begin
    ClrScr;
    TextColor(12);
    WriteLn('  Извините, но процедура Delay на компъютерах с разной');
    WriteLn('скоростью задерживает  выполнение  программы на разное');
    WriteLn('время.');
    Writeln;TextColor(14);
    WriteLn('  Просим Вас ввести коофицент, на  который  нужно умножать');
    WriteLn('параметр передоваемый процедуре. Это нужно для проиемлимой');
    WriteLn('скорости  на  любых  компъютерах. Ниже  показана примерная');
    WriteLn('таблица коофициентов:');WriteLn;
    TextColor(10);
    Writeln('Celeron 433 - k=100');
    Writeln('Pentium 166 - k=25');
    Writeln;
    TextColor(15);
    Write('Введите коофициент который Вы считаете нужным: ');ReadLn(DDD);


  GraphDriver:=Detect;
{  A := RegisterBGIdriver(@EgaVgaDriver);
  B := RegisterBGIfont(@Trip_Font);}
  InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
  ErrorCode:=GraphResult;
  if ErrorCode=grOK then
  BEGIN
    Parametr;
    Repeat
      SetLineStyle(0,0,3);
      SetColor(10);
      Rectangle(2,70,GetMaxX-2,GetMaxY-2);
      SetLineStyle(1,0,3);
      SetColor(15);
      MoveBoa;
    Until (Key=Esc)or(Live=0);
    SetColor(9);
    SetTextStyle(1,0,10);
    OutTextXY(20,80,'Loses');
    ReadKey;ReadKey;ReadKey;
    CloseGraph;
  END
  else begin Writeln('Graphics error: ',GraphErrorMSG(ErrorCode));ReadKey;end;
End.
