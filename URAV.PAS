Program Calc;
uses CRT;
var a,b,x:integer;
    s:string;
Begin
  ClrScr;
  WriteLn('Калькулятор, x- целое число');
  Write('Введите A: ');ReadLn(a);
  Write('Введите B: ');ReadLn(b);
  Write('Что надо сотворить: ');ReadLn(s);
  if s='*' then x:=a*b;
  if s='/' then x:=a div b;
  if s='+' then x:=a+b;
  if s='-' then x:=a-b;
  if (s<>'*')and(s<>'/')and(s<>'+')and(s<>'-') then
    Writeln ( 'Ты что?');

  WriteLn('X=',x);
  WriteLn('2002 Фрейман С.');
  ReadKey;
End.