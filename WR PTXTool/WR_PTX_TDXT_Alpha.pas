unit WR_PTX_TDXT_Alpha;
interface
uses
  Math, KromUtils;

procedure DXT_A_Encode(aRow1, aRow2, aRow3, aRow4: Pointer; out aOutDat: Int64; out aRMS: Single);
procedure DXT_A_Decode(aInDat: Pointer; out aOutDat: array of Byte);

implementation

procedure DXT_A_Encode(aRow1, aRow2, aRow3, aRow4: Pointer; out aOutDat: Int64; out aRMS: Single);
const
  Tolerate = 2; //Which color-value should be treated as non pure black/white, '2' fits just fine
var
  I: Integer;
  srcAlpha: array [1..16] of Byte;
  TestColor: array [1..16] of Byte; //Will store reference test color to compute RMS error
  ColorMin: Byte;
  ColorMax: Byte;
  im: array [1..16] of Byte;
  Trial: array [1..2] of record
    Dat: Int64;
    tRMS: Single;
  end;
begin
  FillChar(im, SizeOf(im), #0);
  FillChar(Trial, SizeOf(Trial), #0);
  for I:=0 to 3 do srcAlpha[I+1] := Byte(Char(Pointer((Integer(aRow1)+I*4))^));
  for I:=0 to 3 do srcAlpha[I+1+4] := Byte(Char(Pointer((Integer(aRow2)+I*4))^));
  for I:=0 to 3 do srcAlpha[I+1+8] := Byte(Char(Pointer((Integer(aRow3)+I*4))^));
  for I:=0 to 3 do srcAlpha[I+1+12] := Byte(Char(Pointer((Integer(aRow4)+I*4))^));

  // Find min-max colors
  ColorMin := 255;
  ColorMax := 0;
  for I:=1 to 8 do ColorMin := Min(ColorMin, srcAlpha[I*2-1], srcAlpha[I*2]);
  for I:=1 to 8 do ColorMax := Max(ColorMax, srcAlpha[I*2-1], srcAlpha[I*2]);

  // If there's same color over the block, then use archive-friendly output
  // Col for the first byte and zero for the rest
  if ColorMin = ColorMax then
  begin
    aOutDat := ColorMin; //Rest of In64 is filled with zeroes
    aRMS := 0;
  end else
  begin
    with Trial[1] do
    begin

      for I := 1 to 16 do
      begin
        if srcAlpha[I]-ColorMin<>0 then //Don't divide by zero
          im[I] := Round(7/((ColorMax-ColorMin)/(srcAlpha[I]-ColorMin)))  //0..7
        else
          im[I] := 0;
        im[I] := 7-im[I] + 1;
        if im[I] = 1 then im[I]:=0;
        if im[I] = 8 then im[I]:=1;
      end;

      Dat := ColorMax + (ColorMin shl 8); //Max goes first
      for I := 1 to 16 do
        Dat := Dat + int64( int64(im[I] AND $07) shl ( 16 + (I-1)*3 ) );
      DXT_A_Decode(@Dat, TestColor);
      tRMS := 0;
      for I := 1 to 16 do tRMS := tRMS + Sqr(srcAlpha[I]-TestColor[I]);
    end;

    with Trial[2] do
    begin
      FillChar(im,SizeOf(im),#0); //reset
      ColorMin := 255 - Tolerate;
      ColorMax := Tolerate;
      for I:=1 to 16 do if srcAlpha[I] >= Tolerate       then ColorMin := Math.min(ColorMin, srcAlpha[I]);
      for I:=1 to 16 do if srcAlpha[I] <= (255-Tolerate) then ColorMax := Math.max(ColorMax, srcAlpha[I]);

      for I:=1 to 16 do begin
        if srcAlpha[I]<=(ColorMin div 2) then im[I]:=6 else
        if srcAlpha[I]>=(ColorMax div 2) then im[I]:=7 else
        if srcAlpha[I]<=ColorMin then im[I]:=0 else
        if srcAlpha[I]>=ColorMax then im[I]:=1 else
          begin
            im[I] := round(5/((ColorMax-ColorMin)/(srcAlpha[I]-ColorMin)))+1;  //0..5
            if im[I]=1 then im[I]:=0;
            if im[I]=6 then im[I]:=1;
          end;
      end;

      Dat := ColorMin + (ColorMax shl 8);
      for I := 1 to 16 do
      Dat := Dat + int64( int64(im[I] AND $07) shl ( 16 + (I-1)*3 ) );
      tRMS := 0;
      DXT_A_Decode(@Dat, TestColor);
      for I := 1 to 16 do tRMS := tRMS + sqr(srcAlpha[I]-TestColor[I]);
    end;

    //Choose least error-result and take it
    if Trial[1].tRMS<Trial[2].tRMS then
    begin
      aRMS    := aRMS + Trial[1].tRMS;
      aOutDat := Trial[1].Dat;
    end else
    begin
      aRMS    := aRMS + Trial[2].tRMS;
      aOutDat := Trial[2].Dat;
    end;
  end;
end;


procedure DXT_A_Decode(aInDat: Pointer; out aOutDat: array of Byte);
var
  I, x: Byte;
  colorMin, colorMax, T: Byte;
  d: Int64;
begin
  d := Int64(aInDat^); //cast all 8 bytes into one int64 value
  colorMin := d and $FF;
  colorMax := (d shr 8) and $FF;
  d := d shr 16;

  for I := 0 to 15 do
  begin
    T := 0;
    x := d shr (I * 3) and $7; //Consequently pick up 3 adjustment bits
    if x = 0 then
      T := colorMin
    else
    if x = 1 then
      T := colorMax
    else

    if colorMin < colorMax then
      // Linear interpolation + min&max
      case x of
        2: T := Round((4*colorMin + 1*colorMax) / 5);
        3: T := Round((3*colorMin + 2*colorMax) / 5);
        4: T := Round((2*colorMin + 3*colorMax) / 5);
        5: T := Round((1*colorMin + 4*colorMax) / 5);
        6: T := 0;
        7: T := 255;
      end
    else
      // Linear interpolation x=2..7
      T := round(((8-x)*colorMin+(x-1)*colorMax)/7);

    aOutDat[I] := T; //0..15
  end;
end;


end.
