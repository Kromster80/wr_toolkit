unit WR_DXTCompressorAlpha;
interface
uses
  Math, KromUtils;

type
  TWRDXTCompressorAlpha = class
  private
    fSrcAlpha: array [1..16] of Byte;

  fDst: array [1..2] of record
    Data: Int64;
    RMS: Single;
  end;

    function CalculateRMS(aBlock: Int64): Single;
    procedure GetMinMaxColor(out aMinAlpha, aMaxAlpha: Byte);
    function Search1: Int64;
    function Search2: Int64;
  public
    procedure CompressBlock(aRow1, aRow2, aRow3, aRow4: Pointer; out aBlockData: Int64; out aRMS: Single);
    procedure DecompressBlock(aInData: Pointer; out aOutDat: array of Byte);
  end;


implementation


procedure TWRDXTCompressorAlpha.GetMinMaxColor(out aMinAlpha, aMaxAlpha: Byte);
var
  I: Integer;
begin
  aMinAlpha := fSrcAlpha[1];
  aMaxAlpha := fSrcAlpha[1];
  for I := 2 to 16 do
  begin
    aMinAlpha := Min(aMinAlpha, fSrcAlpha[I]);
    aMaxAlpha := Max(aMaxAlpha, fSrcAlpha[I]);
  end;
end;


function TWRDXTCompressorAlpha.Search1: Int64;
var
  minAlpha, maxAlpha: Byte;
  I: Integer;
  im: array [1..16] of Byte;
begin
  GetMinMaxColor(minAlpha, maxAlpha);

  // If there's same color over the block, then use archive-friendly output
  // Col for the first byte and zero for the rest
  if minAlpha = maxAlpha then
    Exit(minAlpha); // Rest of the Int64 is filled with zeroes

  FillChar(im, SizeOf(im), #0);

  for I := 1 to 16 do
  begin
    // 01234567 - initial lerp distribution
    im[I] := Round((fSrcAlpha[I] - minAlpha) / (maxAlpha - minAlpha) * 7);

    // 87654321
    im[I] := 7 - im[I] + 1;

    // 87654320
    if im[I] = 1 then im[I] := 0;

    // 17654320 - DXT5 needs it in this order
    if im[I] = 8 then im[I] := 1;
  end;

  // Max goes first
  Result := maxAlpha + (minAlpha shl 8);
  for I := 0 to 15 do
    Result := Result + Int64(Int64(im[I + 1] and $07) shl (16 + I * 3));
end;


function TWRDXTCompressorAlpha.Search2: Int64;
const
  PURE_MARGIN = 2; // Which color-value should be treated as non pure black/white, '2' fits just fine
var
  minAlpha, maxAlpha: Byte;
  I: Integer;
  im: array [1..16] of Byte;
begin
  FillChar(im, SizeOf(im), #0); // reset
  minAlpha := 255 - PURE_MARGIN;
  maxAlpha := PURE_MARGIN;
  for I := 1 to 16 do if fSrcAlpha[I] >= PURE_MARGIN       then minAlpha := Min(minAlpha, fSrcAlpha[I]);
  for I := 1 to 16 do if fSrcAlpha[I] <= (255-PURE_MARGIN) then maxAlpha := Max(maxAlpha, fSrcAlpha[I]);

  for I := 1 to 16 do
  begin
    if fSrcAlpha[I] <= (minAlpha div 2) then
      im[I] := 6 // Closer to the 0.0 than minAlpha
    else
    if fSrcAlpha[I] >= (maxAlpha div 2) then
      im[I] := 7 // Closer to the 1.0 than maxAlpha
    else
    if fSrcAlpha[I] <= minAlpha then
      im[I] := 0 // Closer to the minAlpha
    else
    if fSrcAlpha[I] >= maxAlpha then
      im[I] := 1 // Closer to the maxAlpha
    else
    begin
      im[I] := Round((fSrcAlpha[I] - minAlpha) / (maxAlpha - minAlpha) * 5) + 1;

      if im[I] = 1 then im[I] := 0;
      if im[I] = 6 then im[I] := 1;
    end;
  end;

  // Min goes first
  Result := minAlpha + (maxAlpha shl 8);
  for I := 0 to 15 do
    Result := Result + Int64(Int64(im[I+1] and $07) shl (16 + I * 3));
end;


function TWRDXTCompressorAlpha.CalculateRMS(aBlock: Int64): Single;
var
  I: Integer;
  testAlpha: array [1..16] of Byte;
begin
  DecompressBlock(@aBlock, testAlpha);

  Result := 0;
  for I := 1 to 16 do
    Result := Result + Sqr(fSrcAlpha[I] - testAlpha[I]);
end;


procedure TWRDXTCompressorAlpha.CompressBlock(aRow1, aRow2, aRow3, aRow4: Pointer; out aBlockData: Int64; out aRMS: Single);
var
  I: Integer;
  best: Integer;
begin
  // Save into local RGB buffer
  for I := 0 to 3 do
  begin
    fSrcAlpha[I+1] := PByte(Cardinal(aRow1) + I * 4)^;
    fSrcAlpha[I+5] := PByte(Cardinal(aRow2) + I * 4)^;
    fSrcAlpha[I+9] := PByte(Cardinal(aRow3) + I * 4)^;
    fSrcAlpha[I+13] := PByte(Cardinal(aRow4) + I * 4)^;
  end;

  fDst[1].Data := Search1;
  fDst[2].Data := Search2;

  for I := Low(fDst) to High(fDst) do
    fDst[I].RMS := CalculateRMS(fDst[I].Data);

  // Choose least error-result and take it
  best := Low(fDst);
  for I := Low(fDst) to High(fDst) do
  if fDst[I].RMS < fDst[best].RMS then
    best := I;

  aBlockData := fDst[best].Data;
  aRMS := fDst[best].RMS;
end;


procedure TWRDXTCompressorAlpha.DecompressBlock(aInData: Pointer; out aOutDat: array of Byte);
var
  I, x: Byte;
  alpha0, alpha1, T: Byte;
  d: Int64;
begin
  d := Int64(aInData^); //cast all 8 bytes into one int64 value
  alpha0 := d and $FF;
  alpha1 := (d shr 8) and $FF;
  d := d shr 16;

  for I := 0 to 15 do
  begin
    T := 0;
    x := d shr (I * 3) and $7; // Consequently pick up 3 adjustment bits
    if x = 0 then
      T := alpha0
    else
    if x = 1 then
      T := alpha1
    else

    if alpha0 < alpha1 then
      // Linear interpolation + min&max
      case x of
        2: T := Round((4 * alpha0 + 1 * alpha1) / 5);
        3: T := Round((3 * alpha0 + 2 * alpha1) / 5);
        4: T := Round((2 * alpha0 + 3 * alpha1) / 5);
        5: T := Round((1 * alpha0 + 4 * alpha1) / 5);
        6: T := 0;
        7: T := 255;
      end
    else
      // Linear interpolation x=2..7
      T := Round(((8-x) * alpha0 + (x-1) * alpha1) / 7);

    aOutDat[I] := T; //0..15
  end;
end;


end.
