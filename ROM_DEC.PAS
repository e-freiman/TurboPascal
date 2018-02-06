Function Rom_Dec(NumRoman:string):integer;
Const RomanRecord:string='MDCLXVI';
      ArabRecord:array[1..7]of integer=(1000,500,100,50,10,5,1);
      DetectMasA:array[1..6]of integer=(4,9,40,90,400,900);
      DetectMasR:array[1..6]of string=('IV','IX','XL','XC','CD','CM');
var NumArab,Detect,Code:integer;
    k,i:byte;
Begin
  for i:=1 to Length(NumRoman)do
  BEGIN
    for k:=1 to 6 do
      if NumRoman[i]+NumRoman[i+1]=DetectMasR[k] then
      begin
        NumArab:=NumArab+DetectMasA[k];
        Inc(i,2);
      end;
    if i>Length(NumRoman)then Break;
    for k:=1 to 7 do
      if NumRoman[i]=RomanRecord[k] then NumArab:=NumArab+ArabRecord[k];
  END;
Rom_Dec:=NumArab;
End;