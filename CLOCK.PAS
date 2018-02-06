Program Clock;
{ градус  = 1°  = 0.01745329252
  секунда = 0.1°= 0.001745329252
  минута  = 6°  = 0.10471975512
  час     = 360°= 6.2831853072 }
uses CRT,GRAPH,DOS;
var cx,cy,GD,GM,EC,A,B,C:integer;
    Hour,Minute,Second,Sec100:word;
    i:real;

Procedure Show;
begin
  SetColor(12);
  SetTextStyle(4,0,4);
  OutTextXY(cx-70,cy+50,'17 Stone');
end;

Procedure ConstShow;
begin
SetLineStyle(0,0,3);
SetColor(3);
Rectangle(2,2,GetMaxX-2,GetMaxY-2);
SetTextStyle(4,0,8);
OutTextXY(10,5,'Clock');
OutTextXY(GetMaxX-190,5,'Clock');
OutTextXY(10,GetMaxY-120,'Clock');
OutTextXY(GetMaxX-190,GetMaxY-120,'Clock');
end;
{Procedure EgaVgaDriver; external;
{$L egavga.obj}

{Procedure Triplex_Font; external;
{$L Trip.obj}

{Procedure Goth_Font; external;
{$L goth.obj}

Procedure DrawClock;
var i:real;
    S:string;
    Number:byte;
begin
  SetColor(14);
  Circle(cx,cy,200);
  Circle(cx,cy,150);
  SetTextStyle(1,0,4);
  SetColor(4);
  i:=0.5235987756;
  Number:=1;
  repeat
  i:=i+0.5235987756;
  str(Number,S);
  OutTextXY(round(Cos(i-2.0943951024)*180)+cx-10,round(Sin(i-2.0943951024)*180)+cy-20,S);
  Number:=Number+1;
  until Number=13;
end;

Procedure DrawSecond(x,y,r,time:real);
begin
   time:=time*0.10471975512;
   SetLineStyle(0,0,1);
   SetColor(14);
   Line(trunc(x),trunc(y),round(Cos(time-1.5707963268)*r)+cx,round(Sin(time-1.5707963268)*r)+cy);
   Delay(900);
   SetColor(0);
   Line(trunc(x),trunc(y),round(Cos(time-1.5707963268)*r)+cx,round(Sin(time-1.5707963268)*r)+cy);
end;

Procedure Draw(x,y,r,time:real;Screen:boolean;TT:String);
begin
   if Screen then begin SetFillStyle(0,0);Bar(216,135,420,347);end;
   if TT='M' then begin time:=time*0.10471975512;SetLineStyle(0,0,2);end;
   if TT='H' then begin time:=time*0.5235987756;SetLineStyle(0,0,3);end;
   SetColor(14);
   Line(trunc(x),trunc(y),round(Cos(time-1.5707963268)*r)+cx,round(Sin(time-1.5707963268)*r)+cy);
end;

begin
  GD:=Detect;

{  A := RegisterBGIdriver(@EgaVgaDriver);
  B := RegisterBGIfont(@Triplex_Font);
  C := RegisterBGIfont(@Goth_Font);}

  InitGraph(GD,GM,'C:\TP\BGI');
  EC:=GraphResult;
  if EC=grOK then begin
      cx:=GetMaxX div 2;
      cy:=GetMaxY div 2;
      DrawClock;
      ConstShow;
      GetTime(Hour,Minute,Second,Sec100);
      Draw(cx,cy,100,Minute,false,'M');
      Draw(cx,cy,70,Hour,false,'H');
      repeat
        GetTime(Hour,Minute,Second,Sec100);
        DrawSecond(cx,cy,130,Second);

        if Second=0 then begin
          Draw(cx,cy,100,Minute,true,'M');
          Draw(cx,cy,70,Hour,false,'H');
        end;

        if(Minute=0)and(Second=0)then begin
          Draw(cx,cy,70,Hour,true,'H');
          Draw(cx,cy,100,Minute,false,'M');
        end;

        Draw(cx,cy,70,Hour,false,'H');
        Draw(cx,cy,100,Minute,false,'M');
        Circle(cx,cy,5);
        Show;
      Until KeyPressed;
      CloseGraph;
  end
  else Write('Gaphics error: ',GraphErrorMSG(EC));
End.
