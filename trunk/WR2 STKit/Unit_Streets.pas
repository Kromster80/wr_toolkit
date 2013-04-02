unit Unit_Streets;
interface
uses Classes, sysutils, Windows, KromUtils, Math, dglOpenGL, Unit_Defaults;

type
  TSStreetShape = packed record
    Offset: array [1 .. 2] of single;
    Options: word; // unused (Options=0)
    NumLanes: word;
  end;

  TSStreetNode = packed record
    X, Y, Z, Tx, Ty, Tz: single;
  end;

  TSStreetSpline = packed record
    PtA, PtB: word;
    FirstShRef, NumShRefs: word;
    LenA, LenB, Length: single;
    Density, Options: word;
    OppSpline, PrevSpline: word;
    FirstWay, NumWays: word;
    FirstRoW, NumRoW: word;
  end;

  TSStreetShRef = packed record // Is same count as Num_Shapes
    Shape, Speed: word; // extending each shape with speed limit
    StartU: single; // unused (always 0)
  end;

  TSStreetRoW = packed record // is same count as NumSplines
    Spline: word;
    Tracks: cardinal;
  end;

  TSStreets = class
  private
    Header: array [1 .. 4] of AnsiChar;
    Version, Options: word;

    fShapeCount: integer;
    fNodeCount: integer;
    fSplineCount: integer;
    fShRefCount: integer;
    fRoWCount: integer;

    fChanged: Boolean;
    function ComputeSplineLength(In1: integer): single;
    function FindOppSpline(In1: integer): integer;
    function FindPrevSpline(In1: integer): integer;
    function FindFirstWay(In1: integer): integer;
  public
    Shapes: array of TSStreetShape;
    Nodes: array of TSStreetNode;
    Splines: array of TSStreetSpline;
    ShRefs: array of TSStreetShRef;
    RoWs: array of TSStreetRoW;

    // constructor Create;
    procedure Clear;
    procedure DuplicateTrafficRoutes;
    procedure Recalculate(aAutoCrosses: Boolean);
    procedure ResetShapes;
    function TotalLength: integer;
    // procedure AddShape;
    // procedure RemShape;

    procedure AddNode(X, Y, Z: single);
    procedure AddShape;
    procedure RemShape(aIndex: Integer);
    procedure RemNode(aIndex: Integer);
    procedure RemSpline(In1: integer);
    procedure MakeSpline(Node1, Node2: integer);

    property ShapeCount: integer read fShapeCount;
    property NodeCount: integer read fNodeCount;
    property SplineCount: integer read fSplineCount;
    property ShRefCount: integer read fShRefCount;
    property RoWCount: integer read fRoWCount;
    property Changed: Boolean read fChanged write fChanged;

    function LoadFromFile(aFile: string): Boolean;
    procedure SaveToFile(aFile: string; aAutoCrosses: Boolean);
  end;

var
  STRShapeRefresh: Boolean = false;
  STRPointRefresh: Boolean = false;


implementation
uses Unit_RoutineFunctions, Unit_Tracing;


procedure TSStreets.AddNode(X, Y, Z: single);
begin
  SetLength(Nodes, fNodeCount + 1);

  Nodes[fNodeCount].X := X;
  Nodes[fNodeCount].Y := Y;
  Nodes[fNodeCount].Z := Z;
  Nodes[fNodeCount].Tx := 0;
  Nodes[fNodeCount].Ty := 0;
  Nodes[fNodeCount].Tz := 0;

  Inc(fNodeCount);
end;

procedure TSStreets.Clear;
begin
  fShapeCount := 0;
  fNodeCount := 0;
  fSplineCount := 0;
  fShRefCount := 0;
  fRoWCount := 0;
  SetLength(Shapes, 0);
  SetLength(Nodes, 0);
  SetLength(Splines, 0);
  SetLength(ShRefs, 0);
  SetLength(RoWs, 0);
end;

function TSStreets.LoadFromFile(aFile: string): Boolean;
var
  S: TMemoryStream;
  I: integer;
begin
  Result := false;

  Clear;
  if not FileExists(aFile) then
    exit;

  S := TMemoryStream.Create;
  try
    S.LoadFromFile(aFile);
    S.Read(Header[1], 4);
    if Header[1] + Header[2] + Header[3] + Header[4] <> 'NRTS' then
      exit;
    S.Read(Version, 2);
    S.Read(Options, 2);
    S.Read(fShapeCount, 4);
    S.Read(fNodeCount, 4);
    S.Read(fSplineCount, 4);
    S.Read(fShRefCount, 4);
    S.Read(fRoWCount, 4);

    SetLength(Shapes, fShapeCount + 2); // +2 is necessay to handle 0 length case:
    SetLength(Nodes, fNodeCount + 2); // blockread reads from [1] element which
    SetLength(Splines, fSplineCount + 2); // needs to be existent 0..1 => 0+2
    SetLength(ShRefs, fShRefCount + 2);
    SetLength(RoWs, fRoWCount + 2);

    if (Version = 258) then
    begin // WR2
      S.Read(Shapes[1], fShapeCount * 12);
      S.Read(Nodes[1], fNodeCount * 24);
      S.Read(Splines[1], fSplineCount * 36);
      S.Read(ShRefs[1], fShRefCount * 8);
      S.Read(RoWs[1], fRoWCount * 6);
    end;

    if (Version = 260) then
    begin // AFC11
      for I := 1 to fShapeCount do
      begin
        S.Read(Shapes[I].Offset, 8);
        S.Seek(8, soFromCurrent);
        S.Read(Shapes[I].Options, 4);
      end;
      S.Read(Nodes[1], fNodeCount * 24);
      S.Read(Splines[1], fSplineCount * 36);
      S.Read(ShRefs[1], fShRefCount * 8);
      S.Read(RoWs[1], fRoWCount * 6);
    end;

    fChanged := false;
  finally
    S.Free;
  end;
end;

procedure TSStreets.Recalculate(aAutoCrosses: Boolean);
var
  I: integer;
begin
  Header[1] := 'N';
  Header[2] := 'R';
  Header[3] := 'T';
  Header[4] := 'S';
  Version := 258; // WR2

  if fShapeCount = 0 then
    AddShape; // Make a shape if there's none

  for I := 1 to fSplineCount do
    Splines[I].Length := ComputeSplineLength(I); // must compute before FirstWay

  for I := 1 to fSplineCount do
    Splines[I].FirstWay := FindFirstWay(I);

  for I := 1 to fSplineCount do
  begin
    Splines[I].Density := 2;
    Splines[I].OppSpline := FindOppSpline(I);
    Splines[I].PrevSpline := FindPrevSpline(I);
    Splines[I].FirstRoW := 65535; // I-1;
    Splines[I].NumRoW := 0; // 1;
  end;

  // Autoset crosses
  if aAutoCrosses then
    for I := 1 to fSplineCount do
    begin
      Splines[I].Options := Splines[I].Options AND 13; // 1101 (1,4,8)
      if ((Splines[I].PrevSpline <> 65535) and (Splines[Splines[I].PrevSpline + 1].NumWays
        > 1)) or ((Splines[I].FirstWay <> 65535) and
        (Splines[Splines[I].FirstWay + 1].PrevSpline = 65535)) then
        Splines[I].Options := Splines[I].Options OR 1; //
    end;

  for I := 1 to fRoWCount do
  begin
    RoWs[I].Spline := 0;
    RoWs[I].Tracks := 4294967295; // all bits "1"
  end;

  fChanged := True;
end;

procedure TSStreets.ResetShapes;
var
  I: integer;
begin
  fShRefCount := fShapeCount;

  SetLength(ShRefs, fShRefCount + 2);

  for I := 1 to fShRefCount do
  begin
    ShRefs[I].Shape := 0;
    ShRefs[I].Speed := round(70 / 0.0036);
    ShRefs[I].StartU := 0;
  end;

  fShapeCount := 1;

  for I := 1 to fShapeCount do
  begin
    Shapes[I].Options := 0;
    // Shapes[i].NumLanes:=1;
  end;

  for I := 1 to fSplineCount do
  begin
    Splines[I].FirstShRef := 0;
    Splines[I].NumShRefs := 1;
    if Splines[I].NumRoW = 0 then
      Splines[I].FirstRoW := 65535;
    Splines[I].Options := Splines[I].Options AND 1;
  end;

  fChanged := True;
end;

procedure TSStreets.DuplicateTrafficRoutes;
var
  I: integer;
begin
  SetLength(Shapes, fShapeCount * 2 + 1);
  for I := fShapeCount + 1 to fShapeCount * 2 do
    Shapes[I] := Shapes[I - fShapeCount];

  SetLength(Nodes, fNodeCount * 2 + 1);
  for I := fNodeCount + 1 to fNodeCount * 2 do
  begin
    Nodes[I] := Nodes[I - fNodeCount];
    // Nodes[i].y:=Nodes[i].y+15;
  end;

  SetLength(Splines, fSplineCount * 2 + 1);
  for I := fSplineCount + 1 to fSplineCount * 2 do
  begin
    Splines[I] := Splines[I - fSplineCount];
    Inc(Splines[I].PtA, fNodeCount);
    Inc(Splines[I].PtB, fNodeCount);
    Inc(Splines[I].FirstShRef, fShapeCount);
    if Splines[I].OppSpline <> 65535 then
      Inc(Splines[I].OppSpline, fSplineCount);
    if Splines[I].PrevSpline <> 65535 then
      Inc(Splines[I].PrevSpline, fSplineCount);
    if Splines[I].FirstWay <> 65535 then
      Inc(Splines[I].FirstWay, fSplineCount);
    // Splines[i].FirstRoW
  end;

  SetLength(ShRefs, fShRefCount * 2 + 1);
  for I := fShRefCount + 1 to fShRefCount * 2 do
  begin
    ShRefs[I] := ShRefs[I - fShRefCount];
    Inc(ShRefs[I].Shape, fShapeCount);
  end;

  SetLength(RoWs, fRoWCount * 2 + 1);
  for I := fRoWCount + 1 to fRoWCount * 2 do
    RoWs[I] := RoWs[I - fRoWCount];

  fShapeCount := fShapeCount * 2;
  fNodeCount := fNodeCount * 2;
  fSplineCount := fSplineCount * 2;
  fShRefCount := fShRefCount * 2;
  fRoWCount := fRoWCount * 2;

  fChanged := True;
end;

procedure TSStreets.SaveToFile(aFile: string; aAutoCrosses: Boolean);
var
  S: TMemoryStream;
begin
  Recalculate(aAutoCrosses);

  S := TMemoryStream.Create;
  try
    S.Write(Header[1], 4);
    S.Write(Version, 2);
    S.Write(Options, 2);
    S.Write(fShapeCount, 4);
    S.Write(fNodeCount, 4);
    S.Write(fSplineCount, 4);
    S.Write(fShRefCount, 4);
    S.Write(fRoWCount, 4);

    S.Write(Shapes[1], fShapeCount * 12);
    S.Write(Nodes[1], fNodeCount * 24);
    S.Write(Splines[1], fSplineCount * 36);
    S.Write(ShRefs[1], fShRefCount * 8);
    S.Write(RoWs[1], fRoWCount * 6);

    S.SaveToFile(aFile);

    fChanged := false;
  finally
    S.Free;
  end;
end;

// Lngth in meters
function TSStreets.TotalLength: integer;
var
  I: integer;
begin
  Result := 0;
  for I := 1 to fSplineCount do
    Inc(Result, round(Splines[I].Length / 10));
end;

procedure TSStreets.AddShape;
var
  ID: integer;
begin
  Inc(fShapeCount);
  Inc(fShRefCount);
  ID := fShapeCount;
  SetLength(Shapes, ID + 1);
  SetLength(ShRefs, ID + 1);
  Shapes[ID].Offset[1] := 26;
  Shapes[ID].Offset[2] := 26;
  Shapes[ID].NumLanes := 1;
  Shapes[ID].Options := 0;
  ShRefs[ID].Shape := ID - 1;
  ShRefs[ID].Speed := Round(60 / 0.0036);
  ShRefs[ID].StartU := 0;

  fChanged := True;
end;

procedure TSStreets.RemShape(aIndex: Integer);
var
  I: integer;
begin
  if fShapeCount = 1 then
    Exit;

  for I := aIndex + 1 to fShapeCount do
    Shapes[I - 1] := Shapes[I];

  for I := 1 to fShRefCount do
    if ShRefs[I].Shape + 1 > aIndex then
      dec(ShRefs[I].Shape)
    else if ShRefs[I].Shape + 1 = aIndex then
      ShRefs[I].Shape := EnsureRange(aIndex - 1, 1, fShapeCount) - 1;

  dec(fShapeCount);

  fChanged := True;
end;


procedure TSStreets.RemNode(aIndex: Integer);
var
  I, k: integer;
  toDel: array [1 .. 256] of integer;
begin
  if aIndex = 0 then
    exit;

  k := 1;
  for I := 1 to fSplineCount do // Remove splines using this point
    if (Splines[I].PtA + 1 = aIndex) or (Splines[I].PtB + 1 = aIndex) then
    begin
      toDel[k] := I; // delete later to not interfere with current loop
      Inc(k);
    end;

  for I := k - 1 downto 1 do
    RemSpline(toDel[I]);

  for I := 1 to fSplineCount do
  begin // shift up points in splines
    if Splines[I].PtA + 1 > aIndex then
      dec(Splines[I].PtA);
    if Splines[I].PtB + 1 > aIndex then
      dec(Splines[I].PtB);
  end;

  for I := aIndex + 1 to fNodeCount do // shift up points
    Nodes[I - 1] := Nodes[I];

  dec(fNodeCount);

  fChanged := True;
end;


function TSStreets.ComputeSplineLength(In1: integer): single;
var
  kk, PA, PB: integer;
  LA, LB, T, Len: single; // A,B,C:integer;
var
  ax, bx, cx, x0, x1, x2, x3, xt: single;
  ay, by, cy, y0, y1, y2, y3, yt: single;
  az, bz, cz, z0, z1, z2, z3, zt: single;
  Spline: array [0 .. 32] of record X, Y, Z: single;
end;
begin
  PA := Splines[In1].PtA + 1; // point A index
  PB := Splines[In1].PtB + 1; // point B index
  LA := Splines[In1].LenA / 3; // anchor A length
  LB := -Splines[In1].LenB / 3; // anchor B length

  for kk := 0 to 32 do
  begin // Compute basic spline
    T := kk / 32; // 0..1 range
    x0 := Nodes[PA].X;
    x1 := x0 + Nodes[PA].Tx * LA;
    x3 := Nodes[PB].X;
    x2 := x3 + Nodes[PB].Tx * LB;
    y0 := Nodes[PA].Y;
    y1 := y0 + Nodes[PA].Ty * LA;
    y3 := Nodes[PB].Y;
    y2 := y3 + Nodes[PB].Ty * LB;
    z0 := Nodes[PA].Z;
    z1 := z0 + Nodes[PA].Tz * LA;
    z3 := Nodes[PB].Z;
    z2 := z3 + Nodes[PB].Tz * LB;
    cx := 3 * (x1 - x0);
    bx := 3 * (x2 - x1) - cx;
    ax := x3 - x0 - cx - bx;
    Spline[kk].X := ax * T * T * T + bx * T * T + cx * T + x0;
    cy := 3 * (y1 - y0);
    by := 3 * (y2 - y1) - cy;
    ay := y3 - y0 - cy - by;
    Spline[kk].Y := ay * T * T * T + by * T * T + cy * T + y0;
    cz := 3 * (z1 - z0);
    bz := 3 * (z2 - z1) - cz;
    az := z3 - z0 - cz - bz;
    Spline[kk].Z := az * T * T * T + bz * T * T + cz * T + z0;
  end;

  Len := 0;
  for kk := 1 to 32 do
    Len := Len + sqrt(sqr(Spline[kk].X - Spline[kk - 1].X) +
      sqr(Spline[kk].Y - Spline[kk - 1].Y) + sqr(Spline[kk].Z - Spline[kk - 1].Z));
  Result := Len;
end;

function TSStreets.FindOppSpline(In1: integer): integer;
var
  k: integer;
begin
  Result := 65535;
  for k := 1 to fSplineCount do
    if (Splines[In1].PtA = Splines[k].PtB) and
      (Splines[In1].PtB = Splines[k].PtA) then
      Result := k - 1;
end;

function TSStreets.FindPrevSpline(In1: integer): integer;
var
  k, Prev, NumPrev: integer;
begin
  Prev := 0;
  NumPrev := 0;
  for k := 1 to fSplineCount do
    if (Splines[In1].PtA = Splines[k].PtB) and
      (Splines[In1].PtB <> Splines[k].PtA) and
      (sign(Splines[In1].LenA) = sign(Splines[k].LenB)) then
    begin
      Prev := k;
      Inc(NumPrev);
    end;
  if (Prev = 0) or (NumPrev > 1) then
    Result := 65535
  else
    Result := Prev - 1;
end;

function TSStreets.FindFirstWay(In1: integer): integer;
var
  I, k, NumWays: integer;
  Ways: array [1 .. 4] of integer;
begin
  NumWays := 0;
  for k := 1 to fSplineCount do
    if (Splines[In1].PtB = Splines[k].PtA) and
      (Splines[In1].PtA <> Splines[k].PtB) and
      (sign(Splines[In1].LenB) = sign(Splines[k].LenA)) then
    begin
      if NumWays < 5 then
        Inc(NumWays);
      Ways[NumWays] := k;
    end;

  SetLength(Splines, fSplineCount + 5);
  // Ways[1..16] are holding all possible upcoming routes
  // now we need to sort them in CCW order
  // ExchangeSplines now
  if NumWays > 1 then
    for k := 1 to NumWays do
    begin
      Splines[0] := Splines[In1 + k];
      Splines[In1 + k] := Splines[Ways[k]];
      Splines[Ways[k]] := Splines[0];
    end;

  I := 0; // shift up if there are empty entries
  for k := 1 to fSplineCount do
  begin
    repeat
      Inc(I);
    until (Splines[I].Length <> 0);
    Splines[k] := Splines[I];
  end;

  SetLength(Splines, fSplineCount + 1);

  Splines[In1].NumWays := NumWays;
  case NumWays of
    0:
      Result := 65535; // None
    1:
      Result := Ways[1] - 1; // Found
  else
    Result := (In1 + 1) - 1; // Next
  end;
end;

procedure TSStreets.RemSpline(In1: integer);
var
  I: integer;
begin
  if In1 = 0 then
    exit;

  for I := In1 + 1 to fSplineCount do
  begin
    // dec(Splines[i].FirstShRef);
    // dec(Splines[i].FirstRoW); 65535 now
    Splines[I - 1] := Splines[I];
  end;
  dec(fSplineCount);

  // for i:=In1+1 to fShRefCount do  ShRefs[i-1]:=ShRefs[i];   dec(fShRefCount);
  for I := In1 + 1 to fRoWCount do
    RoWs[I - 1] := RoWs[I];
  dec(fRoWCount);
end;


procedure TSStreets.MakeSpline(Node1, Node2: integer);
var
  ID: integer;
begin
  for ID := 1 to fSplineCount do
    if (Splines[ID].PtA + 1 = Node1) and (Splines[ID].PtB + 1 = Node2) then
      exit;

  Inc(fSplineCount);
  ID := fSplineCount;
  SetLength(Splines, ID + 2);
  // fShRefCount:=ID; //easiest solution - 1Spline=1ShRef
  // setlength(ShRefs,fShRefCount+2);
  fRoWCount := ID; // easiest solution - 1Spline=1RoW
  SetLength(RoWs, fRoWCount + 2);
  Splines[ID].PtA := Node1 - 1;
  Splines[ID].PtB := Node2 - 1;
  Splines[ID].FirstShRef := Splines[ID - 1].FirstShRef; // ID-1; //0..x
  // ShRefs[ID].Shape:=0;
  // ShRefs[ID].Speed:=round(60/0.0036); //60kmh
  // ShRefs[ID].StartU:=0;
  Splines[ID].NumShRefs := 1;
  Splines[ID].LenA := GetLength(Nodes[Node1].X - Nodes[Node2].X,
    Nodes[Node1].Y - Nodes[Node2].Y, Nodes[Node1].Z - Nodes[Node2].Z);
  Splines[ID].LenB := Splines[ID].LenA;
  // Reverse anchors to face each other
  if GetLength((Nodes[Node1].X + Nodes[Node1].Tx * Splines[ID].LenA / 3) -
    Nodes[Node2].X, (Nodes[Node1].Z + Nodes[Node1].Tz * Splines[ID].LenA /
    3) - Nodes[Node2].Z) >
    GetLength((Nodes[Node1].X + Nodes[Node1].Tx * -Splines[ID].LenA / 3) -
    Nodes[Node2].X, (Nodes[Node1].Z + Nodes[Node1].Tz * -Splines[ID].LenA /
    3) - Nodes[Node2].Z) then
    Splines[ID].LenA := -Splines[ID].LenA;
  // LenB is applied with "-" sign !
  if GetLength((Nodes[Node2].X + Nodes[Node2].Tx * -Splines[ID].LenB / 3) -
    Nodes[Node1].X, (Nodes[Node2].Z + Nodes[Node2].Tz * -Splines[ID].LenB /
    3) - Nodes[Node1].Z) >
    GetLength((Nodes[Node2].X + Nodes[Node2].Tx * Splines[ID].LenB / 3) -
    Nodes[Node1].X, (Nodes[Node2].Z + Nodes[Node2].Tz * Splines[ID].LenB /
    3) - Nodes[Node1].Z) then
    Splines[ID].LenB := -Splines[ID].LenB;

  Splines[ID].Options := 0;
  Splines[ID].OppSpline := FindOppSpline(ID);
  Splines[ID].FirstRoW := 65535; // 0..x
  Splines[ID].NumRoW := 0;

  if Splines[ID].OppSpline <> 65535 then
  begin
    Splines[ID].LenA := -Splines[Splines[ID].OppSpline + 1].LenB;
    Splines[ID].LenB := -Splines[Splines[ID].OppSpline + 1].LenA;
  end;
  // if Form1.CBSplineSymmetry.Checked then Form1.STRSplineID1Change(nil);
end;

end.
