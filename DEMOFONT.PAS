Program DemoFont;
uses Graph,CRT;
var Num,GraphDriver,GraphMode,ErrorCode:integer;
Begin
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
  ErrorCode:=GraphResult;
  if ErrorCode=grOK then
  BEGIN
    Num:=InstallUserFont('Euro.chr');

    SetTextStyle(10,1,2);
    OutTextXY(100,100,'Русский шрифт!!!');
    ReadLn;
  END
  else Writeln('Graphics error: ',GraphErrorMSG(ErrorCode));
End.
