unit MTkit2_MOX;
interface
uses
  Math, SysUtils, Windows,
  MTkit2_Vertex;

type
  EExceptionTooNew = class(Exception);

  TMOXFormat = (mfUnknown, mf10MBWR, mf02WR2, mf22WR2);

  TMOXVertice = packed record
    X, Y, Z: Single;
    nX, nY, nZ: Single;
    U, V: Single;
    x1, x2: Single;
  end;

  TMOXPart = packed record
    Dname: string[64];
    Matrix: TMatrix;
    Parent, Child, PrevInLevel, NextInLevel: SmallInt;
    FirstMat, NumMat: Word;
    xMid, yMid, zMid, fRadius: Single;
    w1, w2, w3: SmallInt;
    TypeID: SmallInt;
    x1, x2, y1, y2, z1, z2: Single;
    w4, w5: Integer;
  end;

  TMOXBlinker = packed record
    BlinkerType: Integer;     // 4b Type of object (0..9,16,17,20,24,28,32,33,34,255)
    sMin, sMax, Freq: Single; // Min, Max
    B,G,R,A: Byte;            // 20
    Unused, Parent: SmallInt; // 24
    Matrix: TMatrix;          // 88
  end;

  TMOXChunk16 = packed record
    SidA, SidB, FirstPoly, PolyCount, FirstVtx, LastVtx: Word;
  end;

  TMOXChunk32 = packed record
    SidA, SidB, FirstPoly, PolyCount, FirstVtx, LastVtx: Cardinal;
  end;

  TMOXChunk = packed record
    SidA, SidB, FirstPoly, PolyCount, FirstVtx, LastVtx: Integer;
  end;

const
  MAX_MOX_VTX = 256000;
  MAX_MOX_IDX = 256000;

  MAX_BLINKERS = 128;
  MAX_PARTS = 255;
  MAX_MATERIALS = 1024;

type
  TMOX = record
    Header1: record
      Fmt: AnsiString;
      A: Byte; // 0 - 16bit indices, 1 - 32bit indices, 2 - 32bit indices + tangents
      B: Byte; // Always 0
      C, D: Byte;
    end;
    Header: record VerticeCount, PolyCount, ChunkCount, MatCount, PartCount, BlinkerCount: Integer; end;
    Vertice: array [1..MAX_MOX_VTX] of TMOXVertice;
    Face: array [1..MAX_MOX_IDX,1..3] of Integer;  // Polygon links
    Chunks: array of TMOXChunk;
    MoxMat: array [1..MAX_MATERIALS] of record
      ID: Integer;
      xxx: array [1..332] of AnsiChar;
    end;
    Parts: array [1..MAX_PARTS] of TMOXPart;
    Blinkers: array [1..MAX_BLINKERS] of TMOXBlinker;

    function MOXFormat: TMOXFormat;
    function MOXFormatInt: string;
    function MOXFormatStr: string;
  end;

  procedure LoadMOX(const aFilename: string);

var
  MOX: TMOX;

implementation


function TMOX.MOXFormat: TMOXFormat;
begin
  if (Header1.C = 2) and (Header1.D = 2) then
    Result := mf22WR2 //32bit chunks, parts, blinkers
  else
  if (Header1.C = 0) and (Header1.D = 2) then
    Result := mf02WR2 //32bit chunks
  else
  if (Header1.C = 1) and (Header1.D = 0) then
    Result := mf10MBWR //16bit chunks
  else
    Result := mfUnknown;
end;


function TMOX.MOXFormatInt: string;
begin
  Result := Format('%d%d%d%d', [Header1.A, Header1.B, Header1.C, Header1.D]);
end;


function TMOX.MOXFormatStr: string;
const
  S: array [TMOXFormat] of string = ('Unknown', 'MBWR', 'WR02', 'WR22');
begin
  Result := S[MOXFormat];
end;


procedure LoadMOX(const aFilename: string);
var
  c4: array [1..4] of AnsiChar;
  chunk16: TMOXChunk16;
  chunk32: TMOXChunk32;
  cPart64: array [1..64] of AnsiChar;
  i,j: Integer;
  f: file;
  face6: array [1..3] of Word;
  face12: array [1..3] of Cardinal;
begin
  assignfile(f,aFilename); FileMode:=0; reset(f,1); FileMode:=2;
  try
    FillChar(MOX, SizeOf(MOX), #0);

    blockread(f,c4,4);
    MOX.Header1.Fmt := c4[1]+c4[2]+c4[3]+c4[4];
    if MOX.Header1.Fmt <> ('!XOM') then
      raise Exception.Create('Unsupported MOX format - ' + MOX.Header1.Fmt);

    blockread(f, MOX.Header1.A, 4);

    Assert(mox.Header1.B = 0);

    if MOX.Header1.A > 1 then
      raise EExceptionTooNew.Create('Unsupported MOX version - ' + MOX.MOXFormatInt);
    if MOX.Header1.C > 2 then
      raise EExceptionTooNew.Create('Unsupported MOX version - ' + MOX.MOXFormatInt);

    if MOX.MOXFormat = mfUnknown then
      raise Exception.Create('Unknown MOX version - ' + MOX.MOXFormatInt);

    blockread(f, MOX.Header, 24);

    blockread(f, MOX.Vertice, MOX.Header.VerticeCount*40);

    // Faces
    for i:=1 to MOX.Header.PolyCount do
    if MOX.Header1.A = 1 then
    begin
      blockread(f, face12, 12);
      MOX.Face[i, 1] := face12[1] + 1;
      MOX.Face[i, 2] := face12[2] + 1;
      MOX.Face[i, 3] := face12[3] + 1
    end else
    begin
      blockread(f, face6, 6);
      MOX.Face[i, 1] := face6[1] + 1;
      MOX.Face[i, 2] := face6[2] + 1;
      MOX.Face[i, 3] := face6[3] + 1
    end;

    SetLength(MOX.Chunks, MOX.Header.ChunkCount + 1);

    if MOX.MOXFormat = mf10MBWR then
    for j:=1 to MOX.Header.ChunkCount do
    begin
      blockread(f, chunk16, 12);
      MOX.Chunks[j].SidA := chunk16.SidA;
      MOX.Chunks[j].SidB := chunk16.SidB;
      MOX.Chunks[j].FirstPoly := chunk16.FirstPoly;
      MOX.Chunks[j].PolyCount := chunk16.PolyCount;
      MOX.Chunks[j].FirstVtx := chunk16.FirstVtx + 1;
      MOX.Chunks[j].LastVtx := chunk16.LastVtx + 1;
    end;

    if MOX.MOXFormat in [mf02WR2, mf22WR2] then
    for j:=1 to MOX.Header.ChunkCount do
    begin
      blockread(f, chunk32, 24);
      MOX.Chunks[j].SidA := chunk32.SidA;
      MOX.Chunks[j].SidB := chunk32.SidB;
      MOX.Chunks[j].FirstPoly := chunk32.FirstPoly;
      MOX.Chunks[j].PolyCount := chunk32.PolyCount;
      MOX.Chunks[j].FirstVtx := chunk32.FirstVtx + 1;
      MOX.Chunks[j].LastVtx := chunk32.LastVtx + 1;
    end;

    // Verify faces
    for I := 1 to MOX.Header.PolyCount do
    begin
      Assert(MOX.Face[I,1] <= MOX.Header.VerticeCount);
      Assert(MOX.Face[I,2] <= MOX.Header.VerticeCount);
      Assert(MOX.Face[I,3] <= MOX.Header.VerticeCount);
    end;

    // Verify vertex ranges
    // Some models can be empty - 0 vertices, 0 polys, etc. They are still "valid"
    if MOX.Header.ChunkCount > 0 then
      Assert(MOX.Chunks[1].FirstVtx = 1);
    // This is actually violated in some Synetic models
    {for j:=2 to MOX.Header.ChunkCount do
      if MOX.Chunks[j].FirstVtx <> MOX.Chunks[j-1].LastVtx + 1 then
        Assert(False);}
    // This is actually violated in some Synetic models
    //Assert(MOX.Chunks[MOX.Header.ChunkCount].LastVtx = MOX.Header.VerticeCount);

    // Verify poly ranges
    if MOX.Header.ChunkCount > 0 then
      Assert(MOX.Chunks[1].FirstPoly = 0);
    for j:=2 to MOX.Header.ChunkCount do
      Assert(MOX.Chunks[j].FirstPoly = MOX.Chunks[j-1].FirstPoly + MOX.Chunks[j-1].PolyCount);
    //Assert(MOX.Chunks[MOX.Header.ChunkCount].FirstPoly + MOX.Chunks[MOX.Header.ChunkCount].PolyCount = MOX.Header.PolyCount);

    blockread(f, MOX.MoxMat, (80+256)*MOX.Header.MatCount);   //Crap&Mess

    if MOX.MOXFormat = mf22WR2 then
      for j:=1 to MOX.Header.PartCount do
      begin
        blockread(f, cPart64, 64);
        MOX.Parts[j].Dname := PAnsiChar(@cPart64[1]);
        blockread(f, MOX.Parts[j].Matrix, 132);
      end;

    // Verify damage parts
    for j:=1 to MOX.Header.PartCount do
      Assert(MOX.Parts[j].TypeID in [0..6]);

    // Add fake damage part
    if MOX.MOXFormat in [mf10MBWR, mf02WR2] then
    begin
      MOX.Header.PartCount := 1;

      FillChar(MOX.Parts[1], SizeOf(MOX.Parts[1]), #0);
      MOX.Parts[1].Dname := 'Default';
      MOX.Parts[1].Matrix[1, 1] := 1;
      MOX.Parts[1].Matrix[2, 2] := 1;
      MOX.Parts[1].Matrix[3, 3] := 1;
      MOX.Parts[1].Matrix[4, 4] := 1;
      MOX.Parts[1].Parent := -1;
      MOX.Parts[1].Child := -1;
      MOX.Parts[1].PrevInLevel := -1;
      MOX.Parts[1].NextInLevel := -1;
      MOX.Parts[1].FirstMat := 0;
      MOX.Parts[1].NumMat := MOX.header.MatCount;
      MOX.Parts[1].fRadius := 10;
    end;

    if MOX.Header.BlinkerCount > MAX_BLINKERS then
    begin
      MOX.Header.BlinkerCount := MAX_BLINKERS;
      MessageBox(0, PChar('Blinker quantity limited to ' + IntToStr(MAX_BLINKERS)
        + ' due to compatibility issues.'), 'Warning', MB_OK or MB_ICONWARNING);
    end;

    if MOX.MOXFormat = mf22WR2 then
      blockread(f, MOX.Blinkers, 88*MOX.Header.BlinkerCount);

    // Verify blinkers
    for j:=1 to MOX.Header.BlinkerCount do
      Assert(MOX.Blinkers[j].BlinkerType in [0..9,16,17,20,24,28,32,33,34,255], Format('Unsupported blinker type %d', [MOX.Blinkers[j].BlinkerType]));
  finally
    closefile(f);
  end;
end;


end.
