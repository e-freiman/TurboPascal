Program Broun;
uses Graph,CRT;
const p=5;
var GraphDriver,GraphMode,ErrorCode:integer;
    Time,i,Hits:byte;
    s1,s2,s3:string;
    Key:char;

Begin
  Hits:=0;i:=0;
  TextColor(15);
  WriteLn('Program -=Radnom=-');
  Write('Dealy: ');ReadLn(Time);
  Randomize;
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
  ErrorCode:=GraphResult;
  if ErrorCode=GrOK then
  begin
    Repeat
      Inc(i);
      ClearDevice;
      SetColor(14);
      SetColor(11);
      SetLineStyle(1,0,2);
      MoveTo(0,100);
      LineTo(0,GetMaxY);
      LineTo(GetMaxX,GetMaxY);
      SetColor(12);
      SetLineStyle(0,0,2);
      LineTo(GetMaxX,100);
      LineTo(0,100);
      SetColor(10);
      Rectangle(0,0,GetMaxX,90);

      SetColor(9);
      SetLineStyle(0,0,1);


      MoveTo(GetMaxX div 2,Round(GetMaxY/2+50));

      While(GetX>0)and(GetY<GetMaxY)do
      begin
        LineRel(Trunc((Random-0.5)*p),Trunc((Random-0.5)*p));
        Delay(Time);
        if KeyPressed then
          if ReadKey=#27 then
          begin
            ReadKey;
            CloseGraph;
            Halt;
          end;
        if(GetY<100)or(GetX>GetMaxX)then
        begin
          Inc(Hits);
          Break;
        end;
      end;

      SetColor(10);
      Rectangle(0,0,GetMaxX,90);
      OutTextXY(10,45,'Attempt:');Str(i,s1);OutTextXY(200,45,s1);
      OutTextXY(10,60,'Quantity of hits:');Str(Hits,s2);OutTextXY(200,60,s2);
      OutTextXY(10,75,'Precent of hit:');Str(Hits/i*100:0:2,s3);OutTextXY(200,75,s3+'%');

      Key:=ReadKey;
    Until Key=#27;
    CloseGraph
  end
  else Writeln(GraphErrorMsg(ErrorCode));
End.

