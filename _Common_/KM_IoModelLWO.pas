unit KM_IoModelLWO;
interface
uses
  Classes, Math, SysUtils, Generics.Collections,
  KM_Colors, KM_Vertexes, KM_IoModelLWO_Stream;


type
  // LWO model class, the way it is
  TLWOPostProcess = (ppCalcNormals, ppFixUVs, ppSeparateSurfaces, ppTriangulate);
  TLWOPostProcessSet = set of TLWOPostProcess;

  TIntPair = record
    A, B: Integer;
    class function New(aA, aB: Integer): TIntPair; static;
  end;

  TChunkHead = record
    Title: array [0..3] of Byte;
    Size: Cardinal;
    function TitleString: string;
  end;

  TChunkSubHead = record
    Title: array [0..3] of Byte;
    Size: Word;
    function TitleString: string;
  end;

  TLWUVMap = record
    Name: string;
    UV: TKMVertex2Array;
  end;

  TLWDUVMap = record
    Name: string;
    Count: Integer;
    DUV: array of record
      Vtx, Poly: Word;
      U,V: Single;
    end;
  end;

  // Weightmap vertice count always match its layers VerticeCount (or is absent)
  TLWWeightMap = record
    Name: string;
    Weights: array of Single;
    function IsEmpty: Boolean;
  end;
  PLWWeightMap = ^TLWWeightMap;

  // Layer
  TLWLayer = record
    LayerId: Integer;
    LayerName: string;
    VerticeCount: Integer;
    Vertices: TKMVertex3Array;
    Normals: TKMVertex3Array;
    UVCount: Integer;
    UVs: array of TLWUVMap;
    DUVCount: Integer;
    DUVs: array of TLWDUVMap;
    WeightMaps: array of TLWWeightMap;
    PolyCount: Integer;
    Polys: array of record
      VertCount: Word;
      Indices: array of Word;
      PolySurf: Word;
      PolyBone: Word;
    end;

    function HasUVs: Boolean;
    function GetUVIndex(const aUVName: string): Integer;

    procedure SetPolyCount(aCount: Integer);
    procedure SetUVCount(aUVCount: Integer);
    procedure SetWeightCount(aWeightMapsCount: Integer);
    procedure SetVerticeCount(aCount: Integer);
    procedure PolyMerge(aFrom, aTo: Word);
    procedure PolyMove(aFrom, aTo: Word);
    function VerticesMatch(A, B: Word): Boolean;
    procedure VerticeDuplicate(aVert: Word);
    procedure VerticeMove(aFrom, aTo: Word);
    procedure DUVUpdateVtx(aPoly, aOldVert, aNewVert: Word);
    procedure Post_RegenerateUVs;
  end;
  PLWLayer = ^TLWLayer;

  // Tag
  TLWTagType = (
    ttUnknown,
    ttBnup,     //
    ttBone,     // Bone
    ttColr,     // Wireframe color
    ttPart,     // Part
    ttSurf      // Surface
  );

const
  TAG_TYPE_NAME: array [TLWTagType] of string = ('????', 'Bnup', 'Bone', 'Colr', 'Part', 'Surf');

type
  TLWTag = record
    TagName: string;
    TagType: TLWTagType;
    SmoothingDeg: Single; // Stored in degrees (typicaly 0..180)
    Color: TKMColor3f;
    UVName: string;
    TextureId: Word;
  end;
  PLWTag = ^TLWTag;

  // Model
  TLWModel = class
  private
    fCurrLayer: Integer;

    procedure ReadChunkBBOX(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkCLIP(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkLAYR(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkPNTS(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkPOLS(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkPTAG(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkSURF(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkSURF_BLOK(aStream: TSwappedStream; aSize: Cardinal; aSurf: PLWTag);
    procedure ReadChunkTAGS(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkVMAD(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkVMAP(aStream: TSwappedStream; aSize: Cardinal);
    procedure ReadChunkVMPA(aStream: TSwappedStream; aSize: Cardinal);

    procedure WriteChunkTAGS(aStream: TSwappedStream);
    procedure WriteChunkLAYR(aStream: TSwappedStream);
    procedure WriteChunkPNTS(aStream: TSwappedStream);
    procedure WriteChunkBBOX(aStream: TSwappedStream);
    procedure WriteChunkVMAP(aStream: TSwappedStream);
    procedure WriteChunkVMAP_TXUV(aStream: TSwappedStream; const aMap: TLWUVMap);
    procedure WriteChunkVMAP_WGHT(aStream: TSwappedStream; const aMap: TLWWeightMap);
    procedure WriteChunkPOLS(aStream: TSwappedStream);
    procedure WriteChunkPTAG(aStream: TSwappedStream);
    procedure WriteChunkPTAG_COLR(aStream: TSwappedStream);
    procedure WriteChunkPTAG_SURF(aStream: TSwappedStream);
    procedure WriteChunkCLIP(aStream: TSwappedStream);
    procedure WriteChunkSURF(aStream: TSwappedStream);
    procedure WriteChunkSURF_BLOK(aStream: TSwappedStream; aTag: PLWTag);

    procedure AfterLoad;
    procedure DbgLog(aMsg: string);
    procedure Post_CalculateNormals;
    procedure Post_RegenerateUVs;
    procedure Post_SeparateSurfaces; deprecated 'Method has no body and is unused';
    procedure Post_Triangulate;

    procedure Proc_MergeVertices;
    procedure Proc_MergeVerticesUV;
    procedure Proc_MergePolys(aFlattnessThreshold: Single);
  public
    DbgDoLogging: Boolean;

    // Raw data
    TagCount: Integer;
    Tags: array of TLWTag;
    LayerCount: Integer;
    Layers: array of TLWLayer;
    ClipCount: Integer;
    Clips: array of string;

    // Aux data for processing
    Surfaces: TStringList;
    UVNames: TStringList;

    constructor Create;
    destructor Destroy; override;

    procedure LoadFromFile(aFile: string);
    procedure LoadFromStream(aStream: TStream);
    procedure SaveToFile(aFile: string);
    procedure SaveToStream(aStream: TStream);

    procedure PostProcess(aSteps: TLWOPostProcessSet);
    procedure PrepareToSave;

    procedure AssertDistinctUVPerVertice(const aIgnore: string);
    function GetVerticeCount: Integer;
    function GetPolyCount: Integer;
    procedure GetVerticeUVIndex(aLay: PLWLayer; aVertice: Integer; const aSkip: string; out aLayerUvIndex, aModelUvIndex: Integer);
    procedure GetPolyUVIndex(aLay: PLWLayer; aPoly: Integer; const aSkip: string; out aLayerUvIndex, aModelUvIndex: Integer);

    function LayerAdd: PLWLayer;
    function TagAdd: PLWTag;
    function TagExists(const aName: string; aType: TLWTagType): Boolean;
  end;


implementation
uses
  StrUtils;


{ TIntPair }
class function TIntPair.New(aA, aB: Integer): TIntPair;
begin
  Result.A := aA;
  Result.B := aB;
end;

{ TChunkHead }
function TChunkHead.TitleString: string;
begin
  Result := Char(Title[3]) + Char(Title[2]) + Char(Title[1]) + Char(Title[0]);
end;


{ TChunkSubHead }
function TChunkSubHead.TitleString: string;
begin
  Result := Char(Title[3]) + Char(Title[2]) + Char(Title[1]) + Char(Title[0]);
end;


{ TLWWeightMap }
function TLWWeightMap.IsEmpty: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to High(Weights) do
  if Weights[I] <> 0 then
    Exit(False);
end;


{ TLWLayer }
function TLWLayer.HasUVs: Boolean;
begin
  Result := (UVCount > 0) and (Length(UVs[0].UV) > 0);
end;


// Get UV value from said map name
procedure TLWLayer.DUVUpdateVtx(aPoly, aOldVert, aNewVert: Word);
var
  I, K: Integer;
begin
  for I := 0 to DUVCount - 1 do
    for K := 0 to DUVs[I].Count - 1 do
    if (DUVs[I].DUV[K].Poly = aPoly) and (DUVs[I].DUV[K].Vtx = aOldVert) then
      DUVs[I].DUV[K].Vtx := aNewVert;
end;


function TLWLayer.GetUVIndex(const aUVName: string): Integer;
var
  I: Integer;
begin
  Result := -1;

  for I := 0 to UVCount - 1 do
  if UVs[I].Name = aUVName then
    Exit(I);
end;


procedure TLWLayer.SetPolyCount(aCount: Integer);
begin
  PolyCount := aCount;
  SetLength(Polys, PolyCount);
end;


procedure TLWLayer.SetUVCount(aUVCount: Integer);
begin
  UVCount := aUVCount;
  SetLength(UVs, UVCount);
end;


procedure TLWLayer.SetWeightCount(aWeightMapsCount: Integer);
begin
  SetLength(WeightMaps, aWeightMapsCount);
end;


procedure TLWLayer.SetVerticeCount(aCount: Integer);
var
  I: Integer;
begin
  VerticeCount := aCount;
  SetLength(Vertices, VerticeCount);
  SetLength(Normals, VerticeCount);

  for I := 0 to UVCount - 1 do
    SetLength(UVs[I].UV, VerticeCount);

  for I := 0 to High(WeightMaps) do
    SetLength(WeightMaps[I].Weights, VerticeCount);
end;


procedure TLWLayer.PolyMerge(aFrom, aTo: Word);
var
  I, K: Integer;
  insertAfter: ShortInt;
  newInd: Integer;
begin
  Assert((Polys[aFrom].VertCount = 3) and (Polys[aTo].VertCount = 3));

  insertAfter := -1;
  newInd := -1;

  // Find matching sides
  // We know that adjacent polys have opposite windings
  for I := 0 to 2 do
    for K := 0 to 2 do
      if (Polys[aTo].Indices[I] = Polys[aFrom].Indices[K])
      and (Polys[aTo].Indices[(I+1) mod 3] = Polys[aFrom].Indices[(K+2) mod 3]) then
      begin
        insertAfter := I;
        newInd := Polys[aFrom].Indices[(K+1) mod 3];
      end;

  Assert(insertAfter <> -1, 'Can not merge polys without common edge');
  Assert(newInd <> -1, 'Can not merge polys without common edge');

  // Grow
  Inc(Polys[aTo].VertCount);
  SetLength(Polys[aTo].Indices, Polys[aTo].VertCount);

  // Insert new indice between existing ones
  for I := 3 downto insertAfter + 2 do
    Polys[aTo].Indices[I] := Polys[aTo].Indices[I-1];
  Polys[aTo].Indices[insertAfter + 1] := newInd;

  // Erase aFrom
  Polys[aFrom].VertCount := 0;
  SetLength(Polys[aFrom].Indices, Polys[aFrom].VertCount);
end;


procedure TLWLayer.PolyMove(aFrom, aTo: Word);
var
  I: Integer;
begin
  Polys[aTo].VertCount := Polys[aFrom].VertCount;
  Polys[aTo].PolySurf := Polys[aFrom].PolySurf;
  Polys[aTo].PolyBone := Polys[aFrom].PolyBone;

  // VertCount could be different, since on export we merge some tris into quads
  SetLength(Polys[aTo].Indices, Polys[aFrom].VertCount);
  for I := 0 to Polys[aFrom].VertCount - 1 do
    Polys[aTo].Indices[I] := Polys[aFrom].Indices[I];
end;


function TLWLayer.VerticesMatch(A, B: Word): Boolean;
var
  I: Integer;
  d: Single;
begin
  // Equality check has a small Epsilon of 0.0001, which is okay for our needs
  Result := (Vertices[A] = Vertices[B]);

  if Result then
    for I := 0 to UVCount - 1 do
      Result := Result and (UVs[I].UV[A] = UVs[I].UV[B]);

  // Equality check has a small Epsilon of 0.0001, which is okay for our needs
  if Result then
  begin
    Result := Result and (Normals[A] = Normals[B]);

    d := VectorDotProduct(Normals[A], Normals[B]);
    //if not Result and (d > 0.99) then
    //  gLog.AddNoTime('Suspiciously similar normals: v%d v%d - %.8f', [A, B, d]);
  end;

  if Result then
    for I := 0 to High(WeightMaps) do
      Result := Result and (WeightMaps[I].Weights[A] = WeightMaps[I].Weights[B]);
end;


procedure TLWLayer.VerticeDuplicate(aVert: Word);
var
  I: Integer;
begin
  // Normal
  SetLength(Normals, VerticeCount + 1);
  Normals[VerticeCount] := Normals[aVert];

  // Vertex
  SetLength(Vertices, VerticeCount + 1);
  Vertices[VerticeCount] := Vertices[aVert];

  // UVs
  for I := 0 to UVCount - 1 do
  begin
    SetLength(UVs[I].UV, VerticeCount + 1);
    UVs[I].UV[VerticeCount] := UVs[I].UV[aVert];
  end;

  // Weight maps
  for I := 0 to High(WeightMaps) do
  begin
    SetLength(WeightMaps[I].Weights, VerticeCount + 1);
    WeightMaps[I].Weights[VerticeCount] := WeightMaps[I].Weights[aVert];
  end;

  Inc(VerticeCount);
end;


procedure TLWLayer.VerticeMove(aFrom, aTo: Word);
var
  I: Integer;
begin
  Vertices[aTo] := Vertices[aFrom];
  Normals[aTo] := Normals[aFrom];

  for I := 0 to UVCount - 1 do
    UVs[I].UV[aTo] := UVs[I].UV[aFrom];

  for I := 0 to High(WeightMaps) do
    WeightMaps[I].Weights[aTo] := WeightMaps[I].Weights[aFrom];
end;


procedure TLWLayer.Post_RegenerateUVs;
var
  I, K, H: Integer;
  nc, v, nv, p: Word;
  found: Byte;
begin
  for I := 0 to DUVCount - 1 do
  begin
    // Allocate space for more vertices required for DUVs
    nc := VerticeCount + DUVs[I].Count;
    SetLength(Vertices, nc);
    SetLength(Normals, nc);
    for H := 0 to UVCount - 1 do
      SetLength(UVs[H].UV, nc);
    for H := 0 to High(WeightMaps) do
      SetLength(WeightMaps[H].Weights, nc);

    // For each new DUV we need to duplicate the vertex info and write new UV for it
    // Also update affected polygon
    for K := 0 to DUVs[I].Count - 1 do
    begin
      v := DUVs[I].DUV[K].Vtx;
      nv := VerticeCount + K;

      // Duplicate vertex info
      Vertices[nv] := Vertices[v];
      Normals[nv] := Normals[v];

      for H := 0 to High(WeightMaps) do
        WeightMaps[H].Weights[nv] := WeightMaps[H].Weights[v];

      // Write new UV coords to new vertex (and duplicate other ones)
      for H := 0 to UVCount - 1 do
      if UVs[H].Name = DUVs[I].Name then
      begin
        UVs[H].UV[nv].X := DUVs[I].DUV[K].U;
        UVs[H].UV[nv].Y := DUVs[I].DUV[K].V;
      end else
        UVs[H].UV[nv] := UVs[H].UV[v];

      // Update affected poly
      found := 0;
      p := DUVs[I].DUV[K].Poly;
      for H := 0 to Polys[p].VertCount - 1 do
        if Polys[p].Indices[H] = v then
        begin
          Polys[p].Indices[H] := nv;
          Inc(found);
        end;

      if found <> 1 then
        Assert(False, 'DUV mismatch');
    end;

    // Vertice count increased
    VerticeCount := nc;
  end;
end;


{ TLWModel }
constructor TLWModel.Create;
begin
  inherited;

  Surfaces := TStringList.Create;
  UVNames := TStringList.Create;

  DbgDoLogging := False;

  fCurrLayer := -1;
end;


destructor TLWModel.Destroy;
begin
  Surfaces.Free;
  UVNames.Free;

  inherited;
end;


procedure TLWModel.DbgLog(aMsg: string);
begin
  //if DbgDoLogging then
  //  gLog.AddNoTime(aMsg);
end;


procedure TLWModel.ReadChunkBBOX(aStream: TSwappedStream; aSize: Cardinal);
begin
  aStream.Position := aStream.Position + aSize;
  //DbgLog('BBOX chunk ignored');
end;


procedure TLWModel.WriteChunkBBOX(aStream: TSwappedStream);
const
  EMPTY: AnsiString = #0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0;
var
  S: TSwappedStream;
begin
  S := TSwappedStream.Create;
  S.Write(EMPTY);
  aStream.WriteChunk4('BBOX', S);
  S.Free;
end;


procedure TLWModel.ReadChunkCLIP(aStream: TSwappedStream; aSize: Cardinal);
var
  I, endPos: Integer;
  subHead: TChunkSubHead;
  s: string;
  buf: array [0..1] of Byte;
  buf2: array [0..3] of Byte;
begin
  endPos := aStream.Position + aSize;
  aStream.ReadSwap(I, 4); // Some number ?

  repeat
    aStream.ReadSwap(subHead.Title, 4);
    aStream.ReadSwap(subHead.Size, 2);

    if subHead.TitleString = 'STIL' then
    begin
      Inc(ClipCount);
      SetLength(Clips, ClipCount);

      s := '';
      repeat
        aStream.Read(buf, 2);
        if buf[0] <> 0 then s := s + Char(buf[0]);
        if buf[1] <> 0 then s := s + Char(buf[1]);
      until (buf[1] = 0);

      Clips[High(Clips)] := s;
    end else
    if subHead.TitleString = 'FLAG' then
    begin
      aStream.ReadSwap(buf2, 4);

      s := '';
      for I := 0 to 3 do
        s := s + '#' + IntToStr(Ord(buf2[I]));

      //Assert((s = '#128#0#0#0') or (s = '#0#0#0#8'), 'CLIP.FLAG - unexpected value of ' + s);
      DbgLog('CLIP.FLAG = ' + s);
    end else
    begin
      aStream.Seek(subHead.Size, soFromCurrent);
      // These are image settings (alpha, mipmap, colorspace, etc.)
      DbgLog('CLIP.' + subHead.TitleString + ' chunk ignored');
    end;
  until (aStream.Position >= endPos);
end;


procedure TLWModel.WriteChunkCLIP(aStream: TSwappedStream);
const
  FLAG_: AnsiString = #0#4 + #0#0#0#128;
var
  S: TSwappedStream;
  I: Integer;
begin
  if ClipCount = 0 then Exit;

  S := TSwappedStream.Create;

  S.Write(ClipCount);
  for I := 0 to ClipCount - 1 do
  begin
    S.Write('STIL');
    S.WriteStringPadLen(Clips[I]);
    S.Write('FLAG');
    S.Write(FLAG_);
  end;

  aStream.WriteChunk4('CLIP', S);

  S.Free;
end;


procedure TLWModel.ReadChunkLAYR(aStream: TSwappedStream; aSize: Cardinal);
var
  buf: array [0..1] of Byte;
begin
  Inc(LayerCount);
  SetLength(Layers, LayerCount);

  fCurrLayer := LayerCount - 1;
  aStream.ReadSwap(Layers[fCurrLayer].LayerId, 2);
  aStream.Seek(14, soFromCurrent); //No idea what is there

  repeat
    aStream.Read(buf, 2);
    if buf[0] <> 0 then Layers[fCurrLayer].LayerName := Layers[fCurrLayer].LayerName + Char(buf[0]);
    if buf[1] <> 0 then Layers[fCurrLayer].LayerName := Layers[fCurrLayer].LayerName + Char(buf[1]);
  until (buf[1] = 0);

  //DbgLog('LAYR "' + Layers[fCurrLayer].LayerName + '"');
end;


procedure TLWModel.WriteChunkLAYR(aStream: TSwappedStream);
const
  LAYR_OPTIONS: AnsiString = #0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0;
var
  S: TSwappedStream;
begin
  S := TSwappedStream.Create;

  // 256 layers should be enough for now
  S.Write(#0 + AnsiChar(fCurrLayer));

  S.Write(LAYR_OPTIONS);

  aStream.WriteChunk4('LAYR', S);

  S.Free;
end;


procedure TLWModel.ReadChunkPNTS(aStream: TSwappedStream; aSize: Cardinal);
var
  I: Integer;
begin
  Assert(aSize div 12 < 65280, 'Point quantity exceeds 65`280 limit');
  Layers[fCurrLayer].VerticeCount := aSize div 12;

  SetLength(Layers[fCurrLayer].Vertices, Layers[fCurrLayer].VerticeCount);
  for I := 0 to Layers[fCurrLayer].VerticeCount - 1 do
  begin
    aStream.ReadSwap(Layers[fCurrLayer].Vertices[I].X, 4);
    aStream.ReadSwap(Layers[fCurrLayer].Vertices[I].Y, 4);
    aStream.ReadSwap(Layers[fCurrLayer].Vertices[I].Z, 4);
  end;
end;


procedure TLWModel.WriteChunkPNTS(aStream: TSwappedStream);
var
  S: TSwappedStream;
  I: Integer;
begin
  S := TSwappedStream.Create;

  for I := 0 to Layers[fCurrLayer].VerticeCount - 1 do
  begin
    S.WriteSwap(Layers[fCurrLayer].Vertices[I].X, 4);
    S.WriteSwap(Layers[fCurrLayer].Vertices[I].Y, 4);
    S.WriteSwap(Layers[fCurrLayer].Vertices[I].Z, 4);
  end;

  aStream.WriteChunk4('PNTS', S);

  S.Free;
end;


procedure TLWModel.ReadChunkPOLS(aStream: TSwappedStream; aSize: Cardinal);
var
  endPos: Cardinal;
  I, K: Integer;
  lay: PLWLayer;
begin
  endPos := aStream.Position + aSize;
  aStream.Position := aStream.Position + 4; // 'FACE'

  lay := @Layers[fCurrLayer];

  I := 0;
  repeat
    SetLength(lay.Polys, I + 1);

    aStream.ReadSwap(lay.Polys[I].VertCount, 2);
    SetLength(lay.Polys[I].Indices, lay.Polys[I].VertCount);

    for K := 0 to lay.Polys[I].VertCount - 1 do
      aStream.ReadSwap(lay.Polys[I].Indices[K], 2);

    Inc(I);
  until (aStream.Position >= endPos);

  lay.PolyCount := I;
  Assert(aStream.Position = endPos, 'Unknown error in POLS chunk');
end;


procedure TLWModel.WriteChunkPOLS(aStream: TSwappedStream);
var
  S: TSwappedStream;
  lay: PLWLayer;
  I, K: Integer;
begin
  lay := @Layers[fCurrLayer];

  S := TSwappedStream.Create;

  S.Write('FACE');

  for I := 0 to lay.PolyCount - 1 do
  begin
    S.WriteSwap(lay.Polys[I].VertCount, 2);

    for K := 0 to lay.Polys[I].VertCount - 1 do
      S.WriteSwap(lay.Polys[I].Indices[K], 2);
  end;
  aStream.WriteChunk4('POLS', S);

  S.Free;
end;


procedure TLWModel.ReadChunkPTAG(aStream: TSwappedStream; aSize: Cardinal);
var
  subHead: TChunkSubHead;
  I: Integer;
  id, ptag: Word;
  lay: PLWLayer;
begin
  lay := @Layers[fCurrLayer];

  aStream.ReadSwap(subHead, 4);

  if subHead.TitleString = 'BNUP' then
  begin
    for I := 0 to lay.PolyCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(ptag, 2);
      //Bnup info?
      Tags[ptag].TagType := ttBnup;
    end;
  end
  else
  if subHead.TitleString = 'BONE' then
  begin
    for I := 0 to lay.PolyCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(ptag, 2);
      lay.Polys[id].PolyBone := ptag;
      Tags[ptag].TagType := ttBone;
    end;
  end
  else
  if subHead.TitleString = 'COLR' then
  begin
    for I := 0 to lay.PolyCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(ptag, 2);
      //Color info, safe to ignore
      Tags[ptag].TagType := ttColr;
    end;
  end
  else
  if subHead.TitleString = 'PART' then
  begin
    for I := 0 to lay.PolyCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(ptag, 2);
      //Part info, safe to ignore
      Tags[ptag].TagType := ttPart;
    end;
  end
  else
  if subHead.TitleString = 'SURF' then
  begin
    for I := 0 to lay.PolyCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(ptag, 2);
      lay.Polys[id].PolySurf := ptag;
      Tags[ptag].TagType := ttSurf;
    end;
  end
  else
  begin
    DbgLog('PTAG ' + subHead.TitleString + ' skipped ' + IntToStr(aSize - 4));
    aStream.Position := aStream.Position + aSize - 4;
  end;
end;


procedure TLWModel.WriteChunkPTAG(aStream: TSwappedStream);
begin
//  WriteChunkPTAG_COLR(aStream);
  WriteChunkPTAG_SURF(aStream);
end;


procedure TLWModel.WriteChunkPTAG_COLR(aStream: TSwappedStream);
const
  DEFAULT_COLR: Word = 0;
var
  lay: PLWLayer;
  S: TSwappedStream;
  I: Integer;
begin
  S := TSwappedStream.Create;

  lay := @Layers[fCurrLayer];

  S.Write('COLR');
  for I := 0 to lay.PolyCount - 1 do
  begin
    S.WriteSwap(I, 2);
    S.WriteSwap(DEFAULT_COLR, 2);
  end;

  aStream.WriteChunk4('PTAG', S);

  S.Free;
end;


procedure TLWModel.WriteChunkPTAG_SURF(aStream: TSwappedStream);
var
  lay: PLWLayer;
  S: TSwappedStream;
  I: Integer;
begin
  S := TSwappedStream.Create;

  lay := @Layers[fCurrLayer];

  S.Write('SURF');
  for I := 0 to lay.PolyCount - 1 do
  begin
    S.WriteSwap(I, 2);
    S.WriteSwap(lay.Polys[I].PolySurf, 2);
  end;

  aStream.WriteChunk4('PTAG', S);

  S.Free;
end;


procedure TLWModel.ReadChunkSURF(aStream: TSwappedStream; aSize: Cardinal);
var
  endPos: Cardinal;
  buf: array [0..1] of Byte;
  surfName, surfName2: string;
  surf: PLWTag;
  I: Integer;
  subHead: TChunkSubHead;
begin
  endPos := aStream.Position + aSize;

  // Surface name string
  repeat
    aStream.Read(buf, 2);
    if buf[0] <> 0 then surfName := surfName + Char(buf[0]);
    if buf[1] <> 0 then surfName := surfName + Char(buf[1]);
  until (buf[1] = 0);

  surf := nil;
  for I := 0 to TagCount - 1 do
  if Tags[I].TagName = surfName then
    surf := @Tags[I];

  // Another string, usually empty
  repeat
    aStream.Read(buf, 2);
    if buf[0] <> 0 then surfName2 := surfName2 + Char(buf[0]);
    if buf[1] <> 0 then surfName2 := surfName2 + Char(buf[1]);
  until (buf[1] = 0);

  DbgLog('SURF: ' + surfName + ' [' + surfName2 + ']');

  repeat
    aStream.ReadSwap(subHead.Title, 4);
    aStream.ReadSwap(subHead.Size, 2);

    //DbgLog('subHead.Title/Size: ' + subHead.TitleString + ' / ' + IntToStr(subHead.Size));

    if subHead.TitleString = 'COLR' then
    begin
      aStream.ReadSwap(surf.Color.R, 4);
      aStream.ReadSwap(surf.Color.G, 4);
      aStream.ReadSwap(surf.Color.B, 4);
      aStream.Seek(2, soFromCurrent);
      //gLog.AddNoTime('%.f, %.f, %.f', [surf.Color.X, surf.Color.Y, surf.Color.Z]);
    end
    else
    if subHead.TitleString = 'SMAN' then
    begin
      // Read smoothing degree threshold and store it in degrees (easier to grok)
      aStream.ReadSwap(surf.SmoothingDeg, 4);
      surf.SmoothingDeg := surf.SmoothingDeg / Pi * 180;
      //gLog.AddNoTime('%.f', [surf.SmoothingDeg]);
    end
    else
    if subHead.TitleString = 'BLOK' then
    begin
      ReadChunkSURF_BLOK(aStream, subHead.Size, surf);
    end
    else
      aStream.Seek(subHead.Size, soFromCurrent);
  until (aStream.Position >= endPos);

  aStream.Position := endPos;
end;


procedure TLWModel.WriteChunkSURF(aStream: TSwappedStream);
const
  SMAN_DEFAULT: Single = Pi;
  DIFF_DEFAULT: Single = 1.0;
var
  S: TSwappedStream;
  I: Integer;
  sd: Single;
begin
  S := TSwappedStream.Create;

  for I := 0 to TagCount - 1 do
  if Tags[I].TagType = ttSurf then
  begin
    S.Clear;

    S.WriteStringPad(Tags[I].TagName);
    S.WriteStringPad('');

    S.Write('COLR');
    S.Write(#0#14);
    S.WriteSwap(Tags[I].Color.R, 4);
    S.WriteSwap(Tags[I].Color.G, 4);
    S.WriteSwap(Tags[I].Color.B, 4);
    S.Write(#0#0);

    S.Write('DIFF');
    S.Write(#0#6);
    S.WriteSwap(DIFF_DEFAULT, 4);
    S.Write(#0#0);

    sd := Tags[I].SmoothingDeg / 180 * Pi;
    S.Write('SMAN');
    S.Write(#0#4);
    S.WriteSwap(sd, 4);

    S.Write('SIDE');
    S.WriteStringLen(#0#1);

    WriteChunkSURF_BLOK(S, @Tags[I]);

    aStream.WriteChunk4('SURF', S);
  end;

  S.Free;
end;


procedure TLWModel.WriteChunkSURF_BLOK(aStream: TSwappedStream; aTag: PLWTag);
const
  IMAP_DEFAULT: AnsiString = #0#42#128#0;
  CHAN_DEFAULT: AnsiString = 'COLR';
  OPAC_DEFAULT1: Single = 1.0;
  OPAC_DEFAULT2: Single = 0.0;
  PROJ_DEFAULT: AnsiString = #0#5;
  WRAP_DEFAULT: AnsiString = #0#1#0#1;
var
  S: TSwappedStream;
begin
  S := TSwappedStream.Create;

  S.Write('IMAP');
  S.Write(IMAP_DEFAULT);

  S.Write('CHAN');
  S.WriteStringLen(CHAN_DEFAULT);

  S.Write('OPAC');
  S.Write(#0#8);
  S.WriteSwap(OPAC_DEFAULT1, 4);
  S.WriteSwap(OPAC_DEFAULT2, 4);

  S.Write('PROJ');
  S.WriteStringLen(PROJ_DEFAULT);

  S.Write('IMAG');
  S.Write(#0#2);
  S.WriteSwap(aTag.TextureId, 2);

  S.Write('WRAP');
  S.WriteStringLen(WRAP_DEFAULT);

  S.Write('VMAP');
  S.WriteStringPadLen(aTag.UVName);

  aStream.WriteChunk2('BLOK', S);

  S.Free;
end;


procedure TLWModel.ReadChunkSURF_BLOK(aStream: TSwappedStream; aSize: Cardinal; aSurf: PLWTag);
var
  endPos: Cardinal;
  subHead: TChunkSubHead;
  buf: array [0..1] of Byte;
begin
  endPos := aStream.Position + aSize;

  repeat
    aStream.ReadSwap(subHead.Title, 4);
    aStream.ReadSwap(subHead.Size, 2);

    DbgLog('SURF.BLOK.Title/Size: ' + subHead.TitleString + ' / ' + IntToStr(subHead.Size));

    if subHead.TitleString = 'IMAG' then
    begin
      aStream.ReadSwap(aSurf.TextureId, 2);
    end
    else
    if subHead.TitleString = 'VMAP' then
    begin
      repeat
        aStream.Read(buf, 2);
        if buf[0] <> 0 then aSurf.UVName := aSurf.UVName + Char(buf[0]);
        if buf[1] <> 0 then aSurf.UVName := aSurf.UVName + Char(buf[1]);
      until (buf[1] = 0);
    end
    else
      aStream.Seek(subHead.Size, soFromCurrent);
  until (aStream.Position >= endPos);

  aStream.Position := endPos;
end;


procedure TLWModel.ReadChunkTAGS(aStream: TSwappedStream; aSize: Cardinal);
var
  buf: array [0..1] of Byte;
  readCount: Cardinal;
  s: string;
begin
  Assert(TagCount = 0);

  readCount := 0;
  TagCount := 0;
  repeat
    SetLength(Tags, TagCount + 1);

    s := '';
    repeat
      aStream.Read(buf, 2);
      Inc(readCount, 2);

      if buf[0] <> 0 then s := s + Char(buf[0]);
      if buf[1] <> 0 then s := s + Char(buf[1]);

      Tags[TagCount].TagName := s;
    until (buf[1] = 0);

    Inc(TagCount);
  until (readCount >= aSize);

  Assert(readCount = aSize);
end;


procedure TLWModel.WriteChunkTAGS(aStream: TSwappedStream);
var
  I: Integer;
  S: TSwappedStream;
begin
  S := TSwappedStream.Create;

  for I := 0 to TagCount - 1 do
    S.WriteStringPad(Tags[I].TagName);

  aStream.WriteChunk4('TAGS', S);

  S.Free;
end;


procedure TLWModel.ReadChunkVMAD(aStream: TSwappedStream; aSize: Cardinal);
var
  subHead: TChunkSubHead;
  buf: array [0..1] of Byte;
  VMADName: string;
  readCount: Word;
  elemCount: Integer;
  I: Integer;
  lay: PLWLayer;
begin
  aStream.ReadSwap(subHead.Title, 4);
  aStream.ReadSwap(subHead.Size, 2);
  readCount := 6;

  DbgLog('VMAD ' + subHead.TitleString + ' (coords=' + IntToStr(subHead.Size) + ')');

  lay := @Layers[fCurrLayer];

  if subHead.TitleString = 'APSL' then
  begin
    // Safe to skip
    aStream.Position := aStream.Position + aSize - readCount;
  end
  else
  if subHead.TitleString = 'NORM' then
  begin
    // Normals for vertices? - Safe to skip
    aStream.Position := aStream.Position + aSize - readCount;
  end
  else
  if subHead.TitleString = 'TXUV' then
  begin
    // UV
    repeat
      // UV map name
      aStream.Read(buf, 2);
      if buf[0] <> 0 then VMADName := VMADName + Char(buf[0]);
      if buf[1] <> 0 then VMADName := VMADName + Char(buf[1]);
      Inc(readCount, 2);
    until((buf[0] = 0) or (buf[1] = 0));
    DbgLog('VMAD TXUV name="' + VMADName + '"');

    // Read as is, we will deal with it later in an OOP manner
    Inc(lay.DUVCount);
    SetLength(lay.DUVs, lay.DUVCount);
    lay.DUVs[lay.DUVCount - 1].Name := VMADName;
    elemCount := (aSize - readCount) div 12;
    lay.DUVs[lay.DUVCount - 1].Count := elemCount;
    SetLength(lay.DUVs[lay.DUVCount - 1].DUV, elemCount);
    for I := 0 to elemCount - 1 do
    begin
      aStream.ReadSwap(lay.DUVs[lay.DUVCount - 1].DUV[I].Vtx, 2);  // Vert to cut out
      aStream.ReadSwap(lay.DUVs[lay.DUVCount - 1].DUV[I].Poly, 2); // Poly to cut out
      aStream.ReadSwap(lay.DUVs[lay.DUVCount - 1].DUV[I].U, 4);    // New value
      aStream.ReadSwap(lay.DUVs[lay.DUVCount - 1].DUV[I].V, 4);    // New value
    end;

    aStream.Position := aStream.Position + aSize - readCount - elemCount * 12;
  end
  else
  begin
    //Safe to skip
    aStream.Position := aStream.Position + aSize - readCount;
  end;
end;


procedure TLWModel.ReadChunkVMPA(aStream: TSwappedStream; aSize: Cardinal);
var
  buf: array [0..7] of Byte;
  I: Integer;
  s: string;
begin
  // (SubD interpolation options stuff)
  Assert(aSize = 8, 'Vertex map options is always 8 Byte chunk');
  aStream.Read(buf, 8);

  for I := 0 to 7 do
    s := s + '#' + IntToStr(Ord(buf[I]));

  DbgLog('VMPA ' + s);
end;


procedure TLWModel.ReadChunkVMAP(aStream: TSwappedStream; aSize: Cardinal);
var
  subHead: TChunkSubHead;
  buf: array [0..1] of Byte;
  VMAPName: string;
  readCount: Word;
  I, K: Integer;
  id: Word;
  elemCount: Integer;
  lay: PLWLayer;
begin
  aStream.ReadSwap(subHead.Title, 4);
  aStream.ReadSwap(subHead.Size, 2);

  lay := @Layers[fCurrLayer];

  if subHead.TitleString = 'TXUV' then
  begin
    readCount := 0;
    repeat
      // UV map name
      aStream.Read(buf, 2);
      if buf[0] <> 0 then VMAPName := VMAPName + Char(buf[0]);
      if buf[1] <> 0 then VMAPName := VMAPName + Char(buf[1]);
      Inc(readCount, 2);
    until((buf[0] = 0) or (buf[1] = 0));
    DbgLog('VMAP TXUV name="' + VMAPName + '"');

    // Add new UV map
    Inc(lay.UVCount);
    SetLength(lay.UVs, lay.UVCount);
    lay.UVs[lay.UVCount-1].Name := VMAPName;
    SetLength(lay.UVs[lay.UVCount-1].UV, lay.VerticeCount);

    // Fill with "unused" values
    for I := 0 to lay.VerticeCount - 1 do
      lay.UVs[lay.UVCount-1].UV[I] := TKMVertex2.NaN;

    elemCount := (aSize - readCount - 6) div 10;
    for I := 0 to elemCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(lay.UVs[lay.UVCount-1].UV[id].X, 4);
      aStream.ReadSwap(lay.UVs[lay.UVCount-1].UV[id].Y, 4);
    end;
  end
  else
  if subHead.TitleString = 'WGHT' then
  begin
    readCount := 0;

    // Read Weight map name
    repeat
      aStream.Read(buf, 2);
      if buf[0] <> 0 then VMAPName := VMAPName + Char(buf[0]);
      if buf[1] <> 0 then VMAPName := VMAPName + Char(buf[1]);
      Inc(readCount, 2);
    until((buf[0] = 0) or (buf[1] = 0));

    DbgLog('VMAP WGHT "' + VMAPName + '"');

    // Append new Weight map
    K := Length(lay.WeightMaps);
    SetLength(lay.WeightMaps, K + 1);

    lay.WeightMaps[K].Name := VMAPName;
    SetLength(lay.WeightMaps[K].Weights, lay.VerticeCount);

    elemCount := (aSize - readCount - 6) div 6;
    for I := 0 to elemCount - 1 do
    begin
      aStream.ReadSwap(id, 2);
      aStream.ReadSwap(lay.WeightMaps[K].Weights[id], 4);
    end;
  end
  else
  if subHead.TitleString = 'APSL' then
  begin
    // Safe to skip
    aStream.Position := aStream.Position + aSize - 6;
  end
  else
  begin
    DbgLog('VMAP ' + subHead.TitleString + ' skipped ' + IntToStr(aSize - 6));
    aStream.Position := aStream.Position + aSize - 6;
  end;
end;


procedure TLWModel.WriteChunkVMAP(aStream: TSwappedStream);
const
  VMPA_LENGTH: Integer = 8;
  VMPA_OPTIONS: AnsiString = #0#0#0#0#0#0#0#6;
var
  lay: PLWLayer;
  I: Integer;
begin
  lay := @Layers[fCurrLayer];

  for I := 0 to High(lay.WeightMaps) do
  if not lay.WeightMaps[I].IsEmpty then // Safe to skip, LW will fill any missing maps with 0
  begin
    aStream.Write('VMPA');
    aStream.WriteSwap(VMPA_LENGTH, 4);
    aStream.Write(VMPA_OPTIONS);
    WriteChunkVMAP_WGHT(aStream, lay.WeightMaps[I]);
  end;

  for I := 0 to lay.UVCount - 1 do
  begin
    aStream.Write('VMPA');
    aStream.WriteSwap(VMPA_LENGTH, 4);
    aStream.Write(VMPA_OPTIONS);
    WriteChunkVMAP_TXUV(aStream, lay.UVs[I]);
  end;
end;


procedure TLWModel.WriteChunkVMAP_TXUV(aStream: TSwappedStream; const aMap: TLWUVMap);
const
  TXUV_OPTIONS: AnsiString = #0#2; // Looks like components count - 2
var
  S: TSwappedStream;
  I: Integer;
begin
  S := TSwappedStream.Create;

  S.Write('TXUV');
  S.Write(TXUV_OPTIONS);

  S.WriteStringPad(aMap.Name);
  for I := 0 to High(aMap.UV) do
  if not aMap.UV[I].IsNaN then // Skip unmapped
  begin
    S.WriteSwap(I, 2);
    S.WriteSwap(aMap.UV[I].X, 4);
    S.WriteSwap(aMap.UV[I].Y, 4);
  end;

  aStream.WriteChunk4('VMAP', S);

  S.Free;
end;


procedure TLWModel.WriteChunkVMAP_WGHT(aStream: TSwappedStream; const aMap: TLWWeightMap);
const
  WGHT_OPTIONS: AnsiString = #0#1; // Looks like components count - 1
var
  S: TSwappedStream;
  I: Integer;
begin
  S := TSwappedStream.Create;

  S.Write('WGHT');
  S.Write(WGHT_OPTIONS);

  S.WriteStringPad(aMap.Name);
  for I := 0 to High(aMap.Weights) do
  if aMap.Weights[I] <> 0 then // Safe to skip, LW will fill any missing values with 0
  begin
    S.WriteSwap(I, 2);
    S.WriteSwap(aMap.Weights[I], 4);
  end;

  aStream.WriteChunk4('VMAP', S);

  S.Free;
end;


procedure TLWModel.AssertDistinctUVPerVertice(const aIgnore: string);
var
  I, K, L: Integer;
  lay: PLWLayer;
  uvCount: Integer;
begin
  for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];

    if lay.UVCount > 1 then
      for K := 0 to lay.VerticeCount - 1 do
      begin
        uvCount := 0;

        for L := 0 to lay.UVCount - 1 do
          if lay.UVs[L].Name <> aIgnore then
            uvCount := uvCount + Ord(not lay.UVs[L].UV[K].IsNaN);

        Assert(uvCount <= 1, Format('Vertice %d in layer %d has more than 1 UV mapping', [K, I]) +
                             IfThen(aIgnore <> '', '. Ignoring "' + aIgnore + '"'));

// Should be turned off for release
//        if uvCount = 0 then
//          gLog.AddNoTime('Vertice %d in layer %d has no UV mapping', [K, I]) +
//                             IfThen(aIgnore <> '', '. Ignoring "' + aIgnore + '"');
      end;
  end;
end;


function TLWModel.GetVerticeCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to LayerCount - 1 do
    Result := Result + Layers[I].VerticeCount;
end;


function TLWModel.GetPolyCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to LayerCount - 1 do
    Result := Result + Layers[I].PolyCount;
end;


// Find index of UV map that has data
// UV mapping must be full in Release, but in Alpha, with sketchy houses, it is okay that not all vertices have UV mapping
// Return 0 if none
// aLayerUVIndex - UV map index in this layer, which has values (in case lwo layer has several UV maps)
// aModelUvIndex - UV map index in whole model
procedure TLWModel.GetVerticeUVIndex(aLay: PLWLayer; aVertice: Integer; const aSkip: string; out aLayerUvIndex, aModelUvIndex: Integer);
var
  I: Integer;
begin
  aLayerUvIndex := -1;
  aModelUvIndex := -1;

  for I := 0 to aLay.UVCount - 1 do
  if (aLay.UVs[I].Name <> aSkip) and not aLay.UVs[I].UV[aVertice].IsNaN then
  begin
    // It's safe to exit, since we've made sure there's no multiple UVs per vertice right after LWO loading (lwo.AssertDistinctUVPerVertice)
    aLayerUvIndex := I;
    aModelUvIndex := UVNames.IndexOf(aLay.UVs[I].Name);
  end;
end;


procedure TLWModel.GetPolyUVIndex(aLay: PLWLayer; aPoly: Integer; const aSkip: string; out aLayerUvIndex, aModelUvIndex: Integer);
var
  I: Integer;
  vtx: Word;
begin
  aLayerUvIndex := -1;
  aModelUvIndex := -1;

  // Looking at first vertice is enough
  // since we don't expect polys to span across different UV maps
  vtx := aLay.Polys[aPoly].Indices[0];

  for I := 0 to aLay.UVCount - 1 do
  if (aLay.UVs[I].Name <> aSkip) and not aLay.UVs[I].UV[vtx].IsNaN then
  begin
    // It's safe to exit, since we've made sure there's no multiple UVs per vertice right after LWO loading (lwo.AssertDistinctUVPerVertice)
    aLayerUvIndex := I;
    aModelUvIndex := UVNames.IndexOf(aLay.UVs[I].Name);
  end;
end;


// Calculate normals automatically (properly handling smoothing and 3+ polys)
// Note: This inserts new vertices
procedure TLWModel.Post_CalculateNormals;
var
  I, K: Integer;
  J, H, L: Integer;
  lay: PLWLayer;
  norm: TKMVertex3;
  idVert: Word;
  polyNormals: array {poly} of TKMVertex3;
  polysInVertice: array {vertice} of array {poly} of Word;
  dotThreshold: Single;
begin
  for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];

    SetLength(lay.Normals, lay.VerticeCount);

    SetLength(polyNormals, 0);
    SetLength(polyNormals, lay.PolyCount);

    SetLength(polysInVertice, 0);
    SetLength(polysInVertice, lay.VerticeCount);

    // Build lookup of which polys vert uses
    for K := 0 to lay.PolyCount - 1 do
      for J := 0 to lay.Polys[K].VertCount - 1 do
      begin
        idVert := lay.Polys[K].Indices[J];
        SetLength(polysInVertice[idVert], Length(polysInVertice[idVert]) + 1);
        polysInVertice[idVert, High(polysInVertice[idVert])] := K;
      end;

    // Calculate polygons normals
    for K := 0 to lay.PolyCount - 1 do
    begin
      // Split to triangles and compute average polygon normal
      for J := 2 to lay.Polys[K].VertCount - 1 do
      begin
        norm := VectorCrossProduct(@lay.Vertices[lay.Polys[K].Indices[0]],
                                   @lay.Vertices[lay.Polys[K].Indices[J-1]],
                                   @lay.Vertices[lay.Polys[K].Indices[J]]);
        polyNormals[K] := polyNormals[K] + norm;
      end;

      polyNormals[K] := polyNormals[K].GetNormalize;
    end;

    // Assign polygon normals to vertices
    for K := 0 to lay.PolyCount - 1 do
    begin
      // Smoothing value this poly needs
      dotThreshold := Cos(Tags[lay.Polys[K].PolySurf].SmoothingDeg / 180 * Pi);


      for J := 0 to lay.Polys[K].VertCount - 1 do
      begin
        idVert := lay.Polys[K].Indices[J];

        norm := TKMVertex3.New(0, 0, 0);
        for H := 0 to High(polysInVertice[idVert]) do
          if (polysInVertice[idVert, H] = K)
          or (VectorDotProduct(polyNormals[polysInVertice[idVert, H]], polyNormals[K]) >= dotThreshold) then
            norm := norm + polyNormals[polysInVertice[idVert, H]];

        norm := norm.GetNormalize;

        if lay.Normals[idVert].GetLengthSqr = 0 then
          // First time this vertice is visited
          lay.Normals[idVert] := norm
        else
        if VectorDotProduct(lay.Normals[idVert], norm) > 0.999 then
          // Normals match, do nothing
        else
        begin
          // Duplicate vertex will be added to the end
          lay.VerticeDuplicate(idVert);
          lay.Normals[lay.VerticeCount - 1] := norm;

          // We have added a crease, this poly "K" is no longer using vertice "ind"
          lay.DUVUpdateVtx(K, idVert, lay.VerticeCount - 1);

          // Update poly
          lay.Polys[K].Indices[J] := lay.VerticeCount - 1;
        end;
      end;
    end;
  end;
end;


procedure TLWModel.Post_RegenerateUVs;
var
  I: Integer;
begin
  for I := 0 to LayerCount - 1 do
    Layers[I].Post_RegenerateUVs;
end;


//Separate surfaces from each other to avoid color bleeding between 2 surfs using single vertice
procedure TLWModel.Post_SeparateSurfaces;
{var
  I, K: Integer;
  J, H: Word;
  lay: PLWLayer;
  ind: Word;
  newVert: array of array of Word;
  vertPolys: array of array of Word;
  surf: Word;}
begin
  {for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];

    SetLength(newVert, 0);
    SetLength(newVert, SurfCount, lay.VerticeCount);
    for K := 0 to SurfCount - 1 do
      for J := 0 to lay.VerticeCount - 1 do
        newVert[K,J] := J;

    SetLength(vertPolys, 0);
    SetLength(vertPolys, lay.VerticeCount);

    //Build lookup of which polys vert uses
    for K := 0 to lay.PolyCount - 1 do
    begin
      for J := 0 to lay.Polys[K].VertCount - 1 do
      begin
        ind := lay.Polys[K].Indices[J];
        SetLength(vertPolys[ind], Length(vertPolys[ind]) + 1);
        vertPolys[ind, High(vertPolys[ind])] := K;
      end;
    end;

    //For all polys
    for K := 0 to lay.PolyCount - 1 do
    begin
      surf := lay.Polys[K].PolySurf;
      //For all poly verts
      for J := 0 to lay.Polys[K].VertCount - 1 do
      begin
        ind := lay.Polys[K].Indices[J];

        //Check all udjustent polys surfaces
        for H := 0 to High(vertPolys[ind]) do
        if (lay.Polys[vertPolys[ind, H]] <> surf) then
        begin
          //Replicate vertex
          SetLength(lay.Vertices, lay.VerticeCount + 1);
          SetLength(lay.Normals, lay.VerticeCount + 1);
          lay.Vertices[lay.VerticeCount] := lay.Vertices[ind];
          lay.Normals[lay.VerticeCount] := lay.Normals[ind];
                            ---
          //start using it
          lay.Polys[K].Indices[J] := lay.VerticeCount;

          //Save remap
          newVert[surf, ind] := lay.VerticeCount;

          Inc(lay.VerticeCount);
        end;
      end;
    end;
  end;}
end;


procedure TLWModel.Post_Triangulate;
var
  I, K: Integer;
  lay: PLWLayer;
  J, newPol: Integer;
begin
  for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];

    for K := lay.PolyCount - 1 downto 0 do
      // Naive triangulation
      for J := lay.Polys[K].VertCount - 1 downto 3 do
      begin
        // Append poly
        newPol := lay.PolyCount;
        Inc(lay.PolyCount);
        SetLength(lay.Polys, lay.PolyCount);

        // Copy poly properties
        lay.Polys[newPol].VertCount := 3;
        SetLength(lay.Polys[newPol].Indices, 3);
        lay.Polys[newPol].Indices[0] := lay.Polys[K].Indices[0];
        lay.Polys[newPol].Indices[1] := lay.Polys[K].Indices[lay.Polys[K].VertCount - 2];
        lay.Polys[newPol].Indices[2] := lay.Polys[K].Indices[lay.Polys[K].VertCount - 1];
        lay.Polys[newPol].PolySurf := lay.Polys[K].PolySurf;
        lay.Polys[newPol].PolyBone := lay.Polys[K].PolyBone;

        // Clip indice from original poly
        Dec(lay.Polys[K].VertCount);
        SetLength(lay.Polys[K].Indices, lay.Polys[K].VertCount);
      end;
  end;
end;


function TLWModel.LayerAdd: PLWLayer;
begin
  Inc(LayerCount);
  SetLength(Layers, LayerCount);
  Result := @Layers[LayerCount - 1];
end;


function TLWModel.TagAdd: PLWTag;
begin
  Inc(TagCount);
  SetLength(Tags, TagCount);
  Result := @Tags[TagCount - 1];
end;


function TLWModel.TagExists(const aName: string; aType: TLWTagType): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to TagCount - 1 do
  if (Tags[I].TagName = aName) and (Tags[I].TagType = aType) then
    Exit(True);
end;


procedure TLWModel.LoadFromFile(aFile: string);
var
  fs: TFileStream;
begin
  DbgLog('TLWModel.LoadFromFile ' + aFile);

  fs := TFileStream.Create(aFile, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(fs);
  finally
    fs.Free;
  end;
end;


procedure TLWModel.LoadFromStream(aStream: TStream);
var
  S: TSwappedStream;
  chunkHead: TChunkHead;
  chunkCurr: TChunkHead;
  mainSize: Cardinal;
  //I: Integer;
begin
  DbgLog('TLWModel.LoadFromStream');

  S := TSwappedStream.Create;
  S.LoadFromStream(aStream);
  S.Position := 0;
  S.ReadSwap(chunkHead.Title, 4);
  S.ReadSwap(chunkHead.Size, 4);
  Assert(chunkHead.TitleString = 'FORM', 'Wrong header. File is not Lightwave 7.0+ format');
  S.ReadSwap(chunkHead.Title, 4);
  Assert(chunkHead.TitleString = 'LWO2', 'Wrong header. File is not Lightwave 7.0+ format');

  mainSize := chunkHead.Size - 4;

  repeat
    S.ReadSwap(chunkCurr.Title, 4);
    S.ReadSwap(chunkCurr.Size, 4);
    Dec(mainSize, chunkCurr.Size + 8);

    //gLog.AddNoTime(chunkCurr.TitleString + ' read');

    if chunkCurr.Size <> 0 then

    if chunkCurr.TitleString = 'TAGS' then
      ReadChunkTAGS(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'LAYR' then
      ReadChunkLAYR(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'BBOX' then
      ReadChunkBBOX(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'PNTS' then
      ReadChunkPNTS(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'VMPA' then
      ReadChunkVMPA(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'VMAP' then
      ReadChunkVMAP(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'POLS' then
      ReadChunkPOLS(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'PTAG' then
      ReadChunkPTAG(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'VMAD' then
      ReadChunkVMAD(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'CLIP' then
      ReadChunkCLIP(S, chunkCurr.Size)
    else
    if chunkCurr.TitleString = 'SURF' then
      ReadChunkSURF(S, chunkCurr.Size)
    else
    begin
      DbgLog(chunkCurr.TitleString + ' skipped ' + IntToStr(chunkCurr.Size));
      S.Position := S.Position + chunkCurr.Size;
    end;
  until (mainSize <= 0);

  //for I := 0 to TagCount - 1 do
  //  DbgLog(TAG_TYPE_NAME[Tags[I].TagType] + '. "' + Tags[I].TagName + '"');

  Assert(mainSize = 0, 'Uknown error happened while processing LWO file');

  S.Free;

  AfterLoad;
end;


procedure TLWModel.SaveToFile(aFile: string);
var
  fs: TFileStream;
begin
  DbgLog('TLWModel.SaveToFile ' + aFile);

  fs := TFileStream.Create(aFile, fmCreate or fmOpenWrite or fmShareDenyNone);
  try
    SaveToStream(fs);
  finally
    fs.Free;
  end;
end;


procedure TLWModel.SaveToStream(aStream: TStream);
var
  sLwo2, sFile: TSwappedStream;
  I: Integer;
begin
  //todo -cThink: LWO. resave concerns
  // - Surface smoothing gets applied
  //   [that's acceptable. Set new surfaces to be 179deg smooth]
  // - UVs get split
  //   [can be merged back if normals match]
  // - Surfaces get separated
  //   [vertices can be merged back if normals match]
  // - Polys get triangulated
  //   [merging back works good]
  // - Models loose layers info
  //   []

  DbgLog('TLWModel.SaveToStream');

  sFile := TSwappedStream.Create;
  sLwo2 := TSwappedStream.Create;
  try
    sLwo2.Write('LWO2');
    WriteChunkTAGS(sLwo2);
    for I := 0 to LayerCount - 1 do
    begin
      fCurrLayer := I;
      WriteChunkLAYR(sLwo2);
      WriteChunkPNTS(sLwo2);
      WriteChunkBBOX(sLwo2);
      WriteChunkVMAP(sLwo2);
      WriteChunkPOLS(sLwo2);
      WriteChunkPTAG(sLwo2);
    end;

    WriteChunkCLIP(sLwo2);
    WriteChunkSURF(sLwo2);

    // Write everything as one giant chunk
    sFile.WriteChunk4('FORM', sLwo2);

    sFile.SaveToStream(aStream);
  finally
    sLwo2.Free;
    sFile.Free;
  end;
end;


procedure TLWModel.AfterLoad;
var
  I, K: Integer;
  lay: PLWLayer;
begin
  // Make up a list of surfaces in Alphabetical order (for all layers)
  for I := 0 to TagCount - 1 do
  if Tags[I].TagType = ttSurf then
    Surfaces.Append(Tags[I].TagName);
  Surfaces.Sort;

  UVNames.Clear;
  for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];
    for K := 0 to lay.UVCount - 1 do
      if UVNames.IndexOf(lay.UVs[K].Name) = -1 then
        UVNames.Append(lay.UVs[K].Name);
  end;
end;


// Default preparations
procedure TLWModel.PostProcess(aSteps: TLWOPostProcessSet);
begin
  // Order of operations is important (because of additional vertice duplication on each step)

  if ppCalcNormals in aSteps then
    Post_CalculateNormals;

  // Split vertices for discontinuous UVs
  if ppFixUVs in aSteps then
    Post_RegenerateUVs;

  // Split vertices for adjacent surfaces
  if ppSeparateSurfaces in aSteps then
    Post_SeparateSurfaces;

  // Triangulate final result
  if ppTriangulate in aSteps then
    Post_Triangulate;
end;


procedure TLWModel.PrepareToSave;
begin
  Proc_MergeVertices;
  Proc_MergePolys(0.95);

  // Merging won't cause any more polys to adjoin,
  // cos there are no quad polys split into triangles with different UVs
  Proc_MergeVerticesUV;
end;


procedure TLWModel.Proc_MergeVertices;
var
  I, K, J: Integer;
  lay: PLWLayer;
  remap: TArray<Word>;
begin
  DbgLog('Proc_MergeVertices');
  DbgLog(Format('  Vertices - %d', [GetVerticeCount]));

  for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];

    SetLength(remap, lay.VerticeCount);
    for K := 0 to lay.VerticeCount - 1 do
      remap[K] := K;

    // Find all duplicate vertices and write down remap
    for K := 0 to lay.VerticeCount - 1 do
      if remap[K] = K then // Skip already remapped ones
        for J := K + 1 to lay.VerticeCount - 1 do
          if remap[J] = J then // Skip already remapped ones
            if lay.VerticesMatch(J, K) then
            begin
              remap[J] := K;
              //DbgLog(Format('Layer %d. Vertice %d = %d', [I, K, J]));
            end;

    // Compact and update remap
    J := 0;
    for K := 0 to lay.VerticeCount - 1 do
    begin
      if remap[K] = K then
      // Using self (shift up)
      begin
        lay.VerticeMove(K, J);
        remap[K] := J;
        Inc(J);
      end else
        // Using remap (shift up)
        remap[K] := remap[remap[K]];
    end;

    // Trim
    lay.SetVerticeCount(J);

    for K := 0 to lay.PolyCount - 1 do
      for J := 0 to lay.Polys[K].VertCount - 1 do
        lay.Polys[K].Indices[J] := remap[lay.Polys[K].Indices[J]];
  end;

  DbgLog(Format('  Vertices after - %d', [GetVerticeCount]));
end;


procedure TLWModel.Proc_MergeVerticesUV;
begin
  //DbgLog('Proc_MergeVerticesUV');
  //DbgLog(Format('  Vertices - %d', [GetVerticeCount]));

  //todo -cPractical: Proc_MergeVerticesUV

  //DbgLog(Format('  Vertices after - %d', [GetVerticeCount]));
end;


procedure TLWModel.Proc_MergePolys(aFlattnessThreshold: Single);
var
  I, K, J: Integer;
  lay: PLWLayer;
  aVertA, aVertB, aVertC: TKMVertex3;
  aLenAB, aLenBC, aLenCA: Single;
  bVertA, bVertB, bVertC: TKMVertex3;
  bLenAB, bLenBC, bLenCA: Single;
  pair: TIntPair;
  adjacentSide: Integer;
  match: Boolean;
  an, bn: TKMVertex3;
  flattness: Single;
  adjacentPoly: Integer;
begin
  DbgLog(Format('Proc_MergePolys %.2f', [aFlattnessThreshold]));
  DbgLog(Format('  Polys - %d', [GetPolyCount]));

  for I := 0 to LayerCount - 1 do
  begin
    lay := @Layers[I];

    for K := 0 to lay.PolyCount - 1 do
    begin
      // Skip non-triangles
      if lay.Polys[K].VertCount <> 3 then Continue;

      // Find longer side
      aVertA := lay.Vertices[lay.Polys[K].Indices[0]];
      aVertB := lay.Vertices[lay.Polys[K].Indices[1]];
      aVertC := lay.Vertices[lay.Polys[K].Indices[2]];

      aLenAB := (aVertA - aVertB).GetLengthSqr;
      aLenBC := (aVertB - aVertC).GetLengthSqr;
      aLenCA := (aVertC - aVertA).GetLengthSqr;

      if (aLenAB >= aLenBC) and (aLenAB >= aLenCA) then
        pair := TIntPair.New(lay.Polys[K].Indices[0], lay.Polys[K].Indices[1])
      else
      if (aLenBC >= aLenAB) and (aLenBC >= aLenCA) then
        pair := TIntPair.New(lay.Polys[K].Indices[1], lay.Polys[K].Indices[2])
      else
      if (aLenCA >= aLenAB) and (aLenCA >= aLenBC) then
        pair := TIntPair.New(lay.Polys[K].Indices[2], lay.Polys[K].Indices[0])
      else
        raise Exception.Create('Cant find longest side');

      adjacentPoly := -1;

      // Find polys using this side
      for J := K + 1 to lay.PolyCount - 1 do
      if (lay.Polys[J].VertCount = 3)
      and (lay.Polys[J].PolySurf = lay.Polys[K].PolySurf)
      and (lay.Polys[J].PolyBone = lay.Polys[K].PolyBone) then
      begin
        adjacentSide := -1;

        // We know that adjacent polys will have same winding direction (and inverted indice order)
        if (pair.A = lay.Polys[J].Indices[1]) and (pair.B = lay.Polys[J].Indices[0]) then
          adjacentSide := 0;
        if (pair.A = lay.Polys[J].Indices[2]) and (pair.B = lay.Polys[J].Indices[1]) then
          adjacentSide := 1;
        if (pair.A = lay.Polys[J].Indices[0]) and (pair.B = lay.Polys[J].Indices[2]) then
          adjacentSide := 2;

        if adjacentSide = -1 then Continue;

        // Check that this side is longer for them too
        bVertA := lay.Vertices[lay.Polys[J].Indices[0]];
        bVertB := lay.Vertices[lay.Polys[J].Indices[1]];
        bVertC := lay.Vertices[lay.Polys[J].Indices[2]];

        bLenAB := (bVertA - bVertB).GetLengthSqr;
        bLenBC := (bVertB - bVertC).GetLengthSqr;
        bLenCA := (bVertC - bVertA).GetLengthSqr;

        match := (adjacentSide = 0) and (bLenAB >= bLenBC) and (bLenAB >= bLenCA)
              or (adjacentSide = 1) and (bLenBC >= bLenAB) and (bLenBC >= bLenCA)
              or (adjacentSide = 2) and (bLenCA >= bLenAB) and (bLenCA >= bLenBC);

        if not match then Continue;

        // Check that polys form a flat surface
        an := VectorCrossProduct(@aVertA, @aVertB, @aVertC).GetNormalize;
        bn := VectorCrossProduct(@bVertA, @bVertB, @bVertC).GetNormalize;

        flattness := VectorDotProduct(an, bn);
        if flattness < aFlattnessThreshold then Continue;

        // We also know that there will be only one adjacent poly
        adjacentPoly := J;
        Break;
      end;

      // Merge
      if adjacentPoly <> -1 then
        lay.PolyMerge(K, adjacentPoly);
    end;

    // Compact and remap
    J := 0;
    for K := 0 to lay.PolyCount - 1 do
      if lay.Polys[K].VertCount <> 0 then
      // Shift up
      begin
        if J <> K then
          lay.PolyMove(K, J);
        Inc(J);
      end;

    // Trim
    lay.SetPolyCount(J);
  end;

  DbgLog(Format('  Polys after - %d', [GetPolyCount]));
end;


end.
