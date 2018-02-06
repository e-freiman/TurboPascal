Program Uni_Test;
uses CRT,DOS;
type TMasN=array[1..3,1..300]of byte;
var FVar,FRes:text;
    Year,Month,Day,DayOfWeek:word;
    DetectFalse:boolean;
    S,Name:string;
    Error:integer;
    i,j,w,SumC,Rec:byte;
    Key:char;
    Answers:TMasN;
    MN:array[1..300]of byte;
    A:array[1..3]of real;
    K:array[1..3]of byte;
    Ans1,Ans2,Ans3:real;

Function MasNumber(S:string;var Error:integer):byte;
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

Function MaxNumber(Mas:TMasN;Count,j:byte):byte;
var i,k:byte;
begin
     k:=Mas[j,1];
     for i:=2 to Count do
       if k<Mas[j,i] then k:=Mas[j,i];
     MaxNumber:=k;
end;


Function MinNumber(Mas:TMasN;Count,j:byte):byte;
var i,k:byte;
begin
     k:=Mas[j,1];
     for i:=2 to Count do
       if k>Mas[j,i] then k:=Mas[j,i];
     MinNumber:=k;
end;

Procedure Walls;
type Cell=record
            Symbol:char;
     	      Color:byte;
          end;
     TDisplay=array[1..25,1..80]of Cell;
var Display:TDisplay absolute $B800:$0000;
    i:byte;
Begin
  for i:=WhereY-2 to WhereY+2 do
  begin
    Display[i,1].Symbol:='║';
    Display[i,1].Color:=112;
    Display[i,80].Symbol:='║';
    Display[i,1].Color:=112;
  end;
End;

Procedure Frame(x,y,x1,y1,Style,C:byte);
const MasStyle:string='┌╔┐╗└╚┘╝│║─═';
type Cell=record
          Symbol:char;
     	    Color:byte;
          end;
     TDisplay=array[1..25,1..80]of Cell;

var Display:TDisplay absolute $B800:$0000;
		i,Count,Num_1,Num_2,Pos:byte;
Begin
	for Count:=1 to 4 do
  begin
    Case Count of
      1:begin Num_1:=y;Num_2:=y1;Pos:=x;end;
      2:begin Num_1:=y;Num_2:=y1;Pos:=x1;end;
      3:begin Num_1:=x;Num_2:=x1;Pos:=y;end;
      4:begin Num_1:=x;Num_2:=x1;Pos:=y1;end;
    end;
  	for i:=Num_1 to Num_2 do
			Case Count of
        1..2:begin
               Display[i,Pos].Symbol:=MasStyle[8+Style];
               Display[i,Pos].Color:=C;
             end;
        3..4:begin
               Display[Pos,i].Symbol:=MasStyle[10+Style];
               Display[Pos,i].Color:=C;
             end;
      end;
  end;
  Display[y,x].Symbol:=MasStyle[0+Style];
  Display[y,x].Color:=C;
  Display[y,x1].Symbol:=MasStyle[2+Style];
  Display[y,x1].Color:=C;
  Display[y1,x].Symbol:=MasStyle[4+Style];
  Display[y1,x].Color:=C;
  Display[y1,x1].Symbol:=MasStyle[6+Style];
  Display[y1,x1].Color:=C;
End;

Procedure Open_Files;
begin
  Assign(FVar,'Base.tst');
  {$I-}
  Reset(FVar);
  {$I+}
  if IOResult<>0 then begin
    ClrScr;
    Writeln('Не найден файл теста - Base.tst');
    Writeln('Для работы программы нужно поместить');
    Writeln('этот файл в один каталог с программой.');
    ReadKey;
    Halt;
  end;
end;

BEGIN
  Assign(FRes,'Result.tst');
  {$I-}
  Append(FRes);
  {$I+}
  if IOResult<>0 then begin
    ClrScr;
    Writeln('Не найден файл теста - Result.tst');
    Writeln('Для работы программы нужно поместить');
    Writeln('этот файл в один каталог с программой.');
    ReadKey;
    Halt;
  end;
  GetDate(Year,Month,Day,DayOfWeek);
  WriteLn(Fres,Day,'-',Month,'-',Year);
  Append(FRes);
  REPEAT
    Open_Files;
    Window(1,1,80,25);
    TextBackGround(7);
    TextColor(0);
    ClrScr;
    Frame(1,1,80,25,2,112);
    ReadLn(FVar,S);
    WriteLn;
    Write('║  ');TextColor(14); WriteLn(S);
    TextColor(0);
    Write('╠══════════════════════════════════════════════════════════════════════════════╣');
    Write('║  Ф.И.О., год рождения: ');TextColor(15);ReadLn(Name);TextColor(0);
    WriteLn('╠══════════════════════════════════════════════════════════════════════════════╣');
    ReadLn(FVar,S);
    GoToXY(1,23);
    Write('╠══════════════════════════════════════════════════════════════════════════════╣');
    Write('║ Программист: Фрейман Е. И.  Психолог(и): ',S);
    ReadLn(FVar,S);
    MasNumber(S,Error);
    SumC:=0;
    for i:=1 to MasNumber(S,Error) do SumC:=SumC+MN[i];
    ReadLn(FVar,S);
    GoToXY(1,6);
    Repeat
      ReadLn(FVar,S);
      if S<>'*'then WriteLn('║ ',S);
    Until S='*';
    ReadKey;
    Window(2,6,79,22);
    ClrScr;
    k[1]:=0;k[2]:=0;k[3]:=0;
    ReadLn(FVar,S);
    Repeat
      i:=0;
      Window(1,1,80,25);
      WriteLn;WriteLn;WriteLn;WriteLn;WriteLn;
      val(S,j,Error);
      if Error=0 then
        Repeat
          ReadLn(FVar,S);
          if S<>'++'then WriteLn('║ ',S);
        Until S='++';
      WriteLn('╟──────────────────────────────────────────────────────────────────────────────╢');
      While Length(s)<>1 do
      begin
        Inc(i);
        ReadLn(FVar,S);
        if Length(s)<>1 then
        begin
          Write('║  ');
          TextColor(1);
          Write(i);
          TextColor(0);
          WriteLn(' - ',S);
        end;
        Walls;
        WriteLn;
      end;
      repeat
        Key:=ReadKey;
        if Key=#27 then begin Close(FVar);Close(FRes);Halt;end;
        val(Key,Rec,Error);
      until(Error=0);
        case j of
          1:begin Inc(k[1]);Answers[1,k[1]]:=Rec;end;
          2:begin Inc(k[2]);Answers[2,k[2]]:=Rec;end;
          3:begin Inc(k[3]);Answers[3,k[3]]:=Rec;end;
        end;
      Window(2,6,79,22);
      ClrScr;
    Until EOF(FVar);
    for i:=1 to 3 do A[i]:=0;
    for i:=1 to 3 do
    begin
      for j:=1 to k[i] do
        A[i]:=A[i]+Answers[i,j];
      A[i]:=A[i]/k[i];
    end;

    Ans1:=0;W:=0;
    for i:=3 downto 1 do
      for j:=1 to k[i] do
        begin
          Inc(w);
          Ans1:=Ans1+Answers[i,j]*MN[w];
        end;
    Ans1:=((Ans1/SumC)-1)*50;
    Ans2:=(2-abs(abs((A[2]+A[1])/2)-A[3]))*50;
    SumC:=0;
    for i:=1 to 3 do
      for j:=1 to k[i] do
        SumC:=SumC+sqr(Answers[i,j]);
    W:=0;
    for i:=1 to 3 do
      for j:=1 to k[i] do
        W:=W+Answers[i,j];
    Ans3:=(1-sqrt((SumC-sqr(w)/(k[1]+k[2]+k[3]))/(k[1]+k[2]+k[3])))*100;
    WriteLn;
    WriteLn(' Ваши результаты следующие:');
    WriteLn;TextColor(5);
    WriteLn(' Нравственность:           ',Ans1:0:1,'%');
    WriteLn(' Сила духовных проявлений: ',Ans2:0:1,'%');
    WriteLn(' Цельность личности:       ',Ans3:0:1,'%');
    if A[3]>((A[2]+A[1])/2) then
    begin
      DetectFalse:=true;
      WriteLn;TextColor(12);
      WriteLn(' Искренность Ваших ответов сомнительна...');
    end;
    WriteLn;WriteLn;TextColor(0);
    WriteLn(' Все результаты находятся в файле Result.tst');
    WriteLn;WriteLn;TextColor(14);
    WriteLn(' Весьма вам благодарен за пользование !');
    TextColor(0);
    TextColor(15);
    GoToXY(1,17);
    Write(' Для продолжения нажмите любую клавишу                            ESC - Выход');
    if DetectFalse then
      WriteLn(FRes,Name,' НР: ',Ans1:0:3,' СД: ',Ans2:0:3,' ЦЛ: ',Ans3:0:3,' Ложь ')
                   else
      WriteLn(FRes,Name,' НР: ',Ans1:0:3,' СД: ',Ans2:0:3,' ЦЛ: ',Ans3:0:3);
    Append(FRes);
  UNTIL ReadKey=#27;
  Close(FRes);Close(FVar);
END.

