unit LoadObjects;
interface
uses
  OpenGL, dglOpenGL, SysUtils, KromUtils, PTXTexture;

function LoadObjectMOX(FileName:string; ListID:integer):boolean;
function LoadObjectTREE(FileName:string; ListID:integer):boolean;

implementation
uses
  Unit1,Unit_RoutineFunctions;

function LoadObjectMOX(FileName:string; ListID:integer):boolean;
var     f:file;
        ft:textfile;
        s,MOXname:AnsiString;
        k,i,h,a,b,MatID:integer;

        MOXHead:record
        Head: array [1..4]of AnsiChar;
        Fmt:integer;
        Vert,Poly,Tex,Mat,Clear1,Clear2:integer;
        end;

        mox_V: array of array[1..10]of single;
        mox_I: array of array[1..3]of word;
        mox_C: array of array[1..6]of word;
        mox_C2:array of array[1..6]of integer;

        CHname:AnsiString;
//        MTL_DiffColor: array [1..256,1..3]of byte;
        MTL_TgaFile: array [1..256]of AnsiString;
begin
result:=false;
if not FileExists(FileName+'.MOX') then exit;

AssignFile(f,FileName+'.mox');
FileMode:=0; reset(f,1); FileMode:=2;
blockread(f,MOXHead,32);

if (StrPas(PAnsiChar(@MOXHead.Head))<>'!XOM')or
   ((MOXHead.Fmt<>65536)and(MOXHead.Fmt<>33554432)and(MOXHead.Fmt<>33685504)) //0010-MBWR,0002-simpleWR2,0022-complexWR2
   then begin closefile(f); exit; end;

setlength(mox_v,MOXHead.Vert+1);
setlength(mox_i,MOXHead.Poly+1);
setlength(mox_c,MOXHead.Tex+1);
setlength(mox_c2,MOXHead.Tex+1);
blockread(f,mox_v[1],40*MOXHead.Vert);
blockread(f,mox_i[1],6*MOXHead.Poly);
case MOXHead.Fmt of
65536:   blockread(f,mox_c[1],12*MOXHead.Tex); //MBWR
33554432:blockread(f,mox_c2[1],24*MOXHead.Tex);//simpleWR2
33685504:blockread(f,mox_c2[1],24*MOXHead.Tex);//complexWR2
end;


if not FileExists(FileName+'.MTL') then exit; 
AssignFile(ft,FileName+'.MTL');
FileMode:=0; reset(ft); FileMode:=2;
MatID:=0;
repeat
readln(ft,s);
CHname:=''; k:=1;
while((length(s)>=k)and(s[k]<>#32)) do begin
                                        CHname:=CHname+s[k]; inc(k);
                                        end;
if CHname='#' then begin
inc(MatID);
end;
if CHname='Ambient' then begin
ObjCall[ListID].Ambi[1]:=hextoint(s[11])*16+hextoint(s[12]);
ObjCall[ListID].Ambi[2]:=hextoint(s[13])*16+hextoint(s[14]);
ObjCall[ListID].Ambi[3]:=hextoint(s[15])*16+hextoint(s[16]);
end;
if CHname='Diffuse' then begin
ObjCall[ListID].Diff[1]:=hextoint(s[11])*16+hextoint(s[12]);
ObjCall[ListID].Diff[2]:=hextoint(s[13])*16+hextoint(s[14]);
ObjCall[ListID].Diff[3]:=hextoint(s[15])*16+hextoint(s[16]);
end;
if CHname='Tex1Name' then begin
decs(s,1+3); decs(s,-10);
MTL_TgaFile[MatID]:=s;
end;

until(eof(ft));
closefile(ft);

s:=FileName; MOXname:='';
repeat
MOXname:=s[length(s)]+MOXname;
decs(s);
until((length(s)=0)or(s[length(s)]='\'));
s:=s+'Textures\';

setlength(ObjTex[ListID],MOXHead.Tex);
for i:=1 to MOXHead.Tex do begin
ObjTex[ListID,i-1]:=0;
  if MTL_TgaFile[i]<>'' then //could be optimized to re-use already loaded textures

  if not fileexists(s+MTL_TgaFile[i]+'ptx') then
//  AddWarning('Missing ..\Objects\Textures\'+MTL_TgaFile[i]+'ptx ( '+MOXname+'.mtl )')
  else
  LoadTexturePTX(s+MTL_TgaFile[i]+'ptx',ObjTex[ListID,i-1]);
end;

setlength(ObjCall[ListID].Call,MOXHead.Tex);
for i:=1 to MOXHead.Tex do begin //Generate DisplayList
  if ObjCall[ListID].Call[i-1]=0 then ObjCall[ListID].Call[i-1]:=glGenLists(1);
  glNewList(ObjCall[ListID].Call[i-1], GL_COMPILE);
  glbegin(gl_triangles);

    case MOXHead.Fmt of
    65536:   begin a:=mox_c[i,3]+1; b:=mox_c[i,3]+mox_c[i,4]; end;
    33554432:begin a:=mox_c2[i,3]+1; b:=mox_c2[i,3]+mox_c2[i,4]; end;
    33685504:begin a:=mox_c2[i,3]+1; b:=mox_c2[i,3]+mox_c2[i,4]; end;
    else     begin a:=0; b:=0; end;
    end;

        for k:=a to b do for h:=3 downto 1 do begin
        glTexCoord2fv(@mox_v[mox_i[k,h]+1,7]);
        glnormal3fv(@mox_v[mox_i[k,h]+1,4]);
        glvertex3fv(@mox_v[mox_i[k,h]+1,1]);
        end;

  glEnd;
  glEndList();
end;
end;

function LoadObjectTREE(FileName:string; ListID:integer):boolean;
var
        f:file;
        c: array [1..256]of char;
        k,h,m:integer;
        Tree:record
        header: array [1..4]of AnsiChar;
        NumVertex,NumLeaves,NumIndices:integer;
        end;
        s,TREEname:AnsiString;

        TreeTexNames: array [1..16]of AnsiString;
        TreeLOD: array [1..3] of record First,Count,Offset,PolyCount:integer; end;
        TreeChunks: array [1..20]of integer;
        TreeVertex: array [1..16384]of record X,Y,Z,nX,nY,nZ,U,V:single; end;
        TreePoly: array [1..16384,1..3]of word;
        TreeLeaves: array [1..1024]of record X,Y,Z:single; R,G,B,A:byte; end;
begin
result:=false;
if not FileExists(FileName+'.TREE') then exit;

AssignFile(f,FileName+'.tree');
FileMode:=0; reset(f,1); FileMode:=2;

blockread(f,Tree,16);
blockread(f,c,64); TreeTexNames[1]:=StrPas(PAnsiChar(@c));
blockread(f,c,64); TreeTexNames[2]:=StrPas(PAnsiChar(@c));
blockread(f,TreeLOD,48);//
blockread(f,TreeChunks,60);//
blockread(f,TreeVertex[1],32*Tree.NumVertex);
blockread(f,TreeLeaves,16*Tree.NumLeaves);
blockread(f,TreePoly[1],Tree.NumIndices*2);
closefile(f);

decs(TreeTexNames[1],3); //|tga|
decs(TreeTexNames[2],3);

s:=FileName; TREEname:='';
repeat
TREEname:=s[length(s)]+TREEname;
decs(s);
until((length(s)=0)or(s[length(s)]='\'));
s:=s+'Textures\';

setlength(ObjTex[ListID],2);
for k:=1 to 2 do if TreeTexNames[k]<>'' then begin
ObjTex[ListID,k-1]:=0;
  if not fileexists(s+TreeTexNames[k]+'ptx') then
//  AddWarning('Missing ..\Objects\Textures\'+TreeTexNames[k]+'( '+TREEname+'.tree )')
  else
  LoadTexturePTX(s+TreeTexNames[k]+'ptx',ObjTex[ListID,k-1]);
end else ObjTex[ListID,k-1]:=0;

setlength(ObjCall[ListID].Call,2);
if ObjCall[ListID].Call[0]=0 then ObjCall[ListID].Call[0]:=glGenLists(1);
  glNewList(ObjCall[ListID].Call[0], GL_COMPILE);
    glbegin(gl_triangles);
    for k:=1 to TreeLOD[1].PolyCount do
      for h:=3 downto 1 do begin
      m:=k+TreeLOD[1].Offset div 3;
      glTexCoord2fv(@TreeVertex[TreePoly[m,h]+1].U);
      glNormal3fv(@TreeVertex[TreePoly[m,h]+1].nX);
      glvertex3fv(@TreeVertex[TreePoly[m,h]+1].X);
      end;
    glEnd;
  glEndList();
if ObjCall[ListID].Call[1]=0 then ObjCall[ListID].Call[1]:=glGenLists(1);
  glNewList(ObjCall[ListID].Call[1], GL_COMPILE);
    glbegin(gl_triangles);
    for k:=1 to Tree.NumLeaves do
      for h:=3 downto 1 do begin
//      better leave brightness control to ObjectInShadow and Selection buffer 
//      glColor3f(TreeLeaves[k].R*0.07,TreeLeaves[k].G*0.07,TreeLeaves[k].B*0.07); // /255*1.8
      glTexCoord2fv(@TreeVertex[TreePoly[k,h]+1].U);
      glNormal3fv(@TreeVertex[TreePoly[k,h]+1].nX);
      glvertex3f(TreeVertex[TreePoly[k,h]+1].X+TreeLeaves[k].X,
                 TreeVertex[TreePoly[k,h]+1].Y+TreeLeaves[k].Y,
                 TreeVertex[TreePoly[k,h]+1].Z+TreeLeaves[k].Z);
      end;
    glEnd;
  glEndList();
end;

end.
