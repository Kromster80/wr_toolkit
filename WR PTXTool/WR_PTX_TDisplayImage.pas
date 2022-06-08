unit WR_PTX_TDisplayImage;
interface
uses
  Windows, ExtCtrls, Graphics, SysUtils, Classes, Math, kromUtils, Controls, Forms, WR_DXTCompressorAlpha, WR_DXTCompressorColor;

type
  TRefreshMode = (cmRGB, cmA, cmRGBA);

type
  TDisplayImage = class
  private
    fDXTCompressorColor: TWRDXTCompressorColor;
    fBitmapRGB, fBitmapA: TBitmap;

    fImageRGB, fImageA: TImage;
    Rect: TRect;
    Props: record
      FileMask: string;
      sizeH, sizeV, MipMapQty: Integer;
      IsCompressed: Boolean;
      IsSYNPacked: Boolean;
      hasAlpha: Boolean;
    end;
    RGBA: array [1..2049,1..2049,1..4] of byte;
    RGBAmm: array [1..2049,1..2049,1..4] of byte;
    fRmsRGB: Single;
    fRmsA: Single;
    Fog: array [1..3] of Byte;
    fMipMapCount: Integer;
    fMaxMipMapCount: Integer;
    fIsChanged: Boolean;
    procedure ComputeFog;
    procedure GenerateMipMap(aLevel: Integer);
    procedure ResetAllData;
    procedure SetAllPropsAtOnce(iFileMask: string; iSizeH, iSizeV, iMipMapQty: Integer; iIsCompressed, iIsSYNPacked, ihasAlpha: Boolean);
    procedure RefreshImage(aMode: TRefreshMode);
    procedure UpdateMaxMipMapCount;
  public
    AllowNonPOTImages: Boolean;

    constructor Create(aImageRGB, aImageA: TImage);
    destructor Destroy; override;

    property GetFileMask: string read Props.FileMask;
    property GetMipMapQty: Integer read Props.MipMapQty;

    property MipMapCount: Integer read fMipMapCount write fMipMapCount;
    property MaxMipMapCount: Integer read fMaxMipMapCount;

    property GetCompression: Boolean read Props.IsCompressed;
    property GetPacked: Boolean read Props.IsSYNPacked;
    property GetAlpha: Boolean read Props.hasAlpha;
    function DisplayImage: Boolean;
    function GetInfoString: string;
    function GetFogString: string;
    function GetRMSString: string;
    function GetChangedString: string;

    procedure AlphaInvert;
    procedure AlphaClear;
    procedure AlphaCreateFrom(aX, aY: Integer);
    procedure ColorReplaceWithAverage(aX, aY: Integer);
    procedure OpenPTX(const aFilename: string);
    procedure OpenDDS(const aFilename: string);
    procedure OpenXTX(const aFilename: string);
    procedure OpenTGA(const aFilename: string);
    procedure Open2DB(const aFilename: string);
    procedure SaveUncompressedPTX(const aFileName: string);
    procedure SaveCompressedPTX(const aFilename: string; aHeuristic: TDXTCompressionHeuristics);
    procedure SaveTGA(const aFilename: string);
    procedure SaveMipMap(const aFilename: string; aLevel: Integer);
    procedure ExportBitmapRGB(const aFilename: string);
    procedure ExportBitmapA(const aFilename: string);
    procedure ImportBitmapRGB(const aFilename: string);
    procedure ImportBitmapA(const aFilename: string);
  end;


implementation


const
  RGB_GREY = 128*65793;
  MAX_IMAGE_SIZE = 2048;


{ TDisplayImage }
constructor TDisplayImage.Create(aImageRGB, aImageA: TImage);
begin
  inherited Create;

  fImageRGB := aImageRGB;
  fImageA := aImageA;

  fDXTCompressorColor := TWRDXTCompressorColor.Create;
  fBitmapRGB := TBitmap.Create;
  fBitmapRGB.PixelFormat := pf24bit;
  fBitmapA := TBitmap.Create;
  fBitmapA.PixelFormat   := pf24bit;
end;


destructor TDisplayImage.Destroy;
begin
  FreeAndNil(fDXTCompressorColor);
  FreeAndNil(fBitmapRGB);
  FreeAndNil(fBitmapA);

  inherited;
end;


// Returns "True" on success
function TDisplayImage.DisplayImage: Boolean;
begin
  Result := False;

  fBitmapRGB.Width := Props.sizeH;
  fBitmapRGB.Height:= Props.sizeV;
  fBitmapA.Width   := Props.sizeH;
  fBitmapA.Height  := Props.sizeV;

  Rect.Bottom := fImageRGB.Height;
  Rect.Right  := fImageRGB.Width;

  fImageRGB.Canvas.Brush.Color := RGB_GREY; fImageRGB.Canvas.FillRect(Rect);
  fImageA.Canvas.Brush.Color   := RGB_GREY; fImageA.Canvas.FillRect(Rect);

  if Props.sizeH * Props.sizeV = 0 then Exit; //Image didn't loaded

  if (Props.sizeH / Props.sizeV) > 1 then
    Rect.Bottom := Round(fImageRGB.Height / (Props.sizeH / Props.sizeV))
  else
    Rect.Right  := Round(fImageRGB.Width  / (Props.sizeV / Props.sizeH));

  fImageRGB.Picture.Graphic.Height := fImageRGB.Height;
  fImageRGB.Picture.Graphic.Width := fImageRGB.Width;
  fImageA.Picture.Graphic.Height := fImageA.Height;
  fImageA.Picture.Graphic.Width := fImageA.Width;

  RefreshImage(cmRGB);

  if Props.hasAlpha then
    RefreshImage(cmA);

  Result := true;
end;


function TDisplayImage.GetInfoString: string;
begin
  Result := IntToStr(Props.sizeH) + 'x' + IntToStr(Props.sizeV) + ' RGB';
  if Props.hasAlpha then Result := Result + 'A'; //RGB+A
end;


function TDisplayImage.GetFogString: string;
begin
  Result := 'R' + IntToStr(Fog[1]) + '  G' + IntToStr(Fog[2]) + '  B' + IntToStr(Fog[3]);
end;


function TDisplayImage.GetRMSString: string;
begin
  if fRmsRGB + fRmsA > 0 then
    Result := Format('rgb%.2f a%.2f', [fRmsRGB, fRmsA]);
end;


function TDisplayImage.GetChangedString: string;
const
  IS_CHANGED: array [Boolean] of string = ('', '*');
begin
  Result := IS_CHANGED[fIsChanged];
end;


procedure TDisplayImage.ComputeFog;
var
  I, K: Integer;
  fr, fg, fb: Int64;
begin
  fr := 0;
  fg := 0;
  fb := 0;

  for I := 1 to Props.sizeV do
  for K := 1 to Props.sizeH do
  begin
    Inc(fr, RGBA[I,K,1]);
    Inc(fg, RGBA[I,K,2]);
    Inc(fb, RGBA[I,K,3]);
  end;

  Fog[1] := Round(fr / (Props.sizeV * Props.sizeH));
  Fog[2] := Round(fg / (Props.sizeV * Props.sizeH));
  Fog[3] := Round(fb / (Props.sizeV * Props.sizeH));
end;


procedure TDisplayImage.UpdateMaxMipMapCount;
var
  x: Integer;
begin
  fMaxMipMapCount := 0;
  x := Min(Props.sizeH, Props.sizeV);
  repeat
    x := x div 2;
    Inc(fMaxMipMapCount);
  until (x <= 2);     //min size 4x1 pixels.
end;


procedure TDisplayImage.AlphaInvert;
var
  i,k: Integer;
begin
  for i:=1 to Props.sizeV do
  for k:=1 to Props.sizeH do
    RGBA[i,k,4] := 255 - RGBA[i,k,4];

  RefreshImage(cmA);

  fIsChanged := True;
end;


procedure TDisplayImage.AlphaClear;
var
  i,k:Integer;
begin
  Props.hasAlpha := False;
  for i:=1 to Props.sizeV do
    for k:=1 to Props.sizeH do
      RGBA[i,k,4] := 0;
  fImageA.Canvas.Brush.Color := RGB_GREY;
  fImageA.Canvas.FillRect(Rect);
  fIsChanged := True;
end;


procedure TDisplayImage.RefreshImage(aMode: TRefreshMode);
var
  pRGBLine: PByteArray;
  pALine: PByteArray;
  prevCursor: TCursor;
  I,K: Integer;
begin
  prevCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  if aMode in [cmRGBA, cmRGB] then
  begin
    for I := 1 to Props.sizeV do
    begin
      pRGBLine := fBitmapRGB.ScanLine[I-1];
      for K := 1 to Props.sizeH do
      begin
        pRGBLine[K*3-3] := RGBA[I,K,3];
        pRGBLine[K*3-2] := RGBA[I,K,2];
        pRGBLine[K*3-1] := RGBA[I,K,1];
      end;
    end;
    fImageRGB.Canvas.StretchDraw(Rect, fBitmapRGB);
  end;

  if aMode in [cmRGBA, cmA] then
  begin
    for I := 1 to Props.sizeV do
    begin
      pALine := fBitmapA.ScanLine[I-1];
      for K := 1 to Props.sizeH do
      begin
        pALine[K*3-3] := RGBA[I,K,4];
        pALine[K*3-2] := RGBA[I,K,4];
        pALine[K*3-1] := RGBA[I,K,4];
      end;
    end;
    fImageA.Canvas.StretchDraw(Rect, fBitmapA);
  end;

  Screen.Cursor := prevCursor;
end;


procedure TDisplayImage.GenerateMipMap(aLevel: Integer);
var
  newWidth, newHeight: Integer;
  i,k,h,j: Integer;
  Area: Word;
  Ratio: Single;
  Tmp1,Tmp2,Tmp3,Tmp4,Acc: Single;
begin
  newWidth := Props.sizeH div Pow(2, aLevel - 1);
  newHeight := Props.sizeV div Pow(2, aLevel - 1);

  if aLevel = 1 then
  begin
    for i:=1 to newHeight do for k:=1 to newWidth do
    begin
      RGBAmm[i,k,1] := RGBA[i,k,1];
      RGBAmm[i,k,2] := RGBA[i,k,2];
      RGBAmm[i,k,3] := RGBA[i,k,3];
      RGBAmm[i,k,4] := RGBA[i,k,4];
    end;
    Exit;
  end;

  Area := Pow(2, aLevel-1); //1..1024 (one side only), temp limit to 16
  for i:=1 to newHeight do for k:=1 to newWidth do
  begin
    Tmp1:=0; Tmp2:=0; Tmp3:=0; Tmp4:=0; Acc:=0;
    for h:=1 to Area do for j:=1 to Area do
    begin
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
    RGBAmm[i,k,1]:=Round(EnsureRange(Tmp1/Acc,0,255));
    RGBAmm[i,k,2]:=Round(EnsureRange(Tmp2/Acc,0,255));
    RGBAmm[i,k,3]:=Round(EnsureRange(Tmp3/Acc,0,255));
    RGBAmm[i,k,4]:=Round(EnsureRange(Tmp4/Acc,0,255));
  end;
end;


procedure TDisplayImage.ResetAllData;
begin
  FillChar(RGBA, SizeOf(RGBA), #0);
  FillChar(Fog, SizeOf(Fog), #0);
  FillChar(Props, SizeOf(Props), #0);
  fIsChanged := True;
end;


procedure TDisplayImage.SetAllPropsAtOnce(iFileMask: string; iSizeH, iSizeV, iMipMapQty: Integer; iIsCompressed, iIsSYNPacked, ihasAlpha: Boolean);
begin
  Props.FileMask:=iFileMask;
  Props.sizeH:=iSizeH;
  Props.sizeV:=iSizeV;
  Props.MipMapQty := iMipMapQty;
  Props.IsCompressed:=iIsCompressed;
  Props.IsSYNPacked:=iIsSYNPacked;
  Props.hasAlpha:=ihasAlpha;

  fIsChanged := False;

  UpdateMaxMipMapCount;
  fMipMapCount := fMaxMipMapCount;
end;


procedure TDisplayImage.OpenPTX(const aFilename: string);
var
  i,k,h:Integer;
  a,b:^byte;
  tb:Integer;
  f:file;
  c,d:array of AnsiChar;
  SYNData,PTXData:Integer;
  ci,CurChr,addv,x:Integer;
  flag:array[1..8]of byte;
  Dist,Leng:Integer;
  DXTOut:array[1..48]of byte;
begin
  ResetAllData;
  assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  SetLength(c,24+1);
  blockread(f,c[1],24);

  if ((c[1]<>#0)and(c[1]<>#1))or((c[2]<>#32)and(c[2]<>#24)and(c[2]<>#16)) then
  begin
    MessageBox(0, 'Unknown PTX format, can''t be opened.', 'Error', MB_OK);
    closefile(f);
    exit;
  end;

  if (int2(c[5],c[6])>MAX_IMAGE_SIZE)or(int2(c[9],c[10])>MAX_IMAGE_SIZE) then
  begin
    MessageBox(0,'Big images (2048+ pixels) are not supported', 'Error', MB_OK);
    closefile(f);
    exit;
  end;

  SetAllPropsAtOnce(
    ChangeFileExt(ExtractFileName(aFileName), ''),
    int2(c[5],c[6]),int2(c[9],c[10]),ord(c[13]),
    c[1]=#1,int2(c[21],c[22],c[23],c[24])<>0,c[2]=#32);

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


procedure TDisplayImage.OpenDDS(const aFilename: string);
var i,k,h:Integer; ftype: string[4];
  f:file;
  c:array[1..128]of AnsiChar;
  T:byte;
  DXTOut:array[1..48]of byte;
begin
  ResetAllData;
  assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  blockread(f,c,128);

  //todo: Extract into a common verification method
  if (int2(c[17],c[18])>MAX_IMAGE_SIZE)or(int2(c[13],c[14])>MAX_IMAGE_SIZE) then
  begin
    MessageBox(0,'Big images (2048+) are not supported', 'Error', MB_OK);
    closefile(f);
    Exit;
  end;

  SetAllPropsAtOnce(
          ChangeFileExt(ExtractFileName(aFileName), ''),
          int2(c[17],c[18]),int2(c[13],c[14]),ord(c[29]),
          true,false,(c[88]='3')or(c[88]='5'));

  fType:=c[85]+c[86]+c[87]+c[88];

  for i:=0 to (Props.sizeV div 4)-1 do
  for k:=0 to (Props.sizeH div 4)-1 do
  begin
    ///////////////////////////////////////////////////////
    //Alpha
    if Props.hasAlpha then
    begin
      blockread(f,c,8);
      if ftype='DXT5' then
      begin
        DXT_A_Decode(@c[1],DXTOut);
        for h:=1 to 16 do
          RGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
      end else
      if ftype='DXT3' then
      begin
        for h:=1 to 16 do
        begin
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

  ComputeFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.OpenXTX(const aFilename: string);
var
  i,k,h:Integer; ftype: string[4];
  f:file;
  c:array[1..128]of byte;
  T:byte;
  DXTOut:array[1..48]of byte;
begin
  ResetAllData;
  assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  blockread(f,c,52);

  {if (int2(c[17],c[18])>MAX_IMAGE_SIZE)or(int2(c[13],c[14])>MAX_IMAGE_SIZE) then begin
    MessageBox(0,'Big images (2048+) are not supported','Error',MB_OK);
    closefile(f);
    exit;
  end;  }

  SetAllPropsAtOnce(ChangeFileExt(ExtractFileName(aFileName), ''), 64,64,1, true,false,true);

    fType:='DXT5';//c[85]+c[86]+c[87]+c[88];

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

  ComputeFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.OpenTGA(const aFilename: string);
var
  i,k:Integer;
  f:file;
  c:array of AnsiChar;
  tSizeH,tSizeV:Integer;
  InBit:byte;
begin
  ResetAllData;

  AssignFile(f,aFileName); FileMode:=0; Reset(f,1); FileMode:=2;
  setlength(c,18+1);
  BlockRead(f,c[1],18);
  tSizeH:=int2(c[13],c[14]);
  tSizeV:=int2(c[15],c[16]);
  InBit:=ord(c[17]);

  if ((InBit<>24)and(InBit<>32))
  or ((MakePOT(tSizeH)<>tSizeH)and(not AllowNonPOTImages))
  or ((MakePOT(tSizeV)<>tSizeV)and(not AllowNonPOTImages))
  or (tSizeH < 4) or (tSizeV < 4) or (tSizeH > MAX_IMAGE_SIZE) or (tSizeV > MAX_IMAGE_SIZE) then
  begin
    MessageBox(0, 'Image size must be 4,8,16,32...2048 x 24/32 bit', 'Error', MB_OK);
    closefile(f);
    Exit;
  end;

  SetAllPropsAtOnce(
          ChangeFileExt(ExtractFileName(aFileName), ''),
          tSizeH,tSizeV,1,
          false,false, InBit = 32);

  setlength(c,Props.SizeH*4+1);

  for i:=Props.sizeV downto 1 do
  begin
    if InBit=24 then BlockRead(f,c[1],Props.SizeH*3);
    if InBit=32 then BlockRead(f,c[1],Props.SizeH*4);
    for k:=1 to Props.sizeH do
      if InBit=24 then
      begin
        RGBA[i,k,1]:=ord(c[k*3-0]);
        RGBA[i,k,2]:=ord(c[k*3-1]);
        RGBA[i,k,3]:=ord(c[k*3-2]);
      end else
      if InBit=32 then
      begin
        RGBA[i,k,1]:=ord(c[k*4-1]);
        RGBA[i,k,2]:=ord(c[k*4-2]);
        RGBA[i,k,3]:=ord(c[k*4-3]);
        RGBA[i,k,4]:=ord(c[k*4-0]);
      end;
  end;
  closefile(f);

  ComputeFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.Open2DB(const aFilename: string);
var i,k,h:Integer;
  f:file;
  c:array of char;
  BNKHeader:packed record
  {}Un1,Un2:Integer;                    //always 2, 0
  {}FileSize:Integer;
  {}Fmt1,Fmt2:array[1..4] of char;
  {}Un3:Integer;                        //always 0
  {}Size1,Size2:Integer;
  {}Name:array[1..8] of char;
  {}Width,Height:word;
  {}Un4:word;                           //always 1
  {}MipMapH,MipMapV:byte;
    Un5:Integer;
  {}Un6:Integer;                        //always 0
  {}Un6b:Integer;                       //always 0
    Un6c:Integer;
  {}Un7:byte;                           //always 0
  {}InBit:byte;
  {}Un8:word;                           //always 0
    Un9:Integer;
    Un10,Un11:word;
  {}Un12:Integer;                       //always 0
  end;
  ci:Integer;
  DXTOut:array[1..48]of byte;
begin
  ResetAllData;

  AssignFile(f,aFileName); FileMode:=0; Reset(f,1); FileMode:=2;
  BlockRead(f,BNKHeader,80);

  if ((BNKHeader.InBit<>4)and(BNKHeader.InBit<>8)and(BNKHeader.InBit<>32))or
     (BNKHeader.Width<4)or(BNKHeader.Height<4)or(BNKHeader.Width>MAX_IMAGE_SIZE)or(BNKHeader.Height>MAX_IMAGE_SIZE) then
     begin
    MessageBox(0,'Uknown format','Error',MB_OK);
    closefile(f);
    exit;
  end;

  if (BNKHeader.Un1<>2)and(BNKHeader.Un2<>0)and(BNKHeader.Un3<>0)
  and (BNKHeader.Un4<>1)and(BNKHeader.Un6<>0)and(BNKHeader.Un6b<>0)
  and (BNKHeader.Un7<>0)and(BNKHeader.Un8<>0)and(BNKHeader.Un12<>0) then
    MessageBox(0,'New format modification encountered','Notice',MB_OK);

  SetAllPropsAtOnce(
          ChangeFileExt(ExtractFileName(aFileName), ''),
          BNKHeader.Width,BNKHeader.Height,Math.min(BNKHeader.MipMapH,BNKHeader.MipMapV),
          BNKHeader.InBit<>32,false,(BNKHeader.InBit=32)or(BNKHeader.InBit=8));

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

  if (BNKHeader.InBit=8)or(BNKHeader.InBit=4) then
  begin
    ci:=1;
    if BNKHeader.InBit=8 then
    begin
      setlength(c,Props.sizeV*Props.sizeH +1);
      blockread(f,c[1],Props.sizeV*Props.sizeH ); //read all needed data
    end else
    begin
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

  ComputeFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.SaveUncompressedPTX(const aFileName: string);
var
  i, k, h: Integer;
  f: file;
  thisWidth, thisHeight, thisSize: Integer;
  rgba: array [1..4] of Byte;
begin
  AssignFile(f,aFileName); ReWrite(f,1);
  if Props.hasAlpha then blockwrite(f,AnsiString(#0#32#0#0),4) else blockwrite(f,AnsiString(#0#24#0#0),4);//compression, bpp
  blockwrite(f, Props.SizeH,4);
  blockwrite(f, Props.SizeV,4);
  blockwrite(f, fMipMapCount,1);
  blockwrite(f, Fog[3], 1);
  blockwrite(f, Fog[2], 1);
  blockwrite(f, Fog[1], 1);

  thisWidth:=Props.SizeH;
  thisHeight:=Props.SizeV;
  for h := 1 to fMipMapCount do
  begin
    thisSize := thisWidth * thisHeight * 4;
    blockwrite(f, thisSize, 4);
    blockwrite(f, #0#0#0#0, 4);

    GenerateMipMap(h);

    for i:=1 to thisHeight do for k:=1 to thisWidth do
    begin
      rgba[1] := RGBAmm[i,k,3];
      rgba[2] := RGBAmm[i,k,2];
      rgba[3] := RGBAmm[i,k,1];
      rgba[4] := RGBAmm[i,k,4];

      blockwrite(f, rgba[1], 4);
    end;
    thisWidth := Max(thisWidth div 2, 1);
    thisHeight := Max(thisHeight div 2, 1);
  end;
  closefile(f);
  fRmsRGB := 0;
  fRmsA := 0;
  fIsChanged := False;
end;

procedure TDisplayImage.SaveCompressedPTX(const aFilename: string; aHeuristic: TDXTCompressionHeuristics);
var
  ms: TMemoryStream;
  i,h: Integer;
  thisWidth, thisHeight, thisSize, xp, yp: Integer;
  DXTOut: Int64;
  DXTAOut: Int64;
  newRMS: Single;
begin
  fRmsRGB := 0;
  fRmsA := 0;

  ms := TMemoryStream.Create;

  if Props.hasAlpha then
    ms.Write(AnsiString(#1#32#0#0), 4)  //compression, 32bpp
  else
    ms.Write(AnsiString(#1#24#0#0), 4); //compression, 24bpp

  ms.Write(Props.SizeH, 4);
  ms.Write(Props.SizeV, 4);
  ms.Write(fMipMapCount, 1);
  ms.Write(Fog[3], 1);
  ms.Write(Fog[2], 1);
  ms.Write(Fog[1], 1);

  thisWidth := Props.SizeH;
  thisHeight := Props.SizeV;
  for h := 1 to fMipMapCount do
  begin
    thisSize := IfThen(Props.hasAlpha, thisWidth * thisHeight, thisWidth * thisHeight div 2);

    ms.Write(thisSize, 4);
    ms.Write(AnsiString(#0#0#0#0), 4);
    GenerateMipMap(h);
    for i:=1 to (thisWidth*thisHeight div 16) do
    begin
      xp := ((i-1) * 4) mod thisWidth + 1; //X pixel
      yp := ((i-1) div ((thisWidth-1) div 4 + 1)) * 4 + 1;
      if Props.hasAlpha then
      begin
        newRMS := 0;
        DXT_A_Encode(@RGBAmm[yp+0, xp, 4], @RGBAmm[yp+1, xp, 4], @RGBAmm[yp+2, xp, 4], @RGBAmm[yp+3, xp, 4], DXTAOut, newRMS);
        ms.Write(DXTAOut, 8);

        fRmsA := fRmsA + newRMS;
      end;
      newRMS := 0;
      //DXT_RGB_Encode(@RGBAmm[yp+0, xp, 1], @RGBAmm[yp+1, xp, 1], @RGBAmm[yp+2, xp, 1], @RGBAmm[yp+3, xp, 1], DXTOut, newRMS);
      fDXTCompressorColor.CompressBlock(@RGBAmm[yp+0, xp, 1], @RGBAmm[yp+1, xp, 1], @RGBAmm[yp+2, xp, 1], @RGBAmm[yp+3, xp, 1], aHeuristic, DXTOut, newRMS);
      ms.Write(DXTOut, 8);

      fRmsRGB := fRmsRGB + newRMS;
    end;

    thisWidth := Max(thisWidth div 2, 1);
    thisHeight := Max(thisHeight div 2, 1);
  end;

  ms.SaveToFile(aFileName);
  ms.Free;

  fRmsRGB := Sqrt(fRmsRGB / (Props.SizeH * Props.SizeV));
  fRmsA := Sqrt(fRmsA / (Props.SizeH * Props.SizeV));

  fIsChanged := False;
end;


procedure TDisplayImage.SaveTGA(const aFilename: string);
var
  ms: TMemoryStream;
  I,K,L: Integer;
  buf: array of Byte;
begin
  ms := TMemoryStream.Create;
  ms.Write(AnsiString(#0#0#2#0#0#0#0#0#0#0#0#0), 12);
  ms.Write(Props.sizeH, 2);
  ms.Write(Props.sizeV, 2);
  if Props.hasAlpha then
    ms.Write(AnsiString(#32#0), 2)
  else
    ms.Write(AnsiString(#24#0), 2); // BitDepth

  L := 0;
  SetLength(buf, Props.SizeH * Props.SizeV * 4);
  for I := Props.SizeV downto 1 do
    for K := 1 to Props.SizeH do
    begin
      buf[L + 0] := RGBA[I,K,3];
      buf[L + 1] := RGBA[I,K,2];
      buf[L + 2] := RGBA[I,K,1];
      if Props.hasAlpha then
        buf[L + 3] := RGBA[I,K,4];
      Inc(L, 3 + Ord(Props.hasAlpha));
    end;

  ms.Write(buf[0], L);
  ms.SaveToFile(aFileName);
  ms.Free;

  fIsChanged := False;
end;


procedure TDisplayImage.SaveMipMap(const aFilename: string; aLevel: Integer);
var
  f:file;
  i, k: Integer;
  thisWidth, thisHeight: Word;
begin
  thisWidth:=Props.SizeH div Pow(2,aLevel-1);
  thisHeight:=Props.SizeV div Pow(2,aLevel-1);
  AssignFile(f,aFileName); ReWrite(f,1);
  blockwrite(f,AnsiString(#0#0#2#0#0#0#0#0#0#0#0#0), 12);
  FillChar(RGBAmm, SizeOf(RGBAmm), #0);

  GenerateMipMap(aLevel);

  blockwrite(f, thisWidth, 2);
  blockwrite(f, thisHeight, 2);
  if Props.hasAlpha then blockwrite(f,#32#0,2) else blockwrite(f,#24#0,2);
  for i:=thisHeight downto 1 do
    for k:=1 to thisWidth do
    begin
      blockwrite(f,RGBAmm[i,k,3],1);
      blockwrite(f,RGBAmm[i,k,2],1);
      blockwrite(f,RGBAmm[i,k,1],1);
      if Props.hasAlpha then blockwrite(f,RGBAmm[i,k,4],1);
    end;
  closefile(f);
end;


procedure TDisplayImage.ExportBitmapRGB(const aFileName: string);
begin
  fBitmapRGB.SaveToFile(aFileName);
end;


procedure TDisplayImage.ExportBitmapA(const aFileName: string);
begin
  fBitmapA.SaveToFile(aFileName);
end;


//todo: Rename to OpenBMP (cos it is not an import)
procedure TDisplayImage.ImportBitmapRGB(const aFileName: string);
var
  i,k: Integer;
  bmp: TBitmap;
  p: PByteArray;
begin
  bmp := TBitmap.Create;
  try
    bmp.LoadFromFile(aFileName);

    if ((MakePOT(bmp.Width)<>bmp.Width)and(not AllowNonPOTImages))
    or ((MakePOT(bmp.Height)<>bmp.Height)and(not AllowNonPOTImages))
    or (bmp.Width<4)or(bmp.Height<4)or(bmp.Width>MAX_IMAGE_SIZE)or(bmp.Height>MAX_IMAGE_SIZE) then
    begin
      MessageBox(0, 'Image size must be 4,8,16,32...2048 pixels', 'Error', MB_OK);
      Exit;
    end;

    // Do reset because source RGB has changed
    ResetAllData;
    SetAllPropsAtOnce(
      ChangeFileExt(ExtractFileName(aFileName), ''),
      bmp.Width, bmp.Height, 1,
      false,false,false);

    for i:=1 to Props.SizeV do
    begin
      p:=bmp.ScanLine[i-1];
      for k:=1 to Props.sizeH do
      begin
        RGBA[i,k,1] := p[k*3-1];
        RGBA[i,k,2] := p[k*3-2];
        RGBA[i,k,3] := p[k*3-3];
      end;
    end;
  finally
    bmp.Free;
  end;

  ComputeFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.ImportBitmapA(const aFileName: string);
var
  i,k: Integer;
  bmp: TBitmap;
  p: PByteArray;
begin
  bmp := TBitmap.Create;
  try
    bmp.LoadFromFile(aFileName);

    if (bmp.Width <> Props.SizeH) or (bmp.Height <> Props.SizeV) then
    begin
      MessageBox(0, 'Mask height and width should be same as for RGB image', 'Error', MB_OK);
      Exit;
    end;

    for i:=1 to Props.SizeV do
    begin
      p:=bmp.ScanLine[i-1];
      for k:=1 to Props.sizeH do
        RGBA[i,k,4]:=(p[k*3-1]+p[k*3-2]+p[k*3-3])div 3;
    end;
  finally
    bmp.Free;
  end;

  Props.hasAlpha:=true;
  Props.IsCompressed:=false;
  Props.IsSYNPacked:=false;
  fIsChanged := True;

  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.AlphaCreateFrom(aX,aY: Integer);
var
  R,G,B: Byte;
  i,k:Integer;
begin
  Color2RGB(fImageRGB.Canvas.Pixels[aX, aY], R, G, B);

  for i:=1 to Props.SizeV do
    for k:=1 to Props.sizeH do
      RGBA[i,k,4]:=255-byte((RGBA[i,k,1]=R)and(RGBA[i,k,2]=G)and(RGBA[i,k,3]=B))*255;

  Props.hasAlpha:=true;
  Props.IsCompressed:=false;
  Props.IsSYNPacked:=false;
  fIsChanged := True;
end;


procedure TDisplayImage.ColorReplaceWithAverage(aX,aY: Integer);
var
  keyR, keyG, keyB: Byte;
  i,k,cnt: Integer;
  rgbAvg: array [1..3] of Int64;
begin
  Color2RGB(fImageRGB.Canvas.Pixels[aX, aY], keyR, keyG, keyB);

  cnt := 0;
  rgbAvg[1] := 0;
  rgbAvg[2] := 0;
  rgbAvg[3] := 0;
  for i:=1 to Props.sizeV do
    for k:=1 to Props.sizeH do
    if (RGBA[I, K, 1] <> keyR) or (RGBA[I, K, 2] <> keyG) or (RGBA[I, K, 3] <> keyB) then
    begin
      Inc(cnt);
      rgbAvg[1] := rgbAvg[1] + RGBA[i,k,1];
      rgbAvg[2] := rgbAvg[2] + RGBA[i,k,2];
      rgbAvg[3] := rgbAvg[3] + RGBA[i,k,3];
    end;

  rgbAvg[1] := Round(rgbAvg[1] / cnt);
  rgbAvg[2] := Round(rgbAvg[2] / cnt);
  rgbAvg[3] := Round(rgbAvg[3] / cnt);

  for i:=1 to Props.SizeV do
    for k:=1 to Props.sizeH do
    if (RGBA[I, K, 1] = keyR) and (RGBA[I, K, 2] = keyG) and (RGBA[I, K, 3] = keyB) then
    begin
      RGBA[i,k,1] := rgbAvg[1];
      RGBA[i,k,2] := rgbAvg[2];
      RGBA[i,k,3] := rgbAvg[3];
    end;

  Props.IsCompressed := false;
  Props.IsSYNPacked := false;
  fIsChanged := True;
end;


end.
