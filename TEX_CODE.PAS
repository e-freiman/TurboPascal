Program Tex_Code;
uses CRT,DOS;
const Tex_DOS:string='АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯЁабвгдежзийклмнопрстуфхцчшщъыьэюяё';
type TMas=array[1..66] of string;
var Tex_Win:TMas;
    F_Original,F_New:Text;
    i,k,j:byte;
    Detect,S_Original,S_New,FileName_Original,FileName_New:string;
    Key:char;

Procedure OpenFiles;
var FileName:PathStr;
    Dir:DirStr;
    Name:NameStr;
    Ext:ExtStr;
begin
  Assign(F_Original,FileName_Original);
  Assign(F_New,FileName_New);
  {$I-}
  Reset(F_Original);
  {$I+}
  if IOResult<>0 then begin
    TextColor(3);
    Writeln('This file is not found - ',FileName_Original);
    TextColor(12);
    Writeln('Не найден файл - ',FileName_Original);
    Readln;
    Halt;
  end;

  FSplit(FileName_New,Dir,Name,Ext);
  FileName:=Name+'.'+Ext;
  if FSearch(FileName,Dir)<>'' then
  begin
    Writeln;
    TextColor(3);
    Writeln('The file ',FileName_New,' exists !');
    TextColor(12);
    Writeln('Файл ',FileName_New,' существует !');
    TextColor(3);
    Writeln('At record You will lose the information which was in it !');
    TextColor(12);
    Writeln('При записи Вы потеряете всю информацию которая была в нем !');
    TextColor(3);
    Writeln('To continue ? [Y/N]');
    TextColor(14);
    Writeln('Продолжить ? [Y/N]');
    Key:=ReadKey;
    if(Key='N')or(Key='n')then Halt;
  end;
  Rewrite(F_New)
end;
Procedure WriteMas(var Mas:TMas);
var i,k:byte;
    s:string;
begin
  {Большие буквы}
  for i:=1 to 10 do begin
    str(i-1,s);
    Mas[i]:='\CODE{0x43'+s+'}';
  end;
  k:=96;
  for i:=11 to 16 do begin
    Inc(k);
    Mas[i]:='\CODE{0x43'+chr(k)+'}';
  end;
  for i:=17 to 26 do begin
    str(i-17,s);
    Mas[i]:='\CODE{0x44'+s+'}';
  end;
  k:=96;
  for i:=27 to 32 do begin
    Inc(k);
    Mas[i]:='\CODE{0x44'+chr(k)+'}';
  end;
  Mas[33]:='\CODE{0x451}';
  {Маленькие буквы}

  for i:=34 to 43 do begin
    str(i-34,s);
    Mas[i]:='\CODE{0x41'+s+'}';
  end;
  k:=96;
  for i:=44 to 49 do begin
    Inc(k);
    Mas[i]:='\CODE{0x41'+chr(k)+'}';
  end;
  for i:=50 to 59 do begin
    str(i-50,s);
    Mas[i]:='\CODE{0x42'+s+'}';
  end;
  k:=96;
  for i:=60 to 65 do begin
    Inc(k);
    Mas[i]:='\CODE{0x42'+chr(k)+'}';
  end;
  Mas[66]:='\CODE{0x401}';
end;
Procedure Recode_Win_DOS;
Begin
  While not EOF(F_Original)do
  BEGIN
    Readln(F_Original,S_Original);
    for i:=1 to Length(S_Original)do
    begin
       if S_Original[i]='\'then
      begin
        Detect:='';
        for k:=i to i+14 do Detect:=Detect+S_Original[k];
        for j:=1 to 66 do if Tex_Win[j]=Detect then
        begin
          S_New:=S_New+Tex_DOS[j];
          i:=i+14;
        end;
      end;
      S_New:=S_New+S_Original[i];
    end;
  if(S_Original[Length(S_Original)]<>'%')or
  (S_Original[Length(S_Original)-1]='%')and(S_Original[Length(S_Original)]='%')then
  begin
    Writeln(F_New,S_New);
    S_New:='';
  end
                                        else Delete(S_New,Length(S_New),Length(S_New));
  Write('.')
  END;
End;

Procedure Recode_DOS_Win;
Begin
  While not EOF(F_Original)do
  BEGIN
    S_New:='';
    Readln(F_Original,S_Original);
    for i:=1 to Length(S_Original)do
    begin
      if Pos(S_Original[i],Tex_DOS)<>0 then
{Если символ S_Original[i] НАЙДЕН в строке Tex_DOS то:     }
      begin
        if Length(S_New)>=65 then
        begin
          S_New:=S_New+'%';
          Writeln(F_New,S_New);
          S_New:='';
        end;
        S_New:=S_New+Tex_Win[Pos(S_Original[i],Tex_DOS)];
      end
{**********************************************************}
                                       else
{Если символ S_Original[i] НЕ НАЙДЕН в строке Tex_DOS то:  }
      begin
        if Length(S_New)=80 then
        begin
          Writeln(F_New,S_New);
          S_New:='';
        end;
        S_New:=S_New+S_Original[i];
      end;
{**********************************************************}
    end;
    Writeln(F_New,S_New);
  Write('.');
  END;
End;

begin
Writeln;
TextColor(3);
TextBackGround(0);
Writeln('Converter');
TextColor(10);
Writeln('Конвертор');
TextColor(3);
Writeln('"I shall recode a file from Tex for DOS in Tex for Windows and back !"');
TextColor(15);
Writeln('"Перекодирую файл из Tex for DOS в Tex for Windows и обратно !"');
Writeln;
TextColor(14);
Repeat
TextColor(3);
Writeln('Enter a name of an initial file and way to it');
TextColor(14);
Write('Введите имя исходного файла и путь к нему: ');Readln(FileName_Original);
Until FileName_Original<>'';
Repeat
TextColor(3);
Writeln('Enter a name of a created file and way to it');
TextColor(14);
Write('Введите имя создоваемого файла и путь к нему: ');Readln(FileName_New);
Until(FileName_New<>'')and(FileName_Original<>FileName_New);
OpenFiles;
WriteMas(Tex_Win);
Repeat
  Writeln;
  TextColor(3);
  Writeln('1 - from Tex for DOS in Tex for Windows');
  TextColor(13);
  Writeln('1 - из Tex for DOS в Tex for Windows');
  TextColor(3);
  Writeln('2 - from Tex for Windows in Tex for DOS');
  TextColor(13);
  Writeln('2 - из Tex for Windows в Tex for DOS');
  Writeln('════════════════════════════════════');
  Key:=ReadKey;
  if Key='1' then Recode_DOS_Win
    else if Key='2' then Recode_Win_DOS
      else begin
        TextColor(3);
        Writeln('Incorrect parametr - ',Key);
        TextColor(12);
        Writeln('Неверный параметр - ',Key);
        Key:=' ';
      end;
Until Key<>' ';
Close(F_Original);
Close(F_New);
Writeln;
TextColor(3);
Writeln('Is ready !');
TextColor(14);
Writeln('Готово !');
Writeln;
TextColor(3);
Writeln('I thank for usage');
TextColor(10);
Writeln('Благодарю за пользование');
TextColor(3);
Writeln('2000     Freiman Eugene');
TextColor(10);
Writeln('2000     Фрейман Евгений');
Writeln;
TextColor(3);
Writeln('Press any key');
TextColor(7);
Writeln('Нажмите любую клавишу');
Writeln;
ReadKey;
end.