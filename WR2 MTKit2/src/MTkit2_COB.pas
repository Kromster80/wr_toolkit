unit MTkit2_COB;
interface
uses
  KromUtils;


type
  TModelCOB = class
  public
    Head: record
      PointQty, PolyQty: Integer;
      X, Y, Z, Xmin, Xmax, Ymin, Ymax, Zmin, ZMax: Single;
    end;
    Vertices: array [1..256] of Vector3f;
    NormalsP: array [1..256] of Vector3f;
    Faces: array [1..256, 1..3] of Word;

    procedure Clear;
    function LoadCOB(const aFilename: string): Boolean;
    procedure SaveCOB(const aFilename: string);
    procedure SaveCOB2LWO(const aFilename: string);
  end;


implementation
uses
  SysUtils;


procedure TModelCOB.Clear;
begin
  FillChar(Head, SizeOf(Head), #0);
  FillChar(Vertices, SizeOf(Vertices), #0);
  FillChar(NormalsP, SizeOf(NormalsP), #0);
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
    BlockRead(f, NormalsP[i].X, 12);
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
    BlockWrite(f, NormalsP[i].X, 12);

  CloseFile(f);
end;


procedure TModelCOB.SaveCOB2LWO(const aFilename: string);
var
  i,m: Integer;
  rs: string[4];
  ft: textfile;
begin
  AssignFile(ft,aFilename); Rewrite(ft);
  Write(ft,'FORM'); m:=0;
  Inc(m,12);                                                     //+'LWO2TAGS   2'
  Inc(m,8);                                                      //Default
  Inc(m,8+18);                                                   //+LAYR_
  Inc(m,8+Head.PointQty*12);                                 //+PNTS+3D
  Inc(m,12+Head.PolyQty*8);                                  //+Face 3.x.x.x
  Inc(m,12+Head.PolyQty*4);                                  //+PTAG
  //Inc(m,8+10);                                                 //+SURF Data

  Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'LWO2','TAGS');
  Write(ft,#0,#0,#0,#8,'Default',#0);
  Write(ft,'LAYR',#0,#0,#0,#18,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);

  Write(ft,'PNTS');
  m:=Head.PointQty*12; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  for i:=1 to Head.PointQty do
  begin
    rs:=unreal2(Vertices[i].X/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //LWO uses
    rs:=unreal2(Vertices[i].Y/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //reverse
    rs:=unreal2(Vertices[i].Z/10); Write(ft,rs[4],rs[3],rs[2],rs[1]); //order
  end;

  Write(ft,'POLS');
  m:=Head.PolyQty*8+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'FACE');
  for i:=1 to Head.PolyQty do
  Write(ft,#0,#3
  ,AnsiChar((Faces[i,1]) div 256),AnsiChar(Faces[i,1])
  ,AnsiChar((Faces[i,2]) div 256),AnsiChar(Faces[i,2])
  ,AnsiChar((Faces[i,3]) div 256),AnsiChar(Faces[i,3]));

  Write(ft,'PTAG');
  m:=Head.PolyQty*4+4; Write(ft,#0,#0,AnsiChar(m div 256),AnsiChar(m));
  Write(ft,'SURF');
  for i:=0 to Head.PolyQty-1 do Write(ft,AnsiChar(i div 256),AnsiChar(i),#0,#0);

  Write(ft,'SURF',#0,#0,#0,#10,'Default',#0,#0,#0);

  CloseFile(ft);
end;


end.
