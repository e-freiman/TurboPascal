Program Sample;
uses Graph,Mouse,CRT;
var GraphDriver,GraphMode,ErrorCode:integer;
    RB,TB,LB:boolean;
    EC,BC:byte;
    x,y:word;
Procedure DrawButton;
Begin
  SetColor(15);
  SetLineStyle(0,0,3);
  Rectangle(100,100,GetMaxX-100,200);
  SetTextStyle(1,0,5);
  SetColor(10);
  OutTextXY(225,125,'Press me');
End;

Procedure PressButton;
Begin
  MouseOff;
  SetColor(7);
  SetLineStyle(0,0,3);
  Rectangle(100,100,GetMaxX-100,200);
  SetTextStyle(1,0,5);
  SetColor(3);
  OutTextXY(225,125,'Press me');
  MouseOn;
  Repeat
    GetMouseXY(x,y,LB,RB,TB);
  Until not(LB);
  MouseOff;
  SetColor(15);
  SetLineStyle(0,0,3);
  Rectangle(100,100,GetMaxX-100,200);
  SetTextStyle(1,0,5);
  SetColor(10);
  OutTextXY(225,125,'Press me');
  MouseOn;
End;

Begin
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
  Init(BC,EC);
  ErrorCode:=GraphResult;
  if (ErrorCode=grOK)and(EC=0)then
  BEGIN
    ClearDevice;
    DrawButton;
    MouseOn;
    Repeat
      GetMouseXY(x,y,LB,RB,TB);
      if(x>100)and(x<GetMaxX-100)and(y>100)and(y<200)and(LB)then PressButton;
    Until RB;
    Repeat
      GetMouseXY(x,y,LB,RB,TB);
    Until not(RB)
  END
  else WriteLn('Graphics error:',GraphErrorMsg(ErrorCode),'or Error Mouse');

End.