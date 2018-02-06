program StringToResult;
var S:string;
    Code:integer;
    b,e:byte;

procedure pPEN(Position:byte; var e:byte);{procedure Position End Number}
var i:byte;
begin
  i:=Position+1;
  while(i<Length(S))and(pos(s[i],'+-*/$')=0)do
    Inc(i);
  e:=i-1;
end;{pPEN}

procedure pPBN(Position:byte; var e:byte);{procedure Position Begin Number}
var i:byte;
begin
  i:=Position-1;
  while Pos(S[i],'+-*/')=0 do
    Dec(i);
  b:=i+1;
end;{pPBN}

procedure pCCP;{procedure Cut Calc Paste}
var i,k:integer;
    LS,D:string;
    LR,Rw1,Rw2:real;
begin
  for k:=1 to 2 do
  begin

    case k of
      1:D:='*';
      2:D:='/';
    end;

    i:=0;
    while i<Length(S) do
    begin
      Inc(i);
      if S[i]=D then
      begin
        pPBN(i,b);
        pPEN(i,e);
        LS:=Copy(S,b,e-b+1);
        val(Copy(LS,1,Pos(D,LS)-1),Rw1,Code);
        Delete(LS,1,Pos(D,LS));
        val(LS,Rw2,Code);
        case k of
          1:Str(Rw1*Rw2:0:3,LS);
          2:Str(Rw1/Rw2:0:3,LS);
        end;
        S:=Copy(S,1,b-1)+LS+Copy(S,e,Length(S));
        i:=0;
      end;
    end;
  end;
end;{pCCP}

var Result,R1:real;

Begin
  Result:=0;
  Write('Enter number s string: ');ReadLn(S);
  if(S[1]<>'+')and(S[1]<>'-')then S:='+'+S;
  S:=S+'$';
  pCCP;

  while S<>'' do
  begin
    if S[1]='+'
      then
        begin{+}
          Delete(S,1,1);
          pPEN(0,e);
          val(Copy(S,1,e),R1,Code);
          Result:=Result+R1;
          Delete(S,1,e);
        end
      else
        begin{-}
          Delete(S,1,1);
          pPEN(0,e);
          val(Copy(S,1,e),R1,Code);
          Result:=Result-R1;
          Delete(S,1,e);
        end;
  end;
  WriteLn('Result: ',Result:0:3);
  ReadLn;
end.{Freyman Eugene}