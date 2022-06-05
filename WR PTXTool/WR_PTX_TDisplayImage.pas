unit WR_PTX_TDisplayImage;
interface
uses
  Windows, ExtCtrls, Graphics, SysUtils,Math, kromUtils, Controls, Forms, WR_PTX_TDXT_Alpha, WR_PTX_TDXT_Color;

type
  TConversionMode = (cmRGB, cmA, cmRGBA);

type
  TDisplayImage = class
  private
    BitmapRGB,BitmapA:TBitmap;
    ImageRGB,ImageA:TImage;
    Rect:TRect;
    Props:record
      FileMask:string;
      sizeH,sizeV,MipMapQty:integer;
      IsCompressed:boolean;
      IsSYNPacked:boolean;
      hasAlpha:boolean;
    end;
    RGBA:array [1..2049,1..2049,1..4]of byte;
    RGBAmm:array [1..2049,1..2049,1..4]of byte;
    RMS:array[1..4]of single;
    Fog2: array[1..3]of Byte;
    MipMapQtyUse:integer;
    MipMapQtyMax:integer;
    IsChanged:boolean;
    procedure GenerateMipMap(Width,Height,MMH,MMV,Lev:integer);
    procedure ResetAllData;
    procedure SetAllPropsAtOnce(iFileMask:string; iSizeH,iSizeV,iMipMapQty:integer;
              iIsCompressed,iIsSYNPacked,ihasAlpha:boolean);
  public
    AllowNonPOTImages:boolean;
    property GetFileMask:string read Props.FileMask;
    property GetMipMapQty:integer read Props.MipMapQty;
    property GetMipMapQtyUse:integer read MipMapQtyUse;
    property SetMipMapQtyUse:integer write MipMapQtyUse;
    property GetMaxMipMapQty:integer read MipMapQtyMax;
    property GetCompression:boolean read Props.IsCompressed;
    property GetPacked:boolean read Props.IsSYNPacked;
    property GetAlpha:boolean read Props.hasAlpha;
    constructor Create(inBitmapRGB,inBitmapA:TBitmap; inImageRGB,inImageA:TImage);
    function DisplayImage:boolean;
    function GetInfoString():string;
    function GetFogString():string;
    function GetRMSString():string;
    function GetChangedString():string;
    procedure ComputeFog();
    procedure KnowMaxMipMapQty();
    procedure InvertAlpha;
    procedure ClearAlpha;
    procedure RGB2Bitm(aMode: TConversionMode);
    procedure OpenPTX(aFileName:string);
    procedure OpenDDS(aFileName:string);
    procedure OpenXTX(aFileName:string);
    procedure OpenTGA(aFileName:string);
    procedure Open2DB(aFileName:string);
    procedure SaveUncompressedPTX(FileName:string);
    procedure SaveCompressedPTX(FileName:string);
    procedure SaveTGA(FileName:string);
    procedure SaveMipMap(FileName:string; Lev:integer);
    procedure ExportBitmapRGB(FileName:string);
    procedure ExportBitmapA(FileName:string);
    procedure ImportBitmapRGB(FileName:string);
    procedure ImportBitmapA(FileName:string);
    procedure CreateAlphaFrom(X,Y:integer);
    procedure ReplaceColorKeyFrom(X,Y:integer);
  end;


implementation


constructor TDisplayImage.Create(inBitmapRGB,inBitmapA:TBitmap; inImageRGB,inImageA:TImage);
begin
  BitmapRGB     := inBitmapRGB;
  BitmapA       := inBitmapA;
  BitmapRGB.PixelFormat := pf24bit;
  BitmapA.PixelFormat   := pf24bit;
  ImageRGB      := inImageRGB;
  ImageA        := inImageA;
end;


function TDisplayImage.DisplayImage:boolean;
begin
  Result := false;

  BitmapRGB.Width := Props.sizeH;
  BitmapRGB.Height:= Props.sizeV;
  BitmapA.Width   := Props.sizeH;
  BitmapA.Height  := Props.sizeV;

  Rect.Bottom := ImageRGB.Height;
  Rect.Right  := ImageRGB.Width;

  ImageRGB.Canvas.Brush.Color := 128*65793; ImageRGB.Canvas.FillRect(Rect);
  ImageA.Canvas.Brush.Color   := 128*65793; ImageA.Canvas.FillRect(Rect);

  if Props.sizeH*Props.sizeV=0 then exit; //Image didn't loaded

  if (Props.sizeH / Props.sizeV) > 1 then
    Rect.Bottom:=round(ImageRGB.Height / (Props.sizeH / Props.sizeV))
  else
    Rect.Right :=round(ImageRGB.Width  / (Props.sizeV / Props.sizeH));

  ImageRGB.Picture.Graphic.Height := ImageRGB.Height;
  ImageRGB.Picture.Graphic.Width := ImageRGB.Width;
  ImageA.Picture.Graphic.Height := ImageA.Height;
  ImageA.Picture.Graphic.Width := ImageA.Width;

  RGB2Bitm(cmRGB);
  ImageRGB.Canvas.StretchDraw(Rect, BitmapRGB);

  if Props.hasAlpha then
  begin
    RGB2Bitm(cmA);
    ImageA.Canvas.StretchDraw(Rect, BitmapA);
  end;

  KnowMaxMipMapQty;

  Result := true;
end;

function TDisplayImage.GetInfoString():string;
begin
  Result:='Size - '+IntToStr(Props.SizeH)+'x'+IntToStr(Props.SizeV)+' RGB';
  if Props.hasAlpha then Result := Result + 'A'; //RGB+A
end;

function TDisplayImage.GetFogString():string;
begin
  Result := 'R' + IntToStr(Fog2[1]) + '  G' + IntToStr(Fog2[2]) + '  B' + IntToStr(Fog2[3]);
end;

function TDisplayImage.GetRMSString():string;
begin
  if RMS[1]+RMS[2]+RMS[3]+RMS[4]>0 then
    Result:='RMS '+floattostr(round((RMS[1]+RMS[2]+RMS[3])*33.3)/100)+'  '+floattostr(round(RMS[4]*100)/100);
end;

function TDisplayImage.GetChangedString():string;
begin if IsChanged then Result:='*' else Result:=''; end;

procedure TDisplayImage.ComputeFog();
var
  I,K: Integer;
  fr,fg,fb: Int64;
begin
  fr := 0;
  fg := 0;
  fb := 0;
  for I := 1 to Props.sizeV do
  for K := 1 to Props.sizeH do
  begin
    fr := fr + (RGBA[I,K,1]);
    fg := fg + (RGBA[I,K,2]);
    fb := fb + (RGBA[I,K,3]);
  end;
  Fog2[1] := round(fr / (Props.sizeV * Props.sizeH));
  Fog2[2] := round(fg / (Props.sizeV * Props.sizeH));
  Fog2[3] := round(fb / (Props.sizeV * Props.sizeH));
end;

procedure TDisplayImage.KnowMaxMipMapQty();
var x:integer;
begin
MipMapQtyMax:=0;
x:=Math.min(Props.sizeH,Props.sizeV);
repeat x:=x div 2; inc(MipMapQtyMax); until(x<=2);     //min size 4x1 pixels.
end;

procedure TDisplayImage.InvertAlpha;
var
  i,k: integer;
begin
  for i:=1 to Props.sizeV do
  for k:=1 to Props.sizeH do
    RGBA[i,k,4]:=255-RGBA[i,k,4];
  RGB2Bitm(cmA);
  ImageA.Canvas.StretchDraw(Rect,BitmapA);
end;

procedure TDisplayImage.ClearAlpha;
var i,k:integer;
begin
  Props.hasAlpha:=false;
  for i:=1 to Props.sizeV do
    for k:=1 to Props.sizeH do
      RGBA[i,k,4]:=0;
  ImageA.Canvas.Brush.Color:=128*65793;
  ImageA.Canvas.FillRect(Rect);
end;


procedure TDisplayImage.RGB2Bitm(aMode: TConversionMode);
var
  pRGBLine: PByteArray;
  pALine: PByteArray;
  prevCursor:TCursor;
  i,k:integer;
begin
  prevCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;

  if aMode in [cmRGBA, cmRGB] then
    for i := 1 to Props.sizeV do
    begin
      pRGBLine:=BitmapRGB.ScanLine[i-1];
      for k := 1 to Props.sizeH do
      begin
        pRGBLine[k*3-3] := RGBA[i,k,3];
        pRGBLine[k*3-2] := RGBA[i,k,2];
        pRGBLine[k*3-1] := RGBA[i,k,1];
      end;
    end;

  if aMode in [cmRGBA, cmA] then
    for i := 1 to Props.sizeV do
    begin
      pALine := BitmapA.ScanLine[i-1];
      for k := 1 to Props.sizeH do
      begin
        pALine[k*3-3] := RGBA[i,k,4];
        pALine[k*3-2] := RGBA[i,k,4];
        pALine[k*3-1] := RGBA[i,k,4];
      end;
    end;

  Screen.Cursor:=prevCursor;
end;


procedure TDisplayImage.GenerateMipMap(Width,Height,MMH,MMV,Lev:integer);
var i,k,h,j:integer; Area:word; Ratio:single; Tmp1,Tmp2,Tmp3,Tmp4,Acc:single;
begin
  if Lev=1 then begin
    for i:=1 to MMV do for k:=1 to MMH do begin
      RGBAmm[i,k,1]:=RGBA[i,k,1]; RGBAmm[i,k,2]:=RGBA[i,k,2];
      RGBAmm[i,k,3]:=RGBA[i,k,3]; RGBAmm[i,k,4]:=RGBA[i,k,4];
    end;
    exit;
  end;

  Area:=pow(2,Lev-1); //1..1024 (one side only), temp limit to 16
  for i:=1 to MMV do for k:=1 to MMH do begin
    Tmp1:=0; Tmp2:=0; Tmp3:=0; Tmp4:=0; Acc:=0;
    for h:=1 to Area do for j:=1 to Area do begin
      Ratio:=sqr( Area/2 - (h-0.5) ) + sqr( Area/2 - (j-0.5) );
      Ratio:=Math.max(1-sqrt(Ratio)/Area,0);
      //Ratio:=sqr(Ratio); //Fits rather good but kills thin lines
      Tmp1:=Tmp1+RGBA[(i-1)*Area+h,(k-1)*Area+j,1]*Ratio;
      Tmp2:=Tmp2+RGBA[(i-1)*Area+h,(k-1)*Area+j,2]*Ratio;
      Tmp3:=Tmp3+RGBA[(i-1)*Area+h,(k-1)*Area+j,3]*Ratio;
      Tmp4:=Tmp4+RGBA[(i-1)*Area+h,(k-1)*Area+j,4]*Ratio;
      Acc:=Acc+Ratio;
    end;
    Acc:=Math.max(Acc,1);
    RGBAmm[i,k,1]:=round(EnsureRange(Tmp1/Acc,0,255));
    RGBAmm[i,k,2]:=round(EnsureRange(Tmp2/Acc,0,255));
    RGBAmm[i,k,3]:=round(EnsureRange(Tmp3/Acc,0,255));
    RGBAmm[i,k,4]:=round(EnsureRange(Tmp4/Acc,0,255));
  end;
end;


procedure TDisplayImage.ResetAllData;
begin
  FillChar(RGBA,SizeOf(RGBA),#0);
  FillChar(Fog2, SizeOf(Fog2), #0);
  FillChar(Props,SizeOf(Props),#0);
  IsChanged:=true;
end;


procedure TDisplayImage.SetAllPropsAtOnce(iFileMask:string;
iSizeH,iSizeV,iMipMapQty:integer; iIsCompressed,iIsSYNPacked,ihasAlpha:boolean);
begin
  Props.FileMask:=iFileMask;
  Props.sizeH:=iSizeH;
  Props.sizeV:=iSizeV;
  Props.MipMapQty:=iMipMapQty;
  Props.IsCompressed:=iIsCompressed;
  Props.IsSYNPacked:=iIsSYNPacked;
  Props.hasAlpha:=ihasAlpha;
end;

procedure TDisplayImage.OpenPTX(aFileName:string);
var
  i,k,h:integer;
  a,b:^byte;
  tb:integer;
  f:file;
  c,d:array of AnsiChar;
  SYNData,PTXData:integer;
  ci,CurChr,addv,x:integer;
  flag:array[1..8]of byte;
  Dist,Leng:integer;
  DXTOut:array[1..48]of byte;
begin
  ResetAllData;
  assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  SetLength(c,24+1);
  blockread(f,c[1],24);

  if ((c[1]<>#0)and(c[1]<>#1))or((c[2]<>#32)and(c[2]<>#24)and(c[2]<>#16)) then begin
    MessageBox(0, 'Unknown PTX format, can''t be opened.', 'Error', MB_OK);
    closefile(f);
    exit;
  end;

  if (int2(c[5],c[6])>2048)or(int2(c[9],c[10])>2048) then begin
    MessageBox(0,'Big images (2048+ pixels) are not supported','Error',mb_ok);
    closefile(f);
    exit;
  end;

  IsChanged:=false;

  SetAllPropsAtOnce(
    decs(ExtractFileName(aFileName),4,1),
    int2(c[5],c[6]),int2(c[9],c[10]),ord(c[13]),
    c[1]=#1,int2(c[21],c[22],c[23],c[24])<>0,c[2]=#32);

  MipMapQtyUse := Props.MipMapQty;

  SYNData:=int2(c[21],c[22],c[23],c[24]);

  if Props.IsCompressed then
    if Props.hasAlpha then
      PTXData:=Props.sizeH*Props.sizeV
    else
      PTXData:=Props.sizeH*Props.sizeV div 2
  else
    PTXData:=Props.sizeH*Props.sizeV*4;


  ////////////////////////////////////////////////////////////////////////////////
  //read data / decode
  ////////////////////////////////////////////////////////////////////////////////
  if SYNData>0 then
  begin //decompress
    setlength(d,SYNData+100);
    setlength(c,PTXData+100);
    blockread(f,d[1],SYNData); //read all needed data

    ci:=1; CurChr:=1; //currentbyte
    addv:=0;
    repeat
      x:=ord(d[ci]); inc(ci);
      if x>=128 then begin x:=x-128; flag[8]:=1; end else flag[8]:=2;  //2 means 0
      if x>=64 then begin x:=x-64; flag[7]:=1; end else flag[7]:=2;    //1-Take that
      if x>=32 then begin x:=x-32; flag[6]:=1; end else flag[6]:=2;    //2-Take from behind
      if x>=16 then begin x:=x-16; flag[5]:=1; end else flag[5]:=2;
      if x>=8 then begin x:=x-8; flag[4]:=1; end else flag[4]:=2;
      if x>=4 then begin x:=x-4; flag[3]:=1; end else flag[3]:=2;
      if x>=2 then begin x:=x-2; flag[2]:=1; end else flag[2]:=2;
      if x>=1 then begin {x:=x-1;} flag[1]:=1; end else flag[1]:=2;

      for i:=1 to 8 do if flag[i]=1 then begin
        c[CurChr]:=d[ci];
        inc(CurChr);
        inc(ci);
      end else begin

        Dist:=ord(d[ci])+(ord(d[ci+1]) AND $F0)*16; //1byte + 4bits from 2nd byte  Length is only last 4bits+3
        Leng:=(ord(d[ci+1]) AND $0F) + 3;

        if CurChr>(18+addv+4096) then inc(addv,4096);

        for k:=1 to Leng do
          if Dist>=(CurChr-addv) then
            if (18+k+Dist+addv-4096)<=0 then
              c[CurChr+k-1]:=#32 //if overlap backward
            else
              c[CurChr+k-1]:=c[18+k+Dist+addv-4096]
          else
            if (18+k+Dist+addv)>(CurChr+k-1) then //if overlap forward
              c[CurChr+k-1]:=c[18+k+Dist+addv-4096]
            else
              c[CurChr+k-1]:=c[18+k+Dist+addv];
              //Synetic used ring buffer filled with #32 after all :-)
        inc(CurChr,Leng);
        inc(ci,2);
      end;
    until(ci>SYNData);
  end;

  if Props.IsCompressed and (SYNData=0) then
  begin
    setlength(c,PTXData+1);
    blockread(f,c[1],PTXData); //read all needed data
  end;

  ci:=1;
  if Props.IsCompressed then
  begin

    for i:=0 to (Props.sizeV div 4)-1 do
      for k:=0 to (Props.sizeH div 4)-1 do begin
        ///////////////////////////////////////////////////////
        //Alpha
        if Props.hasAlpha then begin

          DXT_A_Decode(@c[ci],DXTOut);

          for h:=1 to 16 do
            RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
          inc(ci,8);
        end;
        ////////////////////////////////////////////////////////
        //RGB
        DXT_RGB_Decode(@c[ci],DXTOut);
        for h:=1 to 16 do begin
          RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
          RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
          RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
        end;
        inc(ci,8);
      end;  //for 1..x,1..z

  end else
  begin //Compressed=0

    for i:=1 to Props.sizeV do
    begin
      blockread(f,RGBA[i,1,1],Props.sizeH*4);
      for k:=1 to Props.sizeH do
       begin
        a:=@RGBA[i,k,1]; //fast exchange
        b:=@RGBA[i,k,3];
        tb:=a^; a^:=b^; b^:=tb;
      end;
    end;

  end;
  closefile(f);

  ComputeFog;
end;


procedure TDisplayImage.OpenDDS(aFileName: string);
var i,k,h:integer; ftype:string[4];
  f:file;
  c:array[1..128]of AnsiChar;
  T:byte;
  DXTOut:array[1..48]of byte;
begin
ResetAllData;
assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,c,128);

if (int2(c[17],c[18])>2048)or(int2(c[13],c[14])>2048) then begin
  MessageBox(0,'Big images (2048+) are not supported','Error',mb_ok);
  closefile(f);
  exit;
end;

IsChanged:=false;
SetAllPropsAtOnce(
        decs(ExtractFileName(aFileName),4,1),
        int2(c[17],c[18]),int2(c[13],c[14]),ord(c[29]),
        true,false,(c[88]='3')or(c[88]='5'));

  fType:=c[85]+c[86]+c[87]+c[88];
  MipMapQtyUse:=Props.MipMapQty;

for i:=0 to (Props.sizeV div 4)-1 do
  for k:=0 to (Props.sizeH div 4)-1 do begin
///////////////////////////////////////////////////////
//Alpha
if Props.hasAlpha then begin
blockread(f,c,8);
if ftype='DXT5' then begin
  DXT_A_Decode(@c[1],DXTOut);
  for h:=1 to 16 do
    RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
end else
if ftype='DXT3' then begin
  for h:=1 to 16 do begin
    if h mod 2 = 1 then
    T:=(ord(c[(h+1)div 2])mod 16)*17 else
    T:=(ord(c[(h+1)div 2])div 16)*17;
    RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=T;
  end;
end; //Format type DXT3 or DXT5
end; //if alpha
////////////////////////////////////////////////////////
//RGB
blockread(f,c,8);
DXT_RGB_Decode(@c[1],DXTOut);
for h:=1 to 16 do begin
  RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
  RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
  RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
end;

end;
closefile(f);

ComputeFog();
FillChar(RMS,SizeOf(RMS),#0);
end;


procedure TDisplayImage.OpenXTX(aFileName: string);
var i,k,h:integer; ftype:string[4];
  f:file;
  c:array[1..128]of byte;
  T:byte;
  DXTOut:array[1..48]of byte;
begin
ResetAllData;
assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,c,52);

{if (int2(c[17],c[18])>2048)or(int2(c[13],c[14])>2048) then begin
  MessageBox(0,'Big images (2048+) are not supported','Error',mb_ok);
  closefile(f);
  exit;
end;  }

IsChanged:=false;
SetAllPropsAtOnce(
        decs(ExtractFileName(aFileName),4,1),
        64,64,1,
        true,false,true);

  fType:='DXT5';//c[85]+c[86]+c[87]+c[88];
  MipMapQtyUse:=Props.MipMapQty;

for i:=0 to (Props.sizeV div 4)-1 do
  for k:=0 to (Props.sizeH div 4)-1 do begin
///////////////////////////////////////////////////////
//Alpha
if Props.hasAlpha then begin
blockread(f,c,8);
  SwapInt(c[1],c[2]);
  SwapInt(c[3],c[4]);
  SwapInt(c[5],c[6]);
  SwapInt(c[7],c[8]);
if ftype='DXT5' then begin
  DXT_A_Decode(@c[1],DXTOut);
  for h:=1 to 16 do
    RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
end else
if ftype='DXT3' then begin
  for h:=1 to 16 do begin
    if h mod 2 = 1 then
    T:=(ord(c[(h+1)div 2])mod 16)*17 else
    T:=(ord(c[(h+1)div 2])div 16)*17;
    RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=T;
  end;
end; //Format type DXT3 or DXT5
end; //if alpha
////////////////////////////////////////////////////////
//RGB
blockread(f,c,8);
SwapInt(c[1],c[2]);
SwapInt(c[3],c[4]);
SwapInt(c[5],c[6]);
SwapInt(c[7],c[8]);
DXT_RGB_Decode(@c[1],DXTOut);
for h:=1 to 16 do begin
  RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
  RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
  RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
end;

end;
closefile(f);

ComputeFog();
FillChar(RMS,SizeOf(RMS),#0);
end;


procedure TDisplayImage.OpenTGA(aFileName: string);
var i,k:integer;
  f:file;
  c:array of AnsiChar;
  tSizeH,tSizeV:integer;
  InBit:byte;
begin
ResetAllData;

AssignFile(f,aFileName); FileMode:=0; Reset(f,1); FileMode:=2;
setlength(c,18+1);
BlockRead(f,c[1],18);
tSizeH:=int2(c[13],c[14]);
tSizeV:=int2(c[15],c[16]);
InBit:=ord(c[17]);

if ((InBit<>24)and(InBit<>32))or
   ((MakePOT(tSizeH)<>tSizeH)and(not AllowNonPOTImages))or((MakePOT(tSizeV)<>tSizeV)and(not AllowNonPOTImages))or
   (tSizeH<4)or(tSizeV<4)or(tSizeH>2048)or(tSizeV>2048) then begin
  MessageBox(0,'Image size must be 4,8,16,32...2048 x 24/32 bit','Error',mb_ok);
  closefile(f);
  exit;
end;

IsChanged:=false;
SetAllPropsAtOnce(
        decs(ExtractFileName(aFileName),4,1),
        tSizeH,tSizeV,1,
        false,false,InBit=32);

  KnowMaxMipMapQty;
  MipMapQtyUse:=MipMapQtyMax;

setlength(c,Props.SizeH*4+1);

for i:=Props.sizeV downto 1 do begin
  if InBit=24 then BlockRead(f,c[1],Props.SizeH*3);
  if InBit=32 then BlockRead(f,c[1],Props.SizeH*4);
  for k:=1 to Props.sizeH do
    if InBit=24 then begin
      RGBA[i,k,1]:=ord(c[k*3-0]);
      RGBA[i,k,2]:=ord(c[k*3-1]);
      RGBA[i,k,3]:=ord(c[k*3-2]);
    end else
    if InBit=32 then begin
      RGBA[i,k,1]:=ord(c[k*4-1]);
      RGBA[i,k,2]:=ord(c[k*4-2]);
      RGBA[i,k,3]:=ord(c[k*4-3]);
      RGBA[i,k,4]:=ord(c[k*4-0]);
    end;
end;
closefile(f);

ComputeFog();
FillChar(RMS,SizeOf(RMS),#0);
end;

procedure TDisplayImage.Open2DB(aFileName: string);
var i,k,h:integer;
  f:file;
  c:array of char;
  BNKHeader:packed record
  {}Un1,Un2:integer;                    //always 2, 0
  {}FileSize:integer;
  {}Fmt1,Fmt2:array[1..4] of char;
  {}Un3:integer;                        //always 0
  {}Size1,Size2:integer;
  {}Name:array[1..8] of char;
  {}Width,Height:word;
  {}Un4:word;                           //always 1
  {}MipMapH,MipMapV:byte;
    Un5:integer;
  {}Un6:integer;                        //always 0
  {}Un6b:integer;                       //always 0
    Un6c:integer;
  {}Un7:byte;                           //always 0
  {}InBit:byte;
  {}Un8:word;                           //always 0
    Un9:integer;
    Un10,Un11:word;
  {}Un12:integer;                       //always 0
  end;
  ci:integer;
  DXTOut:array[1..48]of byte;
begin
ResetAllData;

AssignFile(f,aFileName); FileMode:=0; Reset(f,1); FileMode:=2;
BlockRead(f,BNKHeader,80);

if ((BNKHeader.InBit<>4)and(BNKHeader.InBit<>8)and(BNKHeader.InBit<>32))or
   (BNKHeader.Width<4)or(BNKHeader.Height<4)or(BNKHeader.Width>2048)or(BNKHeader.Height>2048) then begin
  MessageBox(0,'Uknown format','Error',mb_ok);
  closefile(f);
  exit;
end;

if (BNKHeader.Un1<>2)and(BNKHeader.Un2<>0)and(BNKHeader.Un3<>0)and
   (BNKHeader.Un4<>1)and(BNKHeader.Un6<>0)and(BNKHeader.Un6b<>0)and
   (BNKHeader.Un7<>0)and(BNKHeader.Un8<>0)and(BNKHeader.Un12<>0) then begin
  MessageBox(0,'New format modification encountered','Notice',mb_ok);
end;

IsChanged:=false;
SetAllPropsAtOnce(
        decs(ExtractFileName(aFileName),4,1),
        BNKHeader.Width,BNKHeader.Height,Math.min(BNKHeader.MipMapH,BNKHeader.MipMapV),
        BNKHeader.InBit<>32,false,(BNKHeader.InBit=32)or(BNKHeader.InBit=8));

  MipMapQtyUse:=Props.MipMapQty;

if BNKHeader.InBit=32 then begin
  setlength(c,Props.SizeH*4+1);
  for i:=1 to Props.sizeV do begin
    BlockRead(f,c[1],Props.SizeH*4);
    for k:=1 to Props.sizeH do begin
      RGBA[i,k,1]:=ord(c[k*4-1]);
      RGBA[i,k,2]:=ord(c[k*4-2]);
      RGBA[i,k,3]:=ord(c[k*4-3]);
      RGBA[i,k,4]:=ord(c[k*4-0]);
    end;
  end;
end;

if (BNKHeader.InBit=8)or(BNKHeader.InBit=4) then begin
  ci:=1;
  if BNKHeader.InBit=8 then begin
  setlength(c,Props.sizeV*Props.sizeH +1);
  blockread(f,c[1],Props.sizeV*Props.sizeH ); //read all needed data
  end else begin
  setlength(c,(Props.sizeV*Props.sizeH) div 2 +1);
  blockread(f,c[1],(Props.sizeV*Props.sizeH) div 2); //read all needed data
  end;

  for i:=0 to (Props.sizeV div 4)-1 do
    for k:=0 to (Props.sizeH div 4)-1 do begin
      ///////////////////////////////////////////////////////
      //Alpha
      if Props.hasAlpha then begin
        DXT_A_Decode(@c[ci],DXTOut);
        for h:=1 to 16 do
          RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
        inc(ci,8);
      end;
      ////////////////////////////////////////////////////////
      //RGB
      DXT_RGB_Decode(@c[ci],DXTOut);
      for h:=1 to 16 do begin
        RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
        RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
        RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
      end;
      inc(ci,8);
    end;  //for 1..x,1..z
end;
closefile(f);

ComputeFog();
FillChar(RMS,SizeOf(RMS),#0);
end;

procedure TDisplayImage.SaveUncompressedPTX(FileName:string);
var i,k,h:integer; f:file; MMH,MMV,Size:integer; SpeedUp:array[1..4]of byte;
begin
AssignFile(f,FileName); ReWrite(f,1);
if Props.hasAlpha then blockwrite(f,AnsiString(#0#32#0#0),4) else blockwrite(f,AnsiString(#0#24#0#0),4);//compression, bpp
blockwrite(f,Props.SizeH,4);
blockwrite(f,Props.SizeV,4);
blockwrite(f,MipMapQtyUse,1);
blockwrite(f,Fog2[3],1);
blockwrite(f,Fog2[2],1);
blockwrite(f,Fog2[1],1);

MMH:=Props.SizeH;
MMV:=Props.SizeV;
for h:=1 to MipMapQtyUse do begin
  Size:=MMH*MMV*4;
  blockwrite(f,Size,4);
  blockwrite(f,#0#0#0#0,4);
  GenerateMipMap(Props.SizeH,Props.SizeV,MMH,MMV,h);
  for i:=1 to MMV do for k:=1 to MMH do begin
    SpeedUp[1]:=RGBAmm[i,k,3];
    SpeedUp[2]:=RGBAmm[i,k,2];
    SpeedUp[3]:=RGBAmm[i,k,1];
    SpeedUp[4]:=RGBAmm[i,k,4];
    blockwrite(f,SpeedUp[1],4);
  end;
  MMH:=MMH div 2;
  MMV:=MMV div 2;
  if MMH=0 then MMH:=1;
  if MMV=0 then MMV:=1;
end;
closefile(f);
FillChar(RMS,SizeOf(RMS),#0);
IsChanged:=false;
end;

procedure TDisplayImage.SaveCompressedPTX(FileName:string);
var
  i,h:integer;
  f:file;
  MMH,MMV,Size,xp,yp:integer;
  DXTOut:int64;
  DXTAOut:int64;
begin
  FillChar(RMS,SizeOf(RMS),#0);
  AssignFile(f,FileName); ReWrite(f,1);

  if Props.hasAlpha then blockwrite(f,AnsiString(#1#32#0#0),4) else blockwrite(f,AnsiString(#1#24#0#0),4); //compression, bpp

blockwrite(f,Props.SizeH,4);
blockwrite(f,Props.SizeV,4);
blockwrite(f,MipMapQtyUse,1);
blockwrite(f,Fog2[3],1);
blockwrite(f,Fog2[2],1);
blockwrite(f,Fog2[1],1);

MMH:=Props.SizeH; MMV:=Props.SizeV;
for h:=1 to MipMapQtyUse do begin
  if Props.hasAlpha then Size:=MMH*MMV else Size:=MMH*MMV div 2;
  blockwrite(f,Size,4);
  blockwrite(f,#0#0#0#0,4);
  GenerateMipMap(Props.SizeH,Props.SizeV,MMH,MMV,h);
  for i:=1 to (MMH*MMV div 16) do begin
    xp:=((i-1)*4) mod MMH +1; //X pixel
    yp:=((i-1) div ((MMH-1) div 4 + 1) )*4 + 1;
    if Props.hasAlpha then begin
      DXT_A_Encode(@RGBAmm[yp+0,xp,4],
                   @RGBAmm[yp+1,xp,4],
                   @RGBAmm[yp+2,xp,4],
                   @RGBAmm[yp+3,xp,4],
                   DXTAOut,RMS[4]);
      blockwrite(f,DXTAOut,8);
    end;
    DXT_RGB_Encode(@RGBAmm[yp+0,xp,1],
                   @RGBAmm[yp+1,xp,1],
                   @RGBAmm[yp+2,xp,1],
                   @RGBAmm[yp+3,xp,1],
                   DXTOut,RMS);
    blockwrite(f,DXTOut,8);
  end;

  MMH := MMH div 2;
  MMV := MMV div 2;
  if MMH = 0 then MMH := 1;
  if MMV = 0 then MMV := 1;
end;
closefile(f);
RMS[1]:=sqrt(RMS[1]/(Props.SizeH*Props.SizeV));
RMS[2]:=sqrt(RMS[2]/(Props.SizeH*Props.SizeV));
RMS[3]:=sqrt(RMS[3]/(Props.SizeH*Props.SizeV));
RMS[4]:=sqrt(RMS[4]/(Props.SizeH*Props.SizeV));
IsChanged:=false;
end;

procedure TDisplayImage.SaveTGA(FileName:string);
var f:file; i,k,ci:integer; c:array of byte;
begin
  AssignFile(f,FileName); ReWrite(f,1);
  blockwrite(f,#0#0#2#0#0#0#0#0#0#0#0#0,12);
  blockwrite(f,Props.sizeH,2);
  blockwrite(f,Props.sizeV,2);
  if Props.hasAlpha then blockwrite(f,#32#0,2) else blockwrite(f,#24#0,2); //BitDepth
  ci:=0;
  setlength(c,Props.SizeH*Props.SizeV*4+1);
  for i:=Props.SizeV downto 1 do
    for k:=1 to Props.SizeH do begin
      inc(ci); c[ci]:=RGBA[i,k,3];
      inc(ci); c[ci]:=RGBA[i,k,2];
      inc(ci); c[ci]:=RGBA[i,k,1];
      if Props.hasAlpha then begin inc(ci); c[ci]:=RGBA[i,k,4]; end;
      {blockwrite(f,RGBA[i,k,3],1);
      blockwrite(f,RGBA[i,k,2],1);
      blockwrite(f,RGBA[i,k,1],1);
      if Props.hasAlpha then blockwrite(f,RGBA[i,k,4],1);}
    end;
  Assert(ci=Props.SizeH*Props.SizeV*(3+byte(Props.hasAlpha)));
  blockwrite(f,c[1],ci);
  closefile(f);
  IsChanged:=false;
end;

procedure TDisplayImage.SaveMipMap(FileName:string; Lev:integer);
var f:file; i,k:integer; SizeHDiv,SizeVDiv:word;
begin
  SizeHDiv:=Props.SizeH div pow(2,Lev-1);
  SizeVDiv:=Props.SizeV div pow(2,Lev-1);
  AssignFile(f,FileName); ReWrite(f,1);
  blockwrite(f,#0#0#2#0#0#0#0#0#0#0#0#0,12);
  FillChar(RGBAmm,SizeOf(RGBAmm),#0);
  GenerateMipMap(Props.SizeH, Props.SizeV, SizeHDiv, SizeVDiv, Lev);
  blockwrite(f,SizeHDiv,2);
  blockwrite(f,SizeVDiv,2);
  if Props.hasAlpha then blockwrite(f,#32#0,2) else blockwrite(f,#24#0,2);
  for i:=SizeVDiv downto 1 do
    for k:=1 to SizeHDiv do begin
      blockwrite(f,RGBAmm[i,k,3],1);
      blockwrite(f,RGBAmm[i,k,2],1);
      blockwrite(f,RGBAmm[i,k,1],1);
      if Props.hasAlpha then blockwrite(f,RGBAmm[i,k,4],1);
    end;
  closefile(f);
  IsChanged:=false;
end;

procedure TDisplayImage.ExportBitmapRGB(FileName:string);
begin
BitmapRGB.SaveToFile(FileName);
end;

procedure TDisplayImage.ExportBitmapA(FileName:string);
begin
BitmapA.SaveToFile(FileName);
end;

procedure TDisplayImage.ImportBitmapRGB(FileName:string);
var
  i,k:integer;
  Bitmap:TBitmap;
  p:PbyteArray;
begin
Bitmap:=TBitmap.Create;
Bitmap.LoadFromFile(FileName);

if ((MakePOT(Bitmap.Width)<>Bitmap.Width)and(not AllowNonPOTImages))or((MakePOT(Bitmap.Height)<>Bitmap.Height)and(not AllowNonPOTImages))or
   (Bitmap.Width<4)or(Bitmap.Height<4)or(Bitmap.Width>2048)or(Bitmap.Height>2048) then begin
  Bitmap.Destroy;
  MessageBox(0,'Image size must be 4,8,16,32...2048 pixels','Error',mb_ok);
  exit;
end;

//if (Bitmap.Width<>Props.SizeH)or(Bitmap.Height<>Props.SizeV) then
//Do reset because source RGB has changed
begin
  ResetAllData;
  SetAllPropsAtOnce(
        decs(ExtractFileName(FileName),4,1),
        Bitmap.Width,Bitmap.Height,1,
        false,false,false);

  KnowMaxMipMapQty;
  MipMapQtyUse:=MipMapQtyMax;
end;

for i:=1 to Props.SizeV do begin
  p:=Bitmap.ScanLine[i-1];
  for k:=1 to Props.sizeH do begin
    RGBA[i,k,1] := p[k*3-1];
    RGBA[i,k,2] := p[k*3-2];
    RGBA[i,k,3] := p[k*3-3];
  end;
end;

Bitmap.Destroy;
ComputeFog();
FillChar(RMS,SizeOf(RMS),#0);
IsChanged:=true;
end;

procedure TDisplayImage.ImportBitmapA(FileName:string);
var
  i,k:integer;
  Bitmap:TBitmap;
  p:PbyteArray;
begin
Bitmap:=TBitmap.Create;
Bitmap.LoadFromFile(FileName);

if (Bitmap.Width<>Props.SizeH)or(Bitmap.Height<>Props.SizeV) then begin
  MessageBox(0,'Mask height and width should be same as for RGB image','Error',mb_ok);
  exit;
end;

for i:=1 to Props.SizeV do begin
  p:=Bitmap.ScanLine[i-1];
  for k:=1 to Props.sizeH do
    RGBA[i,k,4]:=(p[k*3-1]+p[k*3-2]+p[k*3-3])div 3;
end;

Props.hasAlpha:=true;
Props.IsCompressed:=false;
Props.IsSYNPacked:=false;

Bitmap.Destroy;
FillChar(RMS,SizeOf(RMS),#0);
IsChanged:=true;
end;


procedure TDisplayImage.CreateAlphaFrom(X,Y:integer);
var R,G,B:byte; i,k:integer;
begin
Color2RGB(ImageRGB.Canvas.Pixels[X,Y],R,G,B);

for i:=1 to Props.SizeV do
  for k:=1 to Props.sizeH do
    RGBA[i,k,4]:=255-byte((RGBA[i,k,1]=R)and(RGBA[i,k,2]=G)and(RGBA[i,k,3]=B))*255;

Props.hasAlpha:=true;
Props.IsCompressed:=false;
Props.IsSYNPacked:=false;
IsChanged:=true;
end;


procedure TDisplayImage.ReplaceColorKeyFrom(X,Y:integer);
var R,G,B:byte; i,k,ci:integer; t:array[1..3]of real;
begin
Color2RGB(ImageRGB.Canvas.Pixels[X,Y],R,G,B);

t[1]:=0; t[2]:=0; t[3]:=0; ci:=0;
for i:=1 to Props.sizeV do for k:=1 to Props.sizeH do
if (RGBA[i,k,1]<>R)or(RGBA[i,k,2]<>G)or(RGBA[i,k,3]<>B) then begin
inc(ci);
t[1]:=t[1]+(RGBA[i,k,1]);
t[2]:=t[2]+(RGBA[i,k,2]);
t[3]:=t[3]+(RGBA[i,k,3]);
end;
{round(r[1]/ci);
round(r[2]/ci);
round(r[3]/ci);}

for i:=1 to Props.SizeV do
  for k:=1 to Props.sizeH do
  if (RGBA[i,k,1]=R)and(RGBA[i,k,2]=G)and(RGBA[i,k,3]=B) then begin
    RGBA[i,k,1]:=round(t[1]/ci);
    RGBA[i,k,2]:=round(t[2]/ci);
    RGBA[i,k,3]:=round(t[3]/ci);
  end;

Props.IsCompressed:=false;
Props.IsSYNPacked:=false;
IsChanged:=true;
end;

end.
