unit MTkit2_Tree;
interface
uses
  Math,
  OpenGL, dglOpenGL;


type
  TModelTree = class
  private
    Tree: record
      Header: array [1..4] of AnsiChar;
      NumVertex, NumLeaves, NumIndices: Integer;
    end;

    TreeTexNames: array [1..2] of string;
    TreeLOD: array [1..3] of record First, Count, Offset, PolyCount: Integer; end;
    TreeChunks: array [1..20] of Integer;
    TreeVertex: array [1..16384] of record X, Y, Z, nX, nY, nZ, U, V: Single; end;
    TreePoly: array [1..16384,1..3] of Word;
    TreeLeaves: array [1..1024] of record X,Y,Z: Single; R,G,B,A: Byte; end;

    TreeHeight: Integer;

    TreeTex: array [1..2]of glUint;
    TreeCall: Integer;
  public
    procedure Clear;
    procedure LoadFromFile(const aFilename: string);
    procedure PrepareDisplayList;
    procedure PrepareTextures(const aFolder: string);
    procedure Render(aPivot: glUint; aRotX, aRotY: Single; aShowWires: Boolean);
  end;


implementation
uses
  MTKit2_Textures;


procedure TModelTree.Clear;
begin
  FillChar(Tree, SizeOf(Tree), #0);
end;


procedure TModelTree.LoadFromFile(const aFilename: string);
var
  c: array [1..1024000] of AnsiChar;
  i: Integer;
  f: file;
begin
  AssignFile(f, aFilename);
  FileMode := 0;
  Reset(f, 1);
  FileMode := 2;

  BlockRead(f, Tree, 16);
  BlockRead(f, c, 64); TreeTexNames[1] := PAnsiChar(@c[1]);
  BlockRead(f, c, 64); TreeTexNames[2] := PAnsiChar(@c[1]);
  BlockRead(f, TreeLOD, 48);
  BlockRead(f, TreeChunks, 60);
  BlockRead(f, TreeVertex[1], 32 * Tree.NumVertex);
  BlockRead(f, TreeLeaves, 16 * Tree.NumLeaves);
  BlockRead(f, TreePoly[1], Tree.NumIndices * 2);
  //BlockRead(f, c, Tree.NumIndices);
  CloseFile(f);

  TreeHeight := 0;
  for i := 1 to Tree.NumVertex do
    TreeHeight := Max(TreeHeight, Round(TreeVertex[i].Y));

  //RGExtra.Items[1]:='Show TREE ('+floattostr(TreeHeight/10)+'m)';
end;


procedure TModelTree.PrepareDisplayList;
var
  h,i,k,LOD:Integer;
  t:Single;
begin
  LOD:=1;
  if TreeCall=0 then TreeCall:=glGenLists(1);
  glNewList (TreeCall, GL_COMPILE);
  glbegin (gl_triangles);
    for i:=TreeLOD[LOD].Offset div 3+1 to TreeLOD[LOD].Offset div 3 + TreeLOD[LOD].PolyCount do
    for h:=3 downto 1 do
    begin
      glTexCoord2fv(@TreeVertex[TreePoly[i,h]+1].U);
      glNormal3fv(@TreeVertex[TreePoly[i,h]+1].nX);
      glVertex3fv(@TreeVertex[TreePoly[i,h]+1].X);
    end;
  glEnd;
  glEndList;
end;


procedure TModelTree.PrepareTextures(const aFolder: string);
var
  i: Integer;
begin
  for i:=1 to 2 do
  begin
    glDeleteTextures(1, @TreeTex[i]); //Clear RAM used by textures
    TreeTex[i] := TryToLoadTexture(aFolder, TreeTexNames[i]);
  end;
end;


procedure TModelTree.Render(aPivot: glUint; aRotX, aRotY: Single; aShowWires: Boolean);
var
  i,h:Integer;
begin
  if Tree.NumVertex=0 then exit;

glPushMatrix;
  glTranslate(0,-TreeHeight/3,0);
  glBindTexture(GL_TEXTURE_2D, TreeTex[1]); //UV map texture

  glCallList(aPivot);

  glColor4f(0.75,0.75,0.75,1);
  glCallList(TreeCall);

  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER,0.5);
  glBindTexture(GL_TEXTURE_2D, TreeTex[2]); //UV map texture
  glColor4f(0.75,0.75,0.75,1);
  for i:=1 to Tree.NumLeaves do
  begin
    glPushMatrix;
      glTranslate(TreeLeaves[i].X, TreeLeaves[i].Y, TreeLeaves[i].Z);
      glRotatef(aRotX, 0, -1, 0); //face camera
      glRotatef(aRotY, -1, 0, 0);
      glbegin (gl_triangles);
      for h:=1 to 3 do begin
        glTexCoord2f(TreeVertex[TreePoly[i,h]+1].U , -TreeVertex[TreePoly[i,h]+1].V);
        glNormal3fv(@TreeVertex[TreePoly[i,h]+1].nX);
        glvertex3fv(@TreeVertex[TreePoly[i,h]+1].X);
      end;
      glEnd;
    glPopMatrix;
  end;
  glDisable(GL_ALPHA_TEST);

  if aShowWires then
  begin
    glBindTexture(GL_TEXTURE_2D,0); //UV map texture
    glDepthFunc(GL_ALWAYS);
    glColor4f(0.6,0.9,0.6,0.1);
    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    glCallList(TreeCall);
    glPolygonMode(GL_FRONT,GL_FILL);
    glDepthFunc(GL_LEQUAL);
  end;

  glPopMatrix;
end;


end.
