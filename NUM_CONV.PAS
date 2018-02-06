Program NubmerConverter;
uses CRT,GRAPH,MOUSE;
var GraphDriver,GraphMode,ErrorCode,Numb:integer;
    x,y:word;
    EC,BC,Count:byte;
    LB,RB,TB:boolean;

Function ShowDecBin:integer;
Begin
End;

Function E(a,b:byte):integer;
var i,l:byte;
Begin
  l:=1;
  for i:=1 to b do l:=l*a;
  E:=l;
End;

Function Bin_Dec(N2:integer):integer;
var N10:integer;
    i,r:byte;
Begin
  N10:=0;
  r:=Trunc(Ln(N2)/Ln(10));
  for i:=1 to Trunc(Ln(N2)/Ln(10)) do
  begin
    N10:=N10+(N2 div E(10,Trunc(Ln(N2)/Ln(10))))*E(2,r);
    N2:=N2-E(10,Trunc(Ln(N2)/Ln(10)));
    Dec(r);
  end;
  Bin_Dec:=N10;
End;

Function Hex_Dec(NumHex:string):integer;
Const RecordHex:String='0123456789ABCDEF';
Var NumDec:integer;
    Position,i:byte;
Begin
  NumDec:=0;
  for i:=1 to Length(NumHex) do
    BEGIN
      Position:=Pos(NumHex[i],RecordHex)-1;
      NumDec:=NumDec+Position*Trunc(Exp((Length(NumHex)-i)*Ln(16)));
    END;
  Hex_Dec:=NumDec;
End;

Function Dec_Hex(Num10:integer):string;
Const Mas16:string='0123456789ABCDEF';
var Num16:string;
    k,i: integer;
Begin
  Num16:='';
  While Num10>15 do
  BEGIN
   Num16:=Num16+Mas16[(Num10 mod 16)+1];
   Num10:=Num10 div 16;
  END;
  Num16:=Mas16[Num10+1]+Num16;
  Dec_Hex:=Num16;
End;

Function Rom_Dec(NumRoman:string):integer;
Const RomanRecord:string='MDCLXVI';
      ArabRecord:array[1..7]of integer=(1000,500,100,50,10,5,1);
      Detect_MasA:array[1..6]of integer=(4,9,40,90,400,900);
      Detect_MasR:array[1..6]of string=('IV','IX','XL','XC','CD','CM');
var NumArab,Detect_,Code:integer;
    k,i:byte;
Begin
  NumArab:=0;
  for i:=1 to Length(NumRoman)do
  BEGIN
    for k:=1 to 6 do
      if NumRoman[i]+NumRoman[i+1]=Detect_MasR[k] then
      begin
        NumArab:=NumArab+Detect_MasA[k];
        Inc(i,2);
      end;
    if i>Length(NumRoman)then Break;
    for k:=1 to 7 do
      if NumRoman[i]=RomanRecord[k] then NumArab:=NumArab+ArabRecord[k];
  END;
Rom_Dec:=NumArab;
End;

Function Dec_Rom(NumArab:integer):string;
Const RomanRecord:string='MDCLXVI';
      ArabRecord:array[1..7]of integer=(1000,500,100,50,10,5,1);
      Detect_Mas:array[1..6]of string=('IV','IX','XL','XC','CD','CM');
var NumRoman,ConStr,S:string;
    Conv,Detect_,Code:integer;
    i,k:byte;

Begin
  ConStr:='';
  for i:=1 to 7 do
  BEGIN
    Conv:=NumArab div ArabRecord[i];
    NumArab:=NumArab mod ArabRecord[i];
    Str(Conv,S);
    ConStr:=ConStr+S+RomanRecord[i];
  END;
  for i:=1 to Length(ConStr)do
  BEGIN
    S:=Copy(ConStr,1,2);
    if S='4I'then NumRoman:=NumRoman+'IV'else
      if S='9I'then NumRoman:=NumRoman+'IX'else
        if S='4X'then NumRoman:=NumRoman+'XL'else
          if S='9X'then NumRoman:=NumRoman+'XC'else
            if S='4C'then NumRoman:=NumRoman+'CD'else
              if S='9C'then NumRoman:=NumRoman+'CM'
    else
    begin
      Val(S[1],Detect_,Code);
      for k:=1 to Detect_ do NumRoman:=NumRoman+RomanRecord[i];
    end;
  Delete(ConStr,1,2);
  END;
  Dec_Rom:=NumRoman;
End;

Procedure F;
Begin
  SetLineStyle(0,0,1);
  ClearDevice;
  SetTextStyle(4,1,4);
  SetColor(4);
  Line(500,100,500,300);
  Line(50,GetMaxY-50,300,GetMaxY-50);
  Line(500,300,300,GetMaxY-50);
  OutTextXY(600,120,'КОНВЕРТЕР ЧИСЕЛ');
  SetBkColor(3);
  SetLineStyle(0,0,3);
  SetColor(11);
  Rectangle(2,2,GetMaxX-2,GetMaxY-2);
  Line(2,70,GetMaxX-2,70);
  SetTextStyle(10,0,6);
  SetColor(4);
  OutTextXY(65,10,'КОНВЕРТЕР ЧИСЕЛ');
End;

Procedure Click;
Begin
  SetColor(11);
  SetTextStyle(7,0,3);
  Rectangle(20,90,170,130);
  Rectangle(20,140,170,180);
  Rectangle(20,190,170,230);
  Rectangle(20,240,170,280);
  Rectangle(20,290,170,330);
  Rectangle(20,340,170,380);
  OutTextXY(25,95, 'Dec - Bin');
  OutTextXY(25,145,'Bin - Dec');
  OutTextXY(25,195,'Dec - Hex');
  OutTextXY(25,245,'Hex - Dec');
  OutTextXY(25,295,'Dec - Rom');
  OutTextXY(25,344,'Rom - Dec');
  Rectangle(180,90,380,130);
  Rectangle(180,140,380,180);
  Rectangle(180,190,380,230);
  OutTextXY(185,95, 'Выход');
  OutTextXY(185,145,'Помощь');
  OutTextXY(185,195,'О программе');
End;

Procedure Show;
Begin
  F;
  Click;
End;

Function IntroduceString:string;
var Key,Number:string;
Begin
Number:='';
repeat
  Key:=ReadKey;
  if Key=#13 then Break;
  Number:=Number+Key;
  OutText(Key);
until false;
IntroduceString:=Number;
End;

Function IntroduceNumber:integer;
var Key,Number:string;
    Detect_,Code:integer;
Begin
Number:='';
repeat
  Key:=ReadKey;
  if Key=#13 then Break;
  Number:=Number+Key;
  OutText(Key);
until false;
val(Number,Detect_,Code);
IntroduceNumber:=Detect_;
End;



Procedure ShowBinDec;
var S:string;
Begin
  ClearDevice;
  F;
  SetColor(14);
  SetTextStyle(7,0,1);
  MoveTo(25,95);
  OutText('Введите число в двоичной форме: ');
  Str(Bin_Dec(IntroduceNumber),S);
  MoveTo(25,145);
  OutText('В десятичной форме число: ');OutText(S);
  OutTextXY(25,195,'Благодарим за пользование');
  ReadKey;
End;

Procedure ShowDecHex;
var S:string;
Begin
  ClearDevice;
  F;
  SetColor(14);
  SetTextStyle(7,0,1);
  MoveTo(25,95);
  OutText('Введите число в десятичной форме: ');
  S:=Dec_Hex(IntroduceNumber);
  MoveTo(25,145);
  OutText('В шестнадцаиричной форме число: ');OutText(S);
  OutTextXY(25,195,'Благодарим за пользование');
  ReadKey;
End;

Procedure ShowHexDec;
var S:string;
Begin
  ClearDevice;
  F;
  SetColor(14);
  SetTextStyle(7,0,1);
  MoveTo(25,95);
  OutText('Введите число в шестнадцатеричной форме: ');
  Str(Hex_Dec(IntroduceString),S);
  MoveTo(25,145);
  OutText('В десятичной форме число: ');OutText(S);
  OutTextXY(25,195,'Благодарим за пользование');
  ReadKey;
End;

Procedure ShowDecRom;
var S:string;
Begin
  ClearDevice;
  F;
  SetColor(14);
  SetTextStyle(7,0,1);
  MoveTo(25,95);
  OutText('Введите число в десятичной форме: ');
  S:=Dec_Rom(IntroduceNumber);
  MoveTo(25,145);
  OutText('В римской форме число: ');OutText(S);
  OutTextXY(25,195,'Благодарим за пользование');
  ReadKey;
End;

Procedure ShowRomDec;
var S:string;
Begin
  ClearDevice;
  F;
  SetColor(14);
  SetTextStyle(7,0,1);
  MoveTo(25,95);
  OutText('Введите число в римской форме: ');
  Str(Rom_Dec(IntroduceString),S);
  MoveTo(25,145);
  OutText('В десятичной форме число: ');OutText(S);
  OutTextXY(25,195,'Благодарим за пользование');
  ReadKey;
End;

Procedure Help;
Begin
  ClearDevice;
  F;
  SetColor(14);
  SetTextStyle(7,0,1);
  OutTextXY(25,95, 'Эта программа перкодирует числа из');
  OutTextXY(25,145,'одной системы отсчёта в другую, включяя');
  OutTextXY(25,195,'римскую.');
  SetColor(15);
  OutTextXY(25,245,'Условные обозначения:');
  OutTextXY(25,295,'Dec - дсятичная                 Bin - двоичная');
  OutTextXY(25,345,'Hex - шестнадцатеричная  Rom - римская');
  ReadKey;
End;

Procedure ProgHelp;
Begin
  ClearDevice;
  F;
  SetColor(15);
  SetTextStyle(7,0,1);
  OutTextXY(25,95, 'Эта программа написана на Turbo Pascal 7.0');
  OutTextXY(25,145,'При обнаружении ошибок обращайтесь по');
  OutTextXY(25,195,'адресу: Россия, Тула, Центральный р-н');
  OutTextXY(25,245,'ул. 3-я Гостеевская д. 1-А');
  OutTextXY(25,295,'Заранее извеняемся за недороботки');
  SetColor(14);
  OutTextXY(25,345,'(С)2000 Фрейман Евгений');
  ReadKey;

End;


Procedure Select;
Begin
  Show;
  MouseOn;
  Repeat
    GetMouseXY(x,y,LB,RB,TB);
    if(x>20)and(x<170)and(LB)then
    Case y of
       90..130:Begin MouseOff;ShowDecBin;Show;MouseOn;end;
      140..180:Begin MouseOff;ShowBinDec;Show;MouseOn;end;
      190..230:Begin MouseOff;ShowDecHex;Show;MouseOn;end;
      240..280:Begin MouseOff;ShowHexDec;Show;MouseOn;end;
      290..330:Begin MouseOff;ShowDecRom;Show;MouseOn;end;
      340..380:Begin MouseOff;ShowRomDec;Show;MouseOn;end;
    end;
    if(x>180)and(x<380)and(LB)then
    Case y of
       90..130:Begin CloseGraph;Halt;End;
      140..180:Begin MouseOff;Help;Show;MouseOn;end;
      190..230:Begin MouseOff;ProgHelp;Show;MouseOn;end;
    end;

  Until False;
End;

Begin
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'c:\tp\bgi');
  ErrorCode:=GraphResult;
  if ErrorCode=grOK then begin
    Init(BC,EC);
    if EC<>0 then begin Writeln('Mouse error');ReadKey;Halt;end;
    Numb:=InstallUserFont('C_01.CHR');
    Select;
  end
else begin Writeln('Graphics error: ',GraphErrorMSG(ErrorCode));ReadKey;end;
End.