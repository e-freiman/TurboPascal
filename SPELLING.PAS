Program Spelling;
uses CRT;
type TWord=string;
var FVar:File of TWord;
    Word_:tWord;

Procedure Opening_of_the_dictionary;
begin
  Assign(FVar,'SpBase.dic');
  {$I-}
  Reset(FVar);
  {$I+}
  if IOResult<>0 then begin
    Writeln('Не найден файл словря - SpBase.dic');
    Writeln('Для работы программы нужно поместить');
    Writeln('этот файл в текущий каталог.');
    Readln;
    Halt;
  end;
end;

Function Mistake(Words:string):boolean;
var Letter,WordDic:string;
begin
  Seek(FVar,0);
  While WordDic<>Words do begin
    WordDic:='';
    Letter:='';
    Repeat
      if Letter='.'then begin Mistake:=True;Exit;end;
      WordDic:=WordDic+Letter;
      Read(FVar,Letter);
    Until Letter=',';
  end;
  Mistake:=False;
end;

Procedure Check_of_words;
Var Words:String;

begin
  WriteLn('Проверка орфографии');
  Repeat
    Write('Введите незнакомое слово: ');
    ReadLn(Words);
    if Mistake(Words) then WriteLn('Слово неправильно написано')
                      else WriteLn('Слово правильно написано');
    WriteLn;
  Until(Words='Выход')or(Words='выход')or(Words='ВЫХОД')
end;


begin
Writeln;
Opening_of_the_dictionary;
Check_of_words;
Close(FVar);
End.