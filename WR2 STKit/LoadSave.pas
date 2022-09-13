unit LoadSave;
interface
uses
  unit1,FileCtrl,sysutils,Windows,KromUtils,Math,dglOpenGL,PTXTexture,Unit_RoutineFunctions,Unit_Defaults;

    procedure LoadQAD(Input:string);
    procedure LoadQAD_BW(Input:string);
    function LoadVTX(Input:string):boolean;
    function LoadIDX(Input:string):boolean;
    function LoadGEO(Input:string):boolean;
    function  LoadSNI(Input:string):boolean;
    procedure LoadLVL(Input:string);
    function  LoadSMP(Input:string):boolean;
    function  LoadNET(Input:string):boolean;
    function  LoadSKY(Input:string):boolean;
    procedure LoadTRK(Input,Input2:string);
    procedure LoadTOB(Input,Input2:string);
    procedure LoadWTR(Input,Input2:string);
    procedure LoadWRK(Input:string);

    procedure SaveQAD(Input:string);
    procedure SaveIDX(Input:string);
    procedure SaveVTX(Input:string);
    procedure SaveSNI(Input:string);

    procedure SaveTRK(Input:string;ID:integer);
    procedure SaveTOB(Input:string;ID:integer);
    procedure SaveWTR(Input:string;ID:integer);
    procedure SaveTRK_DAT(Input:string);
    procedure SaveLVL(Input:string);
    procedure SaveSMP(Input:string);
    procedure SaveSKY(Input:string);
    procedure SaveWRK(Input:string);

implementation

procedure LoadQAD(Input:string);
var
  f:file;
  i,j,k:integer;
begin
if not CheckFileExists(Input+'.qad') then begin
  FillChar(Qty,sizeof(Qty),#0);
  exit;
end;
assignfile(f,Input+'.qad'); reset(f,1);

blockread(f,c,8);
if StrPas(PAnsiChar(@c[1]))='DAUQ' then begin
  closefile(f);
  LoadQAD_BW(Input);
  exit;
end;

reset(f,1);

blockread(f,Qty,64);

if Qty.BumpTexturesFiles<>0 then
  EditingFormat:=ef_CT;

for i:=1 to Qty.TexturesFiles do begin
blockread(f,c,32); TexName[i]:=StrPas(PAnsiChar(@c[1]));
end;

for i:=1 to Qty.BumpTexturesFiles do begin
blockread(f,c,32); BumpTexName[i]:=StrPas(PAnsiChar(@c[1]));
end;
Qty.BumpTexturesFiles:=0;

for i:=1 to Qty.ObjectFiles do begin
blockread(f,c,32); ObjName[i]:=StrPas(PAnsiChar(@c[1]));
end;

for i:=1 to Qty.ObjectFiles do begin
blockread(f,ObjProp[i],20);
blockread(f,c,48); ObjProp[i].HitSound:=StrPas(PAnsiChar(@c[1]));
blockread(f,c,48); ObjProp[i].FallSound:=StrPas(PAnsiChar(@c[1]));
if (ObjProp[i].x1<>0)or(ObjProp[i].x2<>0)or(ObjProp[i].x3<>0)or(ObjProp[i].p4<>0) then
MessageBox(Form1.Handle, 'Unknown object entry found. Contact kromster80@gmail.com', 'ObjectsTable', MB_OK or MB_ICONWARNING);
end;

for k:=1 to Qty.BlocksZ do for i:=1 to Qty.BlocksX do
blockread(f,Block[k,i],48);

blockread(f,v05,4*Qty.BlocksTotal*16);
v05[Qty.BlocksTotal*16+1]:=Qty.ColliSize; //Setting last pointer as end of structure

setlength(v06,Qty.BlocksTotal*16+1);
for i:=1 to Qty.BlocksTotal*16 do begin
blockread(f,c,v05[i+1]-v05[i],k); //Reading next-this
setlength(v06[i],k div 2 +1);
for j:=1 to k div 2 do begin
v06[i,j]:=int2(c[j*2-1],c[j*2]);
end;
end;

setlength(v07,Qty.TexturesTotal+1);
blockread(f,v07[1],Qty.TexturesTotal*12);

if EditingFormat=ef_CT then
  for i:=1 to Qty.Materials do begin
    blockread(f,CTMaterial[i],56);
    Material[i].Tex1:=CTMaterial[i].Tex1;
    Material[i].Tex2:=CTMaterial[i].Tex2;
    Material[i].Tex3:=CTMaterial[i].Tex3;
    case CTMaterial[i].Mode of
      112: Material[i].Mode:=32;
      192: Material[i].Mode:=112;
      208: Material[i].Mode:=96;
      240: Material[i].Mode:=160;
      256: Material[i].Mode:=176;
      304: Material[i].Mode:=208;
      320: Material[i].Mode:=224;
      else  Material[i].Mode:=CTMaterial[i].Mode;
    end;
    Form1.Material_ScaleChange(i,3,0,0,0,CTMaterial[i].Matrix[7]*10,CTMaterial[i].Matrix[8]*10,0,0);
    Form1.Material_ScaleChange(i,1,0,0,0,CTMaterial[i].Matrix[3]*10,CTMaterial[i].Matrix[4]*10,0,0);
  end
else
  blockread(f,Material[1],Qty.Materials*116);

Form1.ComputeChunkMode(nil);

if EditingFormat=ef_CT then
  for i:=1 to Qty.ObjectsTotal do begin
    blockread(f,c,32); Obj[i].Name:=StrPas(PAnsiChar(@c[1]));
    blockread(f,Obj[i].ID,16); //20bytes ahead
//    blockread(f,c,16);
//    blockread(f,Obj[i].Angl,4);
    Obj[i].Size:=1;
    blockread(f,c,20);
    blockread(f,Obj[i].Matrix2[1],44);
    if not Obj[i].InShadow in [0,1] then
    MessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'ObjectInShadow', MB_OK or MB_ICONWARNING);
    //if Obj[i].x5<>0 then
    //MyMessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'ObjectX5', MB_OK or MB_ICONWARNING);
  end
else
  for i:=1 to Qty.ObjectsTotal do begin
    blockread(f,c,32); Obj[i].Name:=StrPas(PAnsiChar(@c[1]));
    blockread(f,Obj[i].ID,68);              //Property of object
    if not Obj[i].InShadow in [0,1] then
    MessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'ObjectInShadow', MB_OK or MB_ICONWARNING);
  end;

blockread(f,Light,Qty.Lights*88);

for i:=1 to Qty.GroundTypes do begin
blockread(f,c,64); Ground[i].Name:=StrPas(PAnsiChar(@c[1]));
blockread(f,Ground[i].Dirt,92);
end;

blockread(f,Tex2Ground,512); //256 words

for i:=1 to Qty.Sounds do begin                   //11th
blockread(f,Sound[i],12);
blockread(f,c,32); Sound[i].Name:=StrPas(PAnsiChar(@c[1]));
blockread(f,Sound[i].Volume,24);
if (Sound[i].z4<>EnsureRange(Sound[i].z4,0,3)) then
MessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'Sounds', MB_OK or MB_ICONWARNING);
end;
closefile(f);
end;


procedure LoadQAD_BW(Input:string);
var
  f:file;
  i,j,k:integer;
  Head:record
    Header: array [1..4]of char;
    Version:integer;
  end;
  BWMaterial: array [1..512]of record
    Tex1,Tex2,Tex3,Clear1,Clear2,Clear3,Clear4,Mode:word; //16byte
    Matrix: array [1..8] of single;                         //32byte
    U1,U2,U3,U4,U5,U6:word; //8byte
  end;

begin
if not CheckFileExists(Input+'.qad') then begin
  FillChar(Qty,sizeof(Qty),#0);
  exit;
end;
assignfile(f,Input+'.qad'); reset(f,1);

EditingFormat:=ef_BW;

blockread(f,Head,8);
if Head.Header<>'D'+'A'+'U'+'Q' then begin
  Assert(false,'Unknown BW version');
  exit;
end;

blockread(f,Qty,64);
blockread(f,c,56);

for i:=1 to Qty.TexturesFiles do begin
blockread(f,c,32); TexName[i]:=StrPas(PAnsiChar(@c[1]));
end;

for i:=1 to Qty.BumpTexturesFiles do begin
blockread(f,c,32); BumpTexName[i]:=StrPas(PAnsiChar(@c[1]));
end;
Qty.BumpTexturesFiles:=0;

for i:=1 to Qty.ObjectFiles do begin
blockread(f,c,32); ObjName[i]:=StrPas(PAnsiChar(@c[1]));
end;

for i:=1 to Qty.ObjectFiles do begin
blockread(f,ObjProp[i],20);
blockread(f,c,48); ObjProp[i].HitSound:=StrPas(PAnsiChar(@c[1]));
blockread(f,c,48); ObjProp[i].FallSound:=StrPas(PAnsiChar(@c[1]));
if (ObjProp[i].x1<>0)or(ObjProp[i].x2<>0)or(ObjProp[i].x3<>0)or(ObjProp[i].p4<>0) then
MessageBox(Form1.Handle, 'Unknown object entry found. Contact kromster80@gmail.com', 'ObjectsTable', MB_OK or MB_ICONWARNING);
end;

for k:=1 to Qty.BlocksZ do for i:=1 to Qty.BlocksX do
blockread(f,Block[k,i],48);

blockread(f,v05,4*Qty.BlocksTotal*16);
v05[Qty.BlocksTotal*16+1]:=Qty.ColliSize; //Setting last pointer as end of structure

setlength(v06,Qty.BlocksTotal*16+1);
for i:=1 to Qty.BlocksTotal*16 do begin
blockread(f,c,v05[i+1]-v05[i],k); //Reading next-this
setlength(v06[i],k div 2 +1);
for j:=1 to k div 2 do begin
v06[i,j]:=int2(c[j*2-1],c[j*2]);
end;
end;

setlength(v07,Qty.TexturesTotal+1);
blockread(f,v07[1],Qty.TexturesTotal*12);

  for i:=1 to Qty.Materials do begin
    blockread(f,BWMaterial[i],60);
    Material[i].Tex1:=BWMaterial[i].Tex1;
    Material[i].Tex2:=BWMaterial[i].Tex2;
    Material[i].Tex3:=BWMaterial[i].Tex3;
    case BWMaterial[i].Mode of
      112: Material[i].Mode:=32;
      192: Material[i].Mode:=112;
      208: Material[i].Mode:=96;
      240: Material[i].Mode:=160;
      256: Material[i].Mode:=176;
      304: Material[i].Mode:=208;
      320: Material[i].Mode:=224;
      else  Material[i].Mode:=BWMaterial[i].Mode;
    end;
    Form1.Material_ScaleChange(i,3,0,0,0,BWMaterial[i].Matrix[7]*10,BWMaterial[i].Matrix[8]*10,0,0);
    Form1.Material_ScaleChange(i,1,0,0,0,BWMaterial[i].Matrix[3]*10,BWMaterial[i].Matrix[4]*10,0,0);
  end;

Form1.ComputeChunkMode(nil);
        exit;
//if FormatAFC11CT then
  for i:=1 to Qty.ObjectsTotal do begin
    blockread(f,c,32); Obj[i].Name:=StrPas(PAnsiChar(@c[1]));
    blockread(f,Obj[i].ID,16); //20bytes ahead
//    blockread(f,c,16);
//    blockread(f,Obj[i].Angl,4);
    Obj[i].Size:=1;
    blockread(f,c,20);
    blockread(f,Obj[i].Matrix2[1],44);
    if not Obj[i].InShadow in [0,1] then
    MessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'ObjectInShadow', MB_OK or MB_ICONWARNING);
    if Obj[i].x5<>0 then
    MessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'ObjectX5', MB_OK or MB_ICONWARNING);
  end;

blockread(f,Light,Qty.Lights*88);

for i:=1 to Qty.GroundTypes do begin
  blockread(f,c,64); Ground[i].Name:=StrPas(PAnsiChar(@c[1]));
  blockread(f,Ground[i].Dirt,92);
end;

blockread(f,Tex2Ground,512); //256 words

for i:=1 to Qty.Sounds do begin                   //11th
  blockread(f,Sound[i],12);
  blockread(f,c,32); Sound[i].Name:=StrPas(PAnsiChar(@c[1]));
  blockread(f,Sound[i].Volume,24);
  if (Sound[i].z4<>EnsureRange(Sound[i].z4,0,3)) then
  MessageBox(Form1.Handle, 'Unknown entry found. Contact kromster80@gmail.com', 'Sounds', MB_OK or MB_ICONWARNING);
end;
closefile(f);
end;


function LoadVTX(Input:string):boolean;
var
  f:file;
  i:integer;
begin
Result:=false;
if not fileexists(Input+'.vtx') then begin
  //MyMessageBox(Form1.Handle,'VTX file doesn''t exist at supplied path.','Loading error',MB_OK or MB_ICONWARNING);
  FillChar(VTXQty,sizeof(VTXQty),#0);
  exit;
end;

assignfile(f,Input+'.vtx'); reset(f,1);
blockread(f,VTXQty[1],256); VTXQty[64]:=0;
for i:=1 to 63 do inc(VTXQty[64],VTXQty[i]);
setlength(VTX,VTXQty[64]+1);
blockread(f,VTX[1],VTXQty[64]*32); //read all vertex in one array at once
closefile(f);
Result:=true;
end;

function LoadIDX(Input:string):boolean;
var
  f:file;
  i,k,j,xt,Pos,preXT:integer;
begin
Result:=false;
if not fileexists(Input+'.idx') then begin
  //MyMessageBox(Form1.Handle,'IDX file doesn''t exist at supplied path.','Loading error',MB_OK or MB_ICONWARNING);
  IDXQty:=0;
  exit;
end;

assignfile(f,Input+'.idx'); reset(f,1);
blockread(f,c,length(c),Pos); //16mb should me more than enough
if Pos>=length(c) then MessageBox(Form1.Handle,'16mb IDX file couldn''t be loaded fully.','Loading error',MB_OK or MB_ICONWARNING);
closefile(f);

IDXQty:=int2(c[1],c[2],c[3],c[4]);
setlength(v,IDXQty div 3+1);
Pos:=4; xt:=0; preXT:=0;
for k:=1 to Qty.BlocksZ do
  for i:=1 to Qty.BlocksX do
    for j:=Block[k,i].FirstPoly+1 to Block[k,i].FirstPoly+Block[k,i].NumPoly do begin
      if Block[k,i].Chunk65k<>preXT then begin
        preXT:=Block[k,i].Chunk65k;
        inc(xt,VTXQty[Block[k,i].Chunk65k]);
      end;
      v[j,1]:=ord(c[Pos+1])+ord(c[Pos+2])*256+xt+1;
      v[j,2]:=ord(c[Pos+3])+ord(c[Pos+4])*256+xt+1;
      v[j,3]:=ord(c[Pos+5])+ord(c[Pos+6])*256+xt+1;
      inc(Pos,6);
    end;
Result:=true;
end;


function LoadGEO(Input:string):boolean;
var
  f:file;
  Head:record
    Header: array [1..4]of char;
    x2,x3,sizeX,sizeZ,XZ,Qty,Density:integer;
  end;
  VTX2:record
    X,Y,Z:single;
    nZ,nY,nX,n0:byte;
    U,V,U2,V2:single;
    BlendR,BlendG,BlendB,Shadow,B,G,R,A:byte;
  end;
  i,k,j,xt,Pos,preXT:integer;
begin
  Result:=false;
  if not fileexists(Input+'.geo') then
  begin
    FillChar(VTXQty,sizeof(VTXQty),#0);
    IDXQty:=0;
    exit;
  end;
  assignfile(f,Input+'.geo'); reset(f,1);
  blockread(f,Head,32);
  blockread(f,VTXQty[1],256); VTXQty[64]:=0;
  for i:=1 to 63 do inc(VTXQty[64],VTXQty[i]);
  setlength(VTX,VTXQty[64]+1);

  for i:=1 to VTXQty[64] do
  begin
    blockread(f,VTX2,40);
    VTX[i].X:=VTX2.X; VTX[i].Y:=VTX2.Y; VTX[i].Z:=VTX2.Z;
    VTX[i].nX:=VTX2.nX; VTX[i].nY:=VTX2.nY; VTX[i].nZ:=VTX2.nZ;
    VTX[i].U:=VTX2.U; VTX[i].V:=VTX2.V;
    VTX[i].BlendR:=VTX2.BlendR; VTX[i].BlendG:=VTX2.BlendG; VTX[i].BlendB:=VTX2.BlendB; VTX[i].Shadow:=VTX2.Shadow;
    VTX[i].B:=VTX2.B; VTX[i].G:=VTX2.G; VTX[i].R:=VTX2.R; VTX[i].A:=VTX2.A;
  end;

  IDXQty:=Head.sizeZ;
  blockread(f,c,length(c),Pos); //16mb should me more than enough
  if Pos>=length(c) then
    MessageBox(Form1.Handle,'16mb IDX file couldn''t be loaded fully.','Loading error',MB_OK or MB_ICONWARNING);
  closefile(f);

  setlength(v,IDXQty div 3+1);
  Pos:=0; xt:=0; preXT:=0;
  for k:=1 to Qty.BlocksZ do
  for i:=1 to Qty.BlocksX do
  for j:=Block[k,i].FirstPoly+1 to Block[k,i].FirstPoly+Block[k,i].NumPoly do
  begin
    if Block[k,i].Chunk65k<>preXT then begin preXT:=Block[k,i].Chunk65k; inc(xt,VTXQty[Block[k,i].Chunk65k]); end;
    v[j,1]:=ord(c[Pos+1])+ord(c[Pos+2])*256+xt+1;
    v[j,2]:=ord(c[Pos+3])+ord(c[Pos+4])*256+xt+1;
    v[j,3]:=ord(c[Pos+5])+ord(c[Pos+6])*256+xt+1;
    inc(Pos,6);
  end;

  Result:=true;
end;


function LoadSNI(Input:string):boolean;
var
  f:file;
begin
  if not fileexists(Input+'.sni') then
  begin
    SNIHead.Obj:=0; SNIHead.Node:=0;
    Result:=false; exit;
  end;
  assignfile(f,Input+'.sni'); reset(f,1);
  blockread(f,SNIHead,16);
  blockread(f,SNIObj,SNIHead.Obj*48);
  blockread(f,SNINode,SNIHead.Node*20);
  closefile(f);
  CalculateSNIRoutes();
  Result:=true;
end;

procedure LoadLVL(Input:string);
var
  f:file;
begin
if not fileexists(Input+'.lvl') then begin
  //MyMessageBox(Form1.Handle,'LVL file doesn''t exist at supplied path.','Loading error',MB_OK or MB_ICONWARNING);
  LVL.SunX:=cos(45*pi/180)*cos(60*pi/180);
  LVL.SunY:=sin(60*pi/180);
  LVL.SunZ:=sin(45*pi/180)*cos(60*pi/180);
  Changes.LVL:=true;
  exit;
end;
assignfile(f,Input+'.lvl'); reset(f,1);
blockread(f,LVL,64);
closefile(f);
end;

function LoadSMP(Input:string):boolean;
var
  f:file;
begin
Result:=false;
    if not fileexists(Input) then begin
    SMPHead.A:=0; SMPHead.B:=0;
    exit; end;
assignfile(f,Input); reset(f,1);
blockread(f,SMPHead,68);
    if (SMPHead.A=0)or(SMPHead.B=0) then begin
    closefile(f);
    exit; end;
setlength(SMPData,SMPHead.A*SMPHead.B+1);
blockread(f,SMPData[1],SMPHead.A*SMPHead.B*4);
closefile(f);
Result:=true;
end;


function LoadNET(Input:string):boolean;
var
  f:file;
begin
Result:=false;
if not fileexists(Input) then begin
NETHead.Num1:=0;
NETHead.Num2:=0;
NETHead.Num3:=0;
NETHead.Num4:=0;
NETHead.Num5:=0;
exit; end;
assignfile(f,Input); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,NETHead,28); //NRTS
blockread(f,c,20);

setlength(NET1,NETHead.Num1+2);  //+2 is necessay to handle 0 length case:
setlength(NET2,NETHead.Num2+2);  //+2 is necessay to handle 0 length case:
setlength(NET3,NETHead.Num3+2);  //+2 is necessay to handle 0 length case:
setlength(NET4,NETHead.Num4+2);  //+2 is necessay to handle 0 length case:
setlength(NET5,NETHead.Num5+2);  //+2 is necessay to handle 0 length case:

blockread(f,NET1[1],24*NETHead.Num1); //Nodes
blockread(f,NET2[1],380*NETHead.Num2);//Splines
blockread(f,NET3[1],24*NETHead.Num3); //Splines x2
blockread(f,NET4[1],84*NETHead.Num4); //
blockread(f,NET5[1],128*NETHead.Num5);//
closefile(f);

Result:=true;
end;


function LoadSKY(Input:string):boolean;
var
  ft:textfile;
  ii,kk:integer;
  CHname,s: AnsiString;
begin
result:=false;
if not fileexists(Input+'.sky') then begin
SkyQty:=0; exit;
end;

assignfile(ft,Input+'.sky'); reset(ft);
SkyQty:=0; ii:=1;
repeat
readln(ft,s);
    CHname:=''; kk:=1;
    repeat
    if length(s)>=kk then CHname:=CHname+s[kk];
    inc(kk);
    until((length(s)<kk)or(s[kk]=#32));
    CHname:=uppercase(CHname); //Chapter name now available

if CHname='#' then begin
decs(s,-2);
//ii:=strtoint(s);
inc(SkyQty);
ii:=SkyQty; //I think it's beter to ignore IDs and use straight list
end else

if CHname='SKYTEX' then SKY[ii].SkyTex:=Copy(s,8,length(s)-7) else
if CHname='FOGTAB' then SKY[ii].FogTab:=Copy(s,8,length(s)-7) else
if chname='FOGCOL' then begin
SKY[ii].FogCol.R:=hextoint(s[8 ])*16+hextoint(s[9 ]);
SKY[ii].FogCol.G:=hextoint(s[10])*16+hextoint(s[11]);
SKY[ii].FogCol.B:=hextoint(s[12])*16+hextoint(s[13]);
end else
if chname='SUNCOL' then begin
SKY[ii].SunCol.R:=hextoint(s[8 ])*16+hextoint(s[9 ]);
SKY[ii].SunCol.G:=hextoint(s[10])*16+hextoint(s[11]);
SKY[ii].SunCol.B:=hextoint(s[12])*16+hextoint(s[13]);
end else
if chname='AMBCOL' then begin
SKY[ii].AmbCol.R:=hextoint(s[8 ])*16+hextoint(s[9 ]);
SKY[ii].AmbCol.G:=hextoint(s[10])*16+hextoint(s[11]);
SKY[ii].AmbCol.B:=hextoint(s[12])*16+hextoint(s[13]);
end else
if chname='WLKAMB' then begin
SKY[ii].WlkAmb.R:=hextoint(s[8 ])*16+hextoint(s[9 ]);
SKY[ii].WlkAmb.G:=hextoint(s[10])*16+hextoint(s[11]);
SKY[ii].WlkAmb.B:=hextoint(s[12])*16+hextoint(s[13]);
end else
if chname='WLKSUN' then begin
SKY[ii].WlkSun.R:=hextoint(s[8 ])*16+hextoint(s[9 ]);
SKY[ii].WlkSun.G:=hextoint(s[10])*16+hextoint(s[11]);
SKY[ii].WlkSun.B:=hextoint(s[12])*16+hextoint(s[13]);
end else
if chname='CARSHD' then begin
SKY[ii].CarShd.A:=hextoint(s[8 ])*16+hextoint(s[9 ]);
SKY[ii].CarShd.R:=hextoint(s[10])*16+hextoint(s[11]);
SKY[ii].CarShd.G:=hextoint(s[12])*16+hextoint(s[13]);
SKY[ii].CarShd.B:=hextoint(s[14])*16+hextoint(s[15]);
end;
until(eof(ft));
closefile(ft);
Result:=true;
end;

procedure LoadTRK(Input,Input2:string);
var
  f:file;
  i,ii,kk:integer;
begin
  TracksQty:=0;
  for i:=1 to MAX_TRACKS do
  if fileexists(Input+Input2+'_'+int2fix(i,2)+'.trk') then
  begin
    assignfile(f,Input+Input2+'_'+int2fix(i,2)+'.trk'); reset(f,1);
    blockread(f,TRKQty[i],16);
    setlength(TRK[i].Route,TRKQty[i].Nodes+1);

    if (TRKQty[i].WR2Flag1=0)and(TRKQty[i].WR2Flag2=0) then //MBWR format gets converted to WR2 right here
      for ii:=1 to TRKQty[i].Nodes do
      begin
        blockread(f,TRK[i].Route[ii],72);
        TRK[i].Route[ii].v1:=0; TRK[i].Route[ii].v2:=0;
        TRK[i].Route[ii].v3:=0; TRK[i].Route[ii].v4:=0;
        TRKQty[i].WR2Flag1:=1;
        TRKQty[i].WR2Flag2:=1;
        TRKQty[i].a1:=0;
        TRKQty[i].a2:=1;
        TRKQty[i].Turns:=0;
        TRKQty[i].Arrows:=0;
      end
    else
    begin
      blockread(f,TRK[i].Route[1],76*TRKQty[i].Nodes);
      if (TRKQty[i].WR2Flag1=1)and(TRKQty[i].WR2Flag2=1) then
      begin
        blockread(f,TRKQty[i].a1,16); //append second header to first one
        for kk:=1 to TRKQty[i].Turns do blockread(f,TRK[i].Turns[kk],12);
        for kk:=1 to TRKQty[i].Turns do blockread(f,TRK[i].Turns[kk].Arrows,56*TRK[i].Turns[kk].ArrowNum);
      end;
    end;

    closefile(f);
    inc(TracksQty);
  end
  else
  begin
    FillChar(TRKQty[i],sizeof(TRKQty[i]),#0);
    FillChar(TRK[i],sizeof(TRK[i]),#0);
  end;

  if TracksQty=0 then
    MessageBox(Form1.Handle,'No tracks found in ..\Tracks\ folder','Loading error',MB_OK or MB_ICONWARNING);
end;

procedure LoadTOB(Input,Input2:string);
var
  f:file;
  i,ii:integer;
begin
for i:=1 to MAX_TRACKS do
if fileexists(Input+Input2+'_'+int2fix(i,2)+'.tob') then begin
  assignfile(f,Input+Input2+'_'+int2fix(i,2)+'.tob'); reset(f,1);
  blockread(f,TOBHead[i],16);
  setlength(TOB[i],TOBHead[i].Qty+1);
  for ii:=1 to TOBHead[i].Qty do begin
    blockread(f,c,32); TOB[i,ii].Name:=StrPas(PAnsiChar(@c[1]));
    if EditingFormat=ef_BW then begin
      blockread(f,TOB[i,ii].ID,92);


    end else
      blockread(f,TOB[i,ii].ID,80);
    Matrix2Angles(TOB[i,ii].M,9,@TOB[i,ii].R1,@TOB[i,ii].R2,@TOB[i,ii].R3);
  end;
  closefile(f);
end else
TOBHead[i].Qty:=0;
end;

procedure LoadWTR(Input,Input2:string);
var
  f:file;
  i,k:integer;
begin
TracksQtyWP:=0;
for i:=1 to MAX_WP_TRACKS do
if fileexists(Input+Input2+'_'+int2fix(i,2)+'.wtr') then begin
assignfile(f,Input+Input2+'_'+int2fix(i,2)+'.wtr'); reset(f,1);
blockread(f,WTR[i].NodeQty,16);
setlength(WTR[i].Node,WTR[i].NodeQty+1);
blockread(f,WTR[i].Node[1],52*WTR[i].NodeQty);
closefile(f);
inc(TracksQtyWP);
    WTRLength[i]:=0;
    for k:=1 to WTR[i].NodeQty-1 do
    inc(WTRLength[i],round(GetLength(WTR[i].Node[k+1].X-WTR[i].Node[k].X,
                                     WTR[i].Node[k+1].Y-WTR[i].Node[k].Y,
                                     WTR[i].Node[k+1].Z-WTR[i].Node[k].Z)/10));
end else WTR[i].NodeQty:=0;
end;


procedure LoadWRK(Input:string);
var
  f:file;
  k,ii,h,nr:integer;
  iw:word;
begin
if not fileexists(Input) then begin
for k:=1 to Qty.Materials do MaterialW[k].Name:='';
for k:=1 to Qty.Materials do MaterialW[k].GrowGrass:=0;
for k:=1 to Qty.Materials do MaterialW[k].Enlite:=0;
for k:=1 to Qty.TexturesFiles do TextureW[k].GrowGrass:=0;
exit;
end;
assignfile(f,Input); reset(f,1);
repeat
blockread(f,c,6); c[7]:=#0;

if StrPas(PAnsiChar(@c[1]))='MATNAM' then begin
  blockread(f,ii,4);
  for k:=1 to ii do begin
  blockread(f,c,32); c[33]:=#0;
  MaterialW[k].Name:=StrPas(PAnsiChar(@c[1]));
  end;
end;
if StrPas(PAnsiChar(@c[1]))='LIGHTS' then begin
  blockread(f,iw,2);
  for k:=1 to iw do
  blockread(f,LightW[k].Radius,4);
end;
if StrPas(PAnsiChar(@c[1]))='AMBLIT' then begin
  blockread(f,AmbLightW.R,4);
end;
if StrPas(PAnsiChar(@c[1]))='MATENL' then begin
  blockread(f,ii,4);
  for k:=1 to ii do
  blockread(f,MaterialW[k].Enlite,1);
end;
if StrPas(PAnsiChar(@c[1]))='MATGRS' then begin
  blockread(f,ii,4);
  for k:=1 to ii do
  blockread(f,MaterialW[k].GrowGrass,1);
end;
if StrPas(PAnsiChar(@c[1]))='MATNSH' then begin //NoShadow
  blockread(f,ii,4);
  for k:=1 to ii do
  blockread(f,MaterialW[k].NoShadow,1);
end;
if StrPas(PAnsiChar(@c[1]))='GRSCOL' then begin
  blockread(f,GrassColorW.R,4);
end;
if StrPas(PAnsiChar(@c[1]))='TEXGRS' then begin
  blockread(f,ii,4);
  for k:=1 to ii do
  blockread(f,TextureW[k].GrowGrass,1);
end;
if StrPas(PAnsiChar(@c[1]))='SNWSNI' then begin
  blockread(f,ii,4);
  for k:=1 to ii do
  blockread(f,SNISpawnW[k].Density,12);
end;
if StrPas(PAnsiChar(@c[1]))='LSTTRK' then begin
  blockread(f,TrackID,4);
end;

if StrPas(PAnsiChar(@c[1]))='LWOSRC' then begin
  blockread(f,ii,4);
  if ii<>0 then blockread(f,c,ii);
  c[ii+1]:=#0;
  LWOSceneryFile:=StrPas(PAnsiChar(@c[1]));
end;

if StrPas(PAnsiChar(@c[1]))='MAKTRK' then begin
  blockread(f,k,4); //integer
  TracksQty:=max(k,TracksQty);
  for ii:=1 to k do begin
    blockread(f,MakeTrack[ii].NodeQty,4); //integer
    setlength(MakeTrack[ii].Node,MakeTrack[ii].NodeQty+2);
    for h:=1 to MakeTrack[ii].NodeQty do begin
      blockread(f,MakeTrack[ii].Node[h].X,16,nr); //3single+2word+boolean
      blockread(f,c,1,nr); //boolean
      MakeTrack[ii].Node[h].Tunnel:=c[1]=#1;
    end;
  end;
  Form1.RebuildMTSplines();
end;

until(eof(f));
nr:=nr*10;
closefile(f);
end;

procedure SaveQAD(Input:string);
var
  f:file;
  i,k:integer;
begin
Form1.SortMaterialModes(nil);
Form1.RemakeQADTable(nil);

assignfile(f,Input); rewrite(f,1);

blockwrite(f,Qty,64);

for i:=1 to Qty.TexturesFiles do
blockwrite(f,chr2(TexName[i],32)[1],32);

for i:=1 to Qty.ObjectFiles do
blockwrite(f,chr2(ObjName[i],32)[1],32);

for i:=1 to Qty.ObjectFiles do begin
blockwrite(f,ObjProp[i],20);
blockwrite(f,chr2(ObjProp[i].HitSound,48)[1],48);
blockwrite(f,chr2(ObjProp[i].FallSound,48)[1],48);
end;

for k:=1 to Qty.BlocksZ do
for i:=1 to Qty.BlocksX do
blockwrite(f,Block[k,i],48);

blockwrite(f,v05,4*Qty.BlocksTotal*16);

for i:=1 to Qty.BlocksTotal*16 do
blockwrite(f,v06[i,1],v05[i+1]-v05[i]);

blockwrite(f,v07[1],Qty.TexturesTotal*12);

blockwrite(f,Material[1],Qty.Materials*116);

for k:=1 to Qty.BlocksTotal do
for i:=1 to Qty.ObjectsTotal do
if ObjW[i].ParentBlock=k then begin
blockwrite(f,chr2(Obj[i].Name,32)[1],32);
blockwrite(f,Obj[i].ID,68);              //Property of object
end;

for k:=1 to Qty.BlocksTotal do
for i:=1 to Qty.Lights do
if LightW[i].ParentBlock=k then
blockwrite(f,Light[i].Mode,88);              //Property of object

for i:=1 to Qty.GroundTypes do begin
blockwrite(f,chr2(Ground[i].Name,64)[1],64);
blockwrite(f,Ground[i].Dirt,92);
end;

blockwrite(f,Tex2Ground,512); //256 words

for i:=1 to Qty.Sounds do begin                   //11th
blockwrite(f,Sound[i],12);
blockwrite(f,chr2(Sound[i].Name,32)[1],32);
blockwrite(f,Sound[i].Volume,24);
end;

closefile(f);
Changes.QAD:=false;
end;

procedure SaveIDX(Input:string);
var
  f:file;
  i,k,h,Chunk65k,x,z:integer;
  idx: array [1..3]of word;
begin
assignfile(f,Input); rewrite(f,1);
blockwrite(f,IDXQty,4); //8mb
Chunk65k:=0; h:=1;
for i:=1 to Qty.BlocksX*Qty.BlocksZ do begin
  x:=(i-1) mod Qty.BlocksX+1;
  z:=(i-1) div Qty.BlocksX+1;
  if Block[z,x].Chunk65k=h then begin
    inc(Chunk65k,VTXQty[h]);
    inc(h);
  end;
  for k:=Block[z,x].FirstPoly+1 to Block[z,x].FirstPoly+Block[z,x].NumPoly do begin
//  if ((v[k,1]-Chunk65k-1)<0)or((v[k,1]-Chunk65k-1)>65535) then
//    Chunk65k:=0;
    idx[1]:=v[k,1]-Chunk65k-1;
    idx[2]:=v[k,2]-Chunk65k-1;
    idx[3]:=v[k,3]-Chunk65k-1;
    blockwrite(f,idx,6);
  end;
end;
closefile(f);
Changes.IDX:=false;
end;

procedure SaveVTX(Input:string);
var
  f:file;
begin
assignfile(f,Input); rewrite(f,1);
blockwrite(f,VTXQty[1],252);
blockwrite(f,#0+#0+#0+#0,4);
blockwrite(f,VTX[1],VTXQty[64]*32);
closefile(f);
Changes.VTX:=false;
end;

procedure SaveSNI(Input:string);
var
  f:file;
begin
assignfile(f,Input); rewrite(f,1);
blockwrite(f,SNIHead,16);
blockwrite(f,SNIObj,SNIHead.Obj*48);
blockwrite(f,SNINode,SNIHead.Node*20);
closefile(f);
Changes.SNI:=false;
end;


procedure SaveTRK(Input:string;ID:integer);
var
  f:file;
  ii,kk,N:integer;
  order: array [1..256]of word;
begin
ElapsedTime(@OldTime);

N:=0;
for ii:=1 to TRKQty[ID].Nodes do        //if = 0 then skipped
for kk:=1 to TRKQty[ID].Turns do
if TRK[ID].Turns[kk].Node1=ii then begin
inc(N);
order[N]:=kk;
end;
TRKQty[ID].Turns:=N; //all non-zeroed

TRKQty[ID].Arrows:=0; //total number of arrows
for ii:=1 to TRKQty[ID].Turns do
inc(TRKQty[ID].Arrows,TRK[ID].Turns[order[ii]].ArrowNum);

assignfile(f,Input); rewrite(f,1);
blockwrite(f,TRKQty[ID],16);
blockwrite(f,TRK[ID].Route[1],76*TRKQty[ID].Nodes);
blockwrite(f,TRKQty[ID].a1,16);
N:=0;
for ii:=1 to TRKQty[ID].Turns do begin
blockwrite(f,TRK[ID].Turns[order[ii]],4);
blockwrite(f,N,2); //Arrow1
blockwrite(f,TRK[ID].Turns[order[ii]].ArrowNum,6);
inc(N,TRK[ID].Turns[order[ii]].ArrowNum);
end;
for ii:=1 to TRKQty[ID].Turns do
blockwrite(f,TRK[ID].Turns[order[ii]].Arrows,56*TRK[ID].Turns[order[ii]].ArrowNum);
closefile(f);
//Form1.Memo1.Lines.Add('Track saved in'+ElapsedTime(@OldTime));
Changes.TRK[ID]:=false;
end;

procedure SaveTOB(Input:string; ID:integer);
var
  f:file;
  ii:integer;
begin
ElapsedTime(@OldTime);
assignfile(f,Input); rewrite(f,1);
blockwrite(f,TOBHead[ID],16);
for ii:=1 to TOBHead[ID].Qty do begin
blockwrite(f,chr2(TOB[ID,ii].Name,32)[1],32);
blockwrite(f,TOB[ID,ii].ID,80);
end;
closefile(f);
//Form1.Memo1.Lines.Add('TOB saved in'+ElapsedTime(@OldTime));
Changes.TOB[ID]:=false;
end;

procedure SaveWTR(Input:string; ID:integer);
var
  f:file;
begin
assignfile(f,Input); rewrite(f,1);
blockwrite(f,WTR[ID].NodeQty,16);
blockwrite(f,WTR[ID].Node[1],52*WTR[ID].NodeQty);
closefile(f);
Changes.WTR[ID]:=false;
end;

procedure SaveTRK_DAT(Input:string);
var
  f:file;
begin
assignfile(f,Input); rewrite(f,1);
blockwrite(f,TracksQty,4);
fillchar(c[1],60,#0);
blockwrite(f,c,60);
closefile(f);
end;

procedure SaveLVL(Input:string);
var
  f:file;
begin
assignfile(f,Input); rewrite(f,1);
blockwrite(f,LVL,64);
closefile(f);
Changes.LVL:=false;
end;

procedure SaveSMP(Input:string);
var
  f:file;
begin
if SMPHead.A=0 then exit;
assignfile(f,Input); rewrite(f,1);
blockwrite(f,SMPHead,68);
blockwrite(f,SMPData[1],SMPHead.A*SMPHead.B*4);
closefile(f);
Changes.SMP:=false;
end;

procedure SaveSKY(Input:string);
var
  ft:textfile;
  i:integer;
begin
assignfile(ft,Input); rewrite(ft);
for i:=1 to SKYQty do begin
writeln(ft,'# '+inttostr(i));
writeln(ft,'SkyTex '+SKY[i].SkyTex);
writeln(ft,'FogTab '+SKY[i].FogTab);
writeln(ft,'FogCol '+inttohex(SKY[i].FogCol.R,2)+inttohex(SKY[i].FogCol.G,2)+inttohex(SKY[i].FogCol.B,2));
writeln(ft,'SunCol '+inttohex(SKY[i].SunCol.R,2)+inttohex(SKY[i].SunCol.G,2)+inttohex(SKY[i].SunCol.B,2));
writeln(ft,'AmbCol '+inttohex(SKY[i].AmbCol.R,2)+inttohex(SKY[i].AmbCol.G,2)+inttohex(SKY[i].AmbCol.B,2));
writeln(ft,'WlkAmb '+inttohex(SKY[i].WlkAmb.R,2)+inttohex(SKY[i].WlkAmb.G,2)+inttohex(SKY[i].WlkAmb.B,2));
writeln(ft,'WlkSun '+inttohex(SKY[i].WlkSun.R,2)+inttohex(SKY[i].WlkSun.G,2)+inttohex(SKY[i].WlkSun.B,2));
writeln(ft,'CarShd A0000000');
writeln(ft);
end;
closefile(ft);
Changes.SKY:=false;
end;


procedure SaveWRK(Input:string);
var
  f:file;
  i,k:integer;
begin
assignfile(f,Input); rewrite(f,1);

blockwrite(f,'MATNAM',6);
blockwrite(f,Qty.Materials,4); //integer
for i:=1 to Qty.Materials do
blockwrite(f,chr2(MaterialW[i].Name,32)[1],32);

blockwrite(f,'LIGHTS',6);
blockwrite(f,Qty.Lights,2); //word
for i:=1 to Qty.Lights do
blockwrite(f,LightW[i].Radius,4); //2byte Radius + 2byte Mode

blockwrite(f,'AMBLIT',6);
blockwrite(f,AmbLightW.R,4);

blockwrite(f,'MATENL',6);
blockwrite(f,Qty.Materials,4); //integer
//since MaterialW is array of records we can't write all bytes at once
for i:=1 to Qty.Materials do
blockwrite(f,MaterialW[i].Enlite,1);

blockwrite(f,'MATGRS',6);
blockwrite(f,Qty.Materials,4); //integer
for i:=1 to Qty.Materials do
blockwrite(f,MaterialW[i].GrowGrass,1);

blockwrite(f,'MATNSH',6);
blockwrite(f,Qty.Materials,4); //integer
for i:=1 to Qty.Materials do
blockwrite(f,MaterialW[i].NoShadow,1);

blockwrite(f,'GRSCOL',6);
blockwrite(f,GrassColorW.R,4);

blockwrite(f,'TEXGRS',6);
blockwrite(f,Qty.TexturesFiles,4); //integer
for i:=1 to Qty.TexturesFiles do
blockwrite(f,TextureW[i].GrowGrass,1);

blockwrite(f,'SNWSNI',6);
blockwrite(f,SNIHead.Obj,4); //integer
for i:=1 to SNIHead.Obj do
blockwrite(f,SNISpawnW[i].Density,12);

blockwrite(f,'LSTTRK',6);
blockwrite(f,TrackID,4); //integer

blockwrite(f,'LWOSRC',6);
i:=length(LWOSceneryFile);
blockwrite(f,i,4); //integer
if i<>0 then blockwrite(f,LWOSceneryFile[1],i); //integer

blockwrite(f,'MAKTRK',6);
blockwrite(f,TracksQty,4); //integer
for i:=1 to TracksQty do begin
  blockwrite(f,MakeTrack[i].NodeQty,4); //integer
  for k:=1 to MakeTrack[i].NodeQty do
    blockwrite(f,MakeTrack[i].Node[k].X,17); //3single+2word+boolean
end;

closefile(f);
Changes.WRK:=false;
end;

end.
