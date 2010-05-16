unit Load_TRK;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses unit1,FileCtrl,sysutils,Windows,KromUtils,Math,dglOpenGL,PTXTexture,Unit_RoutineFunctions,Defaults;

function LoadLWO_TRK(Input:string):boolean;
implementation

function LoadLWO_TRK(Input:string):boolean;
var
  f:file;
  ii,m,chsize:integer; chname:string[4];

  LWT:packed record
    Vqty,Aqty,Bqty:integer;
    XYZ:array of record x,y,z:single; end;
    A,B:array of word; //two guiding arrays of points
    Ax,Bx:array of record x,y,z:single; end;
  end;

  dx,dy,dz,len,ang:single;

begin
Result:=false;
ElapsedTime(@OldTime);
assignfile(f,Input); reset(f,1);

LWT.Vqty:=0;
LWT.Aqty:=0;
LWT.Bqty:=0;

blockread(f,c,12);
if (c[1]+c[2]+c[3]+c[4]+c[9]+c[10]+c[11]+c[12])<>'FORMLWO2' then begin
MyMessageBox(Form1.Handle,'Old or unknown LWO format.','Loading Failed',MB_OK or MB_ICONERROR);
closefile(f); exit;
end;
m:=int2(c[8],c[7],c[6],c[5])-4;

repeat
blockread(f,c,8);
chname:=c[1]+c[2]+c[3]+c[4];
chsize:=int2(c[8],c[7],c[6],c[5]);
m:=m-chsize-8;

if chname='PNTS' then begin
LWT.Vqty:=chsize div 12;
setlength(LWT.XYZ,LWT.Vqty+1);
blockread(f,c,12*LWT.Vqty);
  for ii:=1 to LWT.Vqty do begin
  LWT.XYZ[ii].x:=real2(c[ii*12-8],c[ii*12-9],c[ii*12-10],c[ii*12-11])*10;
  LWT.XYZ[ii].y:=real2(c[ii*12-4],c[ii*12-5],c[ii*12-6],c[ii*12-7])*10;
  LWT.XYZ[ii].z:=real2(c[ii*12-0],c[ii*12-1],c[ii*12-2],c[ii*12-3])*10;
  end;
end else

if chname='POLS' then begin
blockread(f,c,4);
dec(chsize,4);
  if (c[1]+c[2]+c[3]+c[4])<>'CURV' then
  blockread(f,c,chsize)
  else begin

    if LWT.Aqty=0 then begin                    //Filling data for first curve
    blockread(f,c,2);
    LWT.Aqty:=int2(c[2],c[1]); //# of Vertices 12345678 9A BC DEF
    LWT.Aqty:=(LWT.Aqty mod 1024) + (LWT.Aqty div 4096)*1024; //11,12bytes are bitflags and should be excluded
    setlength(LWT.A,LWT.Aqty+1);
    blockread(f,c,LWT.Aqty*2);
    dec(chsize,LWT.Aqty*2+2);
    for ii:=1 to LWT.Aqty do
    LWT.A[ii]:=int2(c[ii*2],c[ii*2-1])+1;
    end;

    if (chsize<>0)and(LWT.Bqty=0) then begin    //Filling data for second curve
    blockread(f,c,2);
    LWT.Bqty:=int2(c[2],c[1]); //# of Vertices
    LWT.Bqty:=(LWT.Bqty mod 1024) + (LWT.Bqty div 4096)*1024; //11,12bytes are bitflags and should be excluded
    setlength(LWT.B,LWT.Bqty+1);
    blockread(f,c,LWT.Bqty*2);
    dec(chsize,LWT.Bqty*2+2);
    for ii:=1 to LWT.Bqty do
    LWT.B[ii]:=int2(c[ii*2],c[ii*2-1])+1;
    end;

if chsize<>0 then begin
MyMessageBox(Form1.Handle,'First two curves accepted, others are ignored.','Warning',MB_OK or MB_ICONWARNING);
blockread(f,c,chsize);
end;

end;

end else begin
for ii:=1 to (chsize div 1024000) do blockread(f,c,1024000);
blockread(f,c,chsize mod 1024000);
end;

until(m<=0);
closefile(f);
Form1.MemoLoad.Lines.Add('Load LWO_TRK in'+ElapsedTime(@OldTime));

if (LWT.Aqty=0)or(LWT.Bqty=0) then begin
MyMessageBox(Form1.Handle,'Not enough curves. Should be 2.','Error',MB_OK or MB_ICONSTOP);
exit;
end;

if TracksQty=0 then begin
TracksQty:=1;
TrackID:=1;
end;
ScnRefresh:=false;

TRKQty[TrackID].Nodes:=LWT.Aqty;
TRKQty[TrackID].LoopFlag:=0;
//switching to WR2 format right away
TRKQty[TrackID].WR2Flag1:=1;
TRKQty[TrackID].WR2Flag2:=1;
TRKQty[TrackID].a1:=0;
TRKQty[TrackID].a2:=1;
TRKQty[TrackID].Turns:=0;
TRKQty[TrackID].Arrows:=0;

setlength(TRK[TrackID].Route,TRKQty[TrackID].Nodes+1);

TRK[TrackID].Route[1].Delta:=0;
TRK[TrackID].Route[1].Delta2:=0;

for ii:=1 to TRKQty[TrackID].Nodes do begin
TRK[TrackID].Route[ii].X:=(LWT.XYZ[LWT.A[ii]].x+LWT.XYZ[LWT.B[ii]].x)/2;
TRK[TrackID].Route[ii].Y:=(LWT.XYZ[LWT.A[ii]].y+LWT.XYZ[LWT.B[ii]].y)/2;
TRK[TrackID].Route[ii].Z:=(LWT.XYZ[LWT.A[ii]].z+LWT.XYZ[LWT.B[ii]].z)/2;
if ii>1 then begin
dx:=TRK[TrackID].Route[ii].X-TRK[TrackID].Route[ii-1].X;
dy:=TRK[TrackID].Route[ii].Y-TRK[TrackID].Route[ii-1].Y;
dz:=TRK[TrackID].Route[ii].Z-TRK[TrackID].Route[ii-1].Z;
len:=sqrt(dx*dx+dy*dy+dz*dz);
TRK[TrackID].Route[ii].Delta:=TRK[TrackID].Route[ii-1].Delta+len;
end;
dx:=TRK[TrackID].Route[ii].X-LWT.XYZ[LWT.A[ii]].x;
dz:=TRK[TrackID].Route[ii].Z-LWT.XYZ[LWT.A[ii]].z;
len:=sqrt(dx*dx+dz*dz);
TRK[TrackID].Route[ii].Margin1:=EnsureRange(-round(len*10),-32768,32767);
TRK[TrackID].Route[ii].Margin2:=EnsureRange( round(len*10),-32768,32767);

TRK[TrackID].Route[ii].Tunnel:=0;
TRK[TrackID].Route[ii].Column:=0;
TRK[TrackID].Route[ii].v1:=0;
TRK[TrackID].Route[ii].v2:=0;
TRK[TrackID].Route[ii].v3:=0;
TRK[TrackID].Route[ii].v4:=0;
end;

for ii:=1 to TRKQty[TrackID].Nodes do begin
//we exclude Y from equation since there are no global height changes
//and it's not very important at all
dx:=TRK[TrackID].Route[EnsureRange(ii+1,1,TRKQty[TrackID].Nodes)].X-TRK[TrackID].Route[EnsureRange(ii-1,1,TRKQty[TrackID].Nodes)].X;
dz:=TRK[TrackID].Route[EnsureRange(ii+1,1,TRKQty[TrackID].Nodes)].Z-TRK[TrackID].Route[EnsureRange(ii-1,1,TRKQty[TrackID].Nodes)].Z;
len:=sqrt(dx*dx+dz*dz);
dx:=dx/len;
dz:=dz/len;

if dx<>0 then
  ang:=arctan2(-dz,dx)
else
  if dz>0 then
    ang:=-pi/2
  else
    ang:=pi/2;

ang:=ang+pi/2;
ang:=ang*180/pi;

Angles2Matrix(0,ang,0,@TRK[TrackID].Route[ii].Matrix[1],9);
end;
 Changes.TRK[TrackID]:=true;
 Result:=true;
end;

end.
