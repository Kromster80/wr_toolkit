unit MTkit2_MOX;
interface
uses
  SysUtils, Windows,
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
    Chunk: array [1..2048, 1..4] of Word;  // Surface ranges (points/polys) 40 parts * 40 materials
    Sid: array [1..2048, 1..2] of Word;
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

  FillChar(MOX, SizeOf(MOX), #0);

  blockread(f,c4,4);
  MOX.Header1.Fmt := c4[1]+c4[2]+c4[3]+c4[4];
  if MOX.Header1.Fmt <> ('!XOM') then
  begin
    MessageBox(0, PChar(MOX.Header1.Fmt), 'Error', MB_OK or MB_ICONERROR);
    closefile(f);
    Exit;
  end;

  blockread(f, MOX.Header1.A, 4);

  if MOX.MOXFormatStr = 'Unknown' then
  begin
    MessageBox(0, PChar('Unknown version - ' + MOX.MOXFormatInt), 'Error', MB_OK or MB_ICONERROR);
    closefile(f);
    Exit;
  end;

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

  if MOX.MOXFormatStr = 'MBWR'{0010} then
  for j:=1 to MOX.Header.ChunkCount do
  begin
    blockread(f, cChunk12, 12);
    MOX.Sid[j,1]:=ord(cChunk12[1])+ord(cChunk12[2])*256;
    MOX.Sid[j,2]:=ord(cChunk12[3])+ord(cChunk12[4])*256;
    MOX.Chunk[j,1]:=ord(cChunk12[5])+ord(cChunk12[6])*256; //first Poly
    MOX.Chunk[j,2]:=ord(cChunk12[7])+ord(cChunk12[8])*256; //number Polys
    MOX.Chunk[j,3]:=ord(cChunk12[9])+ord(cChunk12[10])*256+1; //point From
    MOX.Chunk[j,4]:=ord(cChunk12[11])+ord(cChunk12[12])*256+1; //point Till
  end;

  if (MOX.MOXFormatStr = 'WR22') or (MOX.MOXFormatStr = 'WR02'){0002, 0022} then
  for j:=1 to MOX.Header.ChunkCount do
  begin
    blockread(f, cChunk24, 24);
    MOX.Sid[j,1]:=ord(cChunk24[1])+ord(cChunk24[2])*256;
    MOX.Sid[j,2]:=ord(cChunk24[5])+ord(cChunk24[6])*256;
    MOX.Chunk[j,1]:=ord(cChunk24[9])+ord(cChunk24[10])*256; //first Poly
    MOX.Chunk[j,2]:=ord(cChunk24[13])+ord(cChunk24[14])*256; //number Polys
    MOX.Chunk[j,3]:=ord(cChunk24[17])+ord(cChunk24[18])*256+1; //point From
    MOX.Chunk[j,4]:=ord(cChunk24[21])+ord(cChunk24[22])*256+1; //point Till
  end;

  blockread(f, MOX.MoxMat, (80+256)*MOX.Header.MatCount);   //Crap&Mess

  if MOX.MOXFormatStr = 'WR22' then
    for j:=1 to MOX.Header.PartCount do
    begin
      blockread(f,cPart64,64);
      MOX.Parts[j].Dname:=PAnsiChar(@cPart64[1]);
      blockread(f,MOX.Parts[j].Matrix,132);
    end;

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

  if MOX.MOXFormatStr = 'WR22' then
    blockread(f, MOX.Blinkers, 88*MOX.Header.BlinkerCount);

  closefile(f);
end;


end.
