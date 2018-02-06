Program PLIF;
uses CRT,Graph,Mouse;
type TMasN=array[1..127]of real;
var A,B,C,D,E,F,G,GraphDriver,GraphMode,ErrorCode,Error:integer;
    Key:char;
    MasX,MasY:TMasN;
    Result,nx:real;
    x,y:word;
    EC,BC,Count,DetN1,DetN2:byte;
    LB,RB,TB:boolean;
    smx,smy,snx:string;

{Procedure EgaVgaDriver; external;
{$L EGAVGA.OBJ}
{Procedure EuroFont; external;
{$L Euro.obj}
{Procedure LcomFont; external;
{$L Lcom.obj}
{Procedure SansFont; external;
{$L Sans.obj}
{Procedure ScriFont; external;
{$L Scri.obj}
{Procedure SimpFont; external;
{$L Simp.obj}
Function StrReal(N:real):string;
var s,SNew:string;
    k,i:byte;
    Error:integer;
Begin
  str(N,s);
  Delete(S,1,1);
  if s[Length(s)-2]='+' then
  begin
    Delete(s,2,1);
    val(s[Length(s)],k,Error);
    SNew:=Copy(s,1,k+1);
    Delete(s,1,k+1);
    s:=SNew+'.'+s;
  end;
  if s[Length(s)-2]='-'then
  begin
    Delete(s,2,1);
    val(s[Length(s)],k,Error);
    SNew:='0.';
    for i:=1 to k-1 do SNew:=SNew+'0';
    SNew:=SNew+s;
    s:=SNew;
  end;
  Delete(S,9,Length(S));
  i:=Length(S);
  for k:=1 to i do
    if S[k]='.' then
    While S[i]='0' do
    BEGIN
      Delete(S,i,1);
      Dec(i);
      if S[i]='.' then
      begin
        Delete(S,i,1);
        Break;
      end;
    END;
  StrReal:=s;
End;
Function MasNumber(S:string;var MN:TMasN;var Error:integer):byte;
var i:byte;
begin
  i:=0;
  While Pos(' ',S)<>0 do
  begin
    While Pos(' ',S)=1 do Delete(S,1,1);
    Inc(i);
    Val(Copy(S,1,Pos(' ',S)-1),MN[i],Error);
    if Error<>0 then Exit;
    Delete(S,1,Pos(' ',S));
    While Pos(' ',S)=1 do Delete(S,1,1);
  end;
  if S<>'' then begin Inc(i);Val(Copy(S,1,Length(S)),MN[i],Error);end;
  MasNumber:=i;
end;

Procedure TFunc(x1,x2,y1,y2,x:real);
var s:string;
    a,b:real;
Begin
  a:=(y1-y2)/(x1-x2);
  b:=y1-a*x1;
  Result:=a*nx+b;
End;
Procedure Detected;
var i:byte;
Begin
  for i:=1 to DetN1 do
    if nx=MasX[i] then Result:=MasY[i];
End;
Procedure MinMax;
Begin
  if nx<MasX[1] then TFunc(MasX[1],MasX[2],MasY[1],MasY[2],nx);
  if nx>MasX[DetN1] then TFunc(MasX[DetN1-1],MasX[DetN1],MasY[DetN1-1],MasY[DetN1],nx);
End;
Procedure DetectDots;
var i:byte;
Begin
  for i:=1 to DetN1 do
    if(nx>MasX[i])and(nx<MasX[i+1])then
      TFunc(MasX[i],MasX[i+1],MasY[i],MasY[i+1],nx);
End;

Procedure Mat;
begin
  Detected;
  MinMax;
  DetectDots;
end;

Procedure Swap(var a,b:real);
var c:real;
begin
  c:=a;
  a:=b;
  b:=c;
end;
Procedure Bottle(var MasX,MasY:TMasN);
var i,k:byte;
begin
  for k:=1 to DetN1 do
    for i:=1 to DetN1-k do
      if MasX[i]>MasX[i+1] then
      begin
        Swap(MasX[i],MasX[i+1]);
        Swap(MasY[i],MasY[i+1]);
      end;
end;
Function MinNumber(Mas:TMasN;Count:byte):real;
var i:byte;
    k:real;
begin
     k:=Mas[1];
     for i:=2 to Count do
       if k>Mas[i] then k:=Mas[i];
     MinNumber:=k;
end;
Function MaxNumber(Mas:TMasN;Count:byte):real;
var i:byte;
    k:real;
begin
     k:=Mas[1];
     for i:=2 to Count do
       if k<Mas[i] then k:=Mas[i];
     MaxNumber:=k;
end;
Procedure Show;
Begin
  MouseOff;
  ClearDevice;
  SetBkColor(3);
  SetLineStyle(0,0,3);
  SetColor(9);
  Rectangle(2,2,GetMaxX-2,GetMaxY-2);
  Rectangle(GetMaxX-308,GetMaxY-308,GetMaxX-6,GetMaxY-6);
  SetFillStyle(7,8);
  Bar(GetMaxX-307,GetMaxY-307,GetMaxX-7,GetMaxY-7);
  SetLineStyle(0,0,2);
  Rectangle(10,GetMaxY-60,GetMaxX-357,GetMaxY-10);
  Rectangle(10,GetMaxY-120,GetMaxX-357,GetMaxY-70);
  Rectangle(10,GetMaxY-180,GetMaxX-357,GetMaxY-130);
  Rectangle(10,GetMaxY-240,GetMaxX-357,GetMaxY-190);
  Rectangle(10,GetMaxY-300,160,GetMaxY-250);
  Rectangle(10,GetMaxY-420,60,GetMaxY-320);
  Line(10,GetMaxY-370,GetMaxX-20,GetMaxY-370);
  SetColor(4);
  SetTextStyle(3,0,3);
  OutTextXY(GetMaxX-470,190,snx);
  MoveTo(GetMaxX-570,120);
  SetTextStyle(6,0,3);
  SetColor(4);
  OutTextXY(GetMaxX-570,120,smy);
  OutTextXY(GetMaxX-570,70,smx);
  SetColor(15);
  SetTextStyle(6,0,4);
  OutTextXY(10,10,'Линейное интерполирование функций');
  SetColor(10);
  OutTextXY(100,GetMaxY-55,'Выход');
  OutTextXY(85,GetMaxY-115,'Справка');
  OutTextXY(50,GetMaxY-175,'О Программе');
  OutTextXY(95,GetMaxY-235,'Начать');
  OutTextXY(27,67,'X');
  OutTextXY(27,117,'Y');
  SetTextStyle(6,0,3);
  OutTextXY(20,GetMaxY-290,'Значение X');
  SetColor(4);
  SetTextStyle(6,3,2);
  OutTextXY(300,215,'График интерполяции');
  SetLineStyle(0,0,1);
  SetColor(1);
  Line(GetMaxX-158,GetMaxY-308,GetMaxX-158,GetMaxY-8);
  Line(GetMaxX-308,GetMaxY-158,GetMaxX-8,GetMaxY-158);
  SetTextStyle(10,0,1);
  SetColor(14);
  OutTextXY(GetMaxX-308+140,GetMaxY-308+155,'0');
  OutTextXY(GetMaxX-308+290,GetMaxY-308+155,'x');
  OutTextXY(GetMaxX-308+140,GetMaxY-308+5,'y');
  MouseOn;
End;
Function Scale:real;
var MScales:TMasN;
Begin
  MScales[1]:=abs(MasX[DetN1])/140;
  MScales[2]:=abs(MasX[1])/140;
  MScales[3]:=abs(MaxNumber(MasY,DetN1))/140;
  MScales[4]:=abs(MinNumber(MasY,DetN1))/140;
  MScales[5]:=abs(nx)/140;
  MScales[6]:=abs(Result)/140;
  Scale:=MaxNumber(MScales,6);
End;
Function MN_ALLS:string;
var Mas:TMasN;
    N:byte;
Begin
  Mas[1]:=MaxNumber(MasX,DetN1);
  Mas[2]:=MaxNumber(MasY,DetN1);
  Mas[3]:=nx;
  Mas[4]:=Result;
  MN_ALLS:=StrReal(MaxNumber(Mas,4));
End;
Procedure Graphics(x,y:word);
var mash:real;
    i:byte;
Begin
  Show;
  SetTextStyle(10,0,0);
  mash:=Scale;
  SetLineStyle(0,0,1);
  SetColor(14);
  MoveTo(Round(MasX[1]/mash)+x+150,(y+150)-Round(MasY[1]/mash));
  for i:=1 to DetN1 do
    LineTo(Round(MasX[i]/mash)+x+150,(y+150)-Round(MasY[i]/mash));
  SetLineStyle(1,0,1);
  SetColor(15);
  Line(x+150,(y+150)-Round(Result/mash),(x+150)+Round(nx/mash),(y+150)-Round(Result/mash));
  Line((x+150)+Round(nx/mash),(y+150)-Round(Result/mash),(x+150)+Round(nx/mash),y+150);
  SetColor(15);
  OutTextXY(x+283-Length(MN_ALLS)*5,y+140,MN_ALLS);
  OutTextXY(x+150,y+5,MN_ALLS);
  OutTextXY(x+5,y+140,'-'+MN_ALLS);
  OutTextXY(x+150,y+285,'-'+MN_ALLS);
  SetColor(10);
  OutTextXY((x+145)+Round(nx/mash),y+155,StrReal(nx));
  OutTextXY(x+140,(y+145)-Round(Result/mash),StrReal(Result));
End;
Procedure E1;
Begin
  MouseOff;
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetTextStyle(6,0,3);
  OutTextXY(130,150,'У Вас количество X (икс) не');
  OutTextXY(130,190,'совподает с клоличеством Y (игрек)');
  OutTextXY(130,230,'Исправьте и повторите попытку.');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  MasX[1]:=1;MasX[2]:=3;DetN1:=2;
  MasY[1]:=1;MasY[2]:=3;DetN2:=2;
  nx:=2;Result:=2;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure E2;
Begin
  MouseOff;
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetTextStyle(6,0,3);
  OutTextXY(130,150,'У Вас неправильно ввдены');
  OutTextXY(130,190,'значения X (икс) или Y (игрек)');
  OutTextXY(130,230,'Исправьте и повторите попытку.');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  MasX[1]:=1;MasX[2]:=3;DetN1:=2;
  MasY[1]:=1;MasY[2]:=3;DetN2:=2;
  nx:=2;Result:=2;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure E5;
Begin
  MouseOff;
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetTextStyle(6,0,3);
  OutTextXY(130,150,'У Вас неправильно ввдены, или не ');
  OutTextXY(130,190,'введены значения X (икс) или Y (игрек)');
  OutTextXY(130,230,'Исправьте и повторите попытку.');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  MasX[1]:=1;MasX[2]:=3;DetN1:=2;
  MasY[1]:=1;MasY[2]:=3;DetN2:=2;
  nx:=2;Result:=2;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure E3;
Begin
  MouseOff;
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetTextStyle(6,0,3);
  OutTextXY(130,150,'У Вас ввдены');
  OutTextXY(130,190,'одинаковые значения X (икс)');
  OutTextXY(130,230,'Исправьте и повторите попытку.');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  MasX[1]:=1;MasX[2]:=3;DetN1:=2;
  MasY[1]:=1;MasY[2]:=3;DetN2:=2;
  nx:=2;Result:=2;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure E4;
Begin
  MouseOff;
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetTextStyle(6,0,3);
  OutTextXY(130,150,'У Вас ввдено одно');
  OutTextXY(130,190,'значение X (икс) или Y (игрек)');
  OutTextXY(130,230,'Исправьте и повторите попытку.');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  MasX[1]:=1;MasX[2]:=3;DetN1:=2;
  MasY[1]:=1;MasY[2]:=3;DetN2:=2;
  nx:=2;Result:=2;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure IntroduceNx;
var Key:string;
    i:byte;
Begin
snx:='';
i:=0;
repeat
  Key:=ReadKey;
  if Key=#13 then Break;
  snx:=snx+Key;
  OutText(Key);
  Inc(i);
until(i>9);
End;

Function IntroduceMasXY:string;
var Key,s:string;
    i:byte;
Begin
s:='';
i:=0;
repeat
  Key:=ReadKey;
  if Key=#13 then Break;
  s:=s+Key;
  OutText(Key);
  Inc(i);
until(i>45);
IntroduceMasXY:=s;
End;
Procedure Help;
Begin
  MouseOff;
  ClearDevice;
  SetBkColor(3);
  SetLineStyle(0,0,3);
  SetColor(9);
  Rectangle(2,2,GetMaxX-2,GetMaxY-2);
  SetTextStyle(6,0,3);
  SetColor(4);
  OutTextXY(10,10,'Линейное интерполирование функций - простейший способ');
  OutTextXY(10,30,'нахождения примерного значения функций, если известны');
  OutTextXY(10,50,'их некоторые значения.');
  OutTextXY(10,90,'Он заключается в соединении отрезками точек');
  OutTextXY(10,110,'интеполяции (известных точек).');
  OutTextXY(10,130,'И нахождении по получившимуся графику значений.');
  SetColor(15);
  OutTextXY(10,170,'Для состовления таблицы значений следует щёлкнуть');
  OutTextXY(10,190,'мышкой на кнопку "Х" и ввести через пробел значения');
  OutTextXY(10,210,'X (икс), а потом аналогично с Y (игрек).');
  OutTextXY(10,230,'Потом надо указать при каком X (икс) Вам надо');
  OutTextXY(10,250,'найти Y (игрек), щёлкнув на "Значение Х"');
  OutTextXY(10,270,'Когда всё будет указано щёлкните на "Начать"');
  SetColor(14);
  OutTextXY(10,310,'Можно пользоваться клавиатурой:');
  OutTextXY(10,330,'"X" - ввести Х   "Tab" - ввести значение X');
  OutTextXY(10,350,'"Y" - ввести Y   "S"   - начать  "F1"- справка');
  OutTextXY(10,370,'"ESC" - выход    "Enter" - Ok     "F2"- о программе');
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-60,GetMaxX-250,GetMaxY-10);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-52,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-60)and(y<GetMaxY-10)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-52,'OK');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until not(LB)or(Key=#13);
  show;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure Prog;
Begin
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(11);
  Circle(160,GetMaxY-215,50);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetColor(8);
  OutTextXY(240,280,'Фрейман Евгений Игоревич');
  SetColor(14);
  SetTextStyle(9,0,2);
  OutTextXY(220,170,'Turbo Pascal 7.0');
  OutTextXY(220,210,'5.01.2001');
  SetColor(11);
  OutTextXY(130,GetMaxY-235,'PLIF');
  SetFillStyle(3,6);
  FloodFill(160,GetMaxY-215,11);
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure EMX;
Begin
  MouseOff;
  SetColor(12);
  SetTextStyle(6,0,4);
  OutTextXY(27,67,'X');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB);
  MouseOff;
  SetColor(15);
  OutTextXY(27,67,'X');
  SetFillStyle(1,3);
  Bar(65,GetMaxY-420,GetMaxX-20,105);
  MoveTo(GetMaxX-570,70);
  SetTextStyle(6,0,3);
  SetColor(4);
  smx:=IntroduceMasXY;
  SetColor(10);
  SetTextStyle(6,0,4);
  OutTextXY(27,67,'X');
  MouseOn;
End;
Procedure EMY;
Begin
  MouseOff;
  SetColor(12);
  SetTextStyle(6,0,4);
  OutTextXY(27,117,'Y');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB);
  MouseOff;
  SetColor(15);
  OutTextXY(27,117,'Y');
  SetFillStyle(1,3);
  Bar(65,117,GetMaxX-20,159);
  MoveTo(GetMaxX-570,120);
  SetTextStyle(6,0,3);
  SetColor(4);
  smy:=IntroduceMasXY;
  SetColor(10);
  SetTextStyle(6,0,4);
  OutTextXY(27,117,'Y');
  MouseOn;
End;
Procedure Answer;
Begin
  MouseOff;
  SetLineStyle(0,0,3);
  SetColor(9);
  SetFillStyle(1,7);
  Bar(100,100,GetMaxX-100,GetMaxY-100);
  Rectangle(100,100,GetMaxX-100,GetMaxY-100);
  SetColor(9);
  SetLineStyle(0,0,1);
  Rectangle(250,GetMaxY-160,GetMaxX-250,GetMaxY-110);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  SetTextStyle(5,0,3);
  SetColor(4);
  OutTextXY(130,100,'Линейное интерполирование функций');
  SetTextStyle(6,0,3);
  OutTextXY(130,150,'При X равном: ');
  OutTextXY(130,200,'Y прмерно равен: ');
  SetColor(10);
  OutTextXY(362,150,snx);
  OutTextXY(350,200,StrReal(Result));
  SetColor(9);
  SetTextStyle(5,0,5);
  OutTextXY(130,240,'Успехов в работе');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until(Key=#13)or((x>250)and(x<GetMaxX-250)and(y>GetMaxY-160)and(y<GetMaxY-110)and(LB));
  MouseOff;
  SetColor(12);
  SetTextStyle(8,0,4);
  OutTextXY(297,GetMaxY-152,'OK');
  MouseOn;
  repeat
    if KeyPressed then Key:=ReadKey;
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB)or(Key=#13);
  show;
  Graphics(GetMaxX-308,GetMaxY-308);
End;
Procedure Work;
var i,k:byte;
Begin
  DetN1:=MasNumber(smx,MasX,Error);
  if Error=0 then DetN2:=MasNumber(smy,MasY,Error);
  if Error<>0 then begin E2;Exit;end;
  if DetN1<>DetN2 then begin E1;Exit;end;
  if DetN1=1 then begin E4;Exit;end;
  val(snx,nx,Error);
  for i:=1 to DetN1 do
    for k:=1 to DetN1 do
      if i<>k then
        if MasX[i]=MasX[k] then begin E3;Exit;end;
    if(Error<>0)or(snx='')then begin E5;Exit;end;
      Bottle(MasX,MasY);
      Mat;
      Graphics(GetMaxX-308,GetMaxY-308);
      Repeat
        GetMouseXY(x,y,LB,RB,TB);
      Until(LB)or(RB)or(TB)or(KeyPressed);
      Answer;
End;
Procedure EntnX;
var EC:integer;
Begin
  MouseOff;
  SetColor(12);
  SetTextStyle(6,0,3);
  OutTextXY(20,GetMaxY-290,'Значение X');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB);
  MouseOff;
  SetColor(15);
  OutTextXY(20,GetMaxY-290,'Значение X');
  SetFillStyle(1,3);
  Bar(165,GetMaxY-300,GetMaxX-335,GetMaxY-250);
  MoveTo(GetMaxX-470,190);
  SetTextStyle(3,0,3);
  SetColor(4);
  IntroduceNx;
  SetColor(10);
  SetTextStyle(6,0,3);
  OutTextXY(20,GetMaxY-290,'Значение X');
  MouseOn;
End;
Procedure PressHelp;
Begin
  MouseOff;
  SetColor(12);
  SetTextStyle(6,0,4);
  OutTextXY(85,GetMaxY-115,'Справка');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until not(LB)or(Key=#59);
  Help;
End;
Procedure PressProg;
Begin
  MouseOff;
  SetColor(12);
  SetTextStyle(6,0,4);
  OutTextXY(50,GetMaxY-175,'О Программе');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
    if KeyPressed then Key:=ReadKey;
  until not(LB)or(Key=#60);
  MouseOff;
  SetColor(10);
  OutTextXY(50,GetMaxY-175,'О Программе');
  Prog;
End;
Procedure PressExit;
Begin
  MouseOff;
  SetColor(12);
  SetTextStyle(6,0,4);
  OutTextXY(100,GetMaxY-55,'Выход');
  MouseOn;
  repeat
    GetMouseXY(x,y,LB,RB,TB);
  until not(LB);
End;
Procedure Run;
Begin
 repeat
   if KeyPressed then Key:=ReadKey;
   GetMouseXY(x,y,LB,RB,TB);
   if(Key=#27)or((x>10)and(x<GetMaxX-357)and(y>419)and(y<469)and(LB))then begin PressExit;Break;end;
   if(Key=#59)or((x>10)and(x<GetMaxX-357)and(y>359)and(y<409)and(LB))then PressHelp;
   if(Key=#60)or((x>10)and(x<GetMaxX-357)and(y>299)and(y<349)and(LB))then PressProg;
   if(Key=#115)or((x>10)and(x<GetMaxX-357)and(y>239)and(y<289)and(LB))then Work;
   if(Key=#9)or((x>10)and(x<GetMaxX-357)and(y>179)and(y<229)and(LB))then EntnX;
   if(Key=#121)or((x>10)and(x<GetMaxX-357)and(y>109)and(y<159)and(LB))then EMY;
   if(Key=#120)or((x>10)and(x<GetMaxX-357)and(y>59)and(y<109)and(LB))then EMX;
   Key:=' ';
 until False
End;
Begin
{  A:=RegisterBGIdriver(@EgaVgaDriver);
  B:=RegisterBGIfont(@EuroFont);
  C:=RegisterBGIfont(@LcomFont);
  D:=RegisterBGIfont(@SansFont);
  E:=RegisterBGIfont(@ScriFont);
  F:=RegisterBGIfont(@SimpFont);}
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
  ErrorCode:=GraphResult;
  if ErrorCode=grOK then
  begin
    Init(BC,EC);
    MouseOn;
    Show;
    MasX[1]:=1;MasX[2]:=3;DetN1:=2;
    MasY[1]:=1;MasY[2]:=3;DetN2:=2;
    nx:=2;Result:=2;
    Graphics(GetMaxX-308,GetMaxY-308);
    Run;
    CloseGraph;
  end
  else begin Writeln('Graphics error: ',GraphErrorMSG(ErrorCode));ReadKey;end;
End.
{(C)2001 Freyman Eugene}