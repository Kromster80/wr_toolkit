unit WR_DXTCompressorColor;
interface
uses
  Math, KromUtils, Windows, SysUtils;

type
  TDLLCompressProc = procedure(rgba: PByte; block: Pointer; flags: Integer; metric: PSingle); stdcall;
  TDXTCompressionHeuristics = (
    chBestPick,
    chMinMax1, chMinMax2,
    chExtHigh1, chExtHigh2,
    chExtLow1, chExtLow2,
    chMerged1, chMerged2,
    chRygs1, chRygs2,
    chSquish,
    chPlain1,
    chPlain2,
    chOriginal
  );

const
  HEURISTIC_NAME: array [TDXTCompressionHeuristics] of string = (
    'BestPick',
    'MinMax1',
    'MinMax2',
    'ExtHigh1',
    'ExtHigh2',
    'ExtLow1',
    'ExtLow2',
    'Merged1',
    'Merged2',
    'Rygs1',
    'Rygs2',
    'Squish',
    'Plain1',
    'Plain2',
    'Original'
  );

type
  TRGBColor = record
    R,G,B: Byte;
  end;
  TRGBColor16 = record
    R,G,B: Word;
  end;

  TWRDXTCompressorColor = class
  private
    fDllLib: NativeUInt;
    fDllCompress: TDLLCompressProc;
    fSrcCol: array [1..16] of TRGBColor;

    fDst: array [TDXTCompressionHeuristics] of record
      Data: Int64;
      RMS: Single;
    end;

    function CalculateRMS(aData: Pointer): Single;
    procedure GetMinMaxColor24(out aColorMin, aColorMax: TRGBColor);
    procedure GetMinMaxColor16(out aColorMin, aColorMax: Word);

    procedure GetMergedColors(out aColorMin, aColorMax: Word);
    procedure GetRygsColor16(out aColorMin, aColorMax: Word);
    function RefineBlock(var aColorMin, aColorMax: Word): Boolean;

    function SaveToBlock(aColor0, aColor1: Word): Int64;
    function SearchMinMax(aDir: Boolean): Int64;
    function SearchExt(aExt, aDir: Boolean): Int64;
    function SearchMerged(aDir: Boolean): Int64;
    function SearchRygs(aDir: Boolean): Int64;
    function SearchDLL: Int64;
    function SearchPlain(aDir: Boolean): Int64;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CompressBlock(aRow1, aRow2, aRow3, aRow4: Pointer; aHeuristic: TDXTCompressionHeuristics;
      out aBlockData: Int64; out aRMS: Single);
  end;


procedure DXT_RGB_Encode(aRow1,aRow2,aRow3,aRow4: Pointer; out OutDat: Int64; out RMS: Single);
procedure DXT_RGB_Decode(aInDat: Pointer; out OutDat: array of byte);


implementation


function RGBToWord(aR, aG, aB: Byte): Word; inline;
begin
  if (aB mod 8) > 3 then Result := Min((aB shr 3)+1, 31) else Result := (aB shr 3);
  if (aG mod 4) > 1 then Result := Result + Min((aG shr 2)+1, 63) shl 5 else Result := Result + (aG shr 2) shl 5;
  if (aR mod 8) > 3 then Result := Result + Min((aR shr 3)+1, 31) shl 11 else Result := Result + (aR shr 3) shl 11;
end;


procedure WordToRGB(aWord: Word; out aR, aG, aB: Byte); inline;
var
  temp: Word;
begin
  // Tested to be properly correct:
  // 0 -> 0
  // 31 -> 255

  temp := (aWord shr 11) * 255 + 16;
  aR := Trunc((temp/32 + temp)/32);

  temp := ((aWord shr 5) and $3F) * 255 + 32;
  aG := Trunc((temp/64 + temp)/64);

  temp := (aWord and $1F) * 255 + 16;
  aB := Trunc((temp/32 + temp)/32);
end;


{ TWRDXTCompressorColor }
constructor TWRDXTCompressorColor.Create;
begin
  inherited;

  // Load ourselves to be able to show a warning message and work without the DLL
  if FileExists(ExtractFilePath(ParamStr(0)) + 'squish.dll') then
  begin
    fDllLib := LoadLibrary('squish.dll');
    if fDllLib <> 0 then
      fDllCompress := GetProcAddress(fDllLib, PAnsiChar('Compress2'))
    else
      MessageBox(0, 'DLL method entry point not found', 'Error', MB_OK);
  end else
    MessageBox(0, 'squish.dll not found', 'Error', MB_OK);
end;


destructor TWRDXTCompressorColor.Destroy;
begin
  if fDllLib <> 0 then
    FreeLibrary(fDllLib);

  inherited;
end;


procedure TWRDXTCompressorColor.GetMinMaxColor24(out aColorMin, aColorMax: TRGBColor);
var
  I, K: Integer;
  bestRMS, newRMS: Integer;
  idxColorMin, idxColorMax: Integer;
begin
  idxColorMin := -1;
  idxColorMax := -1;

  // Find minmax pair from existing colors
  bestRMS := 0;

  // Find two most distant colors
  for I:=1 to 16 do
  for K:=I+1 to 16 do
  begin
    newRMS := GetLengthSQR(fSrcCol[I].R - fSrcCol[K].R, fSrcCol[I].G - fSrcCol[K].G, fSrcCol[I].B - fSrcCol[K].B);
    if newRMS >= bestRMS then
    begin
      bestRMS := newRMS;
      if RGBToWord(fSrcCol[I].R, fSrcCol[I].G, fSrcCol[I].B) <= RGBToWord(fSrcCol[K].R, fSrcCol[K].G, fSrcCol[K].B) then
      begin
        idxColorMin := I;
        idxColorMax := K;
      end
      else
      begin
        idxColorMin := K;
        idxColorMax := I;
      end;
    end;
  end;

  aColorMin := fSrcCol[idxColorMin];
  aColorMax := fSrcCol[idxColorMax];
end;


procedure TWRDXTCompressorColor.GetMinMaxColor16(out aColorMin, aColorMax: Word);
var
  a, b: TRGBColor;
begin
  GetMinMaxColor24(a, b);

  aColorMin := RGBToWord(a.R, a.G, a.B);
  aColorMax := RGBToWord(b.R, b.G, b.B);
end;


procedure TWRDXTCompressorColor.GetMergedColors(out aColorMin, aColorMax: Word);
var
  I, K: Integer;
  rms: array [1..16, 1..16] of Integer;
  leastRMS: Integer;
  idxColorMin, idxColorMax: Integer;
  rmsPair1, rmsPair2: Integer;
  wipColor: array [1..16] of TRGBColor;
  L: Integer;
begin
  for I:=1 to 16 do
    wipColor[I] := fSrcCol[I];

  // Calculate all RMSs
  for I:=1 to 16 do
  begin
    rms[I,I] := -1;
    for K:=I+1 to 16 do
    begin
      rms[I,K] := GetLengthSQR(wipColor[I].R - wipColor[K].R, wipColor[I].G - wipColor[K].G, wipColor[I].B - wipColor[K].B);
      rms[K,I] := rms[I,K];
    end;
  end;

  for L := 1 to 14 do
  begin
    // Find a pair of colors with least RMS
    leastRMS := MaxInt;
    for I:=1 to 16 do
      for K:=I+1 to 16 do
        if (rms[I,K] <> -1)
        and (rms[I,K] < leastRMS) then
        begin
          leastRMS := rms[I,K];
          rmsPair1 := I;
          rmsPair2 := K;
        end;

    // Merge colors
    wipColor[rmsPair1].R := (wipColor[rmsPair1].R + wipColor[rmsPair2].R) div 2;
    wipColor[rmsPair1].G := (wipColor[rmsPair1].G + wipColor[rmsPair2].G) div 2;
    wipColor[rmsPair1].B := (wipColor[rmsPair1].B + wipColor[rmsPair2].B) div 2;

    // Disuse anything regarding 2nd color
    for I:=1 to 16 do
    begin
      rms[I,rmsPair2] := -1;
      rms[rmsPair2,I] := -1;
    end;

    // Calculate new RMSs
    for K:=1 to 16 do
    if (rms[rmsPair1,K] <> -1) then
    begin
      rms[rmsPair1,K] := GetLengthSQR(wipColor[rmsPair1].R - wipColor[K].R, wipColor[rmsPair1].G - wipColor[K].G, wipColor[rmsPair1].B - wipColor[K].B);
      rms[K,rmsPair1] := rms[rmsPair1,K];
    end;
  end;

  // Only 2 colors will remain
  for I:=1 to 16 do
  if rms[I,1] <> -1 then
  begin
    aColorMax := aColorMin;
    aColorMin := RGBToWord(wipColor[I].R, wipColor[I].G, wipColor[I].B);
  end;
end;


procedure TWRDXTCompressorColor.GetRygsColor16(out aColorMin, aColorMax: Word);
const
  nIterPower = 4;
var
  I: Integer;
  muv, minv, maxv, mu: TRGBColor16;
  cov: array[0..5]of Integer;
  r,g,b: Integer;
  covf: array[0..5]of Single;
  vfr, vfg, vfb: Single;
  iter: Integer;
  rr,gg,bb: Single;
  magn: Single;
  v_r, v_g, v_b: Integer;
  mind, maxd: Integer;
  dot: Integer;
begin
  muv.R := fSrcCol[1].R;
  muv.G := fSrcCol[1].G;
  muv.B := fSrcCol[1].B;
  minv := muv;
  maxv := muv;
  for I := 2 to 16 do
  begin
    muv.R := muv.R + fSrcCol[I].R;
    muv.G := muv.G + fSrcCol[I].G;
    muv.B := muv.B + fSrcCol[I].B;

    if fSrcCol[I].R < minv.R then minv.R := fSrcCol[I].R;
    if fSrcCol[I].R > maxv.R then maxv.R := fSrcCol[I].R;
    if fSrcCol[I].G < minv.G then minv.G := fSrcCol[I].G;
    if fSrcCol[I].G > maxv.G then maxv.G := fSrcCol[I].G;
    if fSrcCol[I].B < minv.B then minv.B := fSrcCol[I].B;
    if fSrcCol[I].B > maxv.B then maxv.B := fSrcCol[I].B;
  end;

  mu.R := (muv.R + 8) shr 4;
  mu.G := (muv.G + 8) shr 4;
  mu.B := (muv.B + 8) shr 4;

// determine covariance matrix
  for i:=0 to 5 do
    cov[i] := 0;

  for I := 1 to 16 do
  begin
    r := fSrcCol[I].R - mu.R;
    g := fSrcCol[I].G - mu.G;
    b := fSrcCol[I].B - mu.B;

    Inc(cov[0], r*r);
    Inc(cov[1], r*g);
    Inc(cov[2], r*b);
    Inc(cov[3], g*g);
    Inc(cov[4], g*b);
    Inc(cov[5], b*b);
  end;

  // convert covariance matrix to float, find principal axis via power iter
  for i:=0 to 5 do
    covf[i] := cov[i] / 255;

  vfr := maxv.R - minv.R;
  vfg := maxv.G - minv.G;
  vfb := maxv.B - minv.B;

  for iter := 0 to nIterPower - 1 do
  begin
    rr := vfr*covf[0] + vfg*covf[1] + vfb*covf[2];
    gg := vfr*covf[1] + vfg*covf[3] + vfb*covf[4];
    bb := vfr*covf[2] + vfg*covf[4] + vfb*covf[5];

    vfr := rr;
    vfg := gg;
    vfb := bb;
  end;

  magn := Abs(vfr);
  if Abs(vfg) > magn then magn := Abs(vfg);
  if Abs(vfb) > magn then magn := Abs(vfb);

  if magn < 4.0 then
  begin // too small, default to luminance
    v_r := 299; // JPEG YCbCr luma coefs, scaled by 1000.
    v_g := 587;
    v_b := 114;
  end else
  begin
    magn := 512.0 / magn;
    v_r := Round(vfr * magn);
    v_g := Round(vfg * magn);
    v_b := Round(vfb * magn);
  end;

  mind := MaxInt;
  maxd := -MaxInt;

  // Pick colors at extreme points
  for I := 1 to 16 do
  begin
    dot := fSrcCol[i].R*v_r + fSrcCol[i].G*v_g + fSrcCol[i].B*v_b;

    if (dot < mind) then
    begin
      mind := dot;
      aColorMin := RGBToWord(fSrcCol[i].R, fSrcCol[i].G, fSrcCol[i].B);
    end;

    if (dot > maxd) then
    begin
      maxd := dot;
      aColorMax := RGBToWord(fSrcCol[i].R, fSrcCol[i].G, fSrcCol[i].B);
    end;
  end;
end;


function TWRDXTCompressorColor.RefineBlock(var aColorMin, aColorMax: Word): Boolean;
const
  w1Tab: array [0..3] of Byte = (3,0,2,1);
  prods: array [0..3] of Integer = ($090000,$000900,$040102,$010402);
//                                   589824    2304  262402   66562
//                                      768      48     512     258
  // ^some magic to save a lot of multiplies in the accumulating loop...
  // (precomputed products of weights for least squares system, accumulated inside one 32-bit register)
var
  frb,fg: Single;
  oldMin, oldMax, min16, max16: Word;
  i, akku, xx,xy,yy: Integer;
  At1: TRGBColor16;
  At2: TRGBColor16;
  r,g,b,step,w1: Integer;
  L: Integer;
begin
  oldMin := aColorMin;
  oldMax := aColorMax;
             {
  At1 := default(TRGBColor16);
  At2 := default(TRGBColor16);

  for I := 1 to 16 do
  begin
    step := 3;//cm&3;
    w1 := w1Tab[step];
    r := fSrcCol[i].R;
    g := fSrcCol[i].G;
    b := fSrcCol[i].B;

    Inc(akku, prods[step]);
    Inc(At1.r, w1*r);
    Inc(At1.g, w1*g);
    Inc(At1.b, w1*b);
    Inc(At2.r, r);
    Inc(At2.g, g);
    Inc(At2.b, b);
  end;

  At2.r := 3*At2.r - At1.r;
  At2.g := 3*At2.g - At1.g;
  At2.b := 3*At2.b - At1.b;

  // extract solutions and decide solvability
  xx := akku shr 16;
  yy := (akku shr 8) and $ff;
  xy := (akku shr 0) and $ff;

  if (xx*yy - xy*xy) = 0 then
    Exit;

  frb := 3.0 * 31.0 / 255.0 / (xx*yy - xy*xy);
  fg := frb * 63.0 / 31.0;

  // solve.
  max16 := EnsureRange(Round((At1.r*yy - At2.r*xy)*frb+0.5),0,31) shl 11 +
           EnsureRange(Round((At1.g*yy - At2.g*xy)*fg +0.5),0,63) shl 5 +
           EnsureRange(Round((At1.b*yy - At2.b*xy)*frb+0.5),0,31) shl 0;

  min16 := EnsureRange(Round((At2.r*xx - At1.r*xy)*frb+0.5),0,31) shl 11 +
           EnsureRange(Round((At2.g*xx - At1.g*xy)*fg +0.5),0,63) shl 5 +
           EnsureRange(Round((At2.b*xx - At1.b*xy)*frb+0.5),0,31) shl 0;

  aColorMin := min16;
  aColorMax := max16;                                          }
  Result := (oldMin <> aColorMin) or (oldMax <> aColorMax);
end;


function TWRDXTCompressorColor.SearchMinMax(aDir: Boolean): Int64;
var
  colorMin, colorMax: Word;
begin
  GetMinMaxColor16(colorMin, colorMax);
  if aDir then
    Result := SaveToBlock(colorMin, colorMax)
  else
    Result := SaveToBlock(colorMax, colorMin);
end;


function TWRDXTCompressorColor.SearchPlain(aDir: Boolean): Int64;
var
  colorMin, colorMax: TRGBColor;
  colorMin16, colorMax16: Word;
begin
  GetMinMaxColor24(colorMin, colorMax);

  colorMin16 := RGBToWord(Max(colorMin.R - 8, 0), Max(colorMin.G - 4, 0), Max(colorMin.B - 8, 0));
  colorMax16 := RGBToWord(Min(colorMin.R + 8, 255), Min(colorMin.G + 4, 255), Min(colorMin.B + 8, 255));

  if aDir then
    Result := SaveToBlock(colorMin16, colorMax16)
  else
    Result := SaveToBlock(colorMax16, colorMin16);
end;


function TWRDXTCompressorColor.SearchExt(aExt, aDir: Boolean): Int64;
const
  EXTENT = 0.5;
var
  I, K: Integer;
  color24Min, color24Max, colorExt: TRGBColor;
  color16Min, color16Max: Word;
begin
  GetMinMaxColor24(color24Min, color24Max);
  GetMinMaxColor16(color16Min, color16Max);

  // Min .. 1/3 .. 2/3 .. Max
  //  10 ..  13 ..  16 .. 19
  //  10 ..  14 ..  18 .. 22

  if aExt then
  begin
    colorExt.R := Min(color24Max.R + Round(Max(color24Max.R - color24Min.R, 0) * EXTENT), 255);
    colorExt.G := Min(color24Max.G + Round(Max(color24Max.G - color24Min.G, 0) * EXTENT), 255);
    colorExt.B := Min(color24Max.B + Round(Max(color24Max.B - color24Min.B, 0) * EXTENT), 255);
    color16Max := RGBToWord(colorExt.R, colorExt.G, colorExt.B);
  end else
  begin
    colorExt.R := Max(color24Min.R - Round(Max(color24Max.R - color24Min.R, 0) * EXTENT), 0);
    colorExt.G := Max(color24Min.G - Round(Max(color24Max.G - color24Min.G, 0) * EXTENT), 0);
    colorExt.B := Max(color24Min.B - Round(Max(color24Max.B - color24Min.B, 0) * EXTENT), 0);
    color16Min := RGBToWord(colorExt.R, colorExt.G, colorExt.B);
  end;

  if color16Min > color16Max then
    SwapInt(color16Min, color16Max);

  if aDir then
    Result := SaveToBlock(color16Min, color16Max)
  else
    Result := SaveToBlock(color16Max, color16Min);
end;


function TWRDXTCompressorColor.SearchMerged(aDir: Boolean): Int64;
var
  colorMin, colorMax: Word;
begin
  GetMergedColors(colorMin, colorMax);

  if aDir then
    Result := SaveToBlock(colorMin, colorMax)
  else
    Result := SaveToBlock(colorMax, colorMin);
end;


function TWRDXTCompressorColor.SearchDLL: Int64;
const
  FLAG_DXT1 = 1; //! Use DXT1 compression.
  FLAG_DXT3 = 2; //! Use DXT3 compression.
  FLAG_DXT5 = 4; //! Use DXT5 compression.
  FLAG_COLOR_CLUSTER_FIT = 8; //! Use a slow but high quality colour compressor (the default).
  FLAG_COLOR_RANGE_FIT = 16;  //! Use a fast but low quality colour compressor.
  //32 Unused
  //64 Unused
  FLAG_COLOR_BY_ALPHA = 128;              //! Weight the colour by alpha during cluster fit (disabled by default).
  FLAG_COLOR_ITERATIVE_CLUSTER_FIT = 256; //! Use a very slow but very high quality colour compressor.
var
  col: array [0..63] of Byte;
  block: array [0..15] of Byte;
  metrics: array [0..2] of Single;
  flags: Integer;
  I: Integer;
begin
  for I := 0 to 15 do
  begin
    col[I*4+0] := fSrcCol[I+1].R;
    col[I*4+1] := fSrcCol[I+1].G;
    col[I*4+2] := fSrcCol[I+1].B;
    col[I*4+3] := 255;
  end;

  for I := 0 to 15 do block[I] := 0;
  flags := FLAG_DXT1 or FLAG_COLOR_ITERATIVE_CLUSTER_FIT;
  metrics[0] := 1.0;
  metrics[1] := 1.0;
  metrics[2] := 1.0;

  Result := 0;

  if Assigned(fDllCompress) then
  begin
    try
      fDllCompress(@col[0], @block[0], flags, @metrics[0]);
    except
      // Tolerate fails (BestPick will manage this)
    end;

    for I := 0 to 7 do
      Result := Result or (Int64(block[I]) shl (I*8));
  end;
end;


function TWRDXTCompressorColor.SearchRygs(aDir: Boolean): Int64;
var
  colorMin, colorMax: Word;
begin
  GetRygsColor16(colorMin, colorMax);

  RefineBlock(colorMin, colorMax);

  if aDir then
    Result := SaveToBlock(colorMin, colorMax)
  else
    Result := SaveToBlock(colorMax, colorMin);
end;


function TWRDXTCompressorColor.SaveToBlock(aColor0, aColor1: Word): Int64;
var
  I, K: Integer;
  lookup: array [0..3, 1..3] of Byte;
  dst, bestDst: Integer;
  im: array [0..15] of Byte;
begin
  if aColor0 > aColor1 then
  begin
    // Max, Min, 2/3 max, 1/3 max

    WordToRGB(aColor0, lookup[0,1], lookup[0,2], lookup[0,3]);
    WordToRGB(aColor1, lookup[1,1], lookup[1,2], lookup[1,3]);
    lookup[2, 1] := mix(lookup[0, 1], lookup[1, 1], 2 / 3); // 2/3 Max
    lookup[2, 2] := mix(lookup[0, 2], lookup[1, 2], 2 / 3);
    lookup[2, 3] := mix(lookup[0, 3], lookup[1, 3], 2 / 3);
    lookup[3, 1] := mix(lookup[0, 1], lookup[1, 1], 1 / 3); // 1/3 Max
    lookup[3, 2] := mix(lookup[0, 2], lookup[1, 2], 1 / 3);
    lookup[3, 3] := mix(lookup[0, 3], lookup[1, 3], 1 / 3);

    for I := 0 to 15 do
    begin
      // To which of four colors it's closest
      bestDst := MaxInt;
      for K := 0 to 3 do
      begin
        dst := GetLengthSQR(fSrcCol[I + 1].R - lookup[K, 1], fSrcCol[I + 1].G - lookup[K, 2], fSrcCol[I + 1].B - lookup[K, 3]);
        if dst < bestDst then
        begin
          bestDst := dst;
          im[I] := K;
        end;
      end;
    end;
  end else
  begin
    // Min, Max, 1/2

    WordToRGB(aColor0, lookup[0,1], lookup[0,2], lookup[0,3]);
    WordToRGB(aColor1, lookup[1,1], lookup[1,2], lookup[1,3]);
    lookup[2, 1] := mix(lookup[0, 1], lookup[1, 1], 1 / 2); // 1/2
    lookup[2, 2] := mix(lookup[0, 2], lookup[1, 2], 1 / 2);
    lookup[2, 3] := mix(lookup[0, 3], lookup[1, 3], 1 / 2);

    for I := 0 to 15 do
    begin
      // To which of three colors it's closest
      bestDst := MaxInt;
      for K := 0 to 2 do
      begin
        dst := GetLengthSQR(fSrcCol[I + 1].R - lookup[K, 1], fSrcCol[I + 1].G - lookup[K, 2], fSrcCol[I + 1].B - lookup[K, 3]);
        if dst < bestDst then
        begin
          bestDst := dst;
          im[I] := K;
        end;
      end;
    end;
  end;

  Result := aColor0 + (aColor1 shl 16);
  for I := 0 to 15 do
    Result := Result + Int64(Int64(im[I] and $03) shl (32 + I * 2));
end;


function TWRDXTCompressorColor.CalculateRMS(aData: Pointer): Single;
var
  resCol: array [0..47] of Byte;
  I: Integer;
begin
  DXT_RGB_Decode(aData, resCol);

  Result := 0;
  for I := 0 to 15 do Result := Result + Sqr(fSrcCol[I+1].R - resCol[I*3+0]);
  for I := 0 to 15 do Result := Result + Sqr(fSrcCol[I+1].G - resCol[I*3+1]);
  for I := 0 to 15 do Result := Result + Sqr(fSrcCol[I+1].B - resCol[I*3+2]);

  Result := Result / 48;
end;


procedure TWRDXTCompressorColor.CompressBlock(aRow1, aRow2, aRow3, aRow4: Pointer; aHeuristic: TDXTCompressionHeuristics;
  out aBlockData: Int64; out aRMS: Single);
var
  I: Integer;
  L: TDXTCompressionHeuristics;
  best: TDXTCompressionHeuristics;
  s: Single;
begin
  // Save into local RGB buffer
  for I := 1 to 4 do
  begin
    fSrcCol[I].R := PByte(Cardinal(aRow1) + I * 4 - 4 + 0)^;
    fSrcCol[I].G := PByte(Cardinal(aRow1) + I * 4 - 4 + 1)^;
    fSrcCol[I].B := PByte(Cardinal(aRow1) + I * 4 - 4 + 2)^;

    fSrcCol[I+4].R := PByte(Cardinal(aRow2) + I * 4 - 4 + 0)^;
    fSrcCol[I+4].G := PByte(Cardinal(aRow2) + I * 4 - 4 + 1)^;
    fSrcCol[I+4].B := PByte(Cardinal(aRow2) + I * 4 - 4 + 2)^;

    fSrcCol[I+8].R := PByte(Cardinal(aRow3) + I * 4 - 4 + 0)^;
    fSrcCol[I+8].G := PByte(Cardinal(aRow3) + I * 4 - 4 + 1)^;
    fSrcCol[I+8].B := PByte(Cardinal(aRow3) + I * 4 - 4 + 2)^;

    fSrcCol[I+12].R := PByte(Cardinal(aRow4) + I * 4 - 4 + 0)^;
    fSrcCol[I+12].G := PByte(Cardinal(aRow4) + I * 4 - 4 + 1)^;
    fSrcCol[I+12].B := PByte(Cardinal(aRow4) + I * 4 - 4 + 2)^;
  end;

  if aHeuristic in [chBestPick, chMinMax1] then   fDst[chMinMax1].Data := SearchMinMax(False);
  if aHeuristic in [chBestPick, chMinMax2] then   fDst[chMinMax2].Data := SearchMinMax(True);
  if aHeuristic in [chBestPick, chExtHigh1] then  fDst[chExtHigh1].Data := SearchExt(False, False);
  if aHeuristic in [chBestPick, chExtHigh2] then  fDst[chExtHigh2].Data := SearchExt(False, True);
  if aHeuristic in [chBestPick, chExtLow1] then   fDst[chExtLow1].Data := SearchExt(True, False);
  if aHeuristic in [chBestPick, chExtLow2] then   fDst[chExtLow2].Data := SearchExt(True, True);
  if aHeuristic in [chBestPick, chMerged1] then   fDst[chMerged1].Data := SearchMerged(True);
  if aHeuristic in [chBestPick, chMerged2] then   fDst[chMerged2].Data := SearchMerged(False);
  if aHeuristic in [chBestPick, chRygs1] then     fDst[chRygs1].Data := SearchRygs(False);
  if aHeuristic in [chBestPick, chRygs2] then     fDst[chRygs2].Data := SearchRygs(True);
  if aHeuristic in [chBestPick, chSquish] then    fDst[chSquish].Data := SearchDLL;
  if aHeuristic in [chBestPick, chPlain1] then    fDst[chPlain1].Data := SearchPlain(False);
  if aHeuristic in [chBestPick, chPlain2] then    fDst[chPlain2].Data := SearchPlain(True);
  if aHeuristic in [chBestPick, chOriginal] then  DXT_RGB_Encode(aRow1, aRow2, aRow3, aRow4, fDst[chOriginal].Data, s);

  fDst[chBestPick].Data := $AAAAAAAAFFFF;
  fDst[chBestPick].RMS := MaxSingle;

  for L := Low(TDXTCompressionHeuristics) to High(TDXTCompressionHeuristics) do
    fDst[L].RMS := CalculateRMS(@fDst[L].Data);

  best := aHeuristic;
  for L := Low(TDXTCompressionHeuristics) to High(TDXTCompressionHeuristics) do
  if aHeuristic in [chBestPick, L] then
  if fDst[L].RMS < fDst[best].RMS then
    best := L;

  //best := chStraight1;

  aBlockData := fDst[best].Data;
  aRMS := fDst[best].RMS;
        {
  case best of
    chStraight1:   aBlockData := RGBToWord(255, 0, 0);
    chStraight2:   aBlockData := RGBToWord(255, 128, 0);
    chExtended11:  aBlockData := RGBToWord(255, 255, 0);
    chExtended12:  aBlockData := RGBToWord(128, 255, 0);
    chExtended21:  aBlockData := RGBToWord(255, 255, 0);
    chExtended22:  aBlockData := RGBToWord(128, 255, 0);
    ch51:          aBlockData := RGBToWord(0, 255, 0);
    ch52:          aBlockData := RGBToWord(0, 255, 128);
    chRygs1:       aBlockData := RGBToWord(0, 255, 255);
    chRygs2:       aBlockData := RGBToWord(0, 128, 255);
    chDLL:         aBlockData := RGBToWord(0, 0, 255);
    chPlain1:      aBlockData := RGBToWord(0, 0, 128);
    chPlain2:      aBlockData := RGBToWord(0, 0, 128);
    chOld:         aBlockData := RGBToWord(0, 0, 0);
  end;      //}
end;


procedure DXT_RGB_Encode(aRow1,aRow2,aRow3,aRow4: Pointer; out OutDat: Int64; out RMS: Single);
var
  i,k,h:integer;
  Col: array [1..16,1..3]of byte; //Input colors
  c0: array [1..4,1..3]of byte;   //
  c2: array [1..4,1..3]of byte;
  Crms: array [1..48]of byte;
  im: array [1..16]of word;
  m1,m2:word;
  tRMS: array [1..4]of integer;
  Trial: array [1..6]of record
    Dat:int64;
    tRMS:integer;
  end;

  procedure MakeBlock(id,mm1,mm2:word);
  var
    i: integer;
  begin
    with Trial[id] do
    begin
      Dat:=mm1+(mm2 shl 16);
      for i:=1 to 16 do
        Dat := Dat + Int64(Int64(im[I] and $03) shl (32 + (I - 1) * 2));

      {case id of
        1: Dat := RGBToWord(255, 0, 0);
        2: Dat := RGBToWord(255, 128, 0);
        3: Dat := RGBToWord(255, 255, 0);
        4: Dat := RGBToWord(128, 255, 0);
        5: Dat := RGBToWord(0, 255, 0);
        6: Dat := RGBToWord(0, 255, 128);
      end;}
    end;
  end;

begin
  FillChar(im,SizeOf(im),#0);
  FillChar(Trial,SizeOf(Trial),#0);
  FillChar(tRMS,SizeOf(tRMS),#0);
  for i:=0 to 3 do for h:=1 to 3 do col[i+1,h] := PByte(Integer(aRow1) +i*4+h-1)^;
  for i:=0 to 3 do for h:=1 to 3 do col[i+1+4,h] := PByte(Integer(aRow2) +i*4+h-1)^;
  for i:=0 to 3 do for h:=1 to 3 do col[i+1+8,h] := PByte(Integer(aRow3) +i*4+h-1)^;
  for i:=0 to 3 do for h:=1 to 3 do col[i+1+12,h] := PByte(Integer(aRow4) +i*4+h-1)^;
  RMS := 0;

  //Find minmax pair from existing colors;
  tRMS[1] := 65535;
  tRMS[2] := 0;

  for i:=1 to 16 do for h:=i+1 to 16 do
  begin
    if tRMS[2] <= GetLengthSQR(col[i,1]-col[h,1], col[i,2]-col[h,2], col[i,3]-col[h,3]) then
    begin
      tRMS[2] := GetLengthSQR(col[i,1]-col[h,1], col[i,2]-col[h,2], col[i,3]-col[h,3]);
      if RGBToWord(col[i,1], col[i,2], col[i,3]) <= RGBToWord(col[h,1], col[h,2], col[h,3]) then
      begin
        im[1] := i;
        im[2] := h;
      end
      else
      begin
        im[1] := h;
        im[2] := i;
      end;
    end;
  end;

  m1 := RGBToWord(col[im[2],1], col[im[2],2], col[im[2],3]);
  m2 := RGBToWord(col[im[1],1], col[im[1],2], col[im[1],3]);

  //Find another minmax pair from existing colors;
 { tRMS[1]:=65535; tRMS[2]:=0;
  for i:=1 to 16 do for h:=i+1 to 16 do
    if (im[1]<>i)and(im[2]<>h)and(im[2]<>i)and(im[1]<>h) then begin
    if tRMS[2]<=round(GetLength(col[i,1]-col[h,1],col[i,2]-col[h,2],col[i,3]-col[h,3])) then begin
      tRMS[2]:=round(GetLength(col[i,1]-col[h,1],col[i,2]-col[h,2],col[i,3]-col[h,3]));
      if RGBToWord(col[i,1],col[i,2],col[i,3])<=RGBToWord(col[h,1],col[h,2],col[h,3]) then begin
        im[3]:=i; im[4]:=h;
      end else begin
        im[3]:=h; im[4]:=i;
      end;
    end;
  end;
  m1:=RGBToWord((col[im[2],1]+col[im[4],1])div 2,(col[im[2],2]+col[im[4],2])div 2,(col[im[2],3]+col[im[4],3])div 2);
  m2:=RGBToWord((col[im[1],1]+col[im[3],1])div 2,(col[im[1],2]+col[im[3],2])div 2,(col[im[1],3]+col[im[3],3])div 2);
//}

  {//Get minmax pair by luminance, produces rather poor results
  tRMS[1]:=65535; tRMS[2]:=0;
  for i:=1 to 16 do begin
    if tRMS[1]>=(col[i,1]*3+col[i,2]*6+col[i,3]*1) then begin
      tRMS[1]:=(col[i,1]*3+col[i,2]*6+col[i,3]*1);
      im[2]:=i;
      end;
    if tRMS[2]<=(col[i,1]*3+col[i,2]*6+col[i,3]*1) then begin
      tRMS[2]:=(col[i,1]*3+col[i,2]*6+col[i,3]*1);
      im[1]:=i;
      end;
  end; //}

  {//Find a middlepoint and build endpoints from it - incomplete idea
  FillChar(c1[1],SizeOf(c1[1]),#0);
  FillChar(c1[4],SizeOf(c1[4]),#255);
  for i:=1 to 16 do begin
    c1[1,1]:=max(c1[1,1],col[i,1]);
    c1[1,2]:=max(c1[1,2],col[i,2]);
    c1[1,3]:=max(c1[1,3],col[i,3]);
    c1[4,1]:=min(c1[4,1],col[i,1]);
    c1[4,2]:=min(c1[4,2],col[i,2]);
    c1[4,3]:=min(c1[4,3],col[i,3]);
  end;
    c1[2,1]:=(c1[1,1]+c1[4,1])div 2;
    c1[2,2]:=(c1[1,2]+c1[4,2])div 2;
    c1[2,3]:=(c1[1,3]+c1[4,3])div 2; }
  //for i:=1 to 16 do begin
//    if col[i,1]
  //}

  //These are input colors, 1=max and 4=min
  c0[1,1] := col[im[2],1];
  c0[1,2] := col[im[2],2];
  c0[1,3] := col[im[2],3];

  c0[4,1] := col[im[1],1];
  c0[4,2] := col[im[1],2];
  c0[4,3] := col[im[1],3];

//Case1 Straight case, use 2 interpolated colors 1/3 and 2/3
  WordToRGB(m1,c2[1,1],c2[1,2],c2[1,3]);
  WordToRGB(m2,c2[4,1],c2[4,2],c2[4,3]);
  c2[2,1]:=mix(c2[4,1],c2[1,1],1/3);
  c2[2,2]:=mix(c2[4,2],c2[1,2],1/3);
  c2[2,3]:=mix(c2[4,3],c2[1,3],1/3);
  c2[3,1]:=mix(c2[4,1],c2[1,1],2/3);
  c2[3,2]:=mix(c2[4,2],c2[1,2],2/3);
  c2[3,3]:=mix(c2[4,3],c2[1,3],2/3);

  for i:=1 to 16 do
  begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(col[i,1]-c2[h,1],col[i,2]-c2[h,2],col[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h:=1 else h:=2;
    if tRMS[h]>tRMS[3] then h:=3;
    if tRMS[h]>tRMS[4] then h:=4;
    if h=1 then im[i]:=0;
    if h=2 then im[i]:=2;
    if h=3 then im[i]:=3;
    if h=4 then im[i]:=1;
    inc(Trial[1].tRMS,tRMS[h]);
  end;

  MakeBlock(1,m1,m2);

//Case2 Straight case, use 1 interpolated color 1/2, other color should be avoided (it's black?)
  c2[2,1]:=(c2[1,1]+c2[4,1])div 2;
  c2[2,2]:=(c2[1,2]+c2[4,2])div 2;
  c2[2,3]:=(c2[1,3]+c2[4,3])div 2;

  for i:=1 to 16 do
  begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(col[i,1]-c2[h,1],col[i,2]-c2[h,2],col[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h:=1 else h:=2;
    if tRMS[h]>tRMS[4]{=tRMS[3]} then h:=4;
    if h=1 then im[i]:=1;
    if h=2 then im[i]:=2;
    if h=3 then im[i]:=3;
    if h=4 then im[i]:=0;
    inc(Trial[2].tRMS,tRMS[h]);
  end;

  MakeBlock(2,m2,m1);

//Case3 Enlarge range one direction to get better match for 1/3 or 2/3 interpolation

  for k:=0 to 1 do
  begin
    if k=0 then
    begin
      c2[1,1]:=EnsureRange(c0[1,1]+(c0[1,1]-c0[4,1])div 2,0,255);
      c2[1,2]:=EnsureRange(c0[1,2]+(c0[1,2]-c0[4,2])div 2,0,255);
      c2[1,3]:=EnsureRange(c0[1,3]+(c0[1,3]-c0[4,3])div 2,0,255);
      m1:=RGBToWord(c2[1,1],c2[1,2],c2[1,3]);
      m2:=RGBToWord(c0[4,1],c0[4,2],c0[4,3]);
      if m1<m2 then SwapInt(m1,m2);
      WordToRGB(m1,c2[1,1],c2[1,2],c2[1,3]);
      WordToRGB(m2,c2[4,1],c2[4,2],c2[4,3]);
    end;
    if k=1 then begin
      c2[4,1]:=EnsureRange(c0[4,1]-(c0[1,1]-c0[4,1])div 2,0,255);
      c2[4,2]:=EnsureRange(c0[4,2]-(c0[1,2]-c0[4,2])div 2,0,255);
      c2[4,3]:=EnsureRange(c0[4,3]-(c0[1,3]-c0[4,3])div 2,0,255);
      m1:=RGBToWord(c0[1,1],c0[1,2],c0[1,3]);
      m2:=RGBToWord(c2[4,1],c2[4,2],c2[4,3]);
      if m1<m2 then SwapInt(m1,m2);
      WordToRGB(m1,c2[1,1],c2[1,2],c2[1,3]);
      WordToRGB(m2,c2[4,1],c2[4,2],c2[4,3]);
    end;

    c2[2,1]:=mix(c2[4,1],c2[1,1],1/3);
    c2[2,2]:=mix(c2[4,2],c2[1,2],1/3);
    c2[2,3]:=mix(c2[4,3],c2[1,3],1/3);
    c2[3,1]:=mix(c2[4,1],c2[1,1],2/3);
    c2[3,2]:=mix(c2[4,2],c2[1,2],2/3);
    c2[3,3]:=mix(c2[4,3],c2[1,3],2/3);

    for i:=1 to 16 do begin
      for h:=1 to 4 do
        tRMS[h]:=GetLengthSQR(col[i,1]-c2[h,1],col[i,2]-c2[h,2],col[i,3]-c2[h,3]);
      if tRMS[1]<tRMS[2] then h:=1 else h:=2;
      if tRMS[h]>tRMS[3] then h:=3;
      if tRMS[h]>tRMS[4] then h:=4;
      if h=1 then im[i]:=0;
      if h=2 then im[i]:=2;
      if h=3 then im[i]:=3;
      if h=4 then im[i]:=1;
      inc(Trial[3+k].tRMS,tRMS[h]);
    end;

    MakeBlock(3+k,m1,m2);
  end;

//Case4 Compute average block color and try to match it either by 1 or 2 interpolations, best for plaincolor matching
// possibly can be split into R-G-B matching, but that involves triple the code..
  tRMS[1]:=0; tRMS[2]:=0; tRMS[3]:=0;
  for i:=1 to 16 do begin
    inc(tRMS[1],col[i,1]);
    inc(tRMS[2],col[i,2]);
    inc(tRMS[3],col[i,3]);
  end;

  m1:=RGBToWord( //rounded one step up
  EnsureRange((round(tRMS[1]/16)shr 3+1) * 8,0,255),
  EnsureRange((round(tRMS[2]/16)shr 2+1) * 4,0,255),
  EnsureRange((round(tRMS[3]/16)shr 3+1) * 8,0,255));
  WordToRGB(m1,c2[1,1],c2[1,2],c2[1,3]);
  m2:=RGBToWord( //rounded one step down
  EnsureRange((round(tRMS[1]/16)shr 3) * 8,0,255),
  EnsureRange((round(tRMS[2]/16)shr 2) * 4,0,255),
  EnsureRange((round(tRMS[3]/16)shr 3) * 8,0,255));
  WordToRGB(m2,c2[4,1],c2[4,2],c2[4,3]);

  c2[2,1]:=(c2[4,1]+c2[1,1])div 2; c2[2,2]:=(c2[4,2]+c2[1,2])div 2; c2[2,3]:=(c2[4,3]+c2[1,3])div 2;

  for i:=1 to 16 do begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(col[i,1]-c2[h,1],col[i,2]-c2[h,2],col[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h:=1 else h:=2;
    if tRMS[h]>tRMS[4]{=tRMS[3]} then h:=4;
    if h=1 then im[i]:=1;
    if h=2 then im[i]:=2;
    if h=3 then im[i]:=3;
    if h=4 then im[i]:=0;
    inc(Trial[5].tRMS,tRMS[h]);
  end;

  MakeBlock(5, m2, m1);

  c2[2,1] := mix(c2[4,1],c2[1,1],1/3);
  c2[2,2] := mix(c2[4,2],c2[1,2],1/3);
  c2[2,3] := mix(c2[4,3],c2[1,3],1/3);
  c2[3,1] := mix(c2[4,1],c2[1,1],2/3);
  c2[3,2] := mix(c2[4,2],c2[1,2],2/3);
  c2[3,3] := mix(c2[4,3],c2[1,3],2/3);

  for i:=1 to 16 do begin
    for h:=1 to 4 do
      tRMS[h]:=GetLengthSQR(col[i,1]-c2[h,1],col[i,2]-c2[h,2],col[i,3]-c2[h,3]);
    if tRMS[1]<tRMS[2] then h := 1 else h := 2;
    if tRMS[h]>tRMS[3] then h := 3;
    if tRMS[h]>tRMS[4] then h := 4;
    if h=1 then im[i] := 0;
    if h=2 then im[i] := 2;
    if h=3 then im[i] := 3;
    if h=4 then im[i] := 1;
    inc(Trial[6].tRMS,tRMS[h]);
  end;

  MakeBlock(6, m1, m2);

                        {
//  Trial[1].tRMS:=9999999;
//  Trial[2].tRMS:=9999999;
//  Trial[3].tRMS:=9999999;
//  Trial[4].tRMS:=9999999;
//  Trial[5].tRMS:=9999999;
//  Trial[6].tRMS:=9999999;
  Trial[1].Dat:=RGBToWord(255,0,0);   //Red
  Trial[2].Dat:=RGBToWord(255,255,0); //Yellow
  Trial[3].Dat:=RGBToWord(0,255,0);   //Green
  Trial[4].Dat:=RGBToWord(0,255,255); //Cyan
  Trial[5].Dat:=RGBToWord(0,0,255);   //Blue
  Trial[6].Dat:=RGBToWord(255,0,255); //Magenta}

  //Choose the result with least RMS error
  k := MaxInt;
  for i:=1 to 6 do
    if Trial[i].tRMS < k then
    begin
      k := Trial[i].tRMS;
      h := i;
    end;
  OutDat := Trial[h].Dat;
  //  if Trial[h].tRMS>100 then
  //    OutDat:=1023;

  DXT_RGB_Decode(@OutDat, Crms); //Carry out RMS error value
  for i:=1 to 16 do RMS := RMS + Sqr(col[i,1] - Crms[i*3-2]) / 48;
  for i:=1 to 16 do RMS := RMS + Sqr(col[i,2] - Crms[i*3-1]) / 48;
  for i:=1 to 16 do RMS := RMS + Sqr(col[i,3] - Crms[i*3]) / 48;
end;


procedure DXT_RGB_Decode(aInDat:Pointer; out OutDat: array of Byte);
var
  i,h,x:integer;
  c: array [1..8]of byte;
  Colors: array [1..4,1..3]of Byte; //4colors in R,G,B
begin
  for I := 1 to 8 do //cast into array of byte
    c[i] := PByte(Cardinal(aInDat)+I-1)^;

  // Acquire min/max colors
  WordToRGB(c[1] + c[2] shl 8, Colors[1,1], Colors[1,2], Colors[1,3]);
  WordToRGB(c[3] + c[4] shl 8, Colors[2,1], Colors[2,2], Colors[2,3]);

  //Acquire average colors
  if (c[1] + c[2] shl 8) > (c[3] + c[4] shl 8) then
  begin
    Colors[3,1] := Round((Colors[2,1] + Colors[1,1]*2)/3);
    Colors[3,2] := Round((Colors[2,2] + Colors[1,2]*2)/3);
    Colors[3,3] := Round((Colors[2,3] + Colors[1,3]*2)/3);
    Colors[4,1] := Round((Colors[2,1]*2 + Colors[1,1])/3);
    Colors[4,2] := Round((Colors[2,2]*2 + Colors[1,2])/3);
    Colors[4,3] := Round((Colors[2,3]*2 + Colors[1,3])/3);
  end else
  begin
    Colors[3,1] := Round((Colors[2,1] + Colors[1,1])/2); Colors[4,1] := 255; //This is in fact 1bit transparent
    Colors[3,2] := Round((Colors[2,2] + Colors[1,2])/2); Colors[4,2] := 0;   //but let's show it as purple
    Colors[3,3] := Round((Colors[2,3] + Colors[1,3])/2); Colors[4,3] := 255;
  end;

  for h:=1 to 16 do
  begin
    x:=0;
    if h mod 4=1 then x :=  ord(c[1+(h-1)div 4+4])mod 4;        //1,5, 9,13
    if h mod 4=2 then x := (ord(c[1+(h-1)div 4+4])mod 16)div 4; //2,6,10,14
    if h mod 4=3 then x := (ord(c[1+(h-1)div 4+4])mod 64)div 16;//3,7,11,15
    if h mod 4=0 then x :=  ord(c[1+(h-1)div 4+4])div 64;       //4,8,12,16

    OutDat[(h-1)*3+0] := Colors[x+1,1]; //R
    OutDat[(h-1)*3+1] := Colors[x+1,2]; //G
    OutDat[(h-1)*3+2] := Colors[x+1,3]; //B
  end;
end;

end.
