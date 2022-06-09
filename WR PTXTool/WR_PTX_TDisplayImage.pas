unit WR_PTX_TDisplayImage;
interface
uses
  Windows, ExtCtrls, Graphics, SysUtils, Classes, Math, kromUtils, Controls, Forms, WR_DXTCompressorAlpha, WR_DXTCompressorColor;

type
  TRefreshMode = (cmRGB, cmA, cmRGBA);

  TRGBABuffer = array [1..2049, 1..2049, 1..4] of Byte;

  TDisplayImage = class
  private
    fDXTCompressorColor: TWRDXTCompressorColor;
    fBitmapRGB, fBitmapA: TBitmap;
    fImageRGB, fImageA: TImage;
    fDrawRect: TRect;

    fSource: record
      Filename: string;
      Width, Height, MipMapCount: Integer;
      HasAlpha: Boolean;
      Format: string;
    end;

    fRGBA: TRGBABuffer;
    fRGBAmm: TRGBABuffer;
    fFog: array [1..3] of Byte;
    fRmsRGB: Single;
    fRmsA: Single;
    fMipMapCount: Integer;
    fMipMapMax: Integer;
    fIsChanged: Boolean;
    procedure UpdateFog;
    procedure GenerateMipMap(aLevel: Integer);
    procedure ResetAllData;
    procedure SetAllPropsAtOnce(const aFilename: string; aWidth, aHeight, aMipMapCount: Integer; aHasAlpha: Boolean; const aFormat: string);
    procedure RefreshImage(aMode: TRefreshMode);
    function Verify(aWidth, aHeight: Integer): Boolean;
    procedure UpdateMaxMipMapCount;
  public
    AllowNonPOT: Boolean;

    constructor Create(aImageRGB, aImageA: TImage);
    destructor Destroy; override;

    property SourceFilename: string read fSource.Filename;
    property SourceMipMapCount: Integer read fMipMapCount write fSource.MipMapCount;
    property MipMapCount: Integer read fMipMapCount write fMipMapCount;
    property MipMapMax: Integer read fMipMapMax;
    property HasAlpha: Boolean read fSource.HasAlpha;
    property SourceFormatString: string read fSource.Format;
    function DisplayImage: Boolean;
    function GetInfoString: string;
    function GetFogString: string;
    function GetRMSString: string;
    function GetChangedString: string;

    procedure EditAlphaInvert;
    procedure EditAlphaClear;
    procedure EditAlphaCreateFrom(aX, aY: Integer);
    procedure EditColorReplaceWithAverage(aX, aY: Integer);
    procedure OpenBMP(const aFilename: string);
    procedure OpenPTX(const aFilename: string);
    procedure OpenDDS(const aFilename: string);
    procedure OpenXTX(const aFilename: string);
    procedure OpenTGA(const aFilename: string);
    procedure Open2DB(const aFilename: string);
    procedure SavePTXUncompressed(const aFileName: string);
    procedure SavePTXCompressed(const aFilename: string; aHeuristic: TDXTCompressionHeuristics);
    procedure SaveTGA(const aFilename: string);
    procedure SaveMipMap(const aFilename: string; aLevel: Integer);
    procedure ExportBitmapRGB(const aFilename: string);
    procedure ExportBitmapA(const aFilename: string);
    procedure ImportBitmapA(const aFilename: string);
  end;


implementation
uses
  StrUtils;

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

  fBitmapRGB.Width := fSource.Width;
  fBitmapRGB.Height:= fSource.Height;
  fBitmapA.Width   := fSource.Width;
  fBitmapA.Height  := fSource.Height;

  fDrawRect.Bottom := fImageRGB.Height;
  fDrawRect.Right  := fImageRGB.Width;

  fImageRGB.Canvas.Brush.Color := RGB_GREY; fImageRGB.Canvas.FillRect(fDrawRect);
  fImageA.Canvas.Brush.Color   := RGB_GREY; fImageA.Canvas.FillRect(fDrawRect);

  if fSource.Width * fSource.Height = 0 then Exit; // Image didn't load

  if (fSource.Width / fSource.Height) > 1 then
    fDrawRect.Bottom := Round(fImageRGB.Height / (fSource.Width / fSource.Height))
  else
    fDrawRect.Right  := Round(fImageRGB.Width  / (fSource.Height / fSource.Width));

  fImageRGB.Picture.Graphic.Height := fImageRGB.Height;
  fImageRGB.Picture.Graphic.Width := fImageRGB.Width;
  fImageA.Picture.Graphic.Height := fImageA.Height;
  fImageA.Picture.Graphic.Width := fImageA.Width;

  RefreshImage(cmRGB);

  if fSource.HasAlpha then
    RefreshImage(cmA);

  Result := true;
end;


function TDisplayImage.GetInfoString: string;
begin
  Result := IntToStr(fSource.Width) + 'x' + IntToStr(fSource.Height) + ' RGB' + IfThen(fSource.HasAlpha, 'A');
end;


function TDisplayImage.GetFogString: string;
begin
  Result := 'R' + IntToStr(fFog[1]) + '  G' + IntToStr(fFog[2]) + '  B' + IntToStr(fFog[3]);
end;


function TDisplayImage.GetRMSString: string;
begin
  if fRmsRGB + fRmsA > 0 then
    Result := Format('rgb%.2f a%.2f', [fRmsRGB, fRmsA]);
end;


function TDisplayImage.GetChangedString: string;
begin
  Result := IfThen(fIsChanged, '*');
end;


procedure TDisplayImage.UpdateFog;
var
  I, K: Integer;
  r, g, b: Int64;
begin
  r := 0;
  g := 0;
  b := 0;

  for I := 1 to fSource.Height do
  for K := 1 to fSource.Width do
  begin
    Inc(r, fRGBA[I, K, 1]);
    Inc(g, fRGBA[I, K, 2]);
    Inc(b, fRGBA[I, K, 3]);
  end;

  fFog[1] := Round(r / (fSource.Height * fSource.Width));
  fFog[2] := Round(g / (fSource.Height * fSource.Width));
  fFog[3] := Round(b / (fSource.Height * fSource.Width));
end;


procedure TDisplayImage.UpdateMaxMipMapCount;
var
  x: Integer;
begin
  fMipMapMax := 0;
  x := Min(fSource.Width, fSource.Height);
  repeat
    x := x div 2;
    Inc(fMipMapMax);
  until (x <= 2);     // min size 4x1 pixels
end;


function TDisplayImage.Verify(aWidth, aHeight: Integer): Boolean;
begin
  Result := True;

  if ((MakePOT(aWidth) <> aWidth) and (not AllowNonPOT))
  or ((MakePOT(aHeight) <> aHeight) and (not AllowNonPOT))
  or (aWidth < 4) or (aHeight < 4) or (aWidth > MAX_IMAGE_SIZE) or (aHeight > MAX_IMAGE_SIZE) then
  begin
    MessageBox(0, 'Image size must be 4,8,16,32...2048 pixels', 'Error', MB_OK);
    Exit(False);
  end;
end;


procedure TDisplayImage.EditAlphaInvert;
var
  i,k: Integer;
begin
  for i:=1 to fSource.Height do
  for k:=1 to fSource.Width do
    fRGBA[i,k,4] := 255 - fRGBA[i,k,4];

  fIsChanged := True;
end;


procedure TDisplayImage.EditAlphaClear;
var
  i,k:Integer;
begin
  for i:=1 to fSource.Height do
    for k:=1 to fSource.Width do
      fRGBA[i,k,4] := 0;
  fImageA.Canvas.Brush.Color := RGB_GREY;
  fImageA.Canvas.FillRect(fDrawRect);

  fSource.HasAlpha := False;
  fSource.Format := '';
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
    for I := 1 to fSource.Height do
    begin
      pRGBLine := fBitmapRGB.ScanLine[I-1];
      for K := 1 to fSource.Width do
      begin
        pRGBLine[K*3-3] := fRGBA[I,K,3];
        pRGBLine[K*3-2] := fRGBA[I,K,2];
        pRGBLine[K*3-1] := fRGBA[I,K,1];
      end;
    end;
    fImageRGB.Canvas.StretchDraw(fDrawRect, fBitmapRGB);
  end;

  if aMode in [cmRGBA, cmA] then
  begin
    for I := 1 to fSource.Height do
    begin
      pALine := fBitmapA.ScanLine[I-1];
      for K := 1 to fSource.Width do
      begin
        pALine[K*3-3] := fRGBA[I,K,4];
        pALine[K*3-2] := fRGBA[I,K,4];
        pALine[K*3-1] := fRGBA[I,K,4];
      end;
    end;
    fImageA.Canvas.StretchDraw(fDrawRect, fBitmapA);
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
  newWidth := fSource.Width div Pow(2, aLevel - 1);
  newHeight := fSource.Height div Pow(2, aLevel - 1);

  if aLevel = 1 then
  begin
    for i:=1 to newHeight do for k:=1 to newWidth do
    begin
      fRGBAmm[i,k,1] := fRGBA[i,k,1];
      fRGBAmm[i,k,2] := fRGBA[i,k,2];
      fRGBAmm[i,k,3] := fRGBA[i,k,3];
      fRGBAmm[i,k,4] := fRGBA[i,k,4];
    end;
    Exit;
  end;

  Area := Pow(2, aLevel-1); //1..1024 (one side only), temp limit to 16
  for i:=1 to newHeight do for k:=1 to newWidth do
  begin
    Tmp1:=0; Tmp2:=0; Tmp3:=0; Tmp4:=0; Acc:=0;
    for h:=1 to Area do for j:=1 to Area do
    begin
      Ratio := Sqr(Area / 2 - (h - 0.5)) + Sqr(Area / 2 - (j - 0.5));
      Ratio := Max(1-sqrt(Ratio)/Area,0);
      //Ratio:=sqr(Ratio); //Fits rather good but kills thin lines
      Tmp1 := Tmp1 + fRGBA[(I - 1) * Area + h, (K - 1) * Area + j, 1] * Ratio;
      Tmp2 := Tmp2 + fRGBA[(I - 1) * Area + h, (K - 1) * Area + j, 2] * Ratio;
      Tmp3 := Tmp3 + fRGBA[(I - 1) * Area + h, (K - 1) * Area + j, 3] * Ratio;
      Tmp4 := Tmp4 + fRGBA[(I - 1) * Area + h, (K - 1) * Area + j, 4] * Ratio;
      Acc := Acc + Ratio;
    end;
    Acc := Max(Acc, 1);
    fRGBAmm[i,k,1] := Round(EnsureRange(Tmp1/Acc, 0, 255));
    fRGBAmm[i,k,2] := Round(EnsureRange(Tmp2/Acc, 0, 255));
    fRGBAmm[i,k,3] := Round(EnsureRange(Tmp3/Acc, 0, 255));
    fRGBAmm[i,k,4] := Round(EnsureRange(Tmp4/Acc, 0, 255));
  end;
end;


procedure TDisplayImage.ResetAllData;
begin
  FillChar(fRGBA, SizeOf(fRGBA), #0);
  FillChar(fFog, SizeOf(fFog), #0);
  FillChar(fSource, SizeOf(fSource), #0);
  fIsChanged := True;
end;


procedure TDisplayImage.SetAllPropsAtOnce(const aFilename: string; aWidth, aHeight, aMipMapCount: Integer;
  aHasAlpha: Boolean; const aFormat: string);
begin
  fSource.Filename := aFilename;
  fSource.Width := aWidth;
  fSource.Height := aHeight;
  fSource.MipMapCount := aMipMapCount;
  fSource.HasAlpha := aHasAlpha;
  fSource.Format := aFormat;

  fIsChanged := False;

  UpdateMaxMipMapCount;
  fMipMapCount := fMipMapMax;
end;


procedure TDisplayImage.OpenPTX(const aFilename: string);
var
  I, K, h: Integer;
  a, b: ^Byte;
  tb: Integer;
  f: file;
  c, d: array of AnsiChar;
  isCompressed: Boolean;
  SYNData, PTXData: Integer;
  ci, CurChr, addv, x: Integer;
  flag: array [1 .. 8] of Byte;
  Dist, Leng: Integer;
  DXTOut: array [1 .. 48] of Byte;
begin
  ResetAllData;
  assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  SetLength(c,24+1);
  blockread(f,c[1],24);

  if ((c[1]<>#0)and(c[1]<>#1))or((c[2]<>#32)and(c[2]<>#24)and(c[2]<>#16)) then
  begin
    MessageBox(0, 'Unknown PTX format, can''t be opened.', 'Error', MB_OK);
    closefile(f);
    Exit;
  end;

  if not Verify(int2(c[5],c[6]), int2(c[9],c[10])) then
  begin
    CloseFile(f);
    Exit;
  end;

  isCompressed := c[1]=#1;

  SetAllPropsAtOnce(
    ChangeFileExt(ExtractFileName(aFileName), ''),
    int2(c[5], c[6]), int2(c[9], c[10]), ord(c[13]),
    c[2] = #32,
    Trim('PTX ' + IfThen(isCompressed, 'Compressed ') + IfThen(int2(c[21],c[22],c[23],c[24])<>0, 'Packed ')));

  SYNData:=int2(c[21],c[22],c[23],c[24]);

  if isCompressed then
    if fSource.HasAlpha then
      PTXData := fSource.Width*fSource.Height
    else
      PTXData := fSource.Width*fSource.Height div 2
  else
    PTXData := fSource.Width*fSource.Height*4;

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

  if isCompressed and (SYNData = 0) then
  begin
    setlength(c,PTXData+1);
    blockread(f,c[1],PTXData); //read all needed data
  end;

  ci:=1;
  if isCompressed then
  begin
    for i:=0 to (fSource.Height div 4)-1 do
      for k:=0 to (fSource.Width div 4)-1 do
      begin
        ///////////////////////////////////////////////////////
        //Alpha
        if fSource.HasAlpha then
        begin
          DXT_A_Decode(@c[ci],DXTOut);

          for h:=1 to 16 do
            fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
          inc(ci,8);
        end;
        ////////////////////////////////////////////////////////
        //RGB
        DXT_RGB_Decode(@c[ci],DXTOut);
        for h:=1 to 16 do
        begin
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
        end;
        inc(ci,8);
      end;  //for 1..x,1..z
  end else
  begin //Compressed=0
    for i:=1 to fSource.Height do
    begin
      blockread(f,fRGBA[i,1,1],fSource.Width*4);
      for k:=1 to fSource.Width do
       begin
        a:=@fRGBA[i,k,1]; //fast exchange
        b:=@fRGBA[i,k,3];
        tb:=a^; a^:=b^; b^:=tb;
      end;
    end;
  end;
  closefile(f);

  UpdateFog;
end;


procedure TDisplayImage.OpenDDS(const aFilename: string);
var
  I, K, h: Integer;
  ftype: string[4];
  f: file;
  c: array [1 .. 128] of AnsiChar;
  T: Byte;
  DXTOut: array [1 .. 48] of Byte;
begin
  ResetAllData;
  assignfile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  blockread(f,c,128);

  if not Verify(int2(c[17],c[18]), int2(c[13],c[14])) then
  begin
    CloseFile(f);
    Exit;
  end;

  SetAllPropsAtOnce(
          ChangeFileExt(ExtractFileName(aFileName), ''),
          int2(c[17],c[18]),int2(c[13],c[14]),ord(c[29]),
          (c[88]='3')or(c[88]='5'),
          'DDS Compressed');

  fType:=c[85]+c[86]+c[87]+c[88];

  for i:=0 to (fSource.Height div 4)-1 do
  for k:=0 to (fSource.Width div 4)-1 do
  begin
    ///////////////////////////////////////////////////////
    //Alpha
    if fSource.HasAlpha then
    begin
      blockread(f,c,8);
      if ftype='DXT5' then
      begin
        DXT_A_Decode(@c[1],DXTOut);
        for h:=1 to 16 do
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
      end else
      if ftype='DXT3' then
      begin
        for h:=1 to 16 do
        begin
          if h mod 2 = 1 then
          T:=(ord(c[(h+1)div 2])mod 16)*17 else
          T:=(ord(c[(h+1)div 2])div 16)*17;
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=T;
        end;
      end; //Format type DXT3 or DXT5
    end; //if alpha
    ////////////////////////////////////////////////////////
    //RGB
    blockread(f,c,8);
    DXT_RGB_Decode(@c[1],DXTOut);
    for h:=1 to 16 do begin
      fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
      fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
      fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
    end;
  end;
  closefile(f);

  UpdateFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.OpenXTX(const aFilename: string);
var
  i,k,h: Integer;
  ftype: string[4];
  f: file;
  c: array [1..128] of Byte;
  T: Byte;
  DXTOut: array [1..48] of Byte;
begin
  ResetAllData;
  AssignFile(f,aFileName); FileMode:=0; reset(f,1); FileMode:=2;
  blockread(f,c,52);

  {if (int2(c[17],c[18])>MAX_IMAGE_SIZE)or(int2(c[13],c[14])>MAX_IMAGE_SIZE) then begin
    MessageBox(0,'Big images (2048+) are not supported','Error',MB_OK);
    closefile(f);
    exit;
  end;  }

  SetAllPropsAtOnce(ChangeFileExt(ExtractFileName(aFilename), ''), 64, 64, 1, True, 'XTX Compressed');

  fType := 'DXT5';//c[85]+c[86]+c[87]+c[88];

  for i:=0 to (fSource.Height div 4)-1 do
  for k:=0 to (fSource.Width div 4)-1 do
  begin
    ///////////////////////////////////////////////////////
    //Alpha
    if fSource.HasAlpha then
    begin
      blockread(f,c,8);
      SwapInt(c[1],c[2]);
      SwapInt(c[3],c[4]);
      SwapInt(c[5],c[6]);
      SwapInt(c[7],c[8]);

      if ftype = 'DXT5' then
      begin
        DXT_A_Decode(@c[1],DXTOut);
        for h:=1 to 16 do
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
      end else
      if ftype = 'DXT3' then
      begin
        for h:=1 to 16 do
        begin
          if h mod 2 = 1 then
          T:=(ord(c[(h+1)div 2])mod 16)*17 else
          T:=(ord(c[(h+1)div 2])div 16)*17;
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=T;
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
    for h:=1 to 16 do
    begin
      fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
      fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
      fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
    end;
  end;
  closefile(f);

  UpdateFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.OpenTGA(const aFilename: string);
var
  I, K: Integer;
  f: file;
  c: array of AnsiChar;
  tSizeH, tSizeV: Integer;
  InBit: Byte;
begin
  ResetAllData;

  AssignFile(f,aFileName); FileMode:=0; Reset(f,1); FileMode:=2;
  setlength(c,18+1);
  BlockRead(f,c[1],18);
  tSizeH:=int2(c[13],c[14]);
  tSizeV:=int2(c[15],c[16]);
  InBit:=ord(c[17]);

  if (InBit <> 24) and (InBit <> 32) then
  begin
    MessageBox(0, 'Image size must be 24/32 bit', 'Error', MB_OK);
    closefile(f);
    Exit;
  end;

  if not Verify(tSizeH, tSizeV) then
  begin
    closefile(f);
    Exit;
  end;

  SetAllPropsAtOnce(ChangeFileExt(ExtractFileName(aFileName), ''), tSizeH, tSizeV, 1, InBit = 32, 'TGA');

  setlength(c,fSource.Width*4+1);

  for i:=fSource.Height downto 1 do
  begin
    if InBit=24 then BlockRead(f,c[1],fSource.Width*3);
    if InBit=32 then BlockRead(f,c[1],fSource.Width*4);
    for k:=1 to fSource.Width do
      if InBit=24 then
      begin
        fRGBA[i,k,1]:=ord(c[k*3-0]);
        fRGBA[i,k,2]:=ord(c[k*3-1]);
        fRGBA[i,k,3]:=ord(c[k*3-2]);
      end else
      if InBit=32 then
      begin
        fRGBA[i,k,1]:=ord(c[k*4-1]);
        fRGBA[i,k,2]:=ord(c[k*4-2]);
        fRGBA[i,k,3]:=ord(c[k*4-3]);
        fRGBA[i,k,4]:=ord(c[k*4-0]);
      end;
  end;
  closefile(f);

  UpdateFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.Open2DB(const aFilename: string);
var
  i,k,h:Integer;
  f:file;
  c:array of char;
  BNKHeader:packed record
  {}Un1,Un2:Integer;                    //always 2, 0
  {}FileSize:Integer;
  {}Fmt1,Fmt2:array [1..4] of char;
  {}Un3:Integer;                        //always 0
  {}Size1,Size2:Integer;
  {}Name:array [1..8] of char;
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
  DXTOut:array [1..48]of byte;
begin
  ResetAllData;

  AssignFile(f,aFileName); FileMode:=0; Reset(f,1); FileMode:=2;
  BlockRead(f, BNKHeader, 80);

  if not Verify(BNKHeader.Width, BNKHeader.Height) then
  begin
    CloseFile(f);
    Exit;
  end;

  if not (BNKHeader.InBit in [4, 8, 32]) then
  begin
    MessageBox(0, 'Uknown format', 'Error', MB_OK);
    CloseFile(f);
    Exit;
  end;

  if (BNKHeader.Un1<>2)and(BNKHeader.Un2<>0)and(BNKHeader.Un3<>0)
  and (BNKHeader.Un4<>1)and(BNKHeader.Un6<>0)and(BNKHeader.Un6b<>0)
  and (BNKHeader.Un7<>0)and(BNKHeader.Un8<>0)and(BNKHeader.Un12<>0) then
    MessageBox(0,'New format modification encountered','Notice',MB_OK);

  SetAllPropsAtOnce(
          ChangeFileExt(ExtractFileName(aFileName), ''),
          BNKHeader.Width,BNKHeader.Height,Math.min(BNKHeader.MipMapH,BNKHeader.MipMapV),
          (BNKHeader.InBit = 32) or (BNKHeader.InBit = 8),
          '2DB ' + IfThen(BNKHeader.InBit <> 32, 'Compressed'));

  if BNKHeader.InBit=32 then begin
    setlength(c,fSource.Width*4+1);
    for i:=1 to fSource.Height do begin
      BlockRead(f,c[1],fSource.Width*4);
      for k:=1 to fSource.Width do begin
        fRGBA[i,k,1]:=ord(c[k*4-1]);
        fRGBA[i,k,2]:=ord(c[k*4-2]);
        fRGBA[i,k,3]:=ord(c[k*4-3]);
        fRGBA[i,k,4]:=ord(c[k*4-0]);
      end;
    end;
  end;

  if (BNKHeader.InBit=8)or(BNKHeader.InBit=4) then
  begin
    ci:=1;
    if BNKHeader.InBit=8 then
    begin
      setlength(c,fSource.Height*fSource.Width +1);
      blockread(f,c[1],fSource.Height*fSource.Width ); //read all needed data
    end else
    begin
      setlength(c,(fSource.Height*fSource.Width) div 2 +1);
      blockread(f,c[1],(fSource.Height*fSource.Width) div 2); //read all needed data
    end;

    for i:=0 to (fSource.Height div 4)-1 do
      for k:=0 to (fSource.Width div 4)-1 do begin
        ///////////////////////////////////////////////////////
        //Alpha
        if fSource.HasAlpha then begin
          DXT_A_Decode(@c[ci],DXTOut);
          for h:=1 to 16 do
            fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,4]:=DXTOut[h];
          inc(ci,8);
        end;
        ////////////////////////////////////////////////////////
        //RGB
        DXT_RGB_Decode(@c[ci],DXTOut);
        for h:=1 to 16 do begin
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,1]:=DXTOut[(h-1)*3+1];
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,2]:=DXTOut[(h-1)*3+2];
          fRGBA[i*4+(h-1)div 4+1,k*4+(h-1)mod 4+1,3]:=DXTOut[(h-1)*3+3];
        end;
        inc(ci,8);
      end;  //for 1..x,1..z
  end;
  closefile(f);

  UpdateFog;
  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.SavePTXUncompressed(const aFileName: string);
var
  i, k, h: Integer;
  f: file;
  thisWidth, thisHeight, thisSize: Integer;
  fRGBA: array [1..4] of Byte;
begin
  AssignFile(f,aFileName); ReWrite(f,1);
  if fSource.HasAlpha then blockwrite(f,AnsiString(#0#32#0#0),4) else blockwrite(f,AnsiString(#0#24#0#0),4);//compression, bpp
  blockwrite(f, fSource.Width, 4);
  blockwrite(f, fSource.Height, 4);
  blockwrite(f, fMipMapCount, 1);
  blockwrite(f, fFog[3], 1);
  blockwrite(f, fFog[2], 1);
  blockwrite(f, fFog[1], 1);

  thisWidth:=fSource.Width;
  thisHeight:=fSource.Height;
  for h := 1 to fMipMapCount do
  begin
    thisSize := thisWidth * thisHeight * 4;
    blockwrite(f, thisSize, 4);
    blockwrite(f, #0#0#0#0, 4);

    GenerateMipMap(h);

    for i:=1 to thisHeight do
    for k:=1 to thisWidth do
    begin
      fRGBA[1] := fRGBAmm[i,k,3];
      fRGBA[2] := fRGBAmm[i,k,2];
      fRGBA[3] := fRGBAmm[i,k,1];
      fRGBA[4] := fRGBAmm[i,k,4];

      blockwrite(f, fRGBA[1], 4);
    end;
    thisWidth := Max(thisWidth div 2, 1);
    thisHeight := Max(thisHeight div 2, 1);
  end;
  closefile(f);
  fRmsRGB := 0;
  fRmsA := 0;
  fIsChanged := False;
end;

procedure TDisplayImage.SavePTXCompressed(const aFilename: string; aHeuristic: TDXTCompressionHeuristics);
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

  if fSource.HasAlpha then
    ms.Write(AnsiString(#1#32#0#0), 4)  //compression, 32bpp
  else
    ms.Write(AnsiString(#1#24#0#0), 4); //compression, 24bpp

  ms.Write(fSource.Width, 4);
  ms.Write(fSource.Height, 4);
  ms.Write(fMipMapCount, 1);
  ms.Write(fFog[3], 1);
  ms.Write(fFog[2], 1);
  ms.Write(fFog[1], 1);

  thisWidth := fSource.Width;
  thisHeight := fSource.Height;
  for h := 1 to fMipMapCount do
  begin
    thisSize := IfThen(fSource.HasAlpha, thisWidth * thisHeight, thisWidth * thisHeight div 2);

    ms.Write(thisSize, 4);
    ms.Write(AnsiString(#0#0#0#0), 4);
    GenerateMipMap(h);
    for i:=1 to (thisWidth*thisHeight div 16) do
    begin
      xp := ((i-1) * 4) mod thisWidth + 1; //X pixel
      yp := ((i-1) div ((thisWidth-1) div 4 + 1)) * 4 + 1;
      if fSource.HasAlpha then
      begin
        newRMS := 0;
        DXT_A_Encode(@fRGBAmm[yp+0, xp, 4], @fRGBAmm[yp+1, xp, 4], @fRGBAmm[yp+2, xp, 4], @fRGBAmm[yp+3, xp, 4], DXTAOut, newRMS);
        ms.Write(DXTAOut, 8);

        fRmsA := fRmsA + newRMS;
      end;
      newRMS := 0;
      //DXT_RGB_Encode(@fRGBAmm[yp+0, xp, 1], @fRGBAmm[yp+1, xp, 1], @fRGBAmm[yp+2, xp, 1], @fRGBAmm[yp+3, xp, 1], DXTOut, newRMS);
      fDXTCompressorColor.CompressBlock(@fRGBAmm[yp+0, xp, 1], @fRGBAmm[yp+1, xp, 1], @fRGBAmm[yp+2, xp, 1], @fRGBAmm[yp+3, xp, 1], aHeuristic, DXTOut, newRMS);
      ms.Write(DXTOut, 8);

      fRmsRGB := fRmsRGB + newRMS;
    end;

    thisWidth := Max(thisWidth div 2, 1);
    thisHeight := Max(thisHeight div 2, 1);
  end;

  ms.SaveToFile(aFileName);
  ms.Free;

  fRmsRGB := Sqrt(fRmsRGB / (fSource.Width * fSource.Height));
  fRmsA := Sqrt(fRmsA / (fSource.Width * fSource.Height));

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
  ms.Write(fSource.Width, 2);
  ms.Write(fSource.Height, 2);
  if fSource.HasAlpha then
    ms.Write(AnsiString(#32#0), 2)
  else
    ms.Write(AnsiString(#24#0), 2); // BitDepth

  L := 0;
  SetLength(buf, fSource.Width * fSource.Height * 4);
  for I := fSource.Height downto 1 do
    for K := 1 to fSource.Width do
    begin
      buf[L + 0] := fRGBA[I,K,3];
      buf[L + 1] := fRGBA[I,K,2];
      buf[L + 2] := fRGBA[I,K,1];
      if fSource.HasAlpha then
        buf[L + 3] := fRGBA[I,K,4];
      Inc(L, 3 + Ord(fSource.HasAlpha));
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
  thisWidth:=fSource.Width div Pow(2,aLevel-1);
  thisHeight:=fSource.Height div Pow(2,aLevel-1);
  AssignFile(f,aFileName); ReWrite(f,1);
  blockwrite(f,AnsiString(#0#0#2#0#0#0#0#0#0#0#0#0), 12);
  FillChar(fRGBAmm, SizeOf(fRGBAmm), #0);

  GenerateMipMap(aLevel);

  blockwrite(f, thisWidth, 2);
  blockwrite(f, thisHeight, 2);
  if fSource.HasAlpha then blockwrite(f,#32#0,2) else blockwrite(f,#24#0,2);
  for i:=thisHeight downto 1 do
    for k:=1 to thisWidth do
    begin
      blockwrite(f,fRGBAmm[i,k,3],1);
      blockwrite(f,fRGBAmm[i,k,2],1);
      blockwrite(f,fRGBAmm[i,k,1],1);
      if fSource.HasAlpha then blockwrite(f,fRGBAmm[i,k,4],1);
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


procedure TDisplayImage.OpenBMP(const aFileName: string);
var
  i,k: Integer;
  bmp: TBitmap;
  p: PByteArray;
begin
  bmp := TBitmap.Create;
  try
    bmp.LoadFromFile(aFileName);

    if not Verify(bmp.Width, bmp.Height) then
      Exit;

    // Do reset because source RGB has changed
    ResetAllData;
    SetAllPropsAtOnce(ChangeFileExt(ExtractFileName(aFileName), ''), bmp.Width, bmp.Height, 1, False, 'BMP');

    for i:=1 to fSource.Height do
    begin
      p:=bmp.ScanLine[i-1];
      for k:=1 to fSource.Width do
      begin
        fRGBA[i,k,1] := p[k*3-1];
        fRGBA[i,k,2] := p[k*3-2];
        fRGBA[i,k,3] := p[k*3-3];
      end;
    end;
  finally
    bmp.Free;
  end;

  UpdateFog;
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

    if (bmp.Width <> fSource.Width) or (bmp.Height <> fSource.Height) then
    begin
      MessageBox(0, 'Mask height and width should be same as for RGB image', 'Error', MB_OK);
      Exit;
    end;

    for i:=1 to fSource.Height do
    begin
      p:=bmp.ScanLine[i-1];
      for k:=1 to fSource.Width do
        fRGBA[i,k,4]:=(p[k*3-1]+p[k*3-2]+p[k*3-3])div 3;
    end;
  finally
    bmp.Free;
  end;

  fSource.HasAlpha := True;
  fSource.Format := '';
  fIsChanged := True;

  fRmsRGB := 0;
  fRmsA := 0;
end;


procedure TDisplayImage.EditAlphaCreateFrom(aX,aY: Integer);
var
  R,G,B: Byte;
  i,k:Integer;
begin
  Color2RGB(fImageRGB.Canvas.Pixels[aX, aY], R, G, B);

  for i:=1 to fSource.Height do
    for k:=1 to fSource.Width do
      fRGBA[i,k,4]:=255-byte((fRGBA[i,k,1]=R)and(fRGBA[i,k,2]=G)and(fRGBA[i,k,3]=B))*255;

  fSource.HasAlpha := True;
  fSource.Format := '';
  fIsChanged := True;
end;


procedure TDisplayImage.EditColorReplaceWithAverage(aX,aY: Integer);
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
  for i:=1 to fSource.Height do
    for k:=1 to fSource.Width do
    if (fRGBA[I, K, 1] <> keyR) or (fRGBA[I, K, 2] <> keyG) or (fRGBA[I, K, 3] <> keyB) then
    begin
      Inc(cnt);
      rgbAvg[1] := rgbAvg[1] + fRGBA[i,k,1];
      rgbAvg[2] := rgbAvg[2] + fRGBA[i,k,2];
      rgbAvg[3] := rgbAvg[3] + fRGBA[i,k,3];
    end;

  rgbAvg[1] := Round(rgbAvg[1] / cnt);
  rgbAvg[2] := Round(rgbAvg[2] / cnt);
  rgbAvg[3] := Round(rgbAvg[3] / cnt);

  for i:=1 to fSource.Height do
    for k:=1 to fSource.Width do
    if (fRGBA[I, K, 1] = keyR) and (fRGBA[I, K, 2] = keyG) and (fRGBA[I, K, 3] = keyB) then
    begin
      fRGBA[i,k,1] := rgbAvg[1];
      fRGBA[i,k,2] := rgbAvg[2];
      fRGBA[i,k,3] := rgbAvg[3];
    end;

  fSource.Format := '';
  UpdateFog;
  fIsChanged := True;
end;


end.
