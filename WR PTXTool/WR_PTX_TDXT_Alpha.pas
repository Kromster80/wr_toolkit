unit WR_PTX_TDXT_Alpha;
interface
uses
  Math, KromUtils;

procedure DXT_A_Encode(aRow1, aRow2, aRow3, aRow4: Pointer; out aOutDat: Int64; out aRMS: Single);
procedure DXT_A_Decode(aInDat: Pointer; out aOutDat: array of Byte);

implementation

procedure DXT_A_Encode(aRow1, aRow2, aRow3, aRow4: Pointer; out aOutDat: Int64; out aRMS: Single);
const
  PURE_MARGIN = 2; //Which color-value should be treated as non pure black/white, '2' fits just fine
var
  I: Integer;
  srcAlpha: array [1..16] of Byte;
  testAlpha: array [1..16] of Byte; // Test color to compute RMS error
  minAlpha: Byte;
  maxAlpha: Byte;
  im: array [1..16] of Byte;
  Trial: array [1..2] of record
    dstData: Int64;
    RMSError: Single;
  end;
begin
  FillChar(im, SizeOf(im), #0);
  FillChar(Trial, SizeOf(Trial), #0);
  for I := 0 to 3 do srcAlpha[I+1] := PByte(Integer(aRow1)+I*4)^;
  for I := 0 to 3 do srcAlpha[I+1+4] := PByte(Integer(aRow2)+I*4)^;
  for I := 0 to 3 do srcAlpha[I+1+8] := PByte(Integer(aRow3)+I*4)^;
  for I := 0 to 3 do srcAlpha[I+1+12] := PByte(Integer(aRow4)+I*4)^;

  // Find min-max colors
  minAlpha := 255;
  maxAlpha := 0;
  for I := 1 to 16 do
  begin
    minAlpha := Min(minAlpha, srcAlpha[I]);
    maxAlpha := Max(maxAlpha, srcAlpha[I]);
  end;

  // If there's same color over the block, then use archive-friendly output
  // Col for the first byte and zero for the rest
  if minAlpha = maxAlpha then
  begin
    aOutDat := minAlpha; // Rest of the Int64 is filled with zeroes
    aRMS := 0;
    Exit;
  end;

  // 4b Max
  // 4b Min
  // 3bit * 16
  with Trial[1] do
  begin
    for I := 1 to 16 do
    begin
      // 01234567 - initial lerp distribution
      im[I] := Round((srcAlpha[I] - minAlpha) / (maxAlpha - minAlpha) * 7);

      // 87654321
      im[I] := 7 - im[I] + 1;

      // 87654320
      if im[I] = 1 then im[I] := 0;

      // 17654320 - DXT5 needs it in this order
      if im[I] = 8 then im[I] := 1;
    end;

    // Max goes first
    dstData := maxAlpha + (minAlpha shl 8);
    for I := 1 to 16 do
      dstData := dstData + Int64(Int64(im[I] and $07) shl (16 + (I-1)*3));

    DXT_A_Decode(@dstData, testAlpha);
    RMSError := 0;
    for I := 1 to 16 do
      RMSError := RMSError + Sqr(srcAlpha[I] - testAlpha[I]);
  end;

  with Trial[2] do
  begin
    FillChar(im, SizeOf(im), #0); // reset
    minAlpha := 255 - PURE_MARGIN;
    maxAlpha := PURE_MARGIN;
    for I := 1 to 16 do if srcAlpha[I] >= PURE_MARGIN       then minAlpha := Min(minAlpha, srcAlpha[I]);
    for I := 1 to 16 do if srcAlpha[I] <= (255-PURE_MARGIN) then maxAlpha := Max(maxAlpha, srcAlpha[I]);

    for I := 1 to 16 do
    begin
      if srcAlpha[I] <= (minAlpha div 2) then
        im[I] := 6 // Closer to the 0.0 than minAlpha
      else
      if srcAlpha[I] >= (maxAlpha div 2) then
        im[I] := 7 // Closer to the 1.0 than maxAlpha
      else
      if srcAlpha[I] <= minAlpha then
        im[I] := 0 // Closer to the minAlpha
      else
      if srcAlpha[I] >= maxAlpha then
        im[I] := 1 // Closer to the maxAlpha
      else
      begin
        im[I] := Round((srcAlpha[I] - minAlpha) / (maxAlpha - minAlpha) * 5) + 1;

        if im[I] = 1 then im[I] := 0;
        if im[I] = 6 then im[I] := 1;
      end;
    end;

    // Min goes first
    dstData := minAlpha + (maxAlpha shl 8);
    for I := 1 to 16 do
      dstData := dstData + int64( int64(im[I] AND $07) shl ( 16 + (I-1)*3 ) );
    RMSError := 0;
    DXT_A_Decode(@dstData, testAlpha);
    for I := 1 to 16 do
      RMSError := RMSError + sqr(srcAlpha[I] - testAlpha[I]);
  end;

  // Choose least error-result and take it
  if Trial[1].RMSError < Trial[2].RMSError then
  begin
    aRMS    := aRMS + Trial[1].RMSError;
    aOutDat := Trial[1].dstData;
  end else
  begin
    aRMS    := aRMS + Trial[2].RMSError;
    aOutDat := Trial[2].dstData;
  end;
end;


procedure DXT_A_Decode(aInDat: Pointer; out aOutDat: array of Byte);
var
  I, x: Byte;
  alpha0, alpha1, T: Byte;
  d: Int64;
begin
  d := Int64(aInDat^); //cast all 8 bytes into one int64 value
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
