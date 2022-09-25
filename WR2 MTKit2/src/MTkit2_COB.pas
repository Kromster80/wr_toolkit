unit MTkit2_COB;
interface
uses
  KromUtils, KM_Vertexes;


type
  TModelCOB = class
  public
    Head: record
      PointQty, PolyQty: Integer;
      X, Y, Z, Xmin, Xmax, Ymin, Ymax, Zmin, ZMax: Single;
    end;
    Vertices: array [1..256] of TKMVertex3;
    Faces: array [1..256, 1..3] of Word;
    Normals: array [1..256] of TKMVertex3;

    procedure Clear;
    function LoadCOB(const aFilename: string): Boolean;
    procedure SaveCOB(const aFilename: string);
    //procedure SaveCOB2LWO(const aFilename: string);
    procedure SaveCOB2LWO(const aFilename: string);
    procedure ImportLWO2COB(const aFilename: string);
    procedure RebuildBounds;
  end;


implementation
uses
  Math, SysUtils, KM_IoModelLWO;


procedure TModelCOB.Clear;
begin
  FillChar(Head, SizeOf(Head), #0);
  FillChar(Vertices, SizeOf(Vertices), #0);
  FillChar(Normals, SizeOf(Normals), #0);
  FillChar(Faces, SizeOf(Faces), #0);
end;


function TModelCOB.LoadCOB(const aFilename: string): Boolean;
var
  i: Integer;
  f: file;
begin
  Result := False;
  if not FileExists(aFilename) then Exit;

  AssignFile(f, aFilename);
  FileMode := 0;
  Reset(f, 1);
  FileMode := 2;
  BlockRead(f, Head.PointQty, 44);

  for i := 1 to Head.PointQty do
    BlockRead(f, Vertices[i].X, 12);

  BlockRead(f, Faces[1], 6 * Head.PolyQty);

  for i := 1 to Head.PolyQty do
    BlockRead(f, Normals[i].X, 12);

  CloseFile(f);

  Result := True;
end;


procedure TModelCOB.SaveCOB(const aFilename: string);
var
  i: Integer;
  f: file;
begin
  AssignFile(f, aFilename);
  Rewrite(f, 1);
  BlockWrite(f, Head.PointQty, 44);

  for i := 1 to Head.PointQty do
    BlockWrite(f, Vertices[i].X, 12);

  for i := 1 to Head.PolyQty do
    BlockWrite(f, Faces[i, 1], 6);

  for i := 1 to Head.PolyQty do
    BlockWrite(f, Normals[i].X, 12);

  CloseFile(f);
end;


procedure TModelCOB.SaveCOB2LWO(const aFilename: string);
const
  EXPORT_SCALE = 0.1;
var
  lwm: TLWModel;
  lay: PLWLayer;
  I: Integer;
begin
  lwm := TLWModel.Create;
  try
    lay := lwm.LayerAdd;

    // Vertices
    lay.SetVerticeCount(Head.PointQty);
    for I := 1 to Head.PointQty do
    begin
      lay.Vertices[I-1].X := Vertices[I].X * EXPORT_SCALE;
      lay.Vertices[I-1].Y := Vertices[I].Y * EXPORT_SCALE;
      lay.Vertices[I-1].Z := Vertices[I].Z * EXPORT_SCALE;
    end;

    // Polys
    lay.SetPolyCount(Head.PolyQty);
    for I := 1 to Head.PolyQty do
    begin
      lay.Polys[I-1].VertCount := 3;
      SetLength(lay.Polys[I-1].Indices, 3);

      lay.Polys[I-1].Indices[0] := Faces[I,1];
      lay.Polys[I-1].Indices[1] := Faces[I,2];
      lay.Polys[I-1].Indices[2] := Faces[I,3];

      lay.Polys[I-1].PolySurf := 0;
    end;

    // COB is a simple shape, it does not need a surface or anything

    lwm.SaveToFile(aFilename);
  finally
    lwm.Free;
  end;
end;


procedure TModelCOB.RebuildBounds;
var
  I: Integer;
begin
  // Normal to every polygon
  for I := 1 to Head.PolyQty do
  begin
    Normals[I] := VectorCrossProduct(@Vertices[Faces[I,1]+1], @Vertices[Faces[I,2]+1], @Vertices[Faces[I,3]+1]);
    Normals[I] := Normals[I].GetNormalize;
  end;

  // Bounding box
  Head.Xmin := 0; Head.Xmax := 0;
  Head.Ymin := 0; Head.Ymax := 0;
  Head.Zmin := 0; Head.Zmax := 0;
  for I := 1 to Head.PointQty do
  begin
    Head.Xmax := Max(Head.Xmax, Vertices[I].X);
    Head.Ymax := Max(Head.Ymax, Vertices[I].Y);
    Head.Zmax := Max(Head.Zmax, Vertices[I].Z);
    Head.Xmin := Min(Head.Xmin, Vertices[I].X);
    Head.Ymin := Min(Head.Ymin, Vertices[I].Y);
    Head.Zmin := Min(Head.Zmin, Vertices[I].Z);
  end;

  Head.X := 0; // Xmax + Xmin;
  Head.Y := 0; // Ymax + Ymin;
  Head.Z := 0; // Zmax + Zmin;
end;


procedure TModelCOB.ImportLWO2COB(const aFilename: string);
var
  lwm: TLWModel;
  lay: TLWLayer;
  I, K: Integer;
begin
  lwm := TLWModel.Create;
  try
    lwm.LoadFromFile(aFilename);

    if lwm.LayerCount <> 1 then
      raise Exception.Create('Imported LWO must have exactly one layer');

    lay := lwm.Layers[0];

    if (lay.VerticeCount > 255) or (lay.PolyCount > 255) then
      raise Exception.Create('Can''t import more than 255 vertices to COB');

    Head.PointQty := lay.VerticeCount;
    Head.PolyQty := lay.PolyCount;

    for I:=1 to lay.VerticeCount do
      Vertices[I] := lay.Vertices[I - 1] * 10;

    for I := 1 to lay.PolyCount do
      for K := 1 to 3 do
        Faces[I, K] := lay.Polys[I - 1].Indices[K - 1];

    RebuildBounds;
  finally
    lwm.Free;
  end;
end;


end.
