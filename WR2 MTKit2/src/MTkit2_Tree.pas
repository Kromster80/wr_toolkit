unit MTkit2_Tree;
interface
uses
  Math;


procedure LoadTREE(const aFilename: string);


var
  Tree: record
    header: array [1..4] of AnsiChar;
    NumVertex, NumLeaves, NumIndices: Integer;
  end;
  TreeTexNames: array [1..2] of string;
  TreeLOD: array [1..3] of record First, Count, Offset, PolyCount: Integer; end;
  TreeChunks: array [1..20] of Integer;
  TreeVertex: array [1..16384] of record X,Y,Z,nX,nY,nZ,U,V: Single; end;
  TreePoly: array [1..16384,1..3] of Word;
  TreeLeaves: array [1..1024] of record X,Y,Z: Single; R,G,B,A: Byte; end;
  TreeHeight: Integer;


implementation


procedure LoadTREE(const aFilename: string);
var
  c: array [1..1024000] of AnsiChar;
  i: Integer;
  f: file;
begin
  AssignFile(f, aFilename);
  FileMode := 0;
  Reset(f, 1);
  FileMode := 2;

  BlockRead(f,Tree,16);
  BlockRead(f,c,64); TreeTexNames[1] := PAnsiChar(@c[1]);
  BlockRead(f,c,64); TreeTexNames[2] := PAnsiChar(@c[1]);
  BlockRead(f,TreeLOD,48);//
  BlockRead(f,TreeChunks,60);//
  //for i:=1 to 15 do
  //memo2.Lines.Add(inttostr(TreeChunks[i]));
  BlockRead(f,TreeVertex[1],32*Tree.NumVertex);
  BlockRead(f,TreeLeaves,16*Tree.NumLeaves);
  BlockRead(f,TreePoly[1],Tree.NumIndices*2);
  //BlockRead(f,c,Tree.NumIndices);
  CloseFile(f);

  TreeHeight := 0;
  for i := 1 to Tree.NumVertex do
    TreeHeight := Max(TreeHeight, Round(TreeVertex[i].Y));

  //RGExtra.Items[1]:='Show TREE ('+floattostr(TreeHeight/10)+'m)';
end;




end.
