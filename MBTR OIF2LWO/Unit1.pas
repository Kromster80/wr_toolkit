unit Unit1;
interface
uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, sysutils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure MOX2LWO(Sender: TObject);
  end;

var
  Form1: TForm1;
  f:file;
  fo,flog:textfile;
  v: array [1..65536,0..12]of integer;
  uv: array [1..65536,1..12,1..2]of real;
  surf2,surf: array [1..65536] of integer;       //Surfaces
  xyz: array [1..65536,1..3]of real;
  tname: array [1..256]of string;
  c: array [1..256] of char;
  m:integer;
  i,j,k,l:integer;
  pqty,lqty,sqty,tqty:integer;
  res:string[4];
  oifname,s2,s:string;
  NumRead:integer;

implementation

  {$R *.DFM}

function real2(c1,c2,c3,c4:char):real;
var i,sign,exponent:integer; t,mantissa:real;
begin
if ord(c4) div 128 = 1 then Sign:=-1 else Sign:=1;
Exponent:=(ord(c4) mod 128)*2 + (ord(c3) div 128)-127;
Mantissa:=(ord(c3) mod 128)*65536+ord(c2)*256+ord(c1);
t:=(1+Mantissa/8388608)*Sign;
if Exponent=-127 then t:=0 else
if exponent>0 then for i:=1 to exponent do t:=t*2 else
if exponent<0 then for i:=-1 downto exponent do t:=t/2;
real2:=t;
end;

function unreal2(x:real):string;
var sign,mant,expo:integer;
begin
if x<0 then sign:=1 else sign:=0;
if x<>0 then begin
x:=abs(x); expo:=0;
if x>=2 then repeat                  //normalizes X
x:=x/2; expo:=expo+1;           //so it look like
until(x<2)              // 1.28758...
else if x<1 then repeat                  //
x:=x*2; expo:=expo-1;   //power of 2
until(x>=1)             //to use
else expo:=0;           //
mant:=round((x-1)*8388608); expo:=expo+127;
unreal2:=chr(mant)+chr(mant div 256)+chr((mant div 65536)+(expo mod 2)*128)+chr(expo div 2 + sign*128);
end else unreal2:=#0+#0+#0+#0;
end;

procedure TForm1.MOX2LWO(Sender: TObject);
begin
Memo1.Lines.Clear;
Memo1.Lines.Add('Converting OIF >>> LWO');
OpenDialog1.Execute;
if FileExists(OpenDialog1.FileName) then begin
assignfile(f,OpenDialog1.FileName); reset(f,1);
s:=OpenDialog1.FileName;
setlength(s,length(s)-4);
oifname:=s;
memo1.Lines.Add(s+'Accepted');
blockread(f,c,28);
pqty:=ord(c[23])*256+ord(c[24]);
lqty:=ord(c[25])*256+ord(c[26]);
sqty:=ord(c[28]);//ord(c[17]);
//tqty:=0;//ord(c[21]);

Memo1.Lines.Add('Loading points ...');
blockread(f,c,8); //VRTX____
for j:=1 to pqty do begin
blockread(f,c,16);
xyz[j,1]:=real2(c[8],c[7],c[6],c[5])/10;
xyz[j,2]:=real2(c[12],c[11],c[10],c[9])/10;
xyz[j,3]:=real2(c[16],c[15],c[14],c[13])/10;
end;

Memo1.Lines.Add('Loading polys ...');
blockread(f,c,8); //POLY____
for i:=1 to lqty do begin
blockread(f,c,88);
//inc(surf2[ord(c[6])]);        //
v[i,0]:=ord(c[4]);            //Points per poly
surf[i]:=ord(c[8]);           //Texture name
//if surf[i]=1 then surf[i]:=2;
//if c[5]=#0 then surf[i]:=1; //engine, driver, cpit, no reflecting?
//if c[5]=#1 then surf[i]:=1; //hands, brakelights
//if c[5]=#2 then surf[i]:=1; //air intake, interior, not visible? shade?
//if c[5]=#3 then surf[i]:=1; //Default body, reflecting?
//if c[5]=#5 then surf[i]:=1; //front window, bottom
//if c[5]=#16 then surf[i]:=1; //drivewheel
//if c[5]=#57 then surf[i]:=1; //interior panels
//if c[5]=#255 then surf[i]:=1; //tubes, interior, no reflecting?
//if c[6]=#255 then surf[i]:=1; //
//if c[12]=#127 then surf[i]:=1; //Inside car (interior)
//if c[12]=#63 then surf[i]:=1;  //Shaded (wings bottom, hood bottom line)
//255 default
for k:=1 to v[i,0] do begin
v[i,k]:=ord(c[11+k*6])*256+ord(c[12+k*6]);
uv[i,k,1]:=(ord(c[13+k*6])*256+ord(c[14+k*6]))/4096;
uv[i,k,2]:=(ord(c[15+k*6])*256+ord(c[16+k*6]))/4096;
end;
end;
//for i:=1 to 256 do memo1.Lines.Add(inttostr(i)+' - '+inttostr(surf2[i]));

Memo1.Lines.Add('Loading texture names ...');
blockread(f,c,8); //TXPG____
for i:=1 to sqty do begin
blockread(f,c,32); k:=1; tname[i]:='';
repeat
tname[i]:=tname[i]+c[k];
inc(k);
until(c[k]=#0);
tname[i]:=tname[i]+'.tga';
end;

closefile(f); Memo1.Lines.Add('OIF file closed');

///////////////////////////////////////////////////////LWO Summ computing
memo1.Lines.Add('Writing LWO file');
AssignFile(fo,oifname+'.lwo'); Rewrite(fo);
write(fo,'FORM'); m:=0;
m:=m+12;                                                     //+'LWO2TAGS   2'
for i:=1 to sqty do                                          //+Surfaces
if (length(Tname[i]) mod 2)=1 then m:=m+length(Tname[i])+2+1 else m:=m+length(Tname[i])+2+2;

m:=m+8+18;                                                   //+LAYR_
m:=m+8+pqty*12;                                              //+PNTS+3D
m:=m+14+10+pqty*10;                                          //+UV

m:=m+14+10;                                                  //+VMAD
for i:=1 to lqty do m:=m+v[i,0]*12;

m:=m+12+lqty*2;                                              //+Face Z.x.x.x...
for i:=1 to lqty do m:=m+v[i,0]*2;

m:=m+12+lqty*4;                                              //+Surface

for i:=1 to sqty do begin
if (length(Tname[i]) mod 2)=1 then m:=m+length(Tname[i])+1 else m:=m+length(Tname[i])+2;
m:=8+10+m+44;                                                //+CLIP+STIL+name+path
end;

for i:=1 to sqty do begin
m:=m+8+(2+20+12+12+12+10+252);                                     //+SURF Data
if (length(Tname[i]) mod 2)=1 then m:=m+length(Tname[i])+2+1 else m:=m+length(Tname[i])+2+2;
end;

//////////////////////////////Writing LWO
write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,'LWO2','TAGS');
m:=0;
for i:=1 to sqty do
if (length(Tname[i]) mod 2)=1 then m:=m+length(Tname[i])+2+1 else m:=m+length(Tname[i])+2+2;
write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
for i:=1 to sqty do begin
write(fo,inttostr(i div 10 mod 10),inttostr(i mod 10),Tname[i]);
if (length(Tname[i]) mod 2)=1 then write(fo,#0) else write(fo,#0,#0);
end;

write(fo,'LAYR',#0,#0,#0,#18);
for i:=1 to 18 do write(fo,#0);    //instead of 0`s Layer Name could be

write(fo,'PNTS');
m:=pqty*12; write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
for j:=1 to pqty do begin
res:=unreal2(xyz[j,1]); write(fo,res[4],res[3],res[2],res[1]); //LWO uses
res:=unreal2(xyz[j,2]); write(fo,res[4],res[3],res[2],res[1]); //reverse
res:=unreal2(xyz[j,3]); write(fo,res[4],res[3],res[2],res[1]); //order
end;

write(fo,'VMAP');
m:=6+10+pqty*10; write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,'TXUV',#0,#2);
write(fo,'Texture01',#0);           //TextureMap name in LW
for k:=1 to pqty do begin
write(fo,chr((k-1) div 256),chr(k-1));
res:=unreal2(0); write(fo,res[4],res[3],res[2],res[1]);
res:=unreal2(0); write(fo,res[4],res[3],res[2],res[1]);
end;

write(fo,'POLS'); //GP:=85;
m:=lqty*2+4;
for i:=1 to lqty do m:=m+v[i,0]*2;
write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,'FACE');
for j:=1 to lqty do begin
write(fo,#0,chr(v[j,0])); // 3 Points/Polygon
for k:=1 to v[j,0] do
write(fo,chr(v[j,k] div 256),chr(v[j,k]));
//if (lqty[0] div 9<>0) then Gauge3.Progress:=GP + j div (lqty[0] div 9); //33%
end;

write(fo,'PTAG');// GP:=94;
m:=lqty*4+4; write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,'SURF'); {j:=1;} k:=0;
for i:=0 to lqty-1 do begin
//if surf2[1,j]=i then begin inc(k); inc(j); end;
write(fo,chr(i div 256),chr(i),chr(surf[i+1] div 256),chr(surf[i+1]));
//if (lqty[0] div 3<>0) then Gauge3.Progress:=GP + j div (lqty[0] div 3); //33%
end;

write(fo,'VMAD');
m:=6+10;                                                  //VMAD
for i:=1 to lqty do m:=m+v[i,0]*12;
write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,'TXUV',#0,#2);
write(fo,'Texture01',#0);           //TextureMap name in LW
for i:=1 to lqty do
for k:=1 to v[i,0] do begin
write(fo,chr((v[i,k]) div 256),chr(v[i,k]));
write(fo,chr((i-1) div 256),chr(i-1));
res:=unreal2(uv[i,k,1]); write(fo,res[4],res[3],res[2],res[1]);
res:=unreal2(-uv[i,k,2]+1); write(fo,res[4],res[3],res[2],res[1]);
end;


for i:=1 to sqty do begin
write(fo,'CLIP'); m:=10+44;
if (length(Tname[i]) mod 2)=1 then m:=m+length(Tname[i])+1 else m:=m+length(Tname[i])+2;
write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,#0,#0,#0,chr(i));
write(fo,'STIL'); m:=m-10; write(fo,chr(m div 256),chr(m));
write(fo,'C:WINDOWS/Desktop/Delphi/World Racing/Textr/',Tname[i]);
if (length(Tname[i]) mod 2)=1 then write(fo,#0) else write(fo,#0,#0);
end;

end;
for i:=1 to sqty do begin
write(fo,'SURF');
m:=2+20+12+12+12+10+252;      ////Data Len
if (length(Tname[i]) mod 2)=1 then m:=m+2+length(Tname[i])+1 else m:=m+2+length(Tname[i])+2;
write(fo,chr(m div 1677216),chr(m div 65536),chr(m div 256),chr(m));
write(fo,inttostr(i div 10 mod 10),inttostr(i mod 10),Tname[i]);
if (length(Tname[i]) mod 2)=1 then write(fo,#0) else write(fo,#0,#0);

write(fo,#0,#0);
write(fo,'COLR',#0,#14);
for j:=1 to 3 do begin res:=unreal2(0.67); write(fo,res[4],res[3],res[2],res[1]); end;
write(fo,#0,#0);

write(fo,'SPEC',#0,#6);
write(fo,#0,#0,#0,#0,#0,#0);

write(fo,'REFL',#0,#6);
write(fo,#0,#0,#0,#0,#0,#0);

write(fo,'TRAN',#0,#6);
write(fo,#0,#0,#0,#0,#0,#0);

write(fo,'SMAN',#0,#4);
write(fo,#63,#73,#15,#219);  //180`

write(fo,'BLOK');
m:=246;      ////Depends.. 252-6
write(fo,chr(m div 256),chr(m));
write(fo,'IMAP',#0,'*A',#0,'CHAN',#0,#4,'COLROPAC',#0,#8,#0,#0,#63,#128,#0,#0,#0,#0);
write(fo,'ENAB',#0,#2,#0,#1,'NEGA',#0,#2,#0,#0,'TMAP',#0,#98,'CNTR',#0,#14); for j:=1 to 14 do write(fo,#0);
write(fo,'SIZE',#0,#14); for j:=1 to 3 do write(fo,#63,#128,#0,#0); write(fo,#0,#0);
write(fo,'ROTA',#0,#14); for j:=1 to 14 do write(fo,#0);
write(fo,'FALL',#0,#16); for j:=1 to 16 do write(fo,#0);
write(fo,'OREF',#0,#2,#0,#0,'CSYS',#0,#2,#0,#0,'PROJ',#0,#2,#0,#5,'AXIS',#0,#2,#0,#2);
write(fo,'IMAG',#0,#2,#0,chr(i),'WRAP',#0,#4,#0,#0,#0,#0,'WRPW',#0,#6,#63,#128,#0,#0,#0,#0);
write(fo,'WRPH',#0,#6,#63,#128,#0,#0,#0,#0,'VMAP',#0,#10,'Texture01',#0);
write(fo,'AAST',#0,#6,#0,#0,#63,#128,#0,#0,'PIXB',#0,#2,#0,#1);
end;
closefile(fo);
memo1.Lines.Add('Conversion complete.');
//Gauge3.Progress:=100;
//end; //No file case
end;


end.
