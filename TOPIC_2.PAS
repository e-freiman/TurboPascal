Program Topic_2U;
uses CRT,Graph,Mouse;
label 1,2,3,Q_1;
var A,B,C,GraphDriver,l,i,graphMode,q,errorCode,topic,top:integer;
    count,k,number,EC,BC,j,d:byte;
    RB,TB,LB,click:boolean;
    par_1,par_2:string;
    x,y:word;
{     Procedure EgaVgaDriver; external;
     {$L EGAVGA.OBJ}
{     Procedure euro_Font; external;
     {$L euro.obj}
{     Procedure Trip_Font; external;
     {$L Trip.obj}

    procedure draw_1;
    begin
    setcolor(14);
    outtextxy(65,115,'Я');
    outtextxy(125,115,'Он');
    end;
    procedure draw_2;
    begin
    setcolor(14);
    outtextxy(65,213,'Эксперт');
    outtextxy(200,213,'Любитель');
    outtextxy(340,213,'Новичок');
    end;
    procedure draw_3;
    begin
    setcolor(10);
    settextstyle(1,0,7);
    outtextxy(90,400,'1');
    outtextxy(300,400,'2');
    outtextxy(520,400,'3');
    end;
    procedure Victory;
    begin
         mouseoff;
         cleardevice;
         setfillstyle(0,15);
         setlinestyle(0,0,3);
         settextstyle(1,0,8);setcolor(10);
         rectangle(5,5,getmaxx-5,getmaxy-5);setcolor(3);
         bar3d(100,getmaxy-100,200,getmaxy-10,50,true);
         bar3d(200,getmaxy-200,300,getmaxy-10,50,true);
         bar3d(300,getmaxy-140,400,getmaxy-10,50,true);
         setcolor(0);Line(350,getmaxy-175,350,getmaxy-142);
         setcolor(12);
         outtextxy(130,getmaxy-100,'3');
         outtextxy(330,getmaxy-140,'2');
         settextstyle(1,0,10);
         outtextxy(220,getmaxy-220,'1');
         if par_2='expert'then begin
                               setcolor(14);
                               settextstyle(7,0,4);
                               circle(270,getmaxy-260,50);
                               outtextxy(247,getmaxy-280,'Вы');
                               circle(400,getmaxy-210,50);
                               outtextxy(375,getmaxy-230,'Вы');
                               circle(150,getmaxy-160,50);
                               outtextxy(125,getmaxy-180,'Вы');
                               end;
         if par_2='middle'then begin
                               setcolor(12);
                               settextstyle(7,0,2);
                               outtextxy(225,getmaxy-270,'Эксперт');
                               setcolor(14);
                               settextstyle(7,0,4);
                               circle(400,getmaxy-210,50);
                               outtextxy(375,getmaxy-230,'Вы');
                               circle(150,getmaxy-160,50);
                               outtextxy(125,getmaxy-180,'Вы');
                               end;
         if par_2='novice'then begin
                               settextstyle(7,0,2);
                               outtextxy(225,getmaxy-270,'Эксперт');
                               outtextxy(360,getmaxy-230,'Любитель');
                               settextstyle(7,0,4);
                               setcolor(14);
                               circle(150,getmaxy-160,50);
                               outtextxy(125,getmaxy-180,'Вы');
                               end;
         if par_2='lose' then  begin
                               settextstyle(7,0,2);
                               outtextxy(227,getmaxy-280,'Эксперт');
                               outtextxy(360,getmaxy-230,'Любитель');
                               outtextxy(110,getmaxy-180,'Новичок');
                               end;
         setcolor(10);
         line(5,100,getmaxx-5,100);
         line(getmaxx div 2,5,getmaxx div 2,100);
         settextstyle(1,0,5);
         outtextxy(45,25,'Продолжить');
         outtextxy(getmaxx div 2+97,25,'Выход');
         mouseon;
         repeat
            getmousexy(x,y,LB,RB,TB);
            if (y<100)and LB then begin
                          if x<getmaxx div 2 then exit;
                          if x>getmaxx div 2 then begin CloseGraph;halt;end;
                          end;
        until false;
    end;
    procedure GoComp_2;
    begin
         top:=topic;
         case topic of
              1:begin topic:=topic-1;par_2:='middle';end;
              2:topic:=topic-1;
              3:topic:=topic-2;
              4..5:topic:=topic-3;
              6:topic:=topic-1;
              7:topic:=topic-2;
              8:topic:=topic-3;
              9:topic:=topic-1;
             10..15:topic:=topic-3;
             -3..0:par_2:='lose';
         end;
         case top-topic of
         1:begin draw_3;setcolor(12);outtextxy(90,400,'1');end;
         2:begin draw_3;setcolor(12);outtextxy(300,400,'2');end;
         3:begin draw_3;setcolor(12);outtextxy(520,400,'3');end;
         end;
        delay(2000);
    end;
    procedure GoComp_3;
    begin
         randomize;
         top:=topic;
         case topic of
              1:begin topic:=topic-1;par_2:='novice';end;
              2:topic:=topic-1;
              3:topic:=topic-2;
              4..5:topic:=topic-3;
              6..7:topic:=topic-1;
              8:topic:=topic-2;
              9:topic:=topic-3;
             10..11:topic:=topic-1;
             12:topic:=topic-3;
             13:topic:=topic-1;
             14:topic:=topic-3;
             15:topic:=topic-2;
             -3..0:par_2:='lose';
         end;
         case top-topic of
         1:begin draw_3;setcolor(12);outtextxy(90,400,'1');end;
         2:begin draw_3;setcolor(12);outtextxy(300,400,'2');end;
         3:begin draw_3;setcolor(12);outtextxy(520,400,'3');end;
         end;
        delay(2000);
    end;
    procedure GoComp_1;
    begin
         top:=topic;
         case topic of
              1:begin topic:=topic-1;par_2:='expert';end;
              2:topic:=topic-1;
              3:topic:=topic-2;
              4:topic:=topic-3;
              5..6:topic:=topic-1;
              7:topic:=topic-2;
              8:topic:=topic-3;
              9..10:topic:=topic-1;
              11:topic:=topic-2;
             12..13:topic:=topic-3;
             14:topic:=topic-1;
             15:topic:=topic-2;
             -3..0:par_2:='lose';
         end;
         case top-topic of
         1:begin draw_3;setcolor(12);outtextxy(90,400,'1');end;
         2:begin draw_3;setcolor(12);outtextxy(300,400,'2');end;
         3:begin draw_3;setcolor(12);outtextxy(520,400,'3');end;
         end;
        delay(2000);
    end;

    procedure show_1;
    begin
         cleardevice;
         for i:=1 to 2000 do begin
                   x:=random(getmaxx);
                   y:=random(getmaxy);
                   d:=random(15)+1;
                   putpixel(x,y,d);
                   end;

         settextstyle(1,0,8);
         setlinestyle(0,0,3);
         setcolor(1);
         rectangle(5,5,getmaxx-5,getmaxy-5);
         setcolor(2);
         for x:=42 to 50 do
                           begin
                           delay(200);
                           setcolor(x);
                           outtextxy(x,170,'TOPIC 2000 (R)');
                           end;
         settextstyle(0,0,1);
         setcolor(7);
         outtextxy(50,300,'щёлкните мышью');
         mouseon;
         repeat
           getmousexy(x,y,LB,RB,TB);
         until (LB)or(rb)or(tb);
         Delay(500);
    end;
    procedure show_2;
    begin
         clearDevice;
         setlinestyle(0,0,1);
         setcolor(11);
         rectangle(5,5,getmaxx-5,getmaxy-5);
         q:=30;l:=50;
         for k:=1 to topic do
                           begin
                           if topic<=1 then exit;
                           j:=j+1;if j>10 then j:=0;
                           setfillstyle(j,k);
                           bar3D(q,l,q+50,l+50,15,true);
                           q:=q+100;
                           if q>600 then begin l:=l+100;q:=30;end;
                           end;
         line(5,400,getmaxx-5,400);
         line(getmaxx div 3,400,getmaxx div 3,getmaxy-5);
         line((getmaxx div 3)*2,400,(getmaxx div 3)*2,getmaxy-5);
         setcolor(10);
         settextstyle(1,0,7);
         outtextxy(90,400,'1');
         outtextxy(300,400,'2');
         outtextxy(520,400,'3');
    end;
    procedure prog_help;
    var i:byte;
    begin
    mouseoff;
    cleardevice;
    delay(500);
         setcolor(14);
         rectangle(5,5,getmaxx-5,getmaxy-5);
         outtextxy(10,10,'Эта игра называется Topic 2000.');
         outtextxy(10,40,'Два игрока по очереди берут предметы,');
         outtextxy(10,70,'можно брать один, два или три предмета.');
         outtextxy(10,100,'Кто взял последний предмет, тот проиграл.');
         setcolor(10);
         outtextxy(10,160,'Желаем удачи !!!');
         setcolor(15);
         outtextxy(10,270,'Topic 2000 (R) II');
         outtextxy(10,300,'(C)2000 Фрейман Евгений');
         outtextxy(10,330,'Turbo Pascal 7.0');
         outtextxy(10,360,'Сделано в России, Тула 10.8.2000');
         settextstyle(0,0,1);setcolor(7);
         outtextxy(10,getmaxy-30,'щёлкните мышью');
    repeat
    GetMouseXY(x,y,LB,RB,TB);
    until LB or TB or RB;
    end;
    procedure qestion;
    label 1,2;
    begin
         2:
         mouseoff;
         clearDevice;
         setlinestyle(0,0,3);
         setcolor(11);
         rectangle(5,5,getmaxx-5,getmaxy-5);
         settextstyle(1,0,2);
         setcolor(12);
         outtextxy(50,50,'Кто первый ходит ?');
         setcolor(13);
         outtextxy(65,115,'Я');
         setcolor(14);
         rectangle(40,100,100,150);
         rectangle(110,100,170,150);outtextxy(125,115,'Он');
         setcolor(12);
         outtextxy(50,160,'Выберити сложность:');
         setcolor(14);
         rectangle(40,200,170,250);outtextxy(65,213,'Эксперт');
         rectangle(180,200,310,250);outtextxy(200,213,'Любитель');
         rectangle(320,200,450,250);
         setcolor(13);
         outtextxy(340,213,'Новичок');
         setcolor(14);
         rectangle(getmaxx-250,getmaxy-110,getmaxx-50,getmaxy-50);
         rectangle(getmaxx-460,getmaxy-110,getmaxx-260,getmaxy-50);
         rectangle(getmaxx-20,20,getmaxx-220,70);
         settextstyle(1,0,4);
         setcolor(10);
         outtextxy(getmaxx-200,getmaxy-100,'Начать');
         outtextxy(getmaxx-410,getmaxy-100,'Выход');
         outtextxy(getmaxx-180,25,'Справка');
         mouseon;mouseon;
         setfillstyle(5,5);setcolor(14);settextstyle(1,0,2);
         1:
               GetMouseXY(x,y,LB,RB,TB);
               if(y>100)and(y<150)and(LB)then
                   case x of
                   40..100:begin par_1:='i';draw_1;mouseoff;setcolor(13);outtextxy(65,115,'Я');mouseon;end;
                   110..170:begin par_1:='you';draw_1;mouseoff;setcolor(13);outtextxy(125,115,'Он');mouseon;end;
                   else par_1:='no';
                   end;
               if(y>200)and(y<250)and(LB)then
                   case x of
                   40..170:begin par_2:='expert';draw_2;mouseoff;setcolor(13);outtextxy(65,213,'Эксперт');mouseon;end;
                   180..310:begin par_2:='middle';draw_2;mouseoff;setcolor(13);outtextxy(200,213,'Любитель');mouseon;end;
                   320..450:begin par_2:='novice';draw_2;mouseoff;setcolor(13);outtextxy(340,213,'Новичок');mouseon;end;
                   else par_2:='no';
                   end;
               if(x<getmaxx-20)and(x>getmaxx-220)and(y>20)and(y<70)and(LB)then begin prog_help;goto 2;end;
               if(x>getmaxx-460)and(y>getmaxy-110)and(x<getmaxx-260)and(y<getmaxy-50)and(LB)then begin CloseGraph;halt;end;
         if not((x>getmaxx-250)and(y>getmaxy-110)and(x<getmaxx-50)and(y<getmaxy-50)and(LB))then goto 1;
         end;
    procedure GoMen;
    begin
         mouseOff;
         show_2;
         mouseon;
         if topic=1 then begin topic:=0;par_2:='lose';exit;end;
         repeat
               getmousexy(x,y,LB,RB,TB);
               if (y>400)and(LB)then begin
                                     case x of
                                          0..213  :begin topic:=topic-1;click:=true;end;
                                          213..426:begin topic:=topic-2;click:=true;end;
                                          426..639:begin topic:=topic-3;click:=true;end;
                                          end;
                                     end;
         until LB and click;
         if topic<=0 then par_2:='lose';
         show_2;
    end;
begin
graphDriver:=detect;
{A:=RegisterBGIdriver(@EgaVgaDriver);
B:=RegisterBGIfont(@euro_font);
C:=RegisterBGIfont(@Trip_Font);}
InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
init(BC,EC);
if EC<>0 then begin writeln('Error Mouse ');halt;end;
errorCode:=graphResult;
if (errorCode=grOK)then
     begin
         show_1;
         repeat
         topic:=15;
         par_1:='i';
         par_2:='novice';
         click:=false;
         setbkcolor(0);
         qestion;
         Delay(500);
         show_2;
         if(par_2='expert')then
                           begin
                              if(par_1='i')then goto 1;
                              repeat
                                 goComp_1;
                                 1:
                                 goMen;
                              until topic<=1;
                              end;
         if(par_2='middle')then
                             begin
                             if(par_1='i')then goto 2;
                             repeat
                                goComp_2;
                                2:
                                goMen;
                             until topic<=1;
                          end;
         if(par_2='novice')then
                           begin
                              if(par_1='i')then goto 3;
                              repeat
                                 goComp_3;
                                 3:
                                 goMen;
                              until topic<=1;
                           end;
    victory;
    until false;
     end
     else
       writeln('Graphics error:',GraphErrorMsg(errorCode));
end.