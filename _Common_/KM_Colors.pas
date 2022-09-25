unit KM_Colors;
interface
uses
  Math, SysUtils;

// Color structures

type
  // Content-wise it's the same as TKMVertex3f, but since it is a color it has color-specific functions
  // and could be handled and treated differently
  TKMColor3f = record
  public
    R, G, B: Single;
    class function New(aR, aG, aB: Single): TKMColor3f; overload; static;
    class function NewFromArray(const aArray3: TArray<Single>): TKMColor3f; overload; static;
    class function NewGrey(aGrey: Single): TKMColor3f; static;
    class function NewIndex(aIndex: Cardinal): TKMColor3f; static;
    class function NewRGB(aRGB: Cardinal): TKMColor3f; static;
    class function NewFromHSB(const aHue, aSat, aBri: Single): TKMColor3f; static;
    class function NewFromHSV(const aHue, aSat, aVol: Single): TKMColor3f; static;
    class function NewFromH(const aHue: Single): TKMColor3f; static;
    class function NewLerp(const A, B: TKMColor3f; aFactor: Single): TKMColor3f; static;

    class function Black: TKMColor3f; static;
    class function Cyan: TKMColor3f; static;
    class function Magenta: TKMColor3f; static;
    class function White: TKMColor3f; static;

    class operator Equal(const A, B: TKMColor3f): Boolean;
    class operator NotEqual(const A, B: TKMColor3f): Boolean;
    class operator Add(const A, B: TKMColor3f): TKMColor3f; inline;
    class operator Multiply(const A: TKMColor3f; aValue: Single): TKMColor3f;

    function ToArray3: TArray<Single>;
    function ToCardinal: Cardinal;
    function ToColorCode: string;
    function ToString: string;
    function GetBrightness: Single;
    function GetBolder: TKMColor3f;
    function GetHue: Single;
    function GetSat: Single;
    function GetVol: Single;
    procedure Clamp;
    procedure SetBrightness(aBrightness: Single);
  end;
  PKMColorFunc3f = function: TKMColor3f;

//const
//  VIOLET: TKMColor3f = (R:1;G:0;B:1);
//  VIOLET2: TKMColor3f = VIOLET; // [dcc32 Error]: E2029 '(' expected but identifier 'VIOLET' found
//  VIOLET3 = VIOLET; // [dcc32 Error]: E2026 Constant expression expected
//  PKMColor4f = function: TKMColor4f; Works fine :-)


  TKMColor4b = Cardinal;
  {TKMColor4b = record
    R, G, B, A: Byte;
  end;}

  // Content-wise it's the same as TKMVertex4f, but since it it a color it has color-specific functions
  // and could be handled and treated differently
  TKMColor4f = record
  public
    R, G, B, A: Single;
    class function NewGrey(aGrey: Single): TKMColor4f; static;
    class function NewRGB(aRGB: Cardinal): TKMColor4f; static;
    class function NewRGBA(aRGBA: TKMColor4b): TKMColor4f; static;
    class function New(aRGB: TKMColor3f): TKMColor4f; overload; static;
    class function New(aRGB: TKMColor3f; aA: Single): TKMColor4f; overload; static;
    class function New(const aArray4: TArray<Single>): TKMColor4f; overload; static;
    class function New(const aR, aG, aB: Single): TKMColor4f; overload; static;
    class function New(const aR, aG, aB, aA: Single): TKMColor4f; overload; static;
    class function NewFromRGBA(const aR, aG, aB, aA: Single): TKMColor4f; static;
    class function NewFromHSB(const aHue, aSat, aBri, aAlpha: Single): TKMColor4f; static;
    class function NewFromUID(aUID: Integer; aAlpha: Single): TKMColor4f; static;
    class function NewLerp(const A, B: TKMColor4f; aFactor: Single): TKMColor4f; static;

    class function Clear: TKMColor4f; static;
    class function Black: TKMColor4f; static;
    class function Cyan: TKMColor4f; static;
    class function Red: TKMColor4f; static;
    class function Maroon: TKMColor4f; static;
    class function Green: TKMColor4f; static;
    class function GrassGreen: TKMColor4f; static;
    class function DarkBlue: TKMColor4f; static;
    class function Blue: TKMColor4f; static;
    class function LightBlue: TKMColor4f; static;
    class function White: TKMColor4f; static;
    class function Yellow: TKMColor4f; static;
    class function Orange: TKMColor4f; static;
    class function Grey25: TKMColor4f; static;
    class function Grey50: TKMColor4f; static;
    class function Grey75: TKMColor4f; static;
    class function Magenta: TKMColor4f; static;

    class operator Add(const A, B: TKMColor4f): TKMColor4f; inline;
    class operator Multiply(const A, B: TKMColor4f): TKMColor4f; overload;
    class operator Multiply(const A: TKMColor4f; B: Single): TKMColor4f; overload;
    class operator Implicit(const A: TKMColor3f): TKMColor4f;

    function Alpha0: TKMColor4f;
    function Alpha10: TKMColor4f;
    function Alpha25: TKMColor4f;
    function Alpha50: TKMColor4f;
    function Alpha75: TKMColor4f;
    function AlphaMul(aValue: Single): TKMColor4f;
    function AlphaSet(aValue: Single): TKMColor4f;
    function ToArray4: TArray<Single>;
    function ToCardinal: Cardinal;
    function ToColor3f: TKMColor3f; // Lossy operation, so we do it explicitly
    function ToString: string;
  end;
  PKMColorFunc4f = function: TKMColor4f;

  TKMColor4fArray = array of TKMColor4f;


implementation
uses
  KromUtils;


{ TKMColor3f }
class function TKMColor3f.New(aR, aG, aB: Single): TKMColor3f;
begin
  Result.R := aR;
  Result.G := aG;
  Result.B := aB;
end;


class function TKMColor3f.NewFromArray(const aArray3: TArray<Single>): TKMColor3f;
begin
  Assert(Length(aArray3) = 3);
  Result.R := aArray3[0];
  Result.G := aArray3[1];
  Result.B := aArray3[2];
end;


class function TKMColor3f.NewRGB(aRGB: Cardinal): TKMColor3f;
begin
  Result.R := aRGB and $FF / 255;
  Result.G := aRGB shr 8 and $FF / 255;
  Result.B := aRGB shr 16 and $FF / 255;
end;


class function TKMColor3f.NewGrey(aGrey: Single): TKMColor3f;
begin
  Result.R := aGrey;
  Result.G := aGrey;
  Result.B := aGrey;
end;


class function TKMColor3f.NewIndex(aIndex: Cardinal): TKMColor3f;
const
  MAX_GENERIC_COLORS = 12;
  GENERIC_COLORS: array [0..MAX_GENERIC_COLORS-1] of TKMColor3f = (
    (R:1.0; G:0.2; B:0.2),
    (R:1.0; G:0.6; B:0.2),
    (R:1.0; G:1.0; B:0.2),
    (R:0.6; G:1.0; B:0.2),
    (R:0.2; G:1.0; B:0.2),
    (R:0.2; G:1.0; B:0.6),
    (R:0.2; G:1.0; B:1.0),
    (R:0.2; G:0.6; B:1.0),
    (R:0.2; G:0.2; B:1.0),
    (R:0.6; G:0.2; B:1.0),
    (R:1.0; G:0.2; B:1.0),
    (R:1.0; G:0.2; B:0.6)
  );
begin
  Result := GENERIC_COLORS[aIndex mod MAX_GENERIC_COLORS];
end;


// Hue - Roy G. Biv
// Sat - Grey .. Color
// Bri - Black .. White
class function TKMColor3f.NewFromHSB(const aHue, aSat, aBri: Single): TKMColor3f;
const
  V = 6;
var
  Hue, Sat, Bri, Rt, Gt, Bt: Single;
begin
  Hue := (Round(Max(aHue, 0) * 10240) mod 10240) / 10240; // Wrap around
  Sat := Max(aSat, 0); // Allow oversaturated colors (if client wants them)
  Bri := Max(aBri, 0); // Allow overly bright colors (if client wants them)

  // Hue
  Rt := 0;
  Gt := 0;
  Bt := 0;
  case Trunc(Hue * 6) of
    0,6:begin
        Rt := 1;
        Gt := Hue * V;
      end;
    1:begin
        Rt := (2/6 - Hue) * V;
        Gt := 1;
      end;
    2:begin
        Gt := 1;
        Bt := (Hue - 2/6) * V;
      end;
    3:begin
        Gt := (4/6 - Hue) * V;
        Bt := 1;
      end;
    4:begin
        Rt := (Hue - 4/6) * V;
        Bt := 1;
      end;
    5:begin
        Rt := 1;
        Bt := (6/6 - Hue) * V;
      end;
  end;

  // Saturation
  Rt := Rt + (0.5 - Rt) * (1 - Sat);
  Gt := Gt + (0.5 - Gt) * (1 - Sat);
  Bt := Bt + (0.5 - Bt) * (1 - Sat);

  // Brightness
  if Bri > 0.5 then
  begin
    // Mix with white
    Rt := Rt + (1 - Rt) * (Bri - 0.5) * 2;
    Gt := Gt + (1 - Gt) * (Bri - 0.5) * 2;
    Bt := Bt + (1 - Bt) * (Bri - 0.5) * 2;
  end
  else if Bri < 0.5 then
  begin
    // Mix with black
    Rt := Rt * (Bri * 2);
    Gt := Gt * (Bri * 2);
    Bt := Bt * (Bri * 2);
  end;
  // if Bri = 0.5 then color remains the same

  Result.R := Rt;
  Result.G := Gt;
  Result.B := Bt;
end;


// Hue - Roy G. Biv
// Sat - Grey .. Color
// Vol - Black .. Bright
class function TKMColor3f.NewFromHSV(const aHue, aSat, aVol: Single): TKMColor3f;
var
  C, X, M, r, g, b: Single;
begin
  C := aVol * aSat;
  X := C * (1.0 - Abs(Frac(aHue*6/2)*2-1));
  M := aVol - C;

  case Trunc(aHue * 6) of
    0,6:begin
          r := C; g := X; b := 0;
        end;
    1:  begin
          r := X; g := C; b := 0;
        end;
    2:  begin
          r := 0; g := C; b := X;
        end;
    3:  begin
          r := 0; g := X; b := C;
        end;
    4:  begin
          r := X; g := 0; b := C;
        end;
    5:  begin
          r := C; g := 0; b := X;
        end;
  else
    r := 0; g := 0; b := 0;
  end;

  Result.R := M + r;
  Result.G := M + g;
  Result.B := M + b;
end;


// - aHue from 0.0 to 1.0
class function TKMColor3f.NewFromH(const aHue: Single): TKMColor3f;
var
  X, r, g, b: Single;
begin
  X := 1.0 - Abs(Frac(aHue*6/2)*2-1);

  case Trunc(aHue * 6) of
    0,6:begin
          r := 1; g := X; b := 0;
        end;
    1:  begin
          r := X; g := 1; b := 0;
        end;
    2:  begin
          r := 0; g := 1; b := X;
        end;
    3:  begin
          r := 0; g := X; b := 1;
        end;
    4:  begin
          r := X; g := 0; b := 1;
        end;
    5:  begin
          r := 1; g := 0; b := X;
        end;
  else
    r := 0; g := 0; b := 0;
  end;

  Result.R := r;
  Result.G := g;
  Result.B := b;
end;


class function TKMColor3f.White: TKMColor3f;
begin
  Result.R := 1;
  Result.G := 1;
  Result.B := 1;
end;


class function TKMColor3f.Cyan: TKMColor3f;
begin
  Result.R := 0;
  Result.G := 1;
  Result.B := 1;
end;


class function TKMColor3f.Magenta: TKMColor3f;
begin
  Result.R := 1;
  Result.G := 0;
  Result.B := 1;
end;


class function TKMColor3f.Black: TKMColor3f;
begin
  Result.R := 0;
  Result.G := 0;
  Result.B := 0;
end;


class operator TKMColor3f.Equal(const A, B: TKMColor3f): Boolean;
begin
  //Result := (A.R = B.R) and (A.G = B.G) and (A.B = B.B);
  Result := (Abs(A.R - B.R) < 0.0001) and (Abs(A.G - B.G) < 0.0001) and (Abs(A.B - B.B) < 0.0001);
end;


class operator TKMColor3f.NotEqual(const A, B: TKMColor3f): Boolean;
begin
  Result := (Abs(A.R - B.R) >= 0.0001) or (Abs(A.G - B.G) >= 0.0001) or (Abs(A.B - B.B) >= 0.0001);
end;


class operator TKMColor3f.Add(const A, B: TKMColor3f): TKMColor3f;
begin
  Result.R := A.R + B.R;
  Result.G := A.G + B.G;
  Result.B := A.B + B.B;
end;


class operator TKMColor3f.Multiply(const A: TKMColor3f; aValue: Single): TKMColor3f;
begin
  Result.R := A.R * aValue;
  Result.G := A.G * aValue;
  Result.B := A.B * aValue;
end;


procedure TKMColor3f.Clamp;
begin
  R := EnsureRange(R, 0, 1);
  G := EnsureRange(G, 0, 1);
  B := EnsureRange(B, 0, 1);
end;


// Version more suitable for text coloring
function TKMColor3f.GetBolder: TKMColor3f;
var
  h, s, v: Single;
begin
  h := GetHue;
  s := Min(GetSat, 0.93); // Too saturated colors are strain on the eye
  v := Max(GetVol + 0.1, 0.2);

  Result := NewFromHSV(h, s, v);
end;


function TKMColor3f.GetBrightness: Single;
begin
  Result := (R + G + B) / 3;
end;


function TKMColor3f.GetHue: Single;
var
  xMax, xMin, C: Single;
begin
  xMax := Max(R, G, B);
  xMin := Min(R, G, B);
  C := xMax - xMin;

  if C = 0 then
    Result := 0
  else
  if xMax = R then
    Result := (G - B) / C / 6
  else
  if xMax = G then
    Result := (2 + (B - R) / C) / 6
  else
  if xMax = B then
    Result := (4 + (R - G) / C) / 6
  else
    Result := 0;

  Result := Frac(Result + 1);
end;


function TKMColor3f.GetSat: Single;
var
  xMax, xMin, C: Single;
begin
  xMax := Max(R, G, B);
  xMin := Min(R, G, B);
  C := xMax - xMin;

  if xMax = 0 then
    Result := 0
  else
    Result := C / xMax;
end;


function TKMColor3f.GetVol: Single;
begin
  Result := Max(R, G, B);
end;


class function TKMColor3f.NewLerp(const A, B: TKMColor3f; aFactor: Single): TKMColor3f;
begin
  Result := TKMColor3f.NewLerp(A, B, aFactor);
end;


// Set absolute brightness
procedure TKMColor3f.SetBrightness(aBrightness: Single);
var
  oldBrightness: Single;
  scale: Single;
begin
  oldBrightness := GetBrightness;
  if oldBrightness = 0 then
  begin
    R := aBrightness;
    G := aBrightness;
    B := aBrightness;
  end
  else
  begin
    scale := aBrightness / oldBrightness;
    R := R * scale;
    G := G * scale;
    B := B * scale;
  end;
end;


function TKMColor3f.ToArray3: TArray<Single>;
begin
  SetLength(Result, 3);
  Result[0] := R;
  Result[1] := G;
  Result[2] := B;
end;


function TKMColor3f.ToCardinal: Cardinal;
begin
  Result := EnsureRange(Round(R * 255), 0, 255) +
            EnsureRange(Round(G * 255), 0, 255) shl 8 +
            EnsureRange(Round(B * 255), 0, 255) shl 16;
end;


function TKMColor3f.ToColorCode: string;
begin
  Result := '[$' + IntToHex(ToCardinal, 6) + ']';
end;


function TKMColor3f.ToString: string;
begin
  Result := 'R:' + FloatToStrF(R, ffGeneral, 10, 8) + ' G:' + FloatToStrF(G, ffGeneral, 10, 8) + ' B:' + FloatToStrF(B, ffGeneral, 10, 8);
end;


{ TKMColor4f }
class function TKMColor4f.NewGrey(aGrey: Single): TKMColor4f;
begin
  Result.R := aGrey;
  Result.G := aGrey;
  Result.B := aGrey;
  Result.A := 1;
end;


class function TKMColor4f.NewRGB(aRGB: Cardinal): TKMColor4f;
begin
  Result.R := aRGB and $FF / 255;
  Result.G := aRGB shr 8 and $FF / 255;
  Result.B := aRGB shr 16 and $FF / 255;
  Result.A := 1.0;
end;


class function TKMColor4f.NewRGBA(aRGBA: TKMColor4b): TKMColor4f;
begin
  Result.R := aRGBA and $FF / 255;
  Result.G := aRGBA shr 8 and $FF / 255;
  Result.B := aRGBA shr 16 and $FF / 255;
  Result.A := aRGBA shr 24 and $FF / 255;
end;


class function TKMColor4f.New(const aR, aG, aB: Single): TKMColor4f;
begin
  Result.R := aR;
  Result.G := aG;
  Result.B := aB;
  Result.A := 1.0;
end;


class function TKMColor4f.DarkBlue: TKMColor4f;
begin
  Result := New(0, 0, 0.5);
end;


class function TKMColor4f.Blue: TKMColor4f;
begin
  Result := New(0, 0, 1);
end;


class function TKMColor4f.LightBlue: TKMColor4f;
begin
  Result := New(0, 0.5, 1);
end;


class function TKMColor4f.Cyan: TKMColor4f;
begin
  Result := New(0, 1, 1);
end;


class function TKMColor4f.Green: TKMColor4f;
begin
  Result := New(0, 1, 0);
end;


class function TKMColor4f.GrassGreen: TKMColor4f;
begin
  Result := New(0.33, 0.66, 0.33);
end;


class function TKMColor4f.Grey25: TKMColor4f;
begin
  Result := New(0.25, 0.25, 0.25);
end;


class function TKMColor4f.Grey50: TKMColor4f;
begin
  Result := New(0.5, 0.5, 0.5);
end;


class function TKMColor4f.Grey75: TKMColor4f;
begin
  Result := New(0.75, 0.75, 0.75);
end;


// Promoting 3f to 4f is quite harmless
class operator TKMColor4f.Implicit(const A: TKMColor3f): TKMColor4f;
begin
  Move(A.R, Result.R, SizeOf(A.R) * 3);
  Result.A := 1.0;
end;


class operator TKMColor4f.Add(const A, B: TKMColor4f): TKMColor4f;
begin
  Result.R := A.R + B.R;
  Result.G := A.G + B.G;
  Result.B := A.B + B.B;
  Result.A := A.A + B.A;
end;


class operator TKMColor4f.Multiply(const A, B: TKMColor4f): TKMColor4f;
begin
  Result.R := A.R * B.R;
  Result.G := A.G * B.G;
  Result.B := A.B * B.B;
  Result.A := A.A * B.A;
end;


class operator TKMColor4f.Multiply(const A: TKMColor4f; B: Single): TKMColor4f;
begin
  Result.R := A.R * B;
  Result.G := A.G * B;
  Result.B := A.B * B;
  Result.A := A.A * B;
end;


class function TKMColor4f.New(aRGB: TKMColor3f): TKMColor4f;
begin
  Result.R := aRGB.R;
  Result.G := aRGB.G;
  Result.B := aRGB.B;
  Result.A := 1;
end;


class function TKMColor4f.New(aRGB: TKMColor3f; aA: Single): TKMColor4f;
begin
  Result.R := aRGB.R;
  Result.G := aRGB.G;
  Result.B := aRGB.B;
  Result.A := aA;
end;


class function TKMColor4f.New(const aR, aG, aB, aA: Single): TKMColor4f;
begin
  Result.R := aR;
  Result.G := aG;
  Result.B := aB;
  Result.A := aA;
end;


class function TKMColor4f.New(const aArray4: TArray<Single>): TKMColor4f;
begin
  Assert(Length(aArray4) = 4);
  Result.R := aArray4[0];
  Result.G := aArray4[1];
  Result.B := aArray4[2];
  Result.A := aArray4[3];
end;


class function TKMColor4f.NewFromRGBA(const aR, aG, aB, aA: Single): TKMColor4f;
begin
  Result := TKMColor4f.New(TKMColor3f.New(aR, aG, aB), aA);
end;


// Hue - Roy G. Biv
// Sat - Grey .. Color
// Bri - Black..White
class function TKMColor4f.NewFromHSB(const aHue, aSat, aBri, aAlpha: Single): TKMColor4f;
begin
  Result := TKMColor4f.New(TKMColor3f.NewFromHSB(aHue, aSat, aBri), aAlpha);
end;


class function TKMColor4f.NewFromUID(aUID: Integer; aAlpha: Single): TKMColor4f;
begin
  Result := TKMColor4f.New(
    TKMColor3f.NewFromHSB(
      aUID / 99999,
      0.6 + Frac(aUID / 222) * 0.3, // 0.6 .. 0.9
      0.4 + Frac(aUID / 555) * 0.2  // 0.4 .. 0.6
    ),
    aAlpha);
end;


class function TKMColor4f.NewLerp(const A, B: TKMColor4f; aFactor: Single): TKMColor4f;
begin
  Result := TKMColor4f.NewLerp(A, B, aFactor);
end;


class function TKMColor4f.Orange: TKMColor4f;
begin
  Result := New(1, 0.8, 0);
end;


class function TKMColor4f.Red: TKMColor4f;
begin
  Result := New(1, 0, 0);
end;


class function TKMColor4f.Magenta: TKMColor4f;
begin
  Result := New(1, 0, 1);
end;


class function TKMColor4f.Maroon: TKMColor4f;
begin
  Result := New(0.5, 0, 0);
end;


class function TKMColor4f.Clear: TKMColor4f;
begin
  Result := New(0, 0, 0, 0);
end;


class function TKMColor4f.Black: TKMColor4f;
begin
  Result := New(0, 0, 0);
end;


class function TKMColor4f.White: TKMColor4f;
begin
  Result := New(1, 1, 1);
end;


class function TKMColor4f.Yellow: TKMColor4f;
begin
  Result := New(1, 1, 0);
end;


function TKMColor4f.Alpha0: TKMColor4f;
begin
  Result := Self;
  Result.A := 0.0;
end;


function TKMColor4f.Alpha10: TKMColor4f;
begin
  Result := Self;
  Result.A := A * 0.1;
end;


function TKMColor4f.Alpha25: TKMColor4f;
begin
  Result := Self;
  Result.A := A * 0.25;
end;


function TKMColor4f.Alpha50: TKMColor4f;
begin
  Result := Self;
  Result.A := A * 0.5;
end;


function TKMColor4f.Alpha75: TKMColor4f;
begin
  Result := Self;
  Result.A := A * 0.75;
end;


function TKMColor4f.AlphaSet(aValue: Single): TKMColor4f;
begin
  Result := Self;
  Result.A := aValue;
end;


function TKMColor4f.AlphaMul(aValue: Single): TKMColor4f;
begin
  Result := Self;
  Result.A := A * aValue;
end;


function TKMColor4f.ToArray4: TArray<Single>;
begin
  SetLength(Result, 4);
  Result[0] := R;
  Result[1] := G;
  Result[2] := B;
  Result[3] := A;
end;


function TKMColor4f.ToCardinal: Cardinal;
begin
  Result := EnsureRange(Round(R * 255), 0, 255) +
            EnsureRange(Round(G * 255), 0, 255) shl 8 +
            EnsureRange(Round(B * 255), 0, 255) shl 16 +
            EnsureRange(Round(A * 255), 0, 255) shl 24;
end;


function TKMColor4f.ToColor3f: TKMColor3f;
begin
  Result.R := R;
  Result.G := G;
  Result.B := B;
end;


function TKMColor4f.ToString: string;
begin
  Result := 'R:' + FloatToStrF(R, ffGeneral, 10, 8) +
           ' G:' + FloatToStrF(G, ffGeneral, 10, 8) +
           ' B:' + FloatToStrF(B, ffGeneral, 10, 8) +
           ' A:' + FloatToStrF(A, ffGeneral, 10, 8);
end;


end.
