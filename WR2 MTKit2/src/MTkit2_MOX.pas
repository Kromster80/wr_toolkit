unit MTkit2_MOX;
interface
uses
  Math, SysUtils, Windows,
  MTkit2_Vertex, KM_Vertexes;

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
    Matrix: TMatrix4;
    Parent, Child, PrevInLevel, NextInLevel: SmallInt;
    FirstMat, NumMat: Word;
    xMid, yMid, zMid, fRadius: Single;
    w1, w2, w3: SmallInt;
    TypeID: SmallInt;
    x1, x2, y1, y2, z1, z2: Single;
    w4, w5: Integer;
  end;

  TMOXBlinker = packed record
  public
    BlinkerType: Integer;     // 4b Type of object (0..9,16,17,20,24,28,32,33,34,255)
    sMin, sMax, Freq: Single; // Min, Max
    B,G,R,A: Byte;            // 20
    Unused, Parent: SmallInt; // 24
    Matrix: TMatrix4;          // 88

    function GetStr: string;
  end;

const
  BLINKER_TYPE_SHORTNAME: array [0..34] of string = (
    'null','EF','HL','BL','RL','LB',
    'RB','SG','SL','FL','??',
    '??','??','??','??','??',
    'ML','??','??','??','WP',
    '??','??','??','TP','??',
    '??','??','??','??','??',
    '??','??','NF','??');

type
  TMOXChunk16 = packed record
    SidA, SidB, FirstPoly, PolyCount, FirstVtx, LastVtx: Word;
  end;

  TMOXChunk32 = packed record
    SidA, SidB, FirstPoly, PolyCount, FirstVtx, LastVtx: Integer;
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
  TMOX2 = class
  public
    Header1: record
      Fmt: AnsiString;
      A: Byte; // 0 - 16bit indices, 1 - 32bit indices, 2 - 32bit indices + tangents
      B: Byte; // Always 0
      C, D: Byte;
    end;
    Header: record VerticeCount, PolyCount, ChunkCount, MatCount, PartCount, BlinkerCount: Integer; end;
    Vertice: array [1..MAX_MOX_VTX] of TMOXVertice;
    Face: array [1..MAX_MOX_IDX, 1..3] of Integer;  // Polygon links
    Chunks: array of TMOXChunk;
    MoxMat: array [1..MAX_MATERIALS] of record
      ID: Integer;
      xxx: array [1..332] of AnsiChar;
    end;
    Parts: array [1..MAX_PARTS] of TMOXPart;
    Blinkers: array [1..MAX_BLINKERS] of TMOXBlinker;

    procedure Clear;
    function MOXFormat: TMOXFormat;
    function MOXFormatInt: string;
    function MOXFormatStr: string;

    function GetTransformMatrix(aPart: Integer): TMatrix4;

    procedure LoadMOX(const aFilename: string);
    procedure ExportLWO(const aFilename: string; aColorId: Integer; aSpreadOverX: Boolean);
    procedure ExportLWO2(const aFilename: string; aColorId: Integer; aSpreadOverX: Boolean);

    procedure BlinkerAdd(aIndex: Integer);
    procedure BlinkerRemove(aIndex: Integer);
    procedure BlinkersLoad(const aFilename: string);
    procedure BlinkersSave(const aFilename: string);
  end;


var
  Material: array [1..MAX_MATERIALS] of record
    Mtag: string[4];//Material tag (#_0x----)
    Title: string;
    MatClass: array [1..4] of Integer;     //Material class selector (by index)
    Color: array [1..20] of record
      Amb,Dif,Sp1,Sp2,Ref:record
        R,G,B,z: Byte;
      end;
    end;
    Transparency: Byte;
    TexName: string;
    TexEdge: record U, V: Byte; end;
    TexOffset, TexScale: record U, V: Single; end;
    TexAngle: Single;
  end;

implementation
uses
  StrUtils, KromUtils, KM_IoModelLWO;


{ TMOXBlinker }
function TMOXBlinker.GetStr: string;
begin
  Result := Format('%s %.3g->%.3g %d', [BLINKER_TYPE_SHORTNAME[BlinkerType], sMin, sMax, Parent]);
end;


{ TMOX2 }
procedure TMOX2.Clear;
begin
  FillChar(Header1, SizeOf(Header1), #0);
  FillChar(Header, SizeOf(Header), #0);
  FillChar(Vertice, SizeOf(Vertice), #0);
  FillChar(Face, SizeOf(Face), #0);
  SetLength(Chunks, 0);
  FillChar(MoxMat, SizeOf(MoxMat), #0);
  FillChar(Parts, SizeOf(Parts), #0);
  FillChar(Blinkers, SizeOf(Blinkers), #0);
end;


function TMOX2.MOXFormat: TMOXFormat;
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


function TMOX2.MOXFormatInt: string;
begin
  Result := Format('%d%d%d%d', [Header1.A, Header1.B, Header1.C, Header1.D]);
end;


function TMOX2.MOXFormatStr: string;
const
  S: array [TMOXFormat] of string = ('Unknown', 'MBWR', 'WR02', 'WR22');
begin
  Result := S[MOXFormat];
end;


function TMOX2.GetTransformMatrix(aPart: Integer): TMatrix4;
begin
  Result := Parts[aPart].Matrix;

  // Apply parent transforms
  if Parts[aPart].Parent <> -1 then
    Result := Result * GetTransformMatrix(Parts[aPart].Parent+1);
end;


procedure TMOX2.BlinkerAdd(aIndex: Integer);
begin
  if Header.BlinkerCount >= MAX_BLINKERS then Exit;

  Inc(Header.BlinkerCount);

  if InRange(aIndex, 1, Header.BlinkerCount) then
    // Duplicate existing
    Blinkers[Header.BlinkerCount] := Blinkers[aIndex]
  else
  begin
    // Create new
    Blinkers[Header.BlinkerCount].BlinkerType := 0;
    Blinkers[Header.BlinkerCount].sMin := 0;
    Blinkers[Header.BlinkerCount].sMax := 1;
    Blinkers[Header.BlinkerCount].Freq := 0;
    Blinkers[Header.BlinkerCount].B := 255;
    Blinkers[Header.BlinkerCount].G := 64;
    Blinkers[Header.BlinkerCount].R := 0;
    Blinkers[Header.BlinkerCount].A := 255;
    Blinkers[Header.BlinkerCount].Unused := 0;
    Blinkers[Header.BlinkerCount].Parent := 0;
    FillChar(Blinkers[Header.BlinkerCount].Matrix, SizeOf(Blinkers[Header.BlinkerCount].Matrix), #0);
    Blinkers[Header.BlinkerCount].Matrix := TMatrix4.Identity;
  end;
end;


procedure TMOX2.BlinkerRemove(aIndex: Integer);
var
  I: Integer;
begin
  for I := aIndex to Header.BlinkerCount - 1 do
    Blinkers[I] := Blinkers[I + 1];

  Dec(Header.BlinkerCount);
end;


procedure TMOX2.BlinkersLoad(const aFilename: string);
var
  f: file;
begin
  if not FileExists(aFilename) then exit;

  AssignFile(f, aFilename);
  FileMode := 0;
  Reset(f, 1);
  FileMode := 2;
  BlockRead(f, Header.BlinkerCount, 4);
  if Header.BlinkerCount > MAX_BLINKERS then
    Header.BlinkerCount := MAX_BLINKERS;
  BlockRead(f, Blinkers, 88 * Header.BlinkerCount);
  CloseFile(f);
end;


procedure TMOX2.BlinkersSave(const aFilename: string);
var
  f: file;
begin
  AssignFile(f, aFilename);
  Rewrite(f, 1);
  BlockWrite(f, Header.BlinkerCount, 4);
  BlockWrite(f, Blinkers, 88 * Header.BlinkerCount);
  CloseFile(f);
end;


procedure TMOX2.LoadMOX(const aFilename: string);
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
  AssignFile(f,aFilename); FileMode:=0; reset(f,1); FileMode:=2;
  try
    blockread(f,c4,4);
    Header1.Fmt := c4[1]+c4[2]+c4[3]+c4[4];
    if Header1.Fmt <> ('!XOM') then
      raise Exception.Create('Unsupported MOX format - ' + Header1.Fmt);

    blockread(f, Header1.A, 4);

    Assert(Header1.B = 0);

    if Header1.A > 1 then
      raise EExceptionTooNew.Create('Unsupported MOX version - ' + MOXFormatInt);
    if Header1.C > 2 then
      raise EExceptionTooNew.Create('Unsupported MOX version - ' + MOXFormatInt);

    if MOXFormat = mfUnknown then
      raise Exception.Create('Unknown MOX version - ' + MOXFormatInt);

    blockread(f, Header, 24);

    blockread(f, Vertice, Header.VerticeCount*40);

    // Faces
    for i:=1 to Header.PolyCount do
    if Header1.A = 1 then
    begin
      blockread(f, face12, 12);
      Face[i, 1] := face12[1] + 1;
      Face[i, 2] := face12[2] + 1;
      Face[i, 3] := face12[3] + 1
    end else
    begin
      blockread(f, face6, 6);
      Face[i, 1] := face6[1] + 1;
      Face[i, 2] := face6[2] + 1;
      Face[i, 3] := face6[3] + 1
    end;

    SetLength(Chunks, Header.ChunkCount + 1);

    if MOXFormat = mf10MBWR then
    for j:=1 to Header.ChunkCount do
    begin
      blockread(f, chunk16, 12);
      Chunks[j].SidA := chunk16.SidA;
      Chunks[j].SidB := chunk16.SidB;
      Chunks[j].FirstPoly := chunk16.FirstPoly;
      Chunks[j].PolyCount := chunk16.PolyCount;
      Chunks[j].FirstVtx := chunk16.FirstVtx + 1;
      Chunks[j].LastVtx := chunk16.LastVtx + 1;
    end;

    if MOXFormat in [mf02WR2, mf22WR2] then
    for j:=1 to Header.ChunkCount do
    begin
      blockread(f, chunk32, 24);
      Chunks[j].SidA := chunk32.SidA;
      Chunks[j].SidB := chunk32.SidB;
      Chunks[j].FirstPoly := chunk32.FirstPoly;
      Chunks[j].PolyCount := chunk32.PolyCount;
      Chunks[j].FirstVtx := chunk32.FirstVtx + 1;
      Chunks[j].LastVtx := chunk32.LastVtx + 1;
    end;

    // Verify faces
    for I := 1 to Header.PolyCount do
    begin
      Assert(Face[I,1] <= Header.VerticeCount);
      Assert(Face[I,2] <= Header.VerticeCount);
      Assert(Face[I,3] <= Header.VerticeCount);
    end;

    // Verify vertex ranges
    // Some models can be empty - 0 vertices, 0 polys, etc. They are still "valid"
    if Header.ChunkCount > 0 then
      Assert(Chunks[1].FirstVtx = 1);
    // This is actually violated in some Synetic models
    {for j:=2 to Header.ChunkCount do
      if Chunks[j].FirstVtx <> Chunks[j-1].LastVtx + 1 then
        Assert(False);}
    // This is actually violated in some Synetic models
    //Assert(Chunks[Header.ChunkCount].LastVtx = Header.VerticeCount);

    // Verify poly ranges
    if Header.ChunkCount > 0 then
      Assert(Chunks[1].FirstPoly = 0);
    for j:=2 to Header.ChunkCount do
      Assert(Chunks[j].FirstPoly = Chunks[j-1].FirstPoly + Chunks[j-1].PolyCount);
    //Assert(Chunks[Header.ChunkCount].FirstPoly + Chunks[Header.ChunkCount].PolyCount = Header.PolyCount);

    blockread(f, MoxMat, (80+256)*Header.MatCount);

    if MOXFormat = mf22WR2 then
      for j:=1 to Header.PartCount do
      begin
        blockread(f, cPart64, 64);
        Parts[j].Dname := PAnsiChar(@cPart64[1]);
        blockread(f, Parts[j].Matrix, 132);
      end;

    // Verify damage parts
    for j:=1 to Header.PartCount do
      Assert(Parts[j].TypeID in [0..6]);

    // Add fake damage part
    if MOXFormat in [mf10MBWR, mf02WR2] then
    begin
      Header.PartCount := 1;

      FillChar(Parts[1], SizeOf(Parts[1]), #0);
      Parts[1].Dname := 'Default';
      Parts[1].Matrix := TMatrix4.Identity;
      Parts[1].Parent := -1;
      Parts[1].Child := -1;
      Parts[1].PrevInLevel := -1;
      Parts[1].NextInLevel := -1;
      Parts[1].FirstMat := 0;
      Parts[1].NumMat := header.MatCount;
      Parts[1].fRadius := 10;
    end;

    if Header.BlinkerCount > MAX_BLINKERS then
    begin
      Header.BlinkerCount := MAX_BLINKERS;
      MessageBox(0, PChar('Blinker quantity limited to ' + IntToStr(MAX_BLINKERS)
        + ' due to compatibility issues.'), 'Warning', MB_OK or MB_ICONWARNING);
    end;

    if MOXFormat = mf22WR2 then
      blockread(f, Blinkers, 88*Header.BlinkerCount);

    // Verify blinkers
    for j:=1 to Header.BlinkerCount do
      Assert(Blinkers[j].BlinkerType in [0..9,16,17,20,24,28,32,33,34,255], Format('Unsupported blinker type %d', [Blinkers[j].BlinkerType]));
  finally
    closefile(f);
  end;
end;


procedure TMOX2.ExportLWO(const aFilename: string; aColorId: Integer; aSpreadOverX: Boolean);
const
  DEFAULT_PATH = './textures_PC/';
var
  ft: textfile;
  rs: AnsiString;
  s: string;
  h,i,j,k,m: Integer;
  uu,vv,xr: Single;
  t,t2: Vector3f;
  idChunk, idPart, CurrentLev, DepthLev: Integer;
  mtx: TMatrix4;
begin
  SetLength(rs, 4);
  AssignFile(ft,aFilename);
  Rewrite(ft);

  Write(ft,'FORM');

  m:=0;
  m:=m+12;                                        //+'LWO2TAGS   2'

  for i:=1 to Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
        Inc(m,Length(Material[i].Title)+2)
    else
      if Material[i].Mtag<>'' then Inc(m,6); //4+2

  m:=m+8+18;                                      //+LAYR_
  m:=m+8+Header.VerticeCount*12;                      //+PNTS+3D
  m:=m+14+10+Header.VerticeCount*10;                  //+UV
  m:=m+12+Header.PolyCount*8;                         //+Face 3.x.x.x
  m:=m+12+Header.PolyCount*4;                         //+Surface

  for i:=1 to Header.MatCount do
    if Material[i].TexName<>'' then
    begin
      if (Length(Material[i].TexName) mod 2)=1 then
        m:=m+Length(Material[i].TexName)+1
      else
        m:=m+Length(Material[i].TexName)+2;
      m:=8+10+Length(DEFAULT_PATH)+m;                                //+CLIP+STIL+name+path
    end;

  for i:=1 to Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
        Inc(m,Length(Material[i].Title)+2)
    else
     if Material[i].Mtag<>'' then Inc(m,6);       //Writing tagID instead of name, 4+2

  m:=m+(8+2+66+252-8-8-20-42-16) * Header.MatCount;                  //+SURF Data

  //=========================Writing data

  Write(ft, AnsiChar(m div 1677216), AnsiChar(m div 65536), AnsiChar(m div 256), AnsiChar(m));
  Write(ft, 'LWO2', 'TAGS');

  m:=0;
  for i:=1 to Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
       Inc(m,Length(Material[i].Title)+2)
    else
      if Material[i].Mtag<>'' then Inc(m,6); //4+2

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));

  for i:=1 to Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Write(ft,Material[i].Title,#0)
      else
        Write(ft,Material[i].Title,#0,#0)
    else
      if Material[i].Mtag<>'' then
        Write(ft,Material[i].Mtag,#0,#0); //4+2

  Write(ft,'LAYR',#0,#0,#0,#18,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);

  Write(ft,'PNTS');
  m:=Header.VerticeCount*12; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  idChunk:=0; idPart:=0;

  for j:=1 to Header.VerticeCount do
  begin
    t.x:=Vertice[j].X;
    t.y:=Vertice[j].Y;
    t.z:=Vertice[j].Z;

    if (idChunk < Header.ChunkCount) and (j = Chunks[idChunk+1].FirstVtx) then //current point matches first point of next chunk
      Inc(idChunk); //This is idChunk of current chunk
    if (idChunk = Parts[idPart+1].FirstMat+1) and (Parts[idPart+1].NumMat <> 0) then
      Inc(idPart); //This is idChunk of current detail

    DepthLev := 8;
    repeat
      CurrentLev := 1; k := idPart;
      while (Parts[k].Parent > -1) and (CurrentLev <> DepthLev) do
      begin
        k := Parts[k].Parent+1;
        Inc(CurrentLev);
      end;

      DepthLev := CurrentLev; // set depth for first run
      Dec(DepthLev);          // -1

      mtx := Parts[k].Matrix;
      t2.x:=t.x*mtx.m11+t.y*mtx.m21+t.z*mtx.m31+mtx.m41;
      t2.y:=t.x*mtx.m12+t.y*mtx.m22+t.z*mtx.m32+mtx.m42;
      t2.z:=t.x*mtx.m13+t.y*mtx.m23+t.z*mtx.m33+mtx.m43;
      t := t2;
    until(DepthLev=0);

    Vertice[j].X := t.x + idPart * 25 * Ord(aSpreadOverX);
    Vertice[j].Y := t.y;
    Vertice[j].Z := t.z;
    rs := unreal2(Vertice[j].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
    rs := unreal2(Vertice[j].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse Byte
    rs := unreal2(Vertice[j].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'VMAP');
  m:=6+10+Header.VerticeCount*10; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'TXUV',#0,#2);
  Write(ft,'Texture01',#0);           //TextureMap name in LW
  idChunk:=0;
  for k:=1 to Header.VerticeCount do
  begin
    if (idChunk < Header.ChunkCount) and (k = Chunks[idChunk+1].FirstVtx) then
      Inc(idChunk); //idChunk=1 ...

    Write(ft,AnsiChar((k-1) div 256),AnsiChar(k-1));
    if Material[idChunk].TexScale.U=0 then Material[idChunk].TexScale.U:=1;
    if Material[idChunk].TexScale.V=0 then Material[idChunk].TexScale.V:=1;
    uu:= Vertice[k].U*Material[idChunk].TexScale.U+Material[idChunk].TexOffset.U;             // not Reversed
    vv:=-Vertice[k].V*Material[idChunk].TexScale.V+Material[idChunk].TexOffset.V+1;             // not Reversed
    if Material[idChunk].TexAngle=90 then begin xr:=uu; uu:=-vv; vv:=xr; end; //Rotate 90 CCW
    if Material[idChunk].TexAngle=-90 then begin xr:=uu; uu:=vv; vv:=-xr; end;//Rotate 90 CW
    rs:=unreal2(uu); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(vv); Write(ft,rs[4],rs[3],rs[2],rs[1]);
  end;

  Write(ft,'POLS');
  m:=Header.PolyCount*8+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for j:=1 to Header.PolyCount do
  begin
    Write(ft,#0,#3 // 3 Points/Polygon
    ,AnsiChar((Face[j,1]-1) div 256),AnsiChar(Face[j,1]-1)
    ,AnsiChar((Face[j,2]-1) div 256),AnsiChar(Face[j,2]-1)
    ,AnsiChar((Face[j,3]-1) div 256),AnsiChar(Face[j,3]-1));
  end;

  Write(ft,'PTAG');
  m:=Header.PolyCount*4+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'SURF');
  idChunk:=0;
  for i:=1 to Header.PolyCount do
  begin
    if (idChunk < Header.ChunkCount) and (i-1=Chunks[idChunk+1].FirstPoly) then Inc(idChunk);
    Write(ft,AnsiChar((i-1) div 256),AnsiChar(i-1),AnsiChar((Chunks[idChunk].SidA) div 256),AnsiChar(Chunks[idChunk].SidA));
  end;

  for i:=1 to Header.MatCount do
  if Material[i].TexName<>'' then
  begin
    s := DEFAULT_PATH + Material[i].TexName;

    if (Length(s) mod 2) = 1 then m := Length(s) + 1 else m := Length(s) + 2;
    m := 10 + m;

    Write(ft,'CLIP');
    Write(ft, AnsiChar(m div 1677216), AnsiChar(m div 65536), AnsiChar(m div 256), AnsiChar(m));

    Write(ft, #0,#0,#0, AnsiChar(i));
    Write(ft, 'STIL');
    m:=m-4-4-2;
    Write(ft, AnsiChar(m div 256), AnsiChar(m));
    Write(ft, s);
    if (Length(s) mod 2) = 1 then Write(ft, #0) else Write(ft, #0,#0);
  end;

  for i:=1 to Header.MatCount do
  begin
    Write(ft,'SURF');
    m:=2+66+252-8-8-20-42-16;      ////Data Len
    if Material[i].Title <> '' then
      if (Length(Material[i].Title) mod 2) = 1 then
        Inc(m, Length(Material[i].Title)+1)
      else
        Inc(m, Length(Material[i].Title)+2)
    else
      if Material[i].Mtag <> '' then
        Inc(m,6); //4+2
    Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));

    if Material[i].Title <> '' then
      if (Length(Material[i].Title) mod 2) = 1 then
        Write(ft, Material[i].Title, #0)
      else
        Write(ft, Material[i].Title, #0, #0)
    else
    if Material[i].Mtag <> '' then
      Write(ft, Material[i].Mtag, #0, #0); //4+2

    Write(ft,#0,#0);
    Write(ft,'COLR',#0,#14);
    rs:=unreal2(Material[i].Color[aColorId].Dif.R/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(Material[i].Color[aColorId].Dif.G/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(Material[i].Color[aColorId].Dif.B/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);

    Write(ft,#0,#0);
    Write(ft,'SPEC',#0,#6);
    rs:=unreal2((Material[i].Color[aColorId].Sp1.R+
                 Material[i].Color[aColorId].Sp1.G+
                 Material[i].Color[aColorId].Sp1.B)/300);
    Write(ft,rs[4],rs[3],rs[2],rs[1]);
    Write(ft,#0,#0);

    Write(ft,'REFL',#0,#6);
    rs:=unreal2(Material[i].Color[aColorId].Ref.R/255); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    Write(ft,#0,#0);

    Write(ft,'TRAN',#0,#6);
    rs:=unreal2(Material[i].Transparency/100); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    Write(ft,#0,#0);

    Write(ft,'SMAN',#0,#4);
    Write(ft,#63,#200,#3,#14);

    Write(ft,'BLOK'); // 252-6
    m:=246-8-20-42-16;
    Write(ft,AnsiChar(m div 256),AnsiChar(m));
    Write(ft,'IMAP',#0,#42,#128,#0,'CHAN',#0,#4,'COLROPAC',#0,#8,#0,#0,#63,#128,#0,#0,#0,#0);

    Write(ft,'TMAP',#0,Chr(98-20-42-16));
    Write(ft,'SIZE',#0,#14); for j:=1 to 3 do Write(ft,#63,#128,#0,#0); Write(ft,#0,#0);

    Write(ft,'PROJ',#0,#2,#0,#5,'AXIS',#0,#2,#0,#2);
    Write(ft,'IMAG',#0,#2,#0,AnsiChar(i),'WRAP',#0,#4,#0,#0,#0,#0,'WRPW',#0,#6,#63,#128,#0,#0,#0,#0);
    Write(ft,'WRPH',#0,#6,#63,#128,#0,#0,#0,#0,'VMAP',#0,#10,'Texture01',#0);
    Write(ft,'AAST',#0,#6,#0,#0,#63,#128,#0,#0,'PIXB',#0,#2,#0,#1);
  end;

  CloseFile(ft);
end;


procedure TMOX2.ExportLWO2(const aFilename: string; aColorId: Integer; aSpreadOverX: Boolean);
const
  EXPORT_SCALE = 0.1;
var
  lwm: TLWModel;
  lay: PLWLayer;
  I: Integer;
  currentChunk: Integer;
  lwt: PLWTag;
  lwc: PLWClip;
  idChunk, idPart: Integer;
  t: TKMVertex3;
begin
  lwm := TLWModel.Create;
  try
    lay := lwm.LayerAdd;

    idChunk := 0;
    idPart := 0;

    // Vertices
    lay.SetVerticeCount(Header.VerticeCount);
    for I := 0 to Header.VerticeCount - 1 do
    begin
      if (idChunk < Header.ChunkCount) and (I = Chunks[idChunk+1].FirstVtx - 1) then
        Inc(idChunk);
      if (idChunk = Parts[idPart+1].FirstMat+1) and (Parts[idPart+1].NumMat <> 0) then
        Inc(idPart);

      // Transform
      t.X := Vertice[I+1].X;
      t.Y := Vertice[I+1].Y;
      t.Z := Vertice[I+1].Z;

      t := t * GetTransformMatrix(idPart) * EXPORT_SCALE;

      lay.Vertices[I] := t;
    end;

    // UVs
    lay.SetUVCount(1);
    lay.UVs[0].Name := 'Texture01';
    SetLength(lay.UVs[0].UV, Header.VerticeCount);
    for I := 0 to Header.VerticeCount - 1 do
    begin
      lay.UVs[0].UV[I].X := Vertice[I+1].U;
      lay.UVs[0].UV[I].Y := 1 - Vertice[I+1].V;

      //todo: Other MTL transformations
    end;

    // Polys
    currentChunk := 0;
    lay.SetPolyCount(Header.PolyCount);
    for I := 0 to Header.PolyCount - 1 do
    begin
      lay.Polys[I].VertCount := 3;
      SetLength(lay.Polys[I].Indices4, 3);

      lay.Polys[I].Indices4[0] := Face[I+1,1] - 1;
      lay.Polys[I].Indices4[1] := Face[I+1,2] - 1;
      lay.Polys[I].Indices4[2] := Face[I+1,3] - 1;

      if I > Chunks[currentChunk].FirstPoly + Chunks[currentChunk].PolyCount - 1 then
        Inc(currentChunk);

      lay.Polys[I].PolySurf := Chunks[currentChunk].SidA;
    end;

    // Clips
    for I := 0 to Header.MatCount - 1 do
    if Material[I+1].TexName <> '' then
    begin
      lwc := lwm.ClipAdd;
      lwc.Id := I + 1;
      lwc.Filename := './textures_PC/' + Material[I+1].TexName;
    end;

    // Tags
    for I := 0 to Header.MatCount - 1 do
    begin
      lwt := lwm.TagAdd;
      lwt.TagName := IfThen(Material[I+1].Title <> '', Material[I+1].Title, Material[I+1].Mtag);
      lwt.TagType := ttSurf;
      lwt.UVName := 'Texture01';
      lwt.TextureId := I + 1;
      lwt.Color.R := Material[I+1].Color[aColorId].Dif.R / 255;
      lwt.Color.G := Material[I+1].Color[aColorId].Dif.G / 255;
      lwt.Color.B := Material[I+1].Color[aColorId].Dif.B / 255;

      lwt.Specularity := (Material[I+1].Color[aColorId].Sp1.R +
                          Material[I+1].Color[aColorId].Sp1.G +
                          Material[I+1].Color[aColorId].Sp1.B) / 300;

      lwt.Reflection := Material[I+1].Color[aColorId].Ref.R / 255;
      lwt.Transparency := Material[I+1].Transparency / 100;
      lwt.SmoothingDeg := 89.53;
    end;


    lwm.SaveToFile(aFilename);
  finally
    lwm.Free;
  end;
end;


end.
