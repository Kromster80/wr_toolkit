unit Unit_Render;
interface
uses
  OpenGL, Windows,KromOGLUtils,sysutils,math,dglOpenGL,KromUtils;

var
  PointSize,LineWidth:single;

  coArrow,coSquare,coBox,coBoxW,coSkyDome,coSkyPlane,coMover,coCircleXZ,coCircleYZ,coRoundXZ:glUint; //common objects
  coCar:glUint;
  coGrass:array[1..4]of glUint;
  coGrassTex:glUint;
  EnvMap,FlareTex,BlackTex,WhiteTex:glUint;

procedure RenderShaders(Func:string; ShowTex:integer; CBReduceView,CBShowFog,CBCheckers,CBGrass:boolean);
procedure RenderOpenGL(CBCheckers:boolean);
procedure RenderStreets(A:single; NodeID,SplineID:integer);
procedure RenderRoadNet();
procedure RenderBounds();
procedure RenderTracks(ID,Turn,Na,Nz:integer);
procedure RenderTracksWP(A:single; TrackWP,Node:integer);
procedure RenderAnimated(A:single; Mode:string; ObjID,NodeID:integer);
procedure RenderLights(A:single; Mode:string; ID:integer);
procedure RenderMakeTrack(A:single; ID:integer);
procedure RenderSounds(A:single; Input:integer);
procedure RenderObjects(A,In1,In2:integer);
procedure RenderObjectsShaders(A,In1,In2:integer);
procedure RenderTOB_Objects(TrackID,ObjID,A:integer);
procedure RenderCar();
procedure RenderGrid(Mode:integer);
procedure RenderTarget();
procedure RenderWire();
procedure RenderSky(ID:integer);
procedure RenderSunVector();
procedure CompileCommonObjects();
procedure RenderMover(x,y,z:single);
procedure RenderVTX(Mode:string);
procedure RenderObject(ObjectID:integer);

implementation
uses Unit1,Defaults,Unit_RoutineFunctions,LoadObjects,Unit_RenderInit;


procedure RenderShaders(Func:string; ShowTex:integer; CBReduceView,CBShowFog,CBCheckers,CBGrass:boolean);
var a,b,K,i,ii,ID,MatMode,x1,z1,x0,z0:integer;
SetNewMat,RenderMat,OutOfSight:boolean;
ReloadShaderData:boolean;
Gr:array[1..3]of boolean;
s:string;
begin
if UseShaders=false then exit;

x0:=0; z0:=0;
if CBReduceView then begin
  x0:=round (xPos/1024 + Qty.BlocksX div 2 + 0.5);
  z0:=round (zPos/1024 + Qty.BlocksZ div 2 + 0.5);
end;

for K:=1 to Qty.Materials do begin
RenderMat:=true;

  if ActivePage=apMaterials then begin
    s:=Form1.CBMatFilter.Text;
    if s='Grass' then a:=256 else a:=strtoint(s);
    RenderMat:=RenderMat and ((not Form1.CBShowMode.Checked)or(
      (a=256)and(MaterialW[k].GrowGrass=1)or
      (a=Material[k].Mode)));
    RenderMat:=RenderMat and ((not Form1.CBShowMat.Checked)or(Form1.ListMaterials.ItemIndex+1=K));
  end;

  if ActivePage=apTextures then begin
    RenderMat:=(ShowTex=0)or(ShowTex=Material[k].Tex1)or
    (ShowTex=Material[k].Tex2)or(ShowTex=Material[k].Tex3);
  end;

  Gr[1]:=true; Gr[2]:=true; Gr[3]:=true;
  if (ActivePage=apGrounds)and(Form1.CBShowGround.Checked) then begin
    Gr[1]:=Form1.ListGrounds.ItemIndex=Tex2Ground[Material[k].Tex1+1];
    Gr[2]:=Form1.ListGrounds.ItemIndex=Tex2Ground[Material[k].Tex2+1];
    Gr[3]:=Form1.ListGrounds.ItemIndex=Tex2Ground[Material[k].Tex3+1];
    RenderMat:=(Gr[1])or(Gr[2])or(Gr[3]);
  end;

  if RenderMat then begin
    ReloadShaderData:=true;

    for i:=1 to ChunkMode[k,0] do begin
      ii:=ChunkMode[k,i];

      if (CBReduceView)and
      (GetLength(ChunkModeParent[k,i].x-x0,ChunkModeParent[k,i].z-z0) > fOptions.ViewDistance/1024) then
      OutOfSight:=true else OutOfSight:=false;

      if ReloadShaderData and (not OutOfSight) then begin //SetNewMat for first chunk in list of chunks using same material
        MatMode:=Material[K].Mode AND $F0; //11110000
        ID:=MatMode shr 4 +1; //>>>>4bytes 1..16
        if fOptions.RenderMode=rmBlend then ID:=17 else
        if fOptions.RenderMode=rmFlat  then ID:=18;
        if Func='Materials'  then ID:=19;

        glUseProgramObjectARB(po[ID]);

        S_MtlCol:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('MtlCol')));
        S_SunCol:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('SunCol')));
        S_FogCol:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('FogCol')));
        S_FogPos:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('FogPos')));
        T_TA1 := glGetUniformLocationARB(po[ID], PGLcharARB(PChar('TA1')));
        T_TA2 := glGetUniformLocationARB(po[ID], PGLcharARB(PChar('TA2')));
        T_TB1 := glGetUniformLocationARB(po[ID], PGLcharARB(PChar('TB1')));
        T_TB2 := glGetUniformLocationARB(po[ID], PGLcharARB(PChar('TB2')));
        T_TC1 := glGetUniformLocationARB(po[ID], PGLcharARB(PChar('TC1')));
        T_TC2 := glGetUniformLocationARB(po[ID], PGLcharARB(PChar('TC2')));
        S_Tex1:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('Tex1')));
        S_Tex2:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('Tex2')));
        S_Tex3:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('Tex3')));
        S_Tex4:= glGetUniformLocationARB(po[ID], PGLcharARB(PChar('Tex4')));

        glUniform3fARB(S_MtlCol,(K mod 256)/255,
                               ((K mod 65536) div 256)/255,
                               ((K div 65536)+byte(kSurface)*8)/255);

        if (Form1.CBShowTexGrass.Checked)or(SKYIndex=0) then glUniform3fARB(S_SunCol,0.5,0.5,0.5) else
        glUniform3fARB(S_SunCol,SKY[SKYIndex].SunCol.R/255,SKY[SKYIndex].SunCol.G/255,SKY[SKYIndex].SunCol.B/255);

        if SKYIndex=0 then glUniform3fARB(S_FogCol,0.5,0.5,0.5) else
        glUniform3fARB(S_FogCol,SKY[SKYIndex].FogCol.R/255,SKY[SKYIndex].FogCol.G/255,SKY[SKYIndex].FogCol.B/255);
        glUniform4fARB(S_FogPos,xPos,yPos,Zpos,fOptions.ViewDistance*byte(CBShowFog)); //Position and FogRange

        //using CRC checks doesn't affect perfomance
        glUniform4fvARB(T_TA1,1,@Material[K].Matrix[1,1]); glUniform4fvARB(T_TA2,1,@Material[K].Matrix[1,2]);
        glUniform4fvARB(T_TB1,1,@Material[K].Matrix[2,1]); glUniform4fvARB(T_TB2,1,@Material[K].Matrix[2,2]);
        glUniform4fvARB(T_TC1,1,@Material[K].Matrix[3,1]); glUniform4fvARB(T_TC2,1,@Material[K].Matrix[3,2]);

        //skipping unused textures for materials doesn't affect perfomance

        if Gr[1] then begin
        glActiveTexture(GL_TEXTURE0);
        if CBCheckers then glBindTexture(GL_TEXTURE_2D,TextureCHK[Material[K].Tex1+1])
                      else if CBGrass then
                                if TextureW[Material[K].Tex1+1].GrowGrass=1 then
                                glBindTexture(GL_TEXTURE_2D,WhiteTex) else //yes
                                glBindTexture(GL_TEXTURE_2D,BlackTex) //no
                           else glBindTexture(GL_TEXTURE_2D,Texture[Material[K].Tex1+1]);
        glUniform1iARB(S_Tex1, 0);end else glUniform1iARB(S_Tex1,5);

        if Gr[2] then begin
        glActiveTexture(GL_TEXTURE1);
        if CBCheckers then glBindTexture(GL_TEXTURE_2D,TextureCHK[Material[K].Tex2+1])
                      else if CBGrass then
                                if TextureW[Material[K].Tex2+1].GrowGrass=1 then
                                glBindTexture(GL_TEXTURE_2D,WhiteTex) else //yes
                                glBindTexture(GL_TEXTURE_2D,BlackTex) //no
                           else glBindTexture(GL_TEXTURE_2D,Texture[Material[K].Tex2+1]);
        glUniform1iARB(S_Tex2, 1);end else glUniform1iARB(S_Tex2,5);

        if Gr[3] then begin
        glActiveTexture(GL_TEXTURE2);
        if CBCheckers then glBindTexture(GL_TEXTURE_2D,TextureCHK[Material[K].Tex3+1])
                      else if CBGrass then
                                if TextureW[Material[K].Tex3+1].GrowGrass=1 then
                                glBindTexture(GL_TEXTURE_2D,WhiteTex) else //yes
                                glBindTexture(GL_TEXTURE_2D,BlackTex) //no
                           else glBindTexture(GL_TEXTURE_2D,Texture[Material[K].Tex3+1]);
        glUniform1iARB(S_Tex3, 2); end else glUniform1iARB(S_Tex3,5);

        glActiveTexture(GL_TEXTURE3);
        if CBGrass then glBindTexture(GL_TEXTURE_2D,BlackTex)
                   else glBindTexture(GL_TEXTURE_2D,EnvMap);
        glUniform1iARB(S_Tex4,3);

        ReloadShaderData:=false;
      end; //Reloading shader data for new material complete

      if (not OutOfSight)and(ScnCall[ii]<>0) then begin
      //glTranslatef(0,-0.25,0); //Thats check for duplicate polys on different materials
      glCallList(ScnCall[ii]);
      end;

    end; //ii:=1 to ChunkMode[k,0]
  end; //RenderMat
end; //k:=1 to Qty.Materials
glUseProgramObjectARB(0);     //reset state for next renderers
glActiveTexture(GL_TEXTURE0); //
glBindTexture(GL_TEXTURE_2D,0);
end;

procedure RenderSunVector();
begin
  glLineWidth(1);
  glColor4f(1,1,1,1);
  glbegin(GL_LINES);
  glvertex3f(0,0,0);
  glvertex3f(LVL.SunX*10000,LVL.SunY*10000,LVL.SunZ*10000);
  glEnd;
  glLineWidth(LineWidth);
end;

procedure RenderBounds();
begin
if Qty.Polys=0 then exit;
glLineWidth(1);
glbegin(GL_LINE_LOOP);
glColor4f(1,1,1,1);
glvertex3f(-Qty.BlocksX*512,VTX[1].Y,-Qty.BlocksZ*512);
glvertex3f( Qty.BlocksX*512,VTX[1].Y,-Qty.BlocksZ*512);
glvertex3f( Qty.BlocksX*512,VTX[1].Y, Qty.BlocksZ*512);
glvertex3f(-Qty.BlocksX*512,VTX[1].Y, Qty.BlocksZ*512);
glEnd;
glLineWidth(LineWidth);
end;

procedure RenderStreets(A:single; NodeID,SplineID:integer);
var ii,kk,j,h,PA,PB,Col,ShapeID:integer; Speed,LA,LB,T,Offset:single;// A,B,C:integer;
    ax,bx,cx,x0,x1,x2,x3,xt:single;
    ay,by,cy,y0,y1,y2,y3,yt:single;
    az,bz,cz,z0,z1,z2,z3,zt:single;
    v:vector;
    Spline:array of array of record x,y,z,tx,ty,tz:single; end;
    TA1,TA2,TB1,TB2:record x,y,z:single; end;
    Tang:record x,y,z,n:single; end;
    ti:cardinal;
    DT:boolean;
    SNI_LOD:integer;
begin

  SNI_LOD := fOptions.SplineDetail;

  //Prepare Splines
  setlength(Spline,STRHEad.NumSplines+1);
  for ii:=1 to STRHead.NumSplines do begin
    setlength(Spline[ii],SNI_LOD+1);

    x0:=0; z0:=0; x1:=0; x3:=0; z1:=0; z3:=0; //Init to calm down compiler

    PA:=STR_Spline[ii].PtA+1;       //point A index
    PB:=STR_Spline[ii].PtB+1;       //point B index
    LA:=STR_Spline[ii].LenA/3;      //anchor A length
    LB:=-STR_Spline[ii].LenB/3;     //anchor B length

    for kk:=0 to SNI_LOD do begin //Compute basic spline
      T:=kk/SNI_LOD; //0..1 range
      x0:=STR_Point[PA].x; x1:=x0+STR_Point[PA].tx*LA;
      x3:=STR_Point[PB].x; x2:=x3+STR_Point[PB].tx*LB;
      y0:=STR_Point[PA].y; y1:=y0+STR_Point[PA].ty*LA;
      y3:=STR_Point[PB].y; y2:=y3+STR_Point[PB].ty*LB;
      z0:=STR_Point[PA].z; z1:=z0+STR_Point[PA].tz*LA;
      z3:=STR_Point[PB].z; z2:=z3+STR_Point[PB].tz*LB;
      cx:=3*(x1-x0); bx:=3*(x2-x1)-cx; ax:=x3-x0-cx-bx; Spline[ii,kk].x:=ax*t*t*t+bx*t*t+cx*t+x0;
      cy:=3*(y1-y0); by:=3*(y2-y1)-cy; ay:=y3-y0-cy-by; Spline[ii,kk].y:=ay*t*t*t+by*t*t+cy*t+y0;
      cz:=3*(z1-z0); bz:=3*(z2-z1)-cz; az:=z3-z0-cz-bz; Spline[ii,kk].z:=az*t*t*t+bz*t*t+cz*t+z0;
    end;
    for kk:=1 to SNI_LOD-1 do begin //Compute basic spline tangents
      Spline[ii,kk].tx:=Spline[ii,kk+1].x-Spline[ii,kk-1].x;
      Spline[ii,kk].tz:=Spline[ii,kk+1].z-Spline[ii,kk-1].z;
      Normalize(Spline[ii,kk].tx,Spline[ii,kk].tz);
      T:=arctan2(Spline[ii,kk].tx,Spline[ii,kk].tz); T:=T-0.5*pi; //making tangent into perpendicular
      Spline[ii,kk].tx:=sin(T); Spline[ii,kk].tz:=cos(T);
    end; //use nodes tangents for edges

    Spline[ii,0].tx:=x1-x0; Spline[ii,0].tz:=z1-z0;
    T:=arctan2(Spline[ii,0].tx,Spline[ii,0].tz); T:=T-0.5*pi;
    Spline[ii,0].tx:=sin(T); Spline[ii,0].tz:=cos(T);
    Spline[ii,SNI_LOD].tx:=x2-x3; Spline[ii,SNI_LOD].tz:=z2-z3;
    T:=arctan2(Spline[ii,SNI_LOD].tx,Spline[ii,SNI_LOD].tz); T:=T+0.5*pi; //opposite direction perpendicular
    Spline[ii,SNI_LOD].tx:=sin(T); Spline[ii,SNI_LOD].tz:=cos(T);
  end;

  //Centerlines
  if (A<>0)and(A<>1) then
  for ii:=1 to STRHead.NumSplines do begin
    glColor4f(0,0,0,1);
    glLineWidth(1);
    glbegin (GL_LINE_STRIP);
    for kk:=0 to SNI_LOD do glvertex3fv(@Spline[ii,kk].x);
    glEnd;
  end;

//Splines
glbegin (gl_quads);
for ii:=1 to STRHead.NumSplines do begin

    glLineWidth(LineWidth);
    if ii=SplineID then glLineWidth(2*LineWidth);

    Col:=0;
    ShapeID:=STR_ShRef[STR_Spline[ii].FirstShRef+1].Shape+1;
    Speed:=STR_ShRef[STR_Spline[ii].FirstShRef+1].Speed/65535;
    for j:=1 to STR_Shape[ShapeID].NumLanes do begin //Draw 2-lane roads
    if (j=2)and(STR_Shape[ShapeID].Options<>0) then break;
      for kk:=0 to SNI_LOD-1 do begin

          T:=kk/SNI_LOD;
          //Set new Shape color from predefined place
          if (    (Col+1)<STR_Spline[ii].NumShRefs)
          and(T>STR_ShRef[STR_Spline[ii].FirstShRef+1+Col+1].StartU) //bigger than next
          then begin
          inc(Col);
          ShapeID:=STR_ShRef[STR_Spline[ii].FirstShRef+1+Col].Shape+1;
          Speed:=STR_ShRef[STR_Spline[ii].FirstShRef+1+Col].Speed/65535;
          end;

          if A=0 then kSetColorCode(kSpline,ii) else
          if ii=SplineID then glColor4f(1,1,1,A) else
          case Form1.STR_Mode.ItemIndex of
          0: SetPresetColorGL(ShapeID,A);
          1: glColor4f(Speed,1-Speed,0,A);
          2: SetPresetColorGL(STR_Spline[ii].Options+1,A);
          3: SetPresetColorGL(STR_Spline[ii].NumWays*2+1,A);
          4: SetPresetColorGL(STR_Spline[ii].Density+1,A);
          end;

              Offset:=STR_Shape[ShapeID].Offset[j];

              v.x:=Spline[ii,kk].x-Spline[ii,kk].tx*(Offset-CarWidth);
              v.y:=Spline[ii,kk].y+0.1;
              v.z:=Spline[ii,kk].z-Spline[ii,kk].tz*(Offset-CarWidth);
              glvertex3fv(@v);

              v.x:=Spline[ii,kk].x-Spline[ii,kk].tx*(Offset+CarWidth);
              v.z:=Spline[ii,kk].z-Spline[ii,kk].tz*(Offset+CarWidth);
              glvertex3fv(@v);

              v.x:=Spline[ii,kk+1].x-Spline[ii,kk+1].tx*(Offset+CarWidth);
              v.y:=Spline[ii,kk+1].y+0.1;
              v.z:=Spline[ii,kk+1].z-Spline[ii,kk+1].tz*(Offset+CarWidth);
              glvertex3fv(@v);

              v.x:=Spline[ii,kk+1].x-Spline[ii,kk+1].tx*(Offset-CarWidth);
              v.z:=Spline[ii,kk+1].z-Spline[ii,kk+1].tz*(Offset-CarWidth);
              glvertex3fv(@v);

      end;
    end; //for j:=1 to 2 do begin //Draw 2-lane roads
end;
glEnd;

//Draw vertice tangents
if (A<>0)and(A<>1) then begin
glLineWidth(1);
glbegin (GL_LINES);
  for ii:=1 to STRHead.NumPoints do begin
  glColor4f(1,1,0,1);
  glvertex3f(STR_Point[ii].x+STR_Point[ii].tx*100,
             STR_Point[ii].y+STR_Point[ii].ty*100,
             STR_Point[ii].z+STR_Point[ii].tz*100);
//  glColor4f(0.5,0.5,1,1);
  glvertex3f(STR_Point[ii].x-STR_Point[ii].tx*100,
             STR_Point[ii].y-STR_Point[ii].ty*100,
             STR_Point[ii].z-STR_Point[ii].tz*100);
  end;
glEnd;
end;

//Render current selected spline anchors
if (A<>1) then
if SplineID<>0 then begin
PA:=STR_Spline[SplineID].PtA+1;
PB:=STR_Spline[SplineID].PtB+1;
LA:=STR_Spline[SplineID].LenA/3;
LB:=-STR_Spline[SplineID].LenB/3;
TA1.x:=STR_Point[PA].x+STR_Point[PA].tx*LA;
TA1.y:=STR_Point[PA].y+STR_Point[PA].ty*LA;
TA1.z:=STR_Point[PA].z+STR_Point[PA].tz*LA;
TB1.x:=STR_Point[PB].x+STR_Point[PB].tx*LB;
TB1.y:=STR_Point[PB].y+STR_Point[PB].ty*LB;
TB1.z:=STR_Point[PB].z+STR_Point[PB].tz*LB;
  //Render Anchor lines
//  if A<>0 then begin
  glLineWidth(LineWidth/2);
  glbegin (GL_LINES);
  if A=0 then kSetColorCode(kSplineAnchorLength,PA) else glColor4f(1,1,1,1);
  glvertex3f(STR_Point[PA].x-STR_Point[PA].tx*LA, STR_Point[PA].y-STR_Point[PA].ty*LA, STR_Point[PA].z-STR_Point[PA].tz*LA);
  glvertex3fv(@TA1);
  if A=0 then kSetColorCode(kSplineAnchorLength,PB) else glColor4f(1,1,1,1);
  glvertex3f(STR_Point[PB].x-STR_Point[PB].tx*LB, STR_Point[PB].y-STR_Point[PB].ty*LB, STR_Point[PB].z-STR_Point[PB].tz*LB);
  glvertex3fv(@TB1);
  glEnd;
//  end;
glBegin(GL_POINTS);
glPointSize(PointSize);
if A=0 then kSetColorCode(kSplineAnchor,PA) else glColor4f(1,0,1,1);
glvertex3fv(@TA1);
if A=0 then kSetColorCode(kSplineAnchor,PB) else glColor4f(0,1,1,1);
glvertex3fv(@TB1);
glEnd;
end;

if (A<>0)and(A<>1)and(SelectionQueue1[1]<>0) then begin
glLineWidth(LineWidth/3);
glbegin (GL_LINES);
  glColor4f(1,0.5,0,1);
  glvertex3fv(@STR_Point[SelectionQueue1[1]].x);
  glColor4f(1,0,0,1);
  glvertex3fv(@MPos.X);
glEnd;
end;

//if DT then glEnable(GL_DEPTH_TEST);

glPointSize(PointSize);
//All nodes
if A<>0 then begin
glColor4f(1,1,0,A);
glbegin (GL_POINTS);
for ii:=1 to STRHead.NumPoints do glvertex3fv(@STR_Point[ii].x);
glColor4f(1,0,0,1); if NodeID<>0 then glvertex3fv(@STR_Point[NodeID].x);
glColor4f(1,0.5,0,1); if SelectionQueue1[1]<>0 then glvertex3fv(@STR_Point[SelectionQueue1[1]].x);
glEnd;
end;

//All nodes for selection buffer
if A=0 then begin
glbegin (GL_POINTS);
for ii:=1 to STRHead.NumPoints do begin
kSetColorCode(kPoint,ii);
glvertex3fv(@STR_Point[ii].x);
end;
glEnd;
end;

//if DT then glEnable(GL_DEPTH_TEST);
glLineWidth(LineWidth);
end;

procedure RenderRoadNet();
var ii:integer;
begin
glbegin(GL_POINTS);
for ii:=1 to NETHead.Num1 do begin
SetPresetColorGL(NET1[ii].f,1);
//glColor3f(NET1[ii].a/4,NET1[ii].b/4,NET1[ii].c/4);
//glColor3f(NET1[ii].d/16,NET1[ii].e/16,NET1[ii].f/16);
glvertex3fv(@NET1[ii].x);
end;
glEnd;
glbegin(GL_LINES);
for ii:=1 to NETHead.Num2 do begin
glvertex3fv(@NET1[NET2[ii].a+1].x);
glvertex3fv(@NET1[NET2[ii].b+1].x);
end;
glEnd;
end;


procedure RenderAnimated(A:single; Mode:string; ObjID,NodeID:integer);
var ii,kk:integer; xyz,hpb:array[1..3]of single;
begin
if Mode='Paths' then
if A<>0 then begin
for ii:=1 to SNIHead.Obj do begin
  if ii=ObjID then begin glLineWidth(LineWidth*2); glPointSize(PointSize*2); end;
  if ii=ObjID+1 then begin glLineWidth(LineWidth); glPointSize(PointSize); end; //restore

    SetPresetColorGL(ii,A);
    if SNIObj[ii].Mode<5 then begin
      glbegin(GL_LINE_LOOP);
      for kk:=1 to SNIObj[ii].NumNodes*fOptions.SplineDetail do
      glvertex3fv(@SNISubNode[ii,kk]);
    end else if SNIObj[ii].Mode=5 then begin
      glbegin(GL_LINE_STRIP);
      for kk:=1 to (SNIObj[ii].NumNodes-1)*fOptions.SplineDetail+1 do
      glvertex3fv(@SNISubNode[ii,kk]);
    end else if (SNIObj[ii].Mode=6)and(SNISpawnW[ii].TrackID<>0) then begin
      glbegin(GL_LINE_STRIP);
      for kk:=1 to TRKQty[SNISpawnW[ii].TrackID].Nodes do
      glvertex3fv(@TRK[SNISpawnW[ii].TrackID].Route[kk].X);
    end;
    glEnd;

  glbegin(GL_POINTS);
    for kk:=1+SNIObj[ii].firstNode to SNIObj[ii].NumNodes+SNIObj[ii].firstNode do
      glvertex3fv(@SNINode[kk].X);
  glEnd;
end;

  if ObjID<>0 then
  for kk:=1 to SNIObj[ObjID].NumNodes do begin
    glColor4f(1,1,1,1);
    if kk=NodeID then glColor4f(1,0,0,1);
    glRasterPos3fv(@SNINode[kk+SNIObj[ObjID].firstNode].X);
    glPrint(' '+inttostr(kk)+' '+inttostr(round(SNINode[kk+SNIObj[ObjID].firstNode].Speed))+'kmh');
      glLineWidth(1);
      glbegin(GL_LINES);
      glvertex3fv(@SNITang[kk+SNIObj[ObjID].firstNode,1]);
      glvertex3fv(@SNITang[kk+SNIObj[ObjID].firstNode,2]);
      glEnd;
  end;

end else begin
glPointSize(PointSize*2);
glbegin(GL_POINTS);
  for ii:=1 to SNIHead.Obj do
  for kk:=1+SNIObj[ii].firstNode to SNIObj[ii].NumNodes+SNIObj[ii].firstNode do begin
  kSetColorCode(KPoint,kk); glvertex3fv(@SNINode[kk].X); end;
glEnd;
end;

glLineWidth(LineWidth);
glPointSize(PointSize);

if (A=1)or(Mode='Objects') then begin
  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER,0.5);

  for ii:=1 to SNIHead.Obj do begin
    GetPositionFromSNISpeed(ii,@xyz[1],@xyz[2],@xyz[3],@hpb[1],@hpb[2],@hpb[3]);
    glColor4f(1,1,1,1);
    glPushMatrix;
      glTranslatef(xyz[1],xyz[2],xyz[3]);
      glRotatef(hpb[2],0,1,0);
      glRotatef(hpb[1],1,0,0);
      if SNIObj[ii].Mode in [2,4] then
        glRotatef(hpb[3],0,0,1);

      RenderObject(SNIObj[ii].objID+1);
    glPopMatrix;
  end;//ii:=1..

  glBindTexture(GL_TEXTURE_2D,0);
  glDisable(GL_ALPHA_TEST);
end;

end;

procedure RenderObject(ObjectID:integer);
var kk:integer;
begin
      for kk:=1 to length(ObjCall[ObjectID].Call) do begin
      glBindTexture(GL_TEXTURE_2D,ObjTex[ObjectID,kk-1]);
      glCallList(ObjCall[ObjectID].Call[kk-1]);
      glBindTexture(GL_TEXTURE_2D,0);
      end;
end;

procedure RenderTracksWP(a:single; TrackWP,Node:integer);
var ii:integer;
begin
  if TrackWP=0 then exit;

  if A<>0 then begin
    glBegin(GL_LINE_STRIP);
    for ii:=1 to WTR[TrackWP].NodeQty do begin
      glColor4f(1-ii/WTR[TrackWP].NodeQty,ii/WTR[TrackWP].NodeQty,0,1);
      glVertex3fv(@WTR[TrackWP].Node[ii].X);
    end;
    glEnd;

    glLineWidth(1);
    glColor4f(1,1,0,1);
    glBegin(GL_LINES);
    for ii:=1 to WTR[TrackWP].NodeQty do begin
      glVertex3f(WTR[TrackWP].Node[ii].X+WTR[TrackWP].Node[ii].M[1]*50,
                 WTR[TrackWP].Node[ii].Y+WTR[TrackWP].Node[ii].M[4]*50,
                 WTR[TrackWP].Node[ii].Z+WTR[TrackWP].Node[ii].M[7]*50);
      glVertex3f(WTR[TrackWP].Node[ii].X-WTR[TrackWP].Node[ii].M[1]*50,
                 WTR[TrackWP].Node[ii].Y-WTR[TrackWP].Node[ii].M[4]*50,
                 WTR[TrackWP].Node[ii].Z-WTR[TrackWP].Node[ii].M[7]*50);
    end;
    glEnd;
  end;

  glLineWidth(LineWidth);

  glBegin(GL_POINTS);
  for ii:=1 to WTR[TrackWP].NodeQty do begin
    SetPresetColorGL(WTR[TrackWP].Node[ii].CheckPointID,1);
    if A=0 then kSetColorCode(KPoint,ii);
    glVertex3fv(@WTR[TrackWP].Node[ii].X);
  end;
  glColor3f(1,0,0);
  if (Node<>0)and(A<>0) then glvertex3fv(@WTR[TrackWP].Node[Node].X);
  glEnd;

end;

procedure RenderTracks(ID,Turn,Na,Nz:integer);
var ii,kk,A,B,C:integer;
begin
if ID=0 then exit; //no track selected
if TRKQty[ID].Nodes=0 then exit; //empty track
glLineWidth(1);

//Draw Tunnels
glColor4f(1,0.1,0.65,0.4); ii:=0;
repeat inc(ii);

if TRK[ID].Route[ii].Tunnel=0 then
while ((ii<=TRKQty[ID].Nodes)and(TRK[ID].Route[ii].Tunnel=0)) do inc(ii);

    if (ii<=TRKQty[ID].Nodes)and(TRK[ID].Route[ii].Tunnel<>0) then begin
    glbegin(gl_quads);
    repeat
      with TRK[ID].Route[ii] do begin
      glvertex3f(X+Margin1*Matrix[1]/10,Y+Margin1*Matrix[4]/10+15,Z+Margin1*Matrix[7]/10);
      glvertex3f(X+Margin1*Matrix[1]/10,Y+Margin1*Matrix[4]/10,Z+Margin1*Matrix[7]/10);
      end;
      with TRK[ID].Route[ii+1] do begin
      glvertex3f(X+Margin1*Matrix[1]/10,Y+Margin1*Matrix[4]/10,Z+Margin1*Matrix[7]/10);
      glvertex3f(X+Margin1*Matrix[1]/10,Y+Margin1*Matrix[4]/10+15,Z+Margin1*Matrix[7]/10);
      end;
      with TRK[ID].Route[ii] do begin
      glvertex3f(X+Margin2*Matrix[1]/10,Y+Margin2*Matrix[4]/10,Z+Margin2*Matrix[7]/10);
      glvertex3f(X+Margin2*Matrix[1]/10,Y+Margin2*Matrix[4]/10+15,Z+Margin2*Matrix[7]/10);
      end;
      with TRK[ID].Route[ii+1] do begin
      glvertex3f(X+Margin2*Matrix[1]/10,Y+Margin2*Matrix[4]/10+15,Z+Margin2*Matrix[7]/10);
      glvertex3f(X+Margin2*Matrix[1]/10,Y+Margin2*Matrix[4]/10,Z+Margin2*Matrix[7]/10);
      end;
    inc(ii);
    until((ii>=TRKQty[ID].Nodes)or(TRK[ID].Route[ii].Tunnel=0));
    glEnd;
    end;

until(ii>=TRKQty[ID].Nodes);

//Draw Columns
glColor4f(1,0.65,0.1,0.4); ii:=0;
repeat inc(ii);

if TRK[ID].Route[ii].Column=0 then
while (ii+1<TRKQty[ID].Nodes)and(TRK[ID].Route[ii+1].Column=0) do inc(ii);

    if (ii+1<TRKQty[ID].Nodes)and(TRK[ID].Route[ii+1].Column<>0) then begin
    glbegin(gl_quads);
    repeat
      with TRK[ID].Route[ii] do begin
      glvertex3f(X-Column*Matrix[1]/10,Y-Column*Matrix[4]/10,Z-Column*Matrix[7]/10);
      glvertex3f(X-Column*Matrix[1]/10,Y-Column*Matrix[4]/10+15,Z-Column*Matrix[7]/10);
      end;
      with TRK[ID].Route[ii+1] do begin
      glvertex3f(X-Column*Matrix[1]/10,Y-Column*Matrix[4]/10+15,Z-Column*Matrix[7]/10);
      glvertex3f(X-Column*Matrix[1]/10,Y-Column*Matrix[4]/10,Z-Column*Matrix[7]/10);
      end;
      with TRK[ID].Route[ii] do begin
      glvertex3f(X+Column*Matrix[1]/10,Y+Column*Matrix[4]/10+15,Z+Column*Matrix[7]/10);
      glvertex3f(X+Column*Matrix[1]/10,Y+Column*Matrix[4]/10,Z+Column*Matrix[7]/10);
      end;
      with TRK[ID].Route[ii+1] do begin
      glvertex3f(X+Column*Matrix[1]/10,Y+Column*Matrix[4]/10,Z+Column*Matrix[7]/10);
      glvertex3f(X+Column*Matrix[1]/10,Y+Column*Matrix[4]/10+15,Z+Column*Matrix[7]/10);
      end;
    inc(ii);
    until((ii>=TRKQty[ID].Nodes)or(TRK[ID].Route[ii].Column=0));
    glEnd;
    end;

until(ii>=TRKQty[ID].Nodes);

//Draw CenterLine
if TRKQty[ID].LoopFlag=1 then glbegin(GL_LINE_LOOP) else glbegin(GL_LINE_STRIP);
for ii:=1 to TRKQty[ID].Nodes do begin
//glColor4ub(TRK[ID].Route[ii].v3,TRK[ID].Route[ii].v4,0,255);
glColor4ub(TRK[ID].Route[ii].v1,TRK[ID].Route[ii].v2,0,255);
glvertex3fv(@TRK[ID].Route[ii].X);
end;
glEnd;

//Draw IdealLine
glColor4f(1,1,1,1);
if TRKQty[ID].LoopFlag=1 then glbegin(GL_LINE_LOOP) else glbegin(GL_LINE_STRIP);
for ii:=1 to TRKQty[ID].Nodes do begin
glvertex3f(TRK[ID].Route[ii].X+TRK[ID].Route[ii].Ideal*TRK[ID].Route[ii].Matrix[1],
           TRK[ID].Route[ii].Y+TRK[ID].Route[ii].Ideal*TRK[ID].Route[ii].Matrix[4],
           TRK[ID].Route[ii].Z+TRK[ID].Route[ii].Ideal*TRK[ID].Route[ii].Matrix[7]);
end;
glEnd;

//Draw RightMargin
glColor4f(0.3,0.3,1,1);
if TRKQty[ID].LoopFlag=1 then glbegin(GL_LINE_LOOP) else glbegin(GL_LINE_STRIP);
for ii:=1 to TRKQty[ID].Nodes do
glvertex3f(
TRK[ID].Route[ii].X+TRK[ID].Route[ii].Margin1/10*TRK[ID].Route[ii].Matrix[1],
TRK[ID].Route[ii].Y+TRK[ID].Route[ii].Margin1/10*TRK[ID].Route[ii].Matrix[4],
TRK[ID].Route[ii].Z+TRK[ID].Route[ii].Margin1/10*TRK[ID].Route[ii].Matrix[7]);
glEnd;

//Draw LeftMargin
glColor4f(1,0.3,0.3,1);
if TRKQty[ID].LoopFlag=1 then glbegin(GL_LINE_LOOP) else glbegin(GL_LINE_STRIP);
for ii:=1 to TRKQty[ID].Nodes do glvertex3f(
TRK[ID].Route[ii].X+TRK[ID].Route[ii].Margin2/10*TRK[ID].Route[ii].Matrix[1],
TRK[ID].Route[ii].Y+TRK[ID].Route[ii].Margin2/10*TRK[ID].Route[ii].Matrix[4],
TRK[ID].Route[ii].Z+TRK[ID].Route[ii].Margin2/10*TRK[ID].Route[ii].Matrix[7]);
glEnd;

//Draw DirectionArrowsAreas
glColor4f(0,1,0,1);
for ii:=1 to TRKQty[ID].Turns do begin
glbegin(GL_LINE_STRIP);
  for kk:=1 to TRK[ID].Turns[ii].ArrowNum do
  glvertex3fv(@TRK[ID].Turns[ii].Arrows[kk].X);
glEnd;
end;

//if Turn<>0 then begin
for Turn:=1 to TRKQty[ID].Turns do begin

    case TRK[ID].Turns[Turn].BitFlag mod 16 of
    1:glColor4f(0,  0.3,1,  0.5); //left
    2:glColor4f(1,  0.3,0,  0.5); //right
    3:glColor4f(0.3,1,  0.3,0.5); //both
    end;

    for ii:=1 to TRK[ID].Turns[Turn].ArrowNum do begin
    glPushMatrix;
    Matrix2Angles(TRK[ID].Turns[Turn].Arrows[ii].Matrix,9,@a,@b,@c);
    glTranslatef(TRK[ID].Turns[Turn].Arrows[ii].X,TRK[ID].Turns[Turn].Arrows[ii].Y+20,TRK[ID].Turns[Turn].Arrows[ii].Z);
    glRotatef(a,1,0,0); glRotatef(b,0,1,0); glRotatef(c,0,0,1);
    glScalef(0,30,30);
    glCallList(coArrow);
    glPopMatrix;
    end;

end;

glLineWidth(LineWidth);
glPointSize(PointSize);

//Draw direction arrows edge nodes
glbegin(GL_POINTS);
glColor4f(0.7,0.7,0.7,1);
glvertex3fv(@TRK[ID].Route[Form1.E_Node1.Value+1].X);
glColor4f(1,1,1,1);
glvertex3fv(@TRK[ID].Route[Form1.E_Node2.Value+1].X);
glEnd;

//Draw Start/Finish
glbegin(GL_POINTS);
glColor4f(1,1,0,1);
glvertex3fv(@TRK[ID].Route[1].X);
glColor4f(0,1,1,1);
glvertex3fv(@TRK[ID].Route[TRKQty[ID].Nodes].X);
glEnd;
end;


procedure RenderLights(A:single; Mode:string; ID:integer);
var ii:integer; h,p,b:integer;
begin
//glPointSize(PointSize);
glLineWidth(1);
if Mode<>'OnlyFlares' then begin
  glbegin(GL_POINTS);
  for ii:=1 to Qty.Lights do
  if GetLength(Light[ii].Matrix2[13]-xPos,Light[ii].Matrix2[15]-zPos)<fOptions.ViewDistance-300 then begin
    if A<>0 then glColor4f(Light[ii].R/255,Light[ii].G/255,Light[ii].B/255,A)
    else kSetColorCode(KPoint,ii);
    glvertex3fv(@Light[ii].Matrix2[13]);
  end;
  glEnd;
end;

glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  for ii:=1 to Qty.Lights do
  if GetLength(Light[ii].Matrix2[13]-xPos,Light[ii].Matrix2[15]-zPos)<fOptions.ViewDistance-300 then
  if Light[ii].Mode=8 then begin
    glPushMatrix;
      glTranslatef(Light[ii].Matrix2[13],Light[ii].Matrix2[14],Light[ii].Matrix2[15]);
      Matrix2Angles(Light[ii].Matrix2,16,@h,@p,@b);
      glRotatef(h,1,0,0); glRotatef(p+90,0,1,0); glRotatef(b,0,0,1);
      glkScale(Light[ii].Size*10);
      glColor4f(Light[ii].R/255,Light[ii].G/255,Light[ii].B/255,A);
      glBindTexture(GL_TEXTURE_2D,FlareTex);
      if (GetTickCount-round(Light[ii].Offset*1000)) mod 1000 < round(Light[ii].Freq*1000) then
      glCallList(coSquare);
    glPopMatrix;
  end;
glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
glBindTexture(GL_TEXTURE_2D,0);

if Mode<>'OnlyFlares' then begin
if A<>0 then 
for ii:=1 to Qty.Lights do
if GetLength(Light[ii].Matrix2[13]-xPos,Light[ii].Matrix2[15]-zPos)<fOptions.ViewDistance-300 then begin
glPushMatrix;
  glTranslatef(Light[ii].Matrix2[13],Light[ii].Matrix2[14],Light[ii].Matrix2[15]);
  glColor4f(1,1,1,A);
  glScalef(LightW[ii].Radius*10,0,LightW[ii].Radius*10);
  glCallList(coCircleXZ);
glPopMatrix;
end;
end;
glLineWidth(LineWidth);
glPointSize(PointSize);
end;


procedure RenderMakeTrack(A:single; ID:integer);
var ii,kk:integer; n0,n2:integer; TMP:vector3f;
begin
if TrackID=0  then exit;
if MakeTrack[TrackID].NodeQty=0 then exit;
glPointSize(PointSize*2);
glLineWidth(1);
  glbegin(GL_POINTS);
  for ii:=1 to MakeTrack[TrackID].NodeQty do begin
    if A<>0 then
      if ii=ID then glColor4f(1,0.5,0,A) else glColor4f(1,1,1,A)
    else kSetColorCode(kPoint,ii);
    glvertex3fv(@MakeTrack[TrackID].Node[ii].X);
  end;
  glEnd;

glLineWidth(LineWidth);
glPointSize(PointSize);
if A=0 then exit;

  glbegin(GL_LINE_STRIP);
    glColor4f(1,1,1,A);
    for ii:=1 to MakeTrack[TrackID].NodeQty do
    if (ii<MakeTrack[TrackID].NodeQty)or(TRKQty[TrackID].LoopFlag=1) then
      for kk:=1 to fOptions.SplineDetail do
        glvertex3fv(@MakeTrack[TrackID].Node[ii].Sub[kk]);
  glEnd;

  glbegin(GL_LINE_STRIP);
    glColor4f(1,0,0,A);
    for ii:=1 to MakeTrack[TrackID].NodeQty do
      if (ii<MakeTrack[TrackID].NodeQty)or(TRKQty[TrackID].LoopFlag=1) then
      for kk:=1 to fOptions.SplineDetail do begin
        n0:=EnsureRange(kk-1,1,fOptions.SplineDetail);
        n2:=EnsureRange(kk+1,1,fOptions.SplineDetail);
        with MakeTrack[TrackID].Node[ii] do
        Tmp:=Perpendecular2D(Sub[n0],Sub[kk],Sub[n2],mix(RoadWidth,MakeTrack[TrackID].Node[ii mod MakeTrack[TrackID].NodeQty +1].RoadWidth,1-(kk-1)/fOptions.SplineDetail)/2);
        glvertex3fv(@Tmp);
      end;
  glEnd;
  glbegin(GL_LINE_STRIP);
    glColor4f(0,0,1,A);
    for ii:=1 to MakeTrack[TrackID].NodeQty do
      if (ii<MakeTrack[TrackID].NodeQty)or(TRKQty[TrackID].LoopFlag=1) then
      for kk:=1 to fOptions.SplineDetail do begin
        n0:=EnsureRange(kk-1,1,fOptions.SplineDetail);
        n2:=EnsureRange(kk+1,1,fOptions.SplineDetail);
        with MakeTrack[TrackID].Node[ii] do
        Tmp:=Perpendecular2D(Sub[n0],Sub[kk],Sub[n2],-mix(RoadWidth,MakeTrack[TrackID].Node[ii mod MakeTrack[TrackID].NodeQty +1].RoadWidth,1-(kk-1)/fOptions.SplineDetail)/2);
        glvertex3fv(@Tmp);
      end;
  glEnd;

end;

procedure RenderSounds(A:single; Input:integer);
var ii:integer;
begin
if Input<>0 then RenderMover(Sound[Input].X,Sound[Input].Y,Sound[Input].Z);
glPointSize(PointSize);
glLineWidth(1);
if A<>0 then begin
glColor4f(1,0,1,A);
glbegin(GL_POINTS);
for ii:=1 to Qty.Sounds do
glvertex3fv(@Sound[ii].X);
glEnd;

glColor4f(1,1,1,A);
for ii:=1 to Qty.Sounds do begin
glPushMatrix;
  glTranslatef(Sound[ii].X,Sound[ii].Y,Sound[ii].Z);
  glkScale(Sound[ii].Radius*100);
  glCallList(coCircleXZ);
glPopMatrix;
end;

//Sound value for Listener
for ii:=1 to Qty.Sounds do
if SoundW[ii].InList<>0 then begin
glPushMatrix;
  glTranslatef(Sound[ii].X,Sound[ii].Y,Sound[ii].Z);
  glkScale(Sound[ii].Radius*100*WaveList[SoundW[ii].InList].Dist);
  glColor4f(byte(SoundW[ii].IsPlaying),byte(SoundW[ii].IsPlaying),byte(SoundW[ii].IsPlaying),A*0.4);
  glCallList(coRoundXZ);
glPopMatrix;
end;

for ii:=1 to SNIHead.Obj do begin
glPushMatrix;
  GetPositionFromSNI(ii,SNILoc[ii],@Dif[1],@Dif[2],@Dif[3]);
  glTranslatef(Dif[1],Dif[2],Dif[3]);
  glkScale(SNIObj[ii].Radius*100);
  glColor4f(1,1,0,A);
  glCallList(coCircleXZ);
  if SoundW[Qty.Sounds+ii].InList<>0 then begin
    glkScale(WaveList[SoundW[Qty.Sounds+ii].InList].Dist);
    glColor4f(byte(SoundW[Qty.Sounds+ii].IsPlaying),byte(SoundW[Qty.Sounds+ii].IsPlaying),0,A*0.4);
    glCallList(coRoundXZ);
  end;
  if SoundW[Qty.Sounds+ii].WaveID<>0 then begin
    glColor4f(0,1,1,A);
    glbegin(GL_POINTS);
    glvertex3f(0,0,0);
  end;
  glEnd;
glPopMatrix;
end;


end;

  if A=0 then begin
  glBegin(GL_POINTS);
    for ii:=1 to Qty.Sounds do begin
    kSetColorCode(kPoint,ii);
    glvertex3fv(@Sound[ii].X);
    end;
  glEnd;
  end;
  glLineWidth(LineWidth);
end;

procedure RenderObjectsShaders(A,In1,In2:integer);
//var ii,kk,ID:integer;
begin
{
Not yet completed
ID:=Obj[ii].ID+1;
for ii:=1 to Qty.ObjectsTotal do if ID<=list_obj then
if ((not fOptions.ReduceDisplay)and(RenderMode>=rmFull))or(
GetLength(Obj[ii].PosX-xPos,Obj[ii].PosZ-zPos)<ViewDistance-500) then begin

  glPushMatrix;
  glTranslatef(Obj[ii].PosX,Obj[ii].PosY,Obj[ii].PosZ);
  glScalef(Obj[ii].Size,Obj[ii].Size,Obj[ii].Size);

    case ObjProp[ID].Mode of
    3,8: glRotateff(xRot,0,1,0); //Sprite
    4: begin glRotateff(Obj[ii].Angl/pi*180,0,1,0); glRotateff(sin((GetTickCount+RandomArray[ii mod 256])/500)*4,1,0,0.4); end;//Waving on water
    7: glRotateff((GetTickCount div 10) mod 360,0,0,1); //Rotate
    16:
    else glRotateff(Obj[ii].Angl/pi*180,0,1,0);
    end;

  if A=0 then kSetColorCode(kObject,ii) else
  if Obj[ii].InShadow=0 then glColor4f(1.8,1.8,1.8,1) else glColor4f(0.8,0.8,0.8,1);

    for kk:=1 to length(ObjCall[ID].Call) do begin
    if (Obj[ii].Name[1]+Obj[ii].Name[2]='T\')and(kk=2) then glRotateff(xRot,0,1,0); //Sprite

glUseProgramObjectARB(opo[ObjCall[ID].MTLClass]);

  S_MtlCol:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('SCol')));
  S_SunCol:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('SunCol')));
  S_SunPos:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('SunPos')));
  S_FogCol:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('FogCol')));
  S_FogPos:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('FogPos')));
  S_Tex1:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('Tex1')));
  S_Tex2:= glGetUniformLocationARB(opo[ObjCall[ID].MTLClass], PGLcharARB(PChar('Tex2')));

//skipping unused textures for materials doesn't affect perfomance

glActiveTexture(GL_TEXTURE0);
if A<>0 then glBindTexture(GL_TEXTURE_2D,ObjTex[ID,kk-1]);
glUniform1iARB(S_Tex1, 0);

glActiveTexture(GL_TEXTURE1);
glBindTexture(GL_TEXTURE_2D,EnvMap);
glUniform1iARB(S_Tex2,1);


if (Form1.CBShowTexGrass.Checked)or(SKYIndex=0) then glUniform3fARB(S_SunCol,0.5,0.5,0.5) else
glUniform3fARB(S_SunCol,SKY[SKYIndex].SunCol.R/255,SKY[SKYIndex].SunCol.G/255,SKY[SKYIndex].SunCol.B/255);

if SKYIndex=0 then glUniform3fARB(S_FogCol,0.5,0.5,0.5) else
glUniform3fARB(S_FogCol,SKY[SKYIndex].FogCol.R/255,SKY[SKYIndex].FogCol.G/255,SKY[SKYIndex].FogCol.B/255);

glUniform4fARB(S_SunPos,LVL.SunX,LVL.SunY,LVL.SunZ,0);
glUniform4fARB(S_FogPos,xPos,yPos,Zpos,ViewDistance*byte(1)); //Position and FogRange

    glCallList(ObjCall[ID].Call[kk-1]);
    end;

  glPopMatrix;
  end;
   }
end;

procedure RenderObjects(A,In1,In2:integer);
var ii,kk,CallID:integer;
begin
  if A<>0 then begin
    glEnable(GL_ALPHA_TEST);
    glAlphaFunc(GL_GREATER,0.5);
    //glBlendFunc(GL_ONE, GL_ONE);
  end;

  for ii:=1 to Qty.ObjectsTotal do // if ObjProp[Obj[ii].ID+1].Pro1<>3 then
  if Obj[ii].ID+1<=list_obj then
  if ((not fOptions.ReduceDisplay)and(fOptions.RenderMode>=rmFull))or(
  GetLength(Obj[ii].PosX-xPos,Obj[ii].PosZ-zPos)<fOptions.ViewDistance-300) then begin

    CallID := Obj[ii].ID + 1;

    glPushMatrix;
    glTranslatef(Obj[ii].PosX,Obj[ii].PosY,Obj[ii].PosZ);
    glScalef(Obj[ii].Size,Obj[ii].Size,Obj[ii].Size);

    case ObjProp[CallID].Mode of
      3,8:  glRotatef(xRot,0,1,0); //Sprite
      4:    begin glRotatef(Obj[ii].Angl/pi*180,0,1,0); glRotatef(sin((GetTickCount+RandomArray[ii mod 256])/500)*4,1,0,0.4); end;//Waving on water
      7:    glRotatef((GetTickCount div 10) mod 360,0,0,1); //Rotate
      16:   //handled later
      else  glRotatef(Obj[ii].Angl/pi*180,0,1,0);
    end;

    if Obj[ii].InShadow=0 then glColor4f(1.0,1.0,1.0,1) else glColor4f(0.5,0.5,0.5,1);

    if A = 0 then kSetColorCode(kObject,ii);

    for kk:=1 to length(ObjCall[CallID].Call) do begin
      if A<>0 then glBindTexture(GL_TEXTURE_2D,ObjTex[CallID,kk-1]);
      if (Obj[ii].Name[1]+Obj[ii].Name[2]='T\')and(kk=1) then glRotatef(Obj[ii].Angl/pi*180,0,1,0); //Object
      if (Obj[ii].Name[1]+Obj[ii].Name[2]='T\')and(kk=2) then glRotatef(xRot-Obj[ii].Angl/pi*180,0,1,0); //Sprite

      //Special case when I want to render a glowing lightflare
      if (A<>0) and (ObjCall[CallID].Ambi[1]+ObjCall[CallID].Ambi[2]+ObjCall[CallID].Ambi[3]>128) then begin
        glColor3f(ObjCall[CallID].Ambi[1]*1.8/255,ObjCall[CallID].Ambi[2]*1.8/255,ObjCall[CallID].Ambi[3]*1.8/255);
        glDisable(GL_ALPHA_TEST);
        glDisable(GL_LIGHTING);
        //glDisable(GL_DEPTH_TEST);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE);
        glCallList(ObjCall[CallID].Call[kk-1]);
        glEnable(GL_ALPHA_TEST);
        glEnable(GL_LIGHTING);
        //glEnable(GL_DEPTH_TEST);
        glAlphaFunc(GL_GREATER,0.5);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
      end else
        glCallList(ObjCall[CallID].Call[kk-1]);
    end;

    glPopMatrix;
  end;

  glDisable(GL_ALPHA_TEST);
  glBindTexture(GL_TEXTURE_2D,0);

  //render objects points
  if Form1.CBShowObjects.Checked then begin
    glDisable(GL_LIGHTING);
    glDisable(GL_DEPTH_TEST);
    glBegin(GL_POINTS);
    for ii:=1 to Qty.ObjectsTotal do
    if Obj[ii].ID+1=In1 then begin
      if Obj[ii].InShadow=0 then glColor4f(1,1,0,1) else glColor4f(0.4,0.4,0,1);
      if A=0 then kSetColorCode(kObject,ii);
      glvertex3fv(@Obj[ii].PosX);
    end;
    glEnd;
    glEnable(GL_LIGHTING);
    glEnable(GL_DEPTH_TEST);
  end;
end;


procedure RenderTOB_Objects(TrackID,ObjID,A:integer);
var ii,kk:integer;
begin
if TrackID=0 then exit;
if fOptions.RenderMode<rmFull then begin
  glDisable(GL_LIGHTING);
  if ObjID<>0 then RenderMover(TOB[TrackID,ObjID].X,TOB[TrackID,ObjID].Y,TOB[TrackID,ObjID].Z);
  glColor4f(1,1,0,1);
  glbegin(GL_POINTS);
  for ii:=1 to TOBHead[TrackID].Qty do begin
  if A=0 then kSetColorCode(kObject,ii);
  glvertex3fv(@TOB[TrackID,ii].X);
  end;
  glEnd;
end;
  if A<>0 then glEnable(GL_LIGHTING);

  glColor4f(1,1,1,1);
  for ii:=1 to TOBHead[TrackID].Qty do
  if Obj[ii].ID+1<=list_obj then begin
  glPushMatrix;
  glTranslatef(TOB[TrackID,ii].X,TOB[TrackID,ii].Y,TOB[TrackID,ii].Z);
  glRotatef(TOB[TrackID,ii].R1,1,0,0);
  glRotatef(TOB[TrackID,ii].R2,0,1,0);
  glRotatef(TOB[TrackID,ii].R3,0,0,1);
  if A=0 then kSetColorCode(kObject,ii);
    for kk:=1 to length(ObjCall[TOB[TrackID,ii].ID+1].Call) do begin
    if A<>0 then glBindTexture(GL_TEXTURE_2D,ObjTex[TOB[TrackID,ii].ID+1,kk-1]);
    glCallList(ObjCall[TOB[TrackID,ii].ID+1].Call[kk-1]);
    end;
  glPopMatrix;
  end;
  glBindTexture(GL_TEXTURE_2D,0);
//  glEnable(GL_LIGHTING);
end;

procedure RenderCar();
var kk:integer;
begin
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glPushMatrix;
    glColor4f(1,1,1,0.25);
    glTranslatef(CarX,CarY,CarZ); //reset position
    glRotatef(CarH, 0,1,0);
    glRotatef(CarP, 1,0,0);
    glRotatef(CarB, 0,0,1);
    for kk:=1 to length(ObjCall[0].Call) do begin
      glBindTexture(GL_TEXTURE_2D,ObjTex[0,kk-1]);
      glCallList(ObjCall[0].Call[kk-1]);
    end;
  glPopMatrix;
  glBindTexture(GL_TEXTURE_2D,0);
  glDisable(GL_LIGHTING);
  glDisable(GL_DEPTH_TEST);

  glLineWidth(2);
  glPointSize(2);
  glColor4f(0.63,0.63,0.63,1);
  for kk:=1 to 4 do begin
    glPushMatrix;
    glTranslatef(CarWheels[kk].Pos.X,CarWheels[kk].Pos.Y+3,CarWheels[kk].Pos.Z); //reset position
    glkScale(3);
    glRotatef(CarH+CarWheels[kk].Angle.H , 0,1,0);
    glRotatef(CarWheels[kk].Angle.P , 1,0,0);
    glTranslatef(0.4,0,0);
    glCallList(coCircleYZ);
    glTranslatef(-0.8,0,0);
    glCallList(coCircleYZ);
    glPopMatrix;
  end;
end;


procedure RenderVTX(Mode:string);
var ii:integer;
begin
glEnable(GL_DEPTH_TEST);
  if Mode='Points' then begin
  glbegin(GL_POINTS);
    for ii:=1 to VTXQty[64]do begin
    kSetColorCode(kPoint,ii);
    glvertex3fv(@VTX[ii].X);
    end;
  glEnd;
  end;
  if Mode='Materials' then begin
{    for ii:=1 to Qty.TexturesFiles do begin
//    kSetColorCode(kSurface,ii);
    glCallList(ScnCall[ii]);
    end;
                            }
  end;
glDisable(GL_DEPTH_TEST);
end;

procedure RenderGrid(Mode:integer);
var ii,kk,x,z,ci:integer; BlockID:integer; bi:array of integer; s:string;
begin
  if Form1.CBGrid.Checked then begin
  glColor4f(0,1,0,0.25);
  glbegin(GL_LINES);
    for ii:=-Qty.BlocksX*2+1 to Qty.BlocksX*2-1 do begin
    glvertex3f(ii*256,VTX[1].Y,-Qty.BlocksZ*512);  //VTX[1].Y - easy way to get height
    glvertex3f(ii*256,VTX[1].Y, Qty.BlocksZ*512);
    end;
    for ii:=-Qty.BlocksZ*2+1 to Qty.BlocksZ*2-1 do begin
    glvertex3f(-Qty.BlocksX*512,VTX[1].Y,ii*256);  //VTX[1].Y - easy way to get height
    glvertex3f( Qty.BlocksX*512,VTX[1].Y,ii*256);
    end;
  glEnd;
  glColor4f(0,1,0,0.5);
  glbegin(GL_LINES);
    for ii:=-Qty.BlocksX div 2+1 to Qty.BlocksX div 2-1 do begin
    glvertex3f(ii*1024,VTX[1].Y,-Qty.BlocksZ*512);  //VTX[1].Y - easy way to get height
    glvertex3f(ii*1024,VTX[1].Y, Qty.BlocksZ*512);
    end;
    for ii:=-Qty.BlocksZ div 2+1 to Qty.BlocksZ div 2-1 do begin
    glvertex3f(-Qty.BlocksX*512,VTX[1].Y,ii*1024);  //VTX[1].Y - easy way to get height
    glvertex3f( Qty.BlocksX*512,VTX[1].Y,ii*1024);
    end;
  glEnd;
end;

if Qty.Polys=0 then exit;
if Mode>0 then begin
  glColor4f(1,1,1,0.7);
  for kk:=1 to Qty.BlocksZ do for ii:=1 to Qty.BlocksX do
  if GetLength(((ii-0.5)-Qty.BlocksX/2)*1024 - xPos, ((kk-0.5)-Qty.BlocksZ/2)*1024 - zPos) < fOptions.ViewDistance/2 then begin
    glRasterPos3f((ii-Qty.BlocksX div 2-0.7)*1024,VTX[1].Y,(kk-Qty.BlocksZ div 2-0.6)*1024);
    case Mode of
    1:  s:=inttostr(Block[kk,ii].FirstPoly);
    2:  s:=inttostr(Block[kk,ii].NumPoly);
    3:  s:=inttostr(Block[kk,ii].FirstTex);
    4:  s:=inttostr(Block[kk,ii].NumTex);
    5:  s:=inttostr(Block[kk,ii].FirstObj);
    6:  s:=inttostr(Block[kk,ii].NumObj);
    7:  s:=inttostr(Block[kk,ii].FirstLight);
    8:  s:=inttostr(Block[kk,ii].NumLight);
    9:  s:=inttostr(Block[kk,ii].Chunk65k);
    10: s:=inttostr(Block[kk,ii].x1);
    11: begin
          glColor4f(1,1,1,0.3);
          for ci:=1 to 18 do begin
          glPushMatrix;
            glTranslatef(Block[kk,ii].CenterX,Block[kk,ii].CenterY,Block[kk,ii].CenterZ);
            glScalef(Block[kk,ii].Rad,Block[kk,ii].Rad,Block[kk,ii].Rad);
            glRotatef(ci*10, 1, 0, 0);
            glCallList(coCircleXZ);
          glPopMatrix;
          end;
          s:='';
        end;
    end;
    glPrint(s);
  end;
end;
x:=round(xPos/256+0.5+Qty.BlocksX * 2);
z:=round(zPos/256+0.5+Qty.BlocksZ * 2);
x:=EnsureRange(x,1,Qty.BlocksX*4)-1;
z:=EnsureRange(z,1,Qty.BlocksZ*4)-1;

if Form1.CBTracer.Checked then begin
  glColor4f(1,1,1,1); ci:=0;
  repeat
  BlockID:=z*Qty.BlocksX*4+x+1;
  for ii:=1 to v06[BlockID,ci+1] do begin // Polycount; BlockID; ..polys..; Polycount; BlockID; ..polys..; 0-terminator.
  kk:=Block[(v06[BlockID,ci+2]div Qty.BlocksX+1),(v06[BlockID,ci+2]mod Qty.BlocksX+1)].FirstPoly+1;
  kk:=kk+v06[BlockID,ci+2+ii];
  glbegin(GL_LINE_LOOP);
  glvertex3fv(@VTX[v[kk,1]]); glvertex3fv(@VTX[v[kk,2]]); glvertex3fv(@VTX[v[kk,3]]);
  glEnd;
  end;
  inc(ci,v06[BlockID,ci+1]+2); //qty+2
  until(v06[BlockID,ci+1]=0);
end;

if Form1.CBShowSpan.Checked then begin
setlength(bi,256);
krintersect(VTX[v[TracePt,1]].X+Qty.BlocksX*512,VTX[v[TracePt,1]].Z+Qty.BlocksZ*512,
            VTX[v[TracePt,2]].X+Qty.BlocksX*512,VTX[v[TracePt,2]].Z+Qty.BlocksZ*512,
            VTX[v[TracePt,3]].X+Qty.BlocksX*512,VTX[v[TracePt,3]].Z+Qty.BlocksZ*512,
            Qty.BlocksX*4,Qty.BlocksZ*4,bi);
kk:=0;
glColor4f(1,1,1,0.25);
repeat
  glPushMatrix;
  glTranslatef(((bi[kk]-1) mod (Qty.BlocksX*4) +0.5)*256-Qty.BlocksX*512,VTX[1].Y,
              ((bi[kk]-1) div (Qty.BlocksX*4) +0.5)*256-Qty.BlocksZ*512);
  glScalef(256,256,256);
  glCallList(coBox);
  glPopMatrix;
  inc(kk);
until(bi[kk]=0);
end;

if Form1.CBShowTrace.Checked then
if length(Trace2Sun)>1 then begin
for ii:=1 to Trace2Sun[z*Qty.BlocksX*4+x+1,0] do begin
glColor4f(1,1,1,0.25);
  glPushMatrix;
  glTranslatef(((Trace2Sun[z*Qty.BlocksX*4+x+1,ii]-1) mod (Qty.BlocksX*4) +0.5)*256-Qty.BlocksX*512,
                BlockHi[z*Qty.BlocksX*4+x+1],
              ((Trace2Sun[z*Qty.BlocksX*4+x+1,ii]-1) div (Qty.BlocksX*4) +0.5)*256-Qty.BlocksZ*512);
  glScalef(256,0.1,256);
  glCallList(coBox);
  glPopMatrix;
//  inc(kk);
end;
  x:=x*256-Qty.BlocksX*512;
  z:=z*256-Qty.BlocksZ*512;
  glColor4f(1,1,1,0.5);
  glbegin(GL_LINES);
  glvertex3f(x,yPos,z);                 glvertex3f(x+LVL.SunX*100000,yPos,z+LVL.SunZ*100000);
  glvertex3f(x,yPos,(z+256));           glvertex3f(x+LVL.SunX*100000,yPos,(z+256)+LVL.SunZ*100000);
  glvertex3f((x+256),yPos,(z+256));     glvertex3f((x+256)+LVL.SunX*100000,yPos,(z+256)+LVL.SunZ*100000);
  glvertex3f((x+256),yPos,z);           glvertex3f((x+256)+LVL.SunX*100000,yPos,z+LVL.SunZ*100000);
  glEnd;
  glColor4f(1,1,0,1);
  glbegin(GL_LINES);
  glvertex3f(x+128,yPos,z+128);         glvertex3f(x+128+LVL.SunX*100000,yPos,z+128+LVL.SunZ*100000);
  glEnd;
end;
end;

procedure RenderTarget();
begin
if Qty.Polys=0 then exit;
if PlayTrack then exit;
glLineWidth(2);
  glColor4f(1,1,0,1);
  glbegin(GL_LINE_LOOP);
  glvertex3fv(@VTX[v[TracePt,1]].X);
  glvertex3fv(@VTX[v[TracePt,2]].X);
  glvertex3fv(@VTX[v[TracePt,3]].X);
  glEnd;
glLineWidth(LineWidth);
end;

procedure RenderWire();
var ii,i:integer;
v1,v2,v3:array[1..3]of single;
A,B,C:single;
begin
glLineWidth(2);
glPolygonMode(GL_FRONT,GL_LINE);
glBindTexture(GL_TEXTURE_2D,0);
for ii:=1 to Qty.Materials do glCallList(ScnCall2[ii]);

//Render normals
glLineWidth(1);
glColor4f(1,1,0,1);
glBegin(GL_LINES);
for i:=1 to Qty.Polys do
  if GetLength(VTX[v[I,1]].X-xPos,VTX[v[I,1]].Z-zPos)<fOptions.ViewDistance/2 then begin
  v1[1]:=VTX[v[I,1]].X; v1[2]:=VTX[v[I,1]].Y; v1[3]:=VTX[v[I,1]].Z;
  v2[1]:=VTX[v[I,2]].X; v2[2]:=VTX[v[I,2]].Y; v2[3]:=VTX[v[I,2]].Z;
  v3[1]:=VTX[v[I,3]].X; v3[2]:=VTX[v[I,3]].Y; v3[3]:=VTX[v[I,3]].Z;
  Normal2Poly(v1,v2,v3,@A,@B,@C);
  Normalize(A,B,C);
  v1[1]:=(v1[1]+v2[1]+v3[1])/3;
  v1[2]:=(v1[2]+v2[2]+v3[2])/3;
  v1[3]:=(v1[3]+v2[3]+v3[3])/3;
  glVertex3fv(@v1);
  glVertex3f(v1[1]+A*50,v1[2]+B*50,v1[3]+C*50);
end;
glEnd;

glLineWidth(LineWidth);
glPolygonMode(GL_FRONT,GL_FILL);
end;

procedure RenderOpenGL(CBCheckers:boolean);
var ii:integer;
begin
  glBlendFunc(GL_ONE, GL_ZERO);
  glColor4f(1,1,1,1);

  //Render single material
  if Form1.CBShowMat.Checked then begin
    ii:=Form1.ListMaterials.ItemIndex+1;
    if ii=0 then exit;
    if (Material[ii].Tex1+1<=list_tx)and(not CBCheckers) then glBindTexture(GL_TEXTURE_2D,Texture[Material[ii].Tex1+1]);
    glCallList(ScnCall2[ii]);
  end else

  //Render materials
  for ii:=1 to Qty.Materials do
    if (not Form1.CBShowMode.Checked)or
    ((MaterialW[ii].GrowGrass=1)and(Form1.CBMatFilter.Text='Grass'))or
    ((Form1.CBMatFilter.Text<>'Grass')and(Material[ii].Mode=strtoint(Form1.CBMatFilter.Text))) then begin


      if (Material[ii].Tex1+1<=list_tx) then
        if CBCheckers then
          glBindTexture(GL_TEXTURE_2D,TextureCHK[Material[ii].Tex1+1])
        else
          glBindTexture(GL_TEXTURE_2D,Texture[Material[ii].Tex1+1])
      else
        glBindTexture(GL_TEXTURE_2D,0);

      if Material[ii].Mode>=208 then begin
        glEnable(GL_ALPHA_TEST);
        glAlphaFunc(GL_GREATER,0.5);
      end else
        glDisable(GL_ALPHA_TEST);

      glCallList(ScnCall2[ii]);
    end;

  glDisable(GL_ALPHA_TEST);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glBindTexture(GL_TEXTURE_2D,0);
end;

procedure RenderSky(ID:integer);
begin
glColor4f(1,1,1,1);
glBindTexture(GL_TEXTURE_2D,SkyTex[ID,2]);
if SkyTex[ID,2]<>0 then glCallList(coSkyDome);
glBindTexture(GL_TEXTURE_2D,SkyTex[ID,1]);
if SkyTex[ID,1]<>0 then glCallList(coSkyPlane);
glBlendFunc(GL_ONE,GL_ONE);
glPushMatrix;
glTranslatef(xPos+LVL.SunX*100000,yPos+LVL.SunY*100000,zPos+LVL.SunZ*100000);
glScalef(30000,30000,30000); //Sun size
glRotatef(xRot,0,1,0);
glRotatef(180+yRot,1,0,0);
glBindTexture(GL_TEXTURE_2D,SunTex);
//glColor3f(1,1,1); glBegin(GL_POINTS); glVertex3f(0,0,0); glEnd;
glCallList(coSquare);
glPopMatrix;
glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
glBindTexture(GL_TEXTURE_2D,0);
end;

procedure CompileCommonObjects();
var ii,h,step:integer;
begin

//Car
LoadObjectMOX(fOptions.ExeDir+STKit2_Data_Path+'\Car\Car',0);

//Arrow
coArrow:=glGenLists(1);
glNewList (coArrow, GL_COMPILE);
glBegin (GL_QUADS);
for ii:=1 to 8 do glvertex3fv(@BArrow[ii,1]);
for ii:=8 downto 1 do glvertex3fv(@BArrow[ii,1]);
glEnd;
glEndList();

//Grass
for ii:=1 to 4 do begin
  coGrass[ii]:=glGenLists(1);
  glNewList(coGrass[ii], GL_COMPILE);
  glBegin(GL_QUADS);
  glNormal3f(0,0,1);
  glTexCoord2f((ii-1)/4,1); glvertex2f(-5, 0);
  glTexCoord2f(ii/4,    1); glvertex2f( 5, 0);
  glTexCoord2f(ii/4,    0); glvertex2f( 5,10);
  glTexCoord2f((ii-1)/4,0); glvertex2f(-5,10);
  glEnd;
  glEndList();
end;

//Square
coSquare:=glGenLists(1);
glNewList(coSquare, GL_COMPILE);
glBegin(GL_QUADS);
glTexCoord2f(0,0); glvertex2f(-0.5,-0.5);
glTexCoord2f(1,0); glvertex2f( 0.5,-0.5);
glTexCoord2f(1,1); glvertex2f( 0.5, 0.5);
glTexCoord2f(0,1); glvertex2f(-0.5, 0.5);
glEnd;
glEndList();

//Bounding Box
coBox:=glGenLists(1);
glNewList (coBox, GL_COMPILE);
glBegin (GL_QUADS);
for ii:=1 to 6 do
for h:=4 downto 1 do
glvertex3fv(@BBox[BBoxI[ii,h],1]);
glEnd;
glEndList();

//Box Wire
coBoxW:=glGenLists(1);
glNewList (coBoxW, GL_COMPILE);
glbegin (GL_LINE_LOOP);
for ii:=1 to 4 do glvertex3fv(@BBox[ii,1]);
glEnd;
glbegin (GL_LINE_LOOP);
for ii:=5 to 8 do glvertex3fv(@BBox[ii,1]);
glEnd;
glbegin (GL_LINES);
for ii:=1 to 4 do begin
glvertex3fv(@BBox[ii,1]);
glvertex3fv(@BBox[ii+4,1]);
end;
glEnd;
glEndList();

//SkyDome
coSkyDome:=glGenLists(1);
glNewList (coSkyDome, GL_COMPILE);
glbegin (GL_TRIANGLES);
glColor4f(1,1,1,1);
for ii:=1 to 45 do for h:=1 to 3 do begin
glTexCoord2f(OSphere[OSphereP[ii,h],1]/10+0.5,OSphere[OSphereP[ii,h],3]/10+0.5); //Planar Top projection 0..1
glnormal3fv(@OSphereN[OSphereP[ii,h],1]);
glvertex3f(OSphere[OSphereP[ii,h],1]*100000,OSphere[OSphereP[ii,h],2]*2500,OSphere[OSphereP[ii,h],3]*100000);
end;
glEnd;
glEndList();

//SkyPlane
coSkyPlane:=glGenLists(1);
glNewList (coSkyPlane, GL_COMPILE);
glbegin (GL_QUADS);
glColor4f(1,1,1,1);
glnormal3f(0,-1,0);
glTexCoord2f(-4,-4); glvertex3f(-100000,5000,-100000);
glTexCoord2f(-4, 4); glvertex3f(-100000,5000, 100000);
glTexCoord2f( 4, 4); glvertex3f( 100000,5000, 100000);
glTexCoord2f( 4,-4); glvertex3f( 100000,5000,-100000);
glEnd;
glEndList();

//3arrowsXYZ
coMover:=glGenLists(1);
glNewList (coMover, GL_COMPILE);
  glbegin (GL_LINE_STRIP);
  glColor4f(1,0,0,1);
  for ii:=1 to length(ObjMover) do
  glvertex3f(ObjMover[ii,1],ObjMover[ii,2],ObjMover[ii,3]);
  glEnd;
  glbegin (GL_LINE_STRIP);
  glColor4f(0,0,1,1);
  for ii:=1 to length(ObjMover) do
  glvertex3f(ObjMover[ii,3],ObjMover[ii,2],ObjMover[ii,1]);
  glEnd;
  glbegin (GL_LINE_STRIP);
  glColor4f(0,1,0,1);
  for ii:=1 to length(ObjMover) do
  glvertex3f(ObjMover[ii,3],ObjMover[ii,1],ObjMover[ii,2]);
  glEnd;
glEndList();

//CircleXZ
coCircleXZ:=glGenLists(1);
glNewList (coCircleXZ, GL_COMPILE);
  step:=16;
  glbegin (GL_LINE_STRIP);
  for ii:=-step to step do
  glvertex3f(cos(ii/step*pi),0,sin(ii/step*pi));//-1..1
  glEnd;
glEndList();

//CircleYZ
coCircleYZ:=glGenLists(1);
glNewList (coCircleYZ, GL_COMPILE);
  step:=16;
  glbegin (GL_LINE_STRIP);
  for ii:=-step to step do
  glvertex3f(0,cos(ii/step*pi),sin(ii/step*pi));//-1..1
  glEnd;
  glbegin (GL_LINES);
  step:=2;
  for ii:=-step to step do begin
  glvertex3f(0.2,cos(ii/step*pi),sin(ii/step*pi));//-1..1
  glvertex3f(-0.2,cos(ii/step*pi),sin(ii/step*pi));//-1..1
  end;
  glEnd;
glEndList();

//RoundXZ
coRoundXZ:=glGenLists(1);
glNewList (coRoundXZ, GL_COMPILE);
  step:=16;
  glbegin (GL_TRIANGLES);
  for ii:=-step to step-1 do begin
  glvertex3f(cos((ii+1)/step*pi),0,sin((ii+1)/step*pi));//-1..1
  glvertex3f(0,0,0);
  glvertex3f(cos(ii/step*pi),0,sin(ii/step*pi));//-1..1
  end;
  glEnd;
glEndList();
end;


procedure RenderMover(x,y,z:single);
var a:single;
begin
glLineWidth(1+2*power(zoom,3));
a:=1/power(zoom,2.5); //inverse applied zoom
glPushMatrix;
  glTranslatef(x,y,z);
  glRotatef(-xRot, 0, -1, 0);
  glScalef(8*a,8*a,8*a);
  glCallList(coMover);
glPopMatrix;
glLineWidth(LineWidth);
end;


end.
