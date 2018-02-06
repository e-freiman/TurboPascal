unit Screen;
interface
uses CRT;

Function GetChar(x,y:byte):char;

Function GetColorByte(x,y:byte):byte;

Function GetTextColor(x,y:byte):byte;

Function GetBackGroundColor(x,y:byte):byte;

Function GetBlink(x,y:byte):boolean;

Function ColorByte(ColorText,ColorBackGround:byte;BlinkOn:boolean):byte;

Procedure SetChar(x,y:byte;Symbol:char);

Procedure SetColorByte(x,y:byte;ColorByte:byte);

Procedure SetTextColor(x,y,Color:byte);

Procedure SetBackGroundColor(x,y,Color:byte);

Procedure OutStringXY(x,y,Color:byte;S:string);

implementation
type
  Cell = record Symbol:char;
                Color:byte;
         end;
  TDisplay = array [1..25,1..80] of Cell;
var
  Display:TDisplay absolute $B800:$0000;

Function GetChar(x,y:byte):char;
begin
  GetChar:=Display[y,x].Symbol
end;

Function GetColorByte(x,y:byte):byte;
begin
  GetColorByte:=Display[y,x].Color
end;

Function GetTextColor(x,y:byte):byte;
begin
  GetTextColor:=Display[y,x].Color and $0F
end;

Function GetBackGroundColor(x,y:byte):byte;
begin
  GetBackGroundColor:=(Display[y,x].Color and $70)shr 4
end;

Function GetBlink(x,y:byte):boolean;
begin
  if(Display[y,x].Color and $80)=$80 then GetBlink:=True;
end;

Function ColorByte(ColorText,ColorBackGround:byte;BlinkOn:boolean):byte;
var Color:byte;
begin
  Color:=ColorText+16*ColorBackGround;
  if BlinkOn then ColorByte:=Color+$80;
end;

Procedure SetChar(x,y:byte;Symbol:char);
begin
  Display[y,x].Symbol:=Symbol
end;

Procedure SetColorByte(x,y:byte;ColorByte:byte);
begin
  Display[y,x].Color:=ColorByte;
end;

Procedure SetTextColor(x,y,Color:byte);
begin
  Display[y,x].Color:=(Display[y,x].Color and $F0)+Color
end;

Procedure SetBackGroundColor(x,y,Color:byte);
begin
  Display[y,x].Color:=(Color shl 4)+(Display[y,x].Color and $8F)
end;

Procedure OutStringXY(x,y,Color:byte;S:string);
var i:byte;
begin
  for i:=1 to Length(s) do begin
    SetChar(x+i-1,y,s[i]);SetColorByte(x+i-1,y,Color)
  end;
end;
end.