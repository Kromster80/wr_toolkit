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
  public
    BlinkerType: Integer;     // 4b Type of object (0..9,16,17,20,24,28,32,33,34,255)
    sMin, sMax, Freq: Single; // Min, Max
    B,G,R,A: Byte;            // 20
    Unused, Parent: SmallInt; // 24
    Matrix: TMatrix;          // 88

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
  end;

  procedure LoadMOX(aMox: TMOX2; const aFilename: string);
  procedure SaveMOX2LWO(aMox: TMOX2; const aFilename: string; aColorId: Integer; aSpreadOverX: Boolean);

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
  KromUtils;


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


procedure LoadMOX(aMox: TMOX2; const aFilename: string);
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
    aMOX.Header1.Fmt := c4[1]+c4[2]+c4[3]+c4[4];
    if aMOX.Header1.Fmt <> ('!XOM') then
      raise Exception.Create('Unsupported MOX format - ' + aMOX.Header1.Fmt);

    blockread(f, aMOX.Header1.A, 4);

    Assert(aMOX.Header1.B = 0);

    if aMOX.Header1.A > 1 then
      raise EExceptionTooNew.Create('Unsupported MOX version - ' + aMOX.MOXFormatInt);
    if aMOX.Header1.C > 2 then
      raise EExceptionTooNew.Create('Unsupported MOX version - ' + aMOX.MOXFormatInt);

    if aMOX.MOXFormat = mfUnknown then
      raise Exception.Create('Unknown MOX version - ' + aMOX.MOXFormatInt);

    blockread(f, aMOX.Header, 24);

    blockread(f, aMOX.Vertice, aMOX.Header.VerticeCount*40);

    // Faces
    for i:=1 to aMOX.Header.PolyCount do
    if aMOX.Header1.A = 1 then
    begin
      blockread(f, face12, 12);
      aMOX.Face[i, 1] := face12[1] + 1;
      aMOX.Face[i, 2] := face12[2] + 1;
      aMOX.Face[i, 3] := face12[3] + 1
    end else
    begin
      blockread(f, face6, 6);
      aMOX.Face[i, 1] := face6[1] + 1;
      aMOX.Face[i, 2] := face6[2] + 1;
      aMOX.Face[i, 3] := face6[3] + 1
    end;

    SetLength(aMOX.Chunks, aMOX.Header.ChunkCount + 1);

    if aMOX.MOXFormat = mf10MBWR then
    for j:=1 to aMOX.Header.ChunkCount do
    begin
      blockread(f, chunk16, 12);
      aMOX.Chunks[j].SidA := chunk16.SidA;
      aMOX.Chunks[j].SidB := chunk16.SidB;
      aMOX.Chunks[j].FirstPoly := chunk16.FirstPoly;
      aMOX.Chunks[j].PolyCount := chunk16.PolyCount;
      aMOX.Chunks[j].FirstVtx := chunk16.FirstVtx + 1;
      aMOX.Chunks[j].LastVtx := chunk16.LastVtx + 1;
    end;

    if aMOX.MOXFormat in [mf02WR2, mf22WR2] then
    for j:=1 to aMOX.Header.ChunkCount do
    begin
      blockread(f, chunk32, 24);
      aMOX.Chunks[j].SidA := chunk32.SidA;
      aMOX.Chunks[j].SidB := chunk32.SidB;
      aMOX.Chunks[j].FirstPoly := chunk32.FirstPoly;
      aMOX.Chunks[j].PolyCount := chunk32.PolyCount;
      aMOX.Chunks[j].FirstVtx := chunk32.FirstVtx + 1;
      aMOX.Chunks[j].LastVtx := chunk32.LastVtx + 1;
    end;

    // Verify faces
    for I := 1 to aMOX.Header.PolyCount do
    begin
      Assert(aMOX.Face[I,1] <= aMOX.Header.VerticeCount);
      Assert(aMOX.Face[I,2] <= aMOX.Header.VerticeCount);
      Assert(aMOX.Face[I,3] <= aMOX.Header.VerticeCount);
    end;

    // Verify vertex ranges
    // Some models can be empty - 0 vertices, 0 polys, etc. They are still "valid"
    if aMOX.Header.ChunkCount > 0 then
      Assert(aMOX.Chunks[1].FirstVtx = 1);
    // This is actually violated in some Synetic models
    {for j:=2 to aMOX.Header.ChunkCount do
      if aMOX.Chunks[j].FirstVtx <> aMOX.Chunks[j-1].LastVtx + 1 then
        Assert(False);}
    // This is actually violated in some Synetic models
    //Assert(aMOX.Chunks[aMOX.Header.ChunkCount].LastVtx = aMOX.Header.VerticeCount);

    // Verify poly ranges
    if aMOX.Header.ChunkCount > 0 then
      Assert(aMOX.Chunks[1].FirstPoly = 0);
    for j:=2 to aMOX.Header.ChunkCount do
      Assert(aMOX.Chunks[j].FirstPoly = aMOX.Chunks[j-1].FirstPoly + aMOX.Chunks[j-1].PolyCount);
    //Assert(aMOX.Chunks[aMOX.Header.ChunkCount].FirstPoly + aMOX.Chunks[aMOX.Header.ChunkCount].PolyCount = aMOX.Header.PolyCount);

    blockread(f, aMOX.MoxMat, (80+256)*aMOX.Header.MatCount);

    if aMOX.MOXFormat = mf22WR2 then
      for j:=1 to aMOX.Header.PartCount do
      begin
        blockread(f, cPart64, 64);
        aMOX.Parts[j].Dname := PAnsiChar(@cPart64[1]);
        blockread(f, aMOX.Parts[j].Matrix, 132);
      end;

    // Verify damage parts
    for j:=1 to aMOX.Header.PartCount do
      Assert(aMOX.Parts[j].TypeID in [0..6]);

    // Add fake damage part
    if aMOX.MOXFormat in [mf10MBWR, mf02WR2] then
    begin
      aMOX.Header.PartCount := 1;

      FillChar(aMOX.Parts[1], SizeOf(aMOX.Parts[1]), #0);
      aMOX.Parts[1].Dname := 'Default';
      aMOX.Parts[1].Matrix[1, 1] := 1;
      aMOX.Parts[1].Matrix[2, 2] := 1;
      aMOX.Parts[1].Matrix[3, 3] := 1;
      aMOX.Parts[1].Matrix[4, 4] := 1;
      aMOX.Parts[1].Parent := -1;
      aMOX.Parts[1].Child := -1;
      aMOX.Parts[1].PrevInLevel := -1;
      aMOX.Parts[1].NextInLevel := -1;
      aMOX.Parts[1].FirstMat := 0;
      aMOX.Parts[1].NumMat := aMOX.header.MatCount;
      aMOX.Parts[1].fRadius := 10;
    end;

    if aMOX.Header.BlinkerCount > MAX_BLINKERS then
    begin
      aMOX.Header.BlinkerCount := MAX_BLINKERS;
      MessageBox(0, PChar('Blinker quantity limited to ' + IntToStr(MAX_BLINKERS)
        + ' due to compatibility issues.'), 'Warning', MB_OK or MB_ICONWARNING);
    end;

    if aMOX.MOXFormat = mf22WR2 then
      blockread(f, aMOX.Blinkers, 88*aMOX.Header.BlinkerCount);

    // Verify blinkers
    for j:=1 to aMOX.Header.BlinkerCount do
      Assert(aMOX.Blinkers[j].BlinkerType in [0..9,16,17,20,24,28,32,33,34,255], Format('Unsupported blinker type %d', [aMOX.Blinkers[j].BlinkerType]));
  finally
    closefile(f);
  end;
end;


procedure SaveMOX2LWO(aMox: TMOX2; const aFilename: string; aColorId: Integer; aSpreadOverX: Boolean);
var
  ft: textfile;
  rs: AnsiString;
  h,i,j,k,m: Integer;
  uu,vv,xr: Single;
  t,t2: Vector3f;
  idChunk, idPart, CurrentLev, DepthLev: Integer;
  mtx: TMatrix;
begin
  SetLength(rs, 4);
  AssignFile(ft,aFilename);
  Rewrite(ft);

  Write(ft,'FORM');

  m:=0;
  m:=m+12;                                        //+'LWO2TAGS   2'

  for i:=1 to aMOX.Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
        Inc(m,Length(Material[i].Title)+2)
    else
      if Material[i].Mtag<>'' then Inc(m,6); //4+2

  m:=m+8+18;                                      //+LAYR_
  m:=m+8+aMOX.Header.VerticeCount*12;                      //+PNTS+3D
  m:=m+14+10+aMOX.Header.VerticeCount*10;                  //+UV
  m:=m+12+aMOX.Header.PolyCount*8;                         //+Face 3.x.x.x
  m:=m+12+aMOX.Header.PolyCount*4;                         //+Surface

  for i:=1 to aMOX.Header.MatCount do
    if Material[i].TexName<>'' then
    begin
      if (Length(Material[i].TexName) mod 2)=1 then
        m:=m+Length(Material[i].TexName)+1
      else
        m:=m+Length(Material[i].TexName)+2;
      m:=8+10+m+4;                                //+CLIP+STIL+name+path
    end;

  for i:=1 to aMOX.Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
        Inc(m,Length(Material[i].Title)+2)
    else
     if Material[i].Mtag<>'' then Inc(m,6);       //Writing tagID instead of name, 4+2

  m:=m+(8+2+66+252)*aMOX.Header.MatCount;                  //+SURF Data

  //=========================Writing data

  Write(ft, AnsiChar(m div 1677216), AnsiChar(m div 65536), AnsiChar(m div 256), AnsiChar(m));
  Write(ft, 'LWO2', 'TAGS');

  m:=0;
  for i:=1 to aMOX.Header.MatCount do
    if Material[i].Title<>'' then
      if (Length(Material[i].Title) mod 2)=1 then
        Inc(m,Length(Material[i].Title)+1)
      else
       Inc(m,Length(Material[i].Title)+2)
    else
      if Material[i].Mtag<>'' then Inc(m,6); //4+2

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));

  for i:=1 to aMOX.Header.MatCount do
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
  m:=aMOX.Header.VerticeCount*12; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  idChunk:=0; idPart:=0;

  for j:=1 to aMOX.Header.VerticeCount do
  begin
    t.x:=aMOX.Vertice[j].X;
    t.y:=aMOX.Vertice[j].Y;
    t.z:=aMOX.Vertice[j].Z;

    if (idChunk < aMOX.Header.ChunkCount) and (j = aMOX.Chunks[idChunk+1].FirstVtx) then //current point matches first point of next chunk
      Inc(idChunk); //This is idChunk of current chunk
    if (idChunk = aMOX.Parts[idPart+1].FirstMat+1) and (aMOX.Parts[idPart+1].NumMat <> 0) then
      Inc(idPart); //This is idChunk of current detail

    DepthLev := 8;
    repeat
      CurrentLev := 1; k := idPart;
      while (aMOX.Parts[k].Parent > -1) and (CurrentLev <> DepthLev) do
      begin
        k := aMOX.Parts[k].Parent+1;
        Inc(CurrentLev);
      end;

      DepthLev := CurrentLev; // set depth for first run
      Dec(DepthLev);          // -1

      mtx := aMOX.Parts[k].Matrix;
      t2.x:=t.x*mtx[1,1]+t.y*mtx[2,1]+t.z*mtx[3,1]+mtx[4,1];
      t2.y:=t.x*mtx[1,2]+t.y*mtx[2,2]+t.z*mtx[3,2]+mtx[4,2];
      t2.z:=t.x*mtx[1,3]+t.y*mtx[2,3]+t.z*mtx[3,3]+mtx[4,3];
      t:=t2;
    until(DepthLev=0);

    aMOX.Vertice[j].X := t.x + idPart * 25 * Ord(aSpreadOverX);
    aMOX.Vertice[j].Y := t.y;
    aMOX.Vertice[j].Z := t.z;
    rs := unreal2(aMOX.Vertice[j].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
    rs := unreal2(aMOX.Vertice[j].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse Byte
    rs := unreal2(aMOX.Vertice[j].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'VMAP');
  m:=6+10+aMOX.Header.VerticeCount*10; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'TXUV',#0,#2);
  Write(ft,'Texture01',#0);           //TextureMap name in LW
  idChunk:=0;
  for k:=1 to aMOX.Header.VerticeCount do
  begin
    if (idChunk < aMOX.Header.ChunkCount) and (k = aMOX.Chunks[idChunk+1].FirstVtx) then
      Inc(idChunk); //idChunk=1 ...

    Write(ft,AnsiChar((k-1) div 256),AnsiChar(k-1));
    if Material[idChunk].TexScale.U=0 then Material[idChunk].TexScale.U:=1;
    if Material[idChunk].TexScale.V=0 then Material[idChunk].TexScale.V:=1;
    uu:= aMOX.Vertice[k].U*Material[idChunk].TexScale.U+Material[idChunk].TexOffset.U;             // not Reversed
    vv:=-aMOX.Vertice[k].V*Material[idChunk].TexScale.V+Material[idChunk].TexOffset.V+1;             // not Reversed
    if Material[idChunk].TexAngle=90 then begin xr:=uu; uu:=-vv; vv:=xr; end; //Rotate 90 CCW
    if Material[idChunk].TexAngle=-90 then begin xr:=uu; uu:=vv; vv:=-xr; end;//Rotate 90 CW
    rs:=unreal2(uu); Write(ft,rs[4],rs[3],rs[2],rs[1]);
    rs:=unreal2(vv); Write(ft,rs[4],rs[3],rs[2],rs[1]);
  end;

  Write(ft,'POLS');
  m:=aMOX.Header.PolyCount*8+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for j:=1 to aMOX.Header.PolyCount do
  begin
    Write(ft,#0,#3 // 3 Points/Polygon
    ,AnsiChar((aMOX.Face[j,1]-1) div 256),AnsiChar(aMOX.Face[j,1]-1)
    ,AnsiChar((aMOX.Face[j,2]-1) div 256),AnsiChar(aMOX.Face[j,2]-1)
    ,AnsiChar((aMOX.Face[j,3]-1) div 256),AnsiChar(aMOX.Face[j,3]-1));
  end;

  Write(ft,'PTAG');
  m:=aMOX.Header.PolyCount*4+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'SURF');
  idChunk:=0;
  for i:=1 to aMOX.Header.PolyCount do
  begin
    if (idChunk < aMOX.Header.ChunkCount) and (i-1=aMOX.Chunks[idChunk+1].FirstPoly) then Inc(idChunk);
    Write(ft,AnsiChar((i-1) div 256),AnsiChar(i-1),AnsiChar((aMOX.Chunks[idChunk].SidA) div 256),AnsiChar(aMOX.Chunks[idChunk].SidA));
  end;

  for i:=1 to aMOX.Header.MatCount do if Material[i].TexName<>'' then
  begin
    Write(ft,'CLIP');
    if (Length(Material[i].TexName) mod 2)=1 then m:=Length(Material[i].TexName)+1 else m:=Length(Material[i].TexName)+2;
    m:=10+m+4; Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));
    Write(ft,#0,#0,#0,AnsiChar(i));
    Write(ft,'STIL'); m:=m-10; Write(ft,AnsiChar(m div 256),AnsiChar(m));
    Write(ft,'C:1/',Material[i].TexName);
    if (Length(Material[i].TexName) mod 2)=1 then Write(ft,#0) else Write(ft,#0,#0);
  end;

  for i:=1 to aMOX.Header.MatCount do
  begin
    Write(ft,'SURF');
    m:=2+66+252;      ////Data Len
    if Material[i].Title<>'' then
     if (Length(Material[i].Title) mod 2)=1 then
      Inc(m,Length(Material[i].Title)+1) else
      Inc(m,Length(Material[i].Title)+2) else
     if Material[i].Mtag<>'' then Inc(m,6); //4+2
    Write(ft,AnsiChar(m div 1677216),AnsiChar(m div 65536),AnsiChar(m div 256),AnsiChar(m));

    if Material[i].Title<>'' then
     if (Length(Material[i].Title) mod 2)=1 then
      Write(ft,Material[i].Title,#0) else
      Write(ft,Material[i].Title,#0,#0) else
     if Material[i].Mtag<>'' then Write(ft,Material[i].Mtag,#0,#0); //4+2

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
    m:=246; Write(ft,AnsiChar(m div 256),AnsiChar(m));
    Write(ft,'IMAP',#0,'*A',#0,'CHAN',#0,#4,'COLROPAC',#0,#8,#0,#0,#63,#128,#0,#0,#0,#0);
    Write(ft,'ENAB',#0,#2,#0,#1,'NEGA',#0,#2,#0,#0,'TMAP',#0,#98,'CNTR',#0,#14); for j:=1 to 14 do Write(ft,#0);
    Write(ft,'SIZE',#0,#14); for j:=1 to 3 do Write(ft,#63,#128,#0,#0); Write(ft,#0,#0);
    Write(ft,'ROTA',#0,#14); for j:=1 to 14 do Write(ft,#0);
    Write(ft,'FALL',#0,#16); for j:=1 to 16 do Write(ft,#0);
    Write(ft,'OREF',#0,#2,#0,#0,'CSYS',#0,#2,#0,#0,'PROJ',#0,#2,#0,#5,'AXIS',#0,#2,#0,#2);
    Write(ft,'IMAG',#0,#2,#0,AnsiChar(i),'WRAP',#0,#4,#0,#0,#0,#0,'WRPW',#0,#6,#63,#128,#0,#0,#0,#0);
    Write(ft,'WRPH',#0,#6,#63,#128,#0,#0,#0,#0,'VMAP',#0,#10,'Texture01',#0);
    Write(ft,'AAST',#0,#6,#0,#0,#63,#128,#0,#0,'PIXB',#0,#2,#0,#1);
  end;

  CloseFile(ft);
end;


end.
