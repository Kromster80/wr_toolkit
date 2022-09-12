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
  MAX_MOX_VTX = 131072;
  MAX_MOX_IDX = 131072;

  MAX_BLINKERS = 128;
  MAX_PARTS = 255;
  MAX_MATERIALS = 1024;

type
  TMOX = record
    Header1: record Fmt: AnsiString; A, B, C, D: Byte; end;
    Header: record VerticeCount, PolyCount, ChunkCount, MatCount, PartCount, BlinkerCount: Integer; end;
    Vertice: array [1..MAX_MOX_VTX] of TMOXVertice;
    Face: array [1..MAX_MOX_IDX,1..3] of Word;  // Polygon links
    Chunk: array [1..2048, 1..4] of Word;  // Surface ranges (points/polys) 40 parts * 40 materials
    Sid: array [1..2048, 1..2] of Word;
    MoxMat: array [1..MAX_MATERIALS] of record
      ID: Integer;
      xxx: array [1..332] of AnsiChar;
    end;
    Parts: array [1..MAX_PARTS] of TMOXPart;
    Blinkers: array [1..MAX_BLINKERS] of TMOXBlinker;

    function MOXFormat: string;
  end;

  procedure LoadMOX(const aFilename: string);

var
  MOX: TMOX;

implementation


function TMOX.MOXFormat: string;
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
  c: array [1..262144] of AnsiChar;
  h,i,j,k: Integer;
  f: file;
  vv: array [1..65280,1..3] of longWord;
begin
  assignfile(f,aFilename); FileMode:=0; reset(f,1); FileMode:=2;

  FillChar(MOX,SizeOf(MOX),#0);

  blockread(f,c,4);
  MOX.Header1.Fmt := c[1]+c[2]+c[3]+c[4];
  if MOX.Header1.Fmt <> ('!XOM') then
  begin
    MessageBox(0, PChar('Unknown format - '+c[1]+c[2]+c[3]+c[4]), 'Error', MB_OK or MB_ICONERROR);
    closefile(f);
    Exit;
  end;

  blockread(f, MOX.Header1.A, 4);

  if MOX.MOXFormat = 'Unknown' then
  begin
    MessageBox(0, PChar('Unknown version - '+IntToStr(ord(c[1]))+IntToStr(ord(c[2]))+IntToStr(ord(c[3])) + IntToStr(ord(c[4]))), 'Error', MB_OK or MB_ICONERROR);
    closefile(f);
    Exit;
  end;

  blockread(f, MOX.Header, 24);

  blockread(f, MOX.Vertice, MOX.Header.VerticeCount*40);

  // Faces
  for i:=1 to MOX.Header.PolyCount do
  if MOX.Header1.A = 1 then
  begin
    blockread(f, vv[i], 12);
    MOX.Face[i, 1] := vv[i, 1] + 1;
    MOX.Face[i, 2] := vv[i, 2] + 1;
    MOX.Face[i, 3] := vv[i, 3] + 1
  end else
  begin
    blockread(f, MOX.Face[i], 6);
    inc(MOX.Face[i,1],1);
    inc(MOX.Face[i,2],1);
    inc(MOX.Face[i,3],1);
  end;

  if MOX.MOXFormat = 'MBWR' then
  for j:=1 to MOX.Header.ChunkCount do
  begin
    blockread(f,c,12);
    MOX.Sid[j,1]:=ord(c[1])+ord(c[2])*256;
    MOX.Sid[j,2]:=ord(c[3])+ord(c[4])*256;
    MOX.Chunk[j,1]:=ord(c[5])+ord(c[6])*256; //first Poly
    MOX.Chunk[j,2]:=ord(c[7])+ord(c[8])*256; //number Polys
    MOX.Chunk[j,3]:=ord(c[9])+ord(c[10])*256+1; //point From
    MOX.Chunk[j,4]:=ord(c[11])+ord(c[12])*256+1; //point Till
  end;

  if (MOX.MOXFormat = 'WR22') or (MOX.MOXFormat = 'WR02') then
  for j:=1 to MOX.Header.ChunkCount do
  begin
    blockread(f,c,24);
    MOX.Sid[j,1]:=ord(c[1])+ord(c[2])*256;
    MOX.Sid[j,2]:=ord(c[5])+ord(c[6])*256;
    MOX.Chunk[j,1]:=ord(c[9])+ord(c[10])*256; //first Poly
    MOX.Chunk[j,2]:=ord(c[13])+ord(c[14])*256; //number Polys
    MOX.Chunk[j,3]:=ord(c[17])+ord(c[18])*256+1; //point From
    MOX.Chunk[j,4]:=ord(c[21])+ord(c[22])*256+1; //point Till
  end;

  blockread(f,MOX.MoxMat,(80+256)*MOX.Header.MatCount);   //Crap&Mess

  if MOX.MOXFormat = 'WR22' then
    for j:=1 to MOX.Header.PartCount do
    begin
      blockread(f,c,64);
      MOX.Parts[j].Dname:=PAnsiChar(@c[1]);
      blockread(f,MOX.Parts[j].Matrix,132);
    end;

  if (MOX.MOXFormat = 'MBWR') or (MOX.MOXFormat = 'WR02') then
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

  if MOX.MOXFormat = 'WR22' then
    blockread(f, MOX.Blinkers, 88*MOX.Header.BlinkerCount);

  closefile(f);
end;


end.
