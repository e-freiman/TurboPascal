Program Bottle;
var Letter,Letter2,i,k:byte;
    FileName:string;
    FVar:file of byte;

Procedure Swap(var a,b:byte);
var c:byte;
Begin
  c:=a;
  a:=b;
  b:=c;
end;

Begin
  Write('Введите имя файла и путь к нему: ');
  ReadLn(FileName);
  Assign(FVar,FileName);
  {$I-}
  Reset(FVar);
  {$I+}
  if IOResult=0 then
  begin
    for i:=1 to FileSize(FVar)-1 do
      begin
        for k:=1 to FileSize(FVar)-i do
          begin
            Read(FVar,Letter,Letter2);
            if Letter>Letter2 then Swap(Letter,Letter2);
            Seek(FVar,FilePos(FVar)-2);
            Write(FVar,Letter,Letter2);
            Seek(FVar,FilePos(FVar)-1);
          end;
        Seek(FVar,0)
        end;
    Close(FVar)
  end
  else WriteLn('Не открыт файл ',FileName);
End.