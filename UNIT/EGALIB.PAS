unit EGAlib;

interface
uses Dos;

  procedure SetPlatte  ( Color, Red, Green, Blue : byte );
  procedure SetBordure ( Red, Green, Blue : byte );
  procedure SetBlink   ( Mode : boolean );
  procedure GetText    ( Left, Top, Right, Bottom : byte;
                         var Variable );
  procedure PutText    ( Left, Top, Right, Bottom : byte;
                         var Variable );
  function  GetKey    : word;
  function  ScanKey    : word;
  procedure SetCursor  (NewCursor : Word);
  function  Ascii2Scan (ch: Char) : word;
  function ShiftFlags : word;


  Const
    NoCursor = $2000;
    SmallCursor = $0607;
    LargeCursor = $0107;
    LeftShift = $01;
    RigthShift = $02;

implementation

procedure SetPlatte ( Color, Red, Green, Blue : byte );
  label m1,m2,m3,m4,m5,m6;
  begin
    asm
      xor  bh, bh
      mov  bl, Red
      test bl, 2
      jz   m1
      or   bh, 000100b
  m1: test bl, 1
      jz   m2
      or   bh, 100000b
  m2: mov  bl, Green
      test bl, 2
      jz   m3
      or   bh, 000010b
  m3: test bl, 1
      jz m4
      or   bh, 010000b
  m4: mov bl, Blue
      test bl, 2
      jz   m5
      or   bh, 000001b
  m5: test bl, 1
      jz   m6
      or   bh, 001000b
  m6: mov  bl, Color
      mov  ax, 1000h
      int  10h
    end
  end;

procedure SetBordure ( Red, Green, Blue : byte );
  label m1,m2,m3,m4,m5,m6;
  begin
    asm
      xor  bh, bh
      mov  bl, Red
      test bl, 2
      jz   m1
      or   bh, 000100b
  m1: test bl, 1
      jz   m2
      or   bh, 100000b
  m2: mov  bl, Green
      test bl, 2
      jz   m3
      or   bh, 000010b
  m3: test bl, 1
      jz m4
      or   bh, 010000b
  m4: mov bl, Blue
      test bl, 2
      jz   m5
      or   bh, 000001b
  m5: test bl, 1
      jz   m6
      or   bh, 001000b
  m6: mov  ax, 1001h
      int  10h
    end
  end;

procedure SetBlink ( Mode : boolean );
  label m1;
  begin
     asm
      xor bl, bl
      cmp bl, Mode
      je  m1
      mov bl, 1
  m1: mov ax, 1003h
      int 10h
    end
  end;

procedure GetText ( Left, Top, Right, Bottom : byte;
                    var Variable );
  var Columns : byte;
  label m1,m2,m3;
  begin
    asm
      push ds
      mov ah, 0Fh
      int 10h
      mov cl, ah
      shl ah, 1
      mov Columns, ah
      mov bx, 0B800h
      cmp al, 4
      jb  m1
      cmp al, 7
      jne m3
      mov bh, 0B0h
  m1: mov ds, bx
      mov al, Top
      cmp al, 50
      ja  m3
      or  al, al
      jz  m3
      mov dl, Bottom
      cmp dl, 50
      ja  m3
      or  dl, dl
      jz  m3
      cmp dl, al
      jb  m3
      dec al
      sub dl, al
      jz  m3
      mul ah
      mov si, ax
      xor ah, ah
      mov al, Left
      cmp al, cl
      ja  m3
      or  al, al
      jz  m3
      mov bl, Right
      cmp bl, cl
      ja  m3
      or  bl, bl
      jz  m3
      cmp bl, al
      jb  m3
      dec al
      sub bl, al
      shl al, 1
      add si, ax
      xor bh, bh
      les di, Variable
      cld
  m2: mov cx, bx
      push si
      rep movsw
      pop si
      mov al, Columns
      xor ah, ah
      add si, ax
      dec dl
      ja  m2
  m3: pop ds
    end
  end;

procedure PutText ( Left, Top, Right, Bottom : byte;
                    var Variable );
  var Columns : byte;
  label m1,m2,m3;
  begin
    asm
      push ds
      mov ah, 0Fh
      int 10h
      mov cl, ah
      shl ah, 1
      mov Columns, ah
      mov bx, 0B800h
      cmp al, 4
      jb  m1
      cmp al, 7
      jne m3
      mov bh, 0B0h
  m1: mov es, bx
      mov al, Top
      cmp al, 50
      ja  m3
      or  al, al
      jz  m3
      mov dl, Bottom
      cmp dl, 50
      ja  m3
      or  dl, dl
      jz  m3
      cmp dl, al
      jb  m3
      dec al
      sub dl, al
      jz  m3
      mul ah
      mov di, ax
      xor ah, ah
      mov al, Left
      cmp al, cl
      ja  m3
      or  al, al
      jz  m3
      mov bl, Right
      cmp bl, cl
      ja  m3
      or  bl, bl
      jz  m3
      cmp bl, al
      jb  m3
      dec al
      sub bl, al
      shl al, 1
      add di, ax
      xor bh, bh
      lds si, Variable
      cld
  m2: mov cx, bx
      push di
      rep movsw
      pop di
      mov al, Columns
      xor ah, ah
      add di, ax
      dec dl
      ja m2
  m3: pop ds
    end
  end;

function GetKey : word;
  var Key, flag : word;
  label m1,m2,m3;
  begin
    asm
      mov ah, 10h
      int 16h
      or  ah, ah
      jz  m2
      cmp al,224
      jz  m1
      or al,al
      jz m1

      cmp al,48
      jb m3
      cmp al,57
      ja m3
      cmp ah,70
      ja m1

  m3: xor ah, ah
      jmp m2
  m1: mov al, ah
      mov ah, 1
  m2: mov Key, ax
    end;
    GetKey:=Key
  end;

procedure SetCursor(NewCursor : Word);
{ Sets the value of the scan lines of the cursor }
var
  Reg : Registers;
begin
  with Reg do
  begin
    AH := 1;
    BH := 0;
    CX := NewCursor;
    Intr($10, Reg);
  end; { with }
end; { SetCursor }

function ScanKey : word;
var
  Reg : Registers;
begin
    reg.ah := 0;
    Intr($16, Reg);
 ScanKey:=reg.ah shl 8;
end;

function Ascii2Scan(ch: Char) : word;
var
key: word;
begin
case ch of
 'q','Q','â','©','⁄','…': key:=16;
 'w','W','ñ','Ê','¬','À': key:=17;
 'e','E','ì','„','ø','ª': key:=18;
 'r','R','ä','™','’','÷': key:=19;
 't','T','Ö','•','—','“': key:=20;
 'y','Y','ç','≠','∏','∑': key:=21;
 'u','U','É','£','∞': key:=22;
 'i','I','ò','Ë','±': key:=23;
 'o','O','ô','È','≤': key:=24;
 'p','P','á','ß','€': key:=25;
 '[','{','ï','Â','≥': key:=26;
 ']','}','ö','Í','∫': key:=27;

 'a','A','î','‰','√','Ã': key:=30;
 's','S','õ','Î','≈','Œ': key:=31;
 'd','D','Ç','¢','¥','π': key:=32;
 'f','F','Ä','†','∆','«': key:=33;
 'g','G','è','Ø','◊','ÿ': key:=34;
 'h','H','ê','‡','µ','∂': key:=35;
 'j','J','é','Æ','‹': key:=36;
 'k','K','ã','´','ﬂ': key:=37;
 'l','L','Ñ','§','˛': key:=38;
 ';',':','Ü','¶','›': key:=39;
 '"','''','ù','Ì','ﬁ': key:=40;

 'z','Z','ü','Ô','¿','»': key:=44;
 'x','X','ó','Á','¡',' ': key:=45;
 'c','C','ë','·','Ÿ','º': key:=46;
 'v','V','å','¨','‘','”': key:=47;
 'b','B','à','®','œ','–': key:=48;
 'n','N','í','‚','æ','Ω': key:=49;
 'm','M','ú','Ï': key:=50;
 ',','<','Å','°','Û': key:=51;
 '.','>','û','Ó','Ú': key:=52;
 '/','?','','Ò': key:=53;

 '1','!','¸': key:=2;
 '2','@','"','2','˝': key:=3;
 '3','#','3','/','Ù': key:=4;
 '4','$','4','$','ı': key:=5;
 '5','%',':','5','ˆ': key:=6;
 '6','^','6',',','˘': key:=7;
 '7','&','7','.','˙': key:=8;
 '8','*','8',';','˜': key:=9;
 '9','(','9','?','˚': key:=10;
 '0','0','0','%','¯': key:=11;
 '-','_','ƒ': key:=12;
 '=','+': key:=13;
 '`','~','(',')': key:=41;
 '\','|': key:=43;
 end;

Ascii2Scan:=Key shl 8;
end;

function ShiftFlags : word;
var
  Reg : Registers;
begin
    reg.ah := 2;
    Intr($16, Reg);
    ShiftFlags:=reg.al;
end;

end.

