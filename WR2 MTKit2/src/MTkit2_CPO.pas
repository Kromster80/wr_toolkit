unit MTkit2_CPO;
interface
uses
  KromUtils,
  MTkit2_Defaults;

var
  CPOHead: record
    Head: array [1..4] of AnsiChar;
    Qty, x1, x2, x3: Integer;
  end;

  CPO: array [1 .. MAX_CPO_SHAPES] of record
    Format: Integer; // 2 possible types 2-box 3-shape
    PosX, PosY, PosZ: Single;
    ScaleX, ScaleY, ScaleZ: Single;
    Matrix9: array [1 .. 9] of Single;
    VerticeCount, PolyCount, IndiceSize, Clear1: Integer;
    Vertices: array [1 .. 256] of Vector3f;
    Indices:  array [1 .. 512] of Word;
  end;

function  LoadCPO(const aFilename: string): Boolean;
procedure SaveCPO(const aFilename: string);
procedure SaveCPO2LWO(const aFilename: string; ShapeID: Integer);


implementation
uses
  SysUtils;


function LoadCPO(const aFilename: string): Boolean;
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
  BlockRead(f, CPOHead, 16);

  for i:=1 to CPOHead.Qty do
  begin
    BlockRead(f, CPO[i].Format, 4);

    if CPO[i].Format = 2 then
    begin
      BlockRead(f, CPO[i].ScaleX, 12);
      BlockRead(f, CPO[i].PosX, 12);
      BlockRead(f, CPO[i].Matrix9, 36);
    end;

    if CPO[i].Format = 3 then
    begin
      BlockRead(f, CPO[i].VerticeCount, 16);
      BlockRead(f, CPO[i].Vertices[1], CPO[i].VerticeCount * 12);
      BlockRead(f, CPO[i].Indices[1], CPO[i].IndiceSize);
      BlockRead(f, CPO[i].PosX, 12);
      BlockRead(f, CPO[i].Matrix9, 36);
    end;
  end;

  CloseFile(f);
  Result := True;
end;


procedure SaveCPO(const aFilename: string);
var
  i: Integer;
  f: file;
begin
  AssignFile(f, aFilename);
  Rewrite(f, 1);

  BlockWrite(f, CPOHead, 16);

  for i := 1 to CPOHead.Qty do
  begin
    BlockWrite(f,CPO[i].Format, 4);

    if CPO[i].Format = 2 then
    begin
      BlockWrite(f,CPO[i].ScaleX, 12);
      BlockWrite(f,CPO[i].PosX ,12);
      BlockWrite(f,CPO[i].Matrix9, 36);
    end;

    if CPO[i].Format = 3 then
    begin
      BlockWrite(f,CPO[i].VerticeCount, 16);
      BlockWrite(f,CPO[i].Vertices[1], CPO[i].VerticeCount*12);
      BlockWrite(f,CPO[i].Indices[1], CPO[i].IndiceSize);
      BlockWrite(f,CPO[i].PosX, 12);
      BlockWrite(f,CPO[i].Matrix9, 36);
    end;
  end;

  CloseFile(f);
end;


procedure SaveCPO2LWO(const aFilename: string; ShapeID: Integer);
var
  i,m: Integer;
  rs: string[4];
  ft: textfile;
begin
  if (ShapeID=0)or(CPO[ShapeID].Format=2) then exit; //No sense to export bounding box to lwo

  AssignFile(ft,aFilename); Rewrite(ft);
  Write(ft,'FORM'); m:=0;
  Inc(m,12);                                                     //+'LWO2TAGS   2'
  Inc(m,8);                                                      //Default
  Inc(m,8+18);                                                   //+LAYR_
  Inc(m,8+CPO[ShapeID].VerticeCount*12);                         //+PNTS+3D
  Inc(m,12+CPO[ShapeID].IndiceSize);                             //Face
  Inc(m,12+CPO[ShapeID].PolyCount*4);                            //+PTAG
  //Inc(m,8+10);                                                 //+SURF Data

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'LWO2','TAGS');
  Write(ft,#0,#0,#0,#8,'Default',#0);
  Write(ft,'LAYR',#0,#0,#0,#18,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);

  Write(ft,'PNTS');
  m:=CPO[ShapeID].VerticeCount*12; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  for i:=1 to CPO[ShapeID].VerticeCount do
  begin
    rs:=unreal2(CPO[ShapeID].Vertices[i].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
    rs:=unreal2(CPO[ShapeID].Vertices[i].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse
    rs:=unreal2(CPO[ShapeID].Vertices[i].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'POLS');
  m:=CPO[ShapeID].IndiceSize+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for i:=1 to CPO[ShapeID].IndiceSize div 2 do
    Write(ft, AnsiChar(CPO[ShapeID].Indices[i] div 256), AnsiChar(CPO[ShapeID].Indices[i]));

  Write(ft,'PTAG');
  m:=CPO[ShapeID].PolyCount*4+4;
  Write(ft, #0, #0, AnsiChar(m div 256),AnsiChar(m));

  Write(ft,'SURF');
  for i:=0 to CPO[ShapeID].PolyCount-1 do
    Write(ft, AnsiChar(i div 256), AnsiChar(i), #0, #0);

  Write(ft,'SURF',#0,#0,#0,#10,'Default',#0,#0,#0);

  CloseFile(ft);
end;


end.
