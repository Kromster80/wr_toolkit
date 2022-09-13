unit MTkit2_MOX;
interface
uses
  Math, SysUtils, Windows,
  MTkit2_Vertex;

type
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
    BlinkerType: Integer;     // 4b Type of object
    sMin, sMax, Freq: Single; // Min, Max
    B,G,R,A: Byte;            // 20
    Unused, Parent: SmallInt; // 24
    Matrix: TMatrix;          // 88
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
    Header1: record Fmt: AnsiString; A, B, C, D: Byte; end;
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

    function MOXFormatInt: string;
    function MOXFormatStr: string;
  end;

  procedure LoadMOX(const aFilename: string);

var
  MOX: TMOX;

implementation


function TMOX.MOXFormatInt: string;
begin
  Result := Format('%d%d%d%d', [Header1.A, Header1.B, Header1.C, Header1.D]);
end;


function TMOX.MOXFormatStr: string;
begin
  if (Header1.B = 0) and (Header1.C = 2) and (Header1.D = 2) then
    Result := 'WR22' //32bit chunks, parts, blinkers
  else
  if (Header1.B = 0) and (Header1.C = 0) and (Header1.D = 2) then
    Result := 'WR02' //32bit chunks
  else
  if (Header1.B = 0) and (Header1.C = 1) and (Header1.D = 0) then
    Result := 'MBWR' //16bit chunks
  else
    Result := 'Unknown';
end;


procedure LoadMOX(const aFilename: string);
var
  c4: array [1..4] of AnsiChar;
  cChunk12: array [1..12] of AnsiChar;
  cChunk24: array [1..24] of AnsiChar;
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

    if MOX.MOXFormatStr = 'Unknown' then
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

    if MOX.MOXFormatStr = 'MBWR'{0010} then
    for j:=1 to MOX.Header.ChunkCount do
    begin
      blockread(f, cChunk12, 12);
      MOX.Chunks[j].SidA := ord(cChunk12[1]) + ord(cChunk12[2]) * 256;
      MOX.Chunks[j].SidB := ord(cChunk12[3]) + ord(cChunk12[4]) * 256;
      MOX.Chunks[j].FirstPoly := ord(cChunk12[5]) + ord(cChunk12[6]) * 256;
      MOX.Chunks[j].PolyCount := ord(cChunk12[7]) + ord(cChunk12[8]) * 256;
      MOX.Chunks[j].FirstVtx := ord(cChunk12[9]) + ord(cChunk12[10]) * 256 + 1;
      MOX.Chunks[j].LastVtx := ord(cChunk12[11]) + ord(cChunk12[12]) * 256 + 1;
    end;

    if (MOX.MOXFormatStr = 'WR22') or (MOX.MOXFormatStr = 'WR02'){0002, 0022} then
    for j:=1 to MOX.Header.ChunkCount do
    begin
      blockread(f, cChunk24, 24);
      MOX.Chunks[j].SidA := ord(cChunk24[1]) + ord(cChunk24[2]) * 256;
      MOX.Chunks[j].SidB := ord(cChunk24[5]) + ord(cChunk24[6]) * 256;
      MOX.Chunks[j].FirstPoly := ord(cChunk24[9]) + ord(cChunk24[10]) * 256;
      MOX.Chunks[j].PolyCount := ord(cChunk24[13]) + ord(cChunk24[14]) * 256;
      MOX.Chunks[j].FirstVtx := ord(cChunk24[17]) + ord(cChunk24[18]) * 256 + 1;
      MOX.Chunks[j].LastVtx := ord(cChunk24[21]) + ord(cChunk24[22]) * 256 + 1;
    end;

    // Verify faces
    for I := 1 to MOX.Header.PolyCount do
    begin
      Assert(MOX.Face[I,1] <= MOX.Header.VerticeCount);
      Assert(MOX.Face[I,2] <= MOX.Header.VerticeCount);
      Assert(MOX.Face[I,3] <= MOX.Header.VerticeCount);
    end;

    // Verify vertex ranges
    Assert(MOX.Chunks[1].FirstVtx = 1);
    for j:=2 to MOX.Header.ChunkCount do
      Assert(MOX.Chunks[j].FirstVtx = MOX.Chunks[j-1].LastVtx + 1);
    Assert(MOX.Chunks[MOX.Header.ChunkCount].LastVtx = MOX.Header.VerticeCount);

    // Verify poly ranges
    Assert(MOX.Chunks[1].FirstPoly = 0);
    for j:=2 to MOX.Header.ChunkCount do
      Assert(MOX.Chunks[j].FirstPoly = MOX.Chunks[j-1].FirstPoly + MOX.Chunks[j-1].PolyCount);
    Assert(MOX.Chunks[MOX.Header.ChunkCount].FirstPoly + MOX.Chunks[MOX.Header.ChunkCount].PolyCount = MOX.Header.PolyCount);

    blockread(f, MOX.MoxMat, (80+256)*MOX.Header.MatCount);   //Crap&Mess

    if MOX.MOXFormatStr = 'WR22' then
      for j:=1 to MOX.Header.PartCount do
      begin
        blockread(f, cPart64, 64);
        MOX.Parts[j].Dname := PAnsiChar(@cPart64[1]);
        blockread(f, MOX.Parts[j].Matrix, 132);
      end;

    // Verify damage parts
    for j:=1 to MOX.Header.PartCount do
      Assert(MOX.Parts[j].TypeID in [0..6]);

    if (MOX.MOXFormatStr = 'MBWR') or (MOX.MOXFormatStr = 'WR02') then
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

    // Verify blinkers
    for j:=1 to MOX.Header.BlinkerCount do
      Assert(MOX.Blinkers[j].BlinkerType in [0..9,16,20,24,33]);

    if MOX.MOXFormatStr = 'WR22' then
      blockread(f, MOX.Blinkers, 88*MOX.Header.BlinkerCount);
  finally
    closefile(f);
  end;
end;


end.
