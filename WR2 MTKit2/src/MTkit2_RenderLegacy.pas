unit MTkit2_RenderLegacy;
interface
uses
  OpenGL, dglOpenGL, kromOGLUtils,kromUtils, Math;

  procedure RenderOpenGL;
  procedure RenderDiffuse(ID,PartID:integer; param:string; t:Single);
  procedure RenderSpec(ID,PartID:integer; param:string; t:Single);
  procedure RenderSpecular(ID,PartID:integer; param:string; t:Single);
  procedure RenderSpecular2(ID,PartID:integer; param:string; t:Single);
  procedure RenderReflection(ID,PartID:integer; param:string; t:Single);
  procedure RenderTexture(ID,PartID:integer; param:string; t:Single);
  procedure RenderDirt(param:string; t:Single);
  procedure RenderDummy;
  procedure RenderPivotSetup(param,param2,p3:integer);
  procedure RenderWireframe(param:string);
  procedure TransformAndCall(ID,PartID:integer; mode:Byte);
  procedure TransformParent(param:integer);
  procedure RenderUVMap(ID:integer);

implementation
uses
  MTkit2_Unit1, MTkit2_MOX, MTkit2_Defaults, Windows, sysutils;

procedure RenderOpenGL;
var
  h: integer;
  ID,PartID: integer;
begin
  h:=0; PartID:=1;
  for ID:=1 to MOX.Qty.Chunks do
  begin
    if ID>(MOX.Parts[PartID].NumMat+h) then begin inc(h,MOX.Parts[PartID].NumMat); inc(PartID); end; //define detail

    if (ActivePage=apMTL)
    or (SelectedTreeNode=0)
    or (not RenderOpts.ShowPart)
    or ((RenderOpts.ShowPart) and (PartID = SelectedTreeNode)) then //skip render of unseen parts
      case Material[MOX.Sid[ID,1]+1].MatClass[2] of
        0:  case Material[MOX.Sid[ID,1]+1].MatClass[3] of
              0:  begin                                                                        //++
                    RenderDiffuse(ID,PartID,'SetTrans',0);
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'SetTrans',0);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                  end;
            end;
        3:  case Material[MOX.Sid[ID,1]+1].MatClass[3] of
              0:  begin                                                                        //++
                    RenderDiffuse(ID,PartID,'SetTrans',0);
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderTexture(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'',1);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                  end;
             1:   begin                                                                        //++
                    RenderDiffuse(ID,PartID,'',0);                                                           //wheels
                    RenderSpecular2(ID,PartID,'',0);
                    RenderTexture(ID,PartID,'**',0);
                    RenderReflection(ID,PartID,'Blend',0);
                    RenderSpecular(ID,PartID,'',0);
                  end;
             2:   begin                                                                        //++
                    RenderDiffuse(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/400);              //wheels
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderTexture(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'',0);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                  end;
             3:   begin                                                                        //++
                    RenderDiffuse(ID,PartID,'SetTrans',0.25+Material[MOX.Sid[ID,1]+1].Transparency/70);          //wheels
                    RenderSpecular2(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                    RenderTexture(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                    RenderReflection(ID,PartID,'Blend',0);
                    RenderSpecular(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                  end;
             4:   if Material[MOX.Sid[ID,1]+1].Transparency<=50 then                         //++
                  begin
                    RenderDiffuse(ID,PartID,'SetTrans',0);
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderTexture(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'',1);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                  end;
            end;

        4:  case Material[MOX.Sid[ID,1]+1].MatClass[3]of
              0:  begin                                                                        //+
                    RenderDiffuse(ID,PartID,'SetTrans',0);
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'',1);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                    RenderTexture(ID,PartID,'SetTrans',0);
                  end;
              1:  begin                                                                        //+
                    RenderDiffuse(ID,PartID,'',0);                                                           //wheels
                    RenderSpecular2(ID,PartID,'',0);
                    RenderReflection(ID,PartID,'Blend',0);
                    RenderSpecular(ID,PartID,'',0);
                    RenderTexture(ID,PartID,'**',0);
                  end;
              2:  begin                                                                        //+
                    RenderDiffuse(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/400);
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'',0);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                    RenderTexture(ID,PartID,'SetTrans',0);
                  end;
              3:  begin                                                                        //+
                    RenderDiffuse(ID,PartID,'SetTrans',0.25+Material[MOX.Sid[ID,1]+1].Transparency/70);
                    RenderSpecular2(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                    RenderReflection(ID,PartID,'Blend',1);
                    RenderSpecular(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                    RenderTexture(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                  end;
              4:  if Material[MOX.Sid[ID,1]+1].Transparency<=50 then
                  begin
                    RenderDiffuse(ID,PartID,'SetTrans',0);
                    RenderSpecular2(ID,PartID,'SetTrans',0);
                    RenderReflection(ID,PartID,'',1);
                    RenderSpecular(ID,PartID,'SetTrans',0);
                    RenderTexture(ID,PartID,'SetTrans',0);
                  end;
            end;
      end;
  end;

  h:=0; PartID:=1;
  for ID:=1 to MOX.Qty.Chunks do
  begin
  if ID>(MOX.Parts[PartID].NumMat+h) then begin inc(h,MOX.Parts[PartID].NumMat); inc(PartID); end; //define detail

  //mat:=Material[MOX.Sid[ID,1]+1].Transparency;
  if (ActivePage=apMTL)
  or (SelectedTreeNode=0)
  or (not RenderOpts.ShowPart)
  or ((RenderOpts.ShowPart)and(PartID=SelectedTreeNode)) then //skip render of unseen parts
    case Material[MOX.Sid[ID,1]+1].MatClass[2] of
      0:  case Material[MOX.Sid[ID,1]+1].MatClass[3]of
            1:  begin                                                                       //++
                  RenderDiffuse(ID,PartID,'',1);                                                           //wheels
                  RenderSpecular2(ID,PartID,'',1);
                  RenderReflection(ID,PartID,'Blend',1);
                  RenderSpecular(ID,PartID,'',1);
                end;
            2:  begin                                                                       //++
                  RenderDiffuse(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/400);              //wheels
                  RenderSpecular2(ID,PartID,'',1);
                  RenderReflection(ID,PartID,'',1);
                  RenderSpecular(ID,PartID,'',1);
                end;
            3:  begin                                                                       //++
                  RenderDiffuse(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);           //wheels
                  RenderSpecular2(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                  RenderReflection(ID,PartID,'Blend',1);
                  RenderSpecular(ID,PartID,'SetTrans',0.2+Material[MOX.Sid[ID,1]+1].Transparency/70);
                end;
            4:  if Material[MOX.Sid[ID,1]+1].Transparency<=50 then                          //+
                begin
                  RenderDiffuse(ID,PartID,'SetTrans',0);
                  RenderSpecular2(ID,PartID,'SetTrans',0);
                  RenderReflection(ID,PartID,'SetTrans',0);
                  RenderSpecular(ID,PartID,'SetTrans',0);
                end;
          end;
      1:  case Material[MOX.Sid[ID,1]+1].MatClass[3]of
            0:  begin                                                                       //++
                  RenderDiffuse(ID,PartID,'SetTrans',0.33);
                  RenderTexture(ID,PartID,'14',0);
                  RenderReflection(ID,PartID,'SetTrans',0.33);
                  RenderSpecular2(ID,PartID,'SetTrans',0.33);
                  RenderSpecular(ID,PartID,'SetTrans',0.33);
                end;
            1:  begin
                  if MoxTex[MOX.Sid[ID,1]+1]=0 then RenderDiffuse(ID,PartID,'',1);                                                           //only texture need to reflect
                  RenderTexture(ID,PartID,'11',0);                                                         //++
                  RenderReflection(ID,PartID,'',1);                                                        //wheels
                  RenderSpecular2(ID,PartID,'',1);
                  RenderSpecular(ID,PartID,'',1);
                end;
            2:  begin                                                                       //++
                  RenderDiffuse(ID,PartID,'SetTrans',0.75);                                                //wheels
                  RenderTexture(ID,PartID,'14',0);
                  RenderReflection(ID,PartID,'SetTrans',0.75);
                  RenderSpecular2(ID,PartID,'SetTrans',0.75);
                  RenderSpecular(ID,PartID,'SetTrans',0.75);
                end;
            3:  RenderTexture(ID,PartID,'1*',0);                                                       //++ wheels
            4:  begin                                                                       //++
                  glEnable(GL_ALPHA_TEST);                                                       //only texture reflects
                  glAlphaFunc(GL_GREATER,Material[MOX.Sid[ID,1]+1].Transparency/50);
                  RenderTexture(ID,PartID,'14',0);
                  glDisable(GL_ALPHA_TEST);
                  RenderReflection(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/50);
                  RenderSpecular2(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/50);
                  RenderSpecular(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/50);
                end;
          end;
      2:  case Material[MOX.Sid[ID,1]+1].MatClass[3]of
            0:  begin                                                                       //only texture reflects
                  RenderDiffuse(ID,PartID,'SetTrans',0.33);                                                //++
                  RenderTexture(ID,PartID,'14',0);
                  RenderReflection(ID,PartID,'SetTrans',0.33);
                  RenderSpecular2(ID,PartID,'SetTrans',0.33);
                  RenderSpecular(ID,PartID,'SetTrans',0.33);
                end;
            1:  begin                                                                       //only texture reflects
                  RenderTexture(ID,PartID,'11',0);                                                         //++
                  RenderReflection(ID,PartID,'',1);                                                        //wheels
                  RenderSpecular2(ID,PartID,'',1);
                  RenderSpecular(ID,PartID,'',1);
                end;
            2:  begin                                                                       //+
                  RenderDiffuse(ID,PartID,'SetTrans',0.75);                                                //wheels
                  RenderTexture(ID,PartID,'14',0);
                  RenderReflection(ID,PartID,'SetTrans',0.75);
                  RenderSpecular2(ID,PartID,'SetTrans',0.75);
                  RenderSpecular(ID,PartID,'SetTrans',0.75);
                end;
            3:  RenderTexture(ID,PartID,'11',0);                                                      //only texture reflects wheels
            4:  begin                                                                       //++
                  glEnable(GL_ALPHA_TEST);                                                       //only texture reflects
                  glAlphaFunc(GL_GREATER,Material[MOX.Sid[ID,1]+1].Transparency/50);
                  RenderTexture(ID,PartID,'14',0);
                  glDisable(GL_ALPHA_TEST);
                  RenderReflection(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/50);
                  RenderSpecular2(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/50);
                  RenderSpecular(ID,PartID,'SetTrans',Material[MOX.Sid[ID,1]+1].Transparency/50);
                end;
          end;
    end;
  end;
end;

procedure RenderDiffuse(ID,PartID:integer; param:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
  glBindTexture(GL_TEXTURE_2D, 0); //UV map texture

  if param='Mask' then
    glBindTexture(GL_TEXTURE_2D, MoxTex[MOX.Sid[ID,1]+1]); //UV map texture

  Dif[0]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Dif.R/180,1);
  Dif[1]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Dif.G/180,1);
  Dif[2]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Dif.B/180,1);
  Dif[3]:=1-Material[MOX.Sid[ID,1]+1].Transparency/100;

  if param='SetTrans' then
    Dif[3]:=1-t;

  glColor4fv(@Dif);
  TransformAndCall(ID,PartID, 1);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
end;

procedure RenderSpec(ID,PartID:integer; param:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA,GL_ONE);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glEnable(GL_TEXTURE_GEN_S);     // Enable spherical
    glEnable(GL_TEXTURE_GEN_T);     // Environment Mapping
  Dif[3]:=1-Material[MOX.Sid[ID,1]+1].Transparency/100;
  if param='SetTrans' then Dif[3]:=1-t;
  glColor4fv(@Dif);
  TransformAndCall(ID,PartID, 0);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glDisable(GL_TEXTURE_GEN_S);     // Disable
    glDisable(GL_TEXTURE_GEN_T);     // Spherical
end;

procedure RenderSpecular(ID,PartID:integer; param:string; t:Single);
begin
  glBindTexture(GL_TEXTURE_2D, SpecTexture);
  Dif[0]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Sp1.R/180,1);
  Dif[1]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Sp1.G/180,1);
  Dif[2]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Sp1.B/180,1);
  RenderSpec(ID,PartID,param,t);
end;

procedure RenderSpecular2(ID,PartID:integer; param:string; t:Single);
begin
  glBindTexture(GL_TEXTURE_2D, Spec2Texture);
  Dif[0]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Sp2.R/150,1);
  Dif[1]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Sp2.G/150,1);
  Dif[2]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Sp2.B/150,1);
  RenderSpec(ID,PartID,param,t);
end;


procedure RenderReflection(ID,PartID:integer; param:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  if (Material[MOX.Sid[ID,1]+1].Color[ColID].Ref.R=0) and (not RenderChrome) then Exit;
  glBindTexture(GL_TEXTURE_2D, EnvTexture);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glEnable(GL_TEXTURE_GEN_S);     // Enable spherical
    glEnable(GL_TEXTURE_GEN_T);     // Environment Mapping

  Dif[0]:=1; Dif[1]:=1; Dif[2]:=1;
  if (Material[MOX.Sid[ID,1]+1].MatClass[4] and 8) <> 0 then //if 8
    Dif[3]:=Material[MOX.Sid[ID,1]+1].Color[ColID].Ref.R/255//keep a bit transparent
  else
  if RenderChrome then
    Dif[3]:=0.8
  else
    Dif[3]:=0.2;

  if param='Blend' then
    Dif[3]:=Dif[3]*(1-Material[MOX.Sid[ID,1]+1].Transparency/100);

  glColor4fv(@Dif);
  TransformAndCall(ID,PartID, 0);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glDisable(GL_TEXTURE_GEN_S);     // Disable
    glDisable(GL_TEXTURE_GEN_T);     // Spherical
end;


procedure RenderTexture(ID,PartID:integer; param:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
  if MoxTex[MOX.Sid[ID,1]+1]=0 then exit;
  glBindTexture(GL_TEXTURE_2D, MoxTex[MOX.Sid[ID,1]+1]); //UV map texture

  if (Form1.CBVinyl.ItemIndex+1>1) then
    if (Material[MOX.Sid[ID,1]+1].MatClass[4] AND 1 = 1) then
      glBindTexture(GL_TEXTURE_2D, VinylsTex); //UV map texture

  Dif[0]:=1; Dif[1]:=1; Dif[2]:=1; Dif[3]:=1-Material[MOX.Sid[ID,1]+1].Transparency/100;
  if param='SetTrans' then Dif[3]:=1-t;
  if param[1]='1' then begin
    Dif[0]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Dif.R/180,1);
    Dif[1]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Dif.G/180,1);
    Dif[2]:=min(Material[MOX.Sid[ID,1]+1].Color[ColID].Dif.B/180,1);
  end;
  if param[2]='4' then Dif[3]:=1-t;
  glColor4fv(@Dif);
  TransformAndCall(ID,PartID, 1);
end;

procedure RenderDirt(param:string; t:Single);
var h,ID,IDk:integer;
begin
  if (DirtTex=0) or (t=0) then exit;
  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER, 1-t/100);
  glBindTexture(GL_TEXTURE_2D, DirtTex); //UV map texture
  glColor3f(1,1,1);
  h:=0; IDk:=1;
  for ID:=1 to MOX.Qty.Chunks do begin
    if ID>(MOX.Parts[IDk].NumMat+h) then begin inc(h,MOX.Parts[IDk].NumMat); inc(IDk); end; //define detail
    if (SelectedTreeNode=0)or(ActivePage=apParts)or(not(RenderOpts.ShowPart)or //skip render of unseen parts
       (RenderOpts.ShowPart)and(IDk=SelectedTreeNode)) then
      if Material[MOX.Sid[ID,1]+1].MatClass[4] and 4=4 then
        TransformAndCall(ID,IDk, 1);
  end;
  glBindTexture(GL_TEXTURE_2D, 0);
  glDisable(GL_ALPHA_TEST);
end;

procedure RenderDummy;
begin
if SelectedTreeNode=0 then exit;
glBindTexture(GL_TEXTURE_2D, 0); //UV map texture
glDisable(GL_LIGHTING);

glPushMatrix;
  TransformParent(SelectedTreeNode);
  glTranslate(PartModify[SelectedTreeNode].Move[1],PartModify[SelectedTreeNode].Move[2],PartModify[SelectedTreeNode].Move[3]);
//  if ActivePage=apMTL then
  glCallList(Pivot); //Pivot
  glTranslate(-PartModify[SelectedTreeNode].Move[1],-PartModify[SelectedTreeNode].Move[2],-PartModify[SelectedTreeNode].Move[3]);
  glTranslate(MOX.Parts[SelectedTreeNode].xMid,MOX.Parts[SelectedTreeNode].yMid,MOX.Parts[SelectedTreeNode].zMid);
  glkScale(MOX.Parts[SelectedTreeNode].fRadius/18);
  glCallList(Center); //Center
  glkScale(1.8);
  glCallList(SelectionSphere);
//  glPolygonMode(GL_FRONT,GL_FILL);
glPopMatrix;

glEnable(GL_LIGHTING);
end;

procedure RenderPivotSetup(param,param2,p3:integer);
var
  i,k:integer;
begin
  if Form1.PageControl2.ActivePageIndex<>0 then exit;
  if (param>MOX.Qty.Vertice)or(param<=0) then exit;
  glDisable(GL_LIGHTING);
  glPushMatrix;
    TransformParent(SelectedTreeNode);
    glBindTexture(GL_TEXTURE_2D, 0);
    k:=MOX.Chunk[MOX.Parts[SelectedTreeNode].FirstMat+1,3]-1;
    for i:=1 to param2 do begin
      glColor4f(0.9,0.9,0.9,1);
      glRasterPos3f(MOX.Vertice[i+k].X,MOX.Vertice[i+k].Y,MOX.Vertice[i+k].Z);
      glPrint(inttostr(i));
    end;
    glColor4f(1,0,0,1);
    glRasterPos3f(MOX.Vertice[param].X,MOX.Vertice[param].Y,MOX.Vertice[param].Z);
    glPrint(inttostr(p3));
  glPopMatrix;
  glEnable(GL_LIGHTING);
end;

procedure RenderWireframe(param:string);
var h,ID,IDk:integer;
begin
glPolygonMode(GL_FRONT,GL_LINE);
glBindTexture(GL_TEXTURE_2D, 0);
glColor3ubv(@WFColor[1]);
h:=0; IDk:=1;
for ID:=1 to MOX.Qty.Chunks do begin
  if ID>(MOX.Parts[IDk].NumMat+h) then begin inc(h,MOX.Parts[IDk].NumMat); inc(IDk); end; //define detail
  if (SelectedTreeNode=0)or(ActivePage=apParts)or(not(RenderOpts.ShowPart)or //skip render of unseen parts
     (RenderOpts.ShowPart)and(IDk=SelectedTreeNode)) then
      TransformAndCall(ID,IDk, 1);
end;
glPolygonMode(GL_FRONT,GL_FILL);
end;

procedure TransformAndCall(ID,PartID:integer; mode:Byte);
begin
if (Form1.CBShowMat.Checked)and(MOX.Sid[ID,1]+1<>MatID) then exit;
  if RenderOpts.UVMap then begin
    if mode=1 then RenderUVMap(ID)
  end else begin
    glPushMatrix;
    TransformParent(PartID);
    glCallList(MoxCall[ID]);
    glPopMatrix;
  end;
end;

procedure TransformParent(param:integer);
var
  k:integer;
  currentLev,depthLev:integer; //Depth Level
begin
if param=0 then exit;
DepthLev:=8;
repeat
CurrentLev:=1; k:=param;
while (MOX.Parts[k].Parent>=0)and(CurrentLev<>DepthLev) do begin
k:=MOX.Parts[k].Parent+1;
inc(CurrentLev); end;
DepthLev:=CurrentLev; //set depth for first run
dec(DepthLev);        //-1
glMultMatrixf(@MOX.Parts[k].Matrix);
if RenderOpts.ShowDamage then begin //Flap everything correctly
glTranslate(PartModify[param].Move[1],PartModify[param].Move[2],PartModify[param].Move[3]); //Shift part in proper place for rotation
glRotatef(Mix(MOX.Parts[k].x1,MOX.Parts[k].x2,RenderOpts.PartsFlapPos)/pi*180,1,0,0);
glRotatef(Mix(MOX.Parts[k].y1,MOX.Parts[k].y2,RenderOpts.PartsFlapPos)/pi*180,0,1,0);
glRotatef(Mix(MOX.Parts[k].z1,MOX.Parts[k].z2,RenderOpts.PartsFlapPos)/pi*180,0,0,-1);
glTranslate(-PartModify[param].Move[1],-PartModify[param].Move[2],-PartModify[param].Move[3]);
end;
until(DepthLev=0);
if (not RenderOpts.ShowDamage)and(param=SelectedTreeNode) then begin //
glTranslate(PartModify[param].Move[1],PartModify[param].Move[2],PartModify[param].Move[3]); //Shift part in proper place for rotation
glRotatef(Mix(MOX.Parts[k].x1,MOX.Parts[k].x2,RenderOpts.PartsFlapPos)/pi*180,1,0,0);
glRotatef(Mix(MOX.Parts[k].y1,MOX.Parts[k].y2,RenderOpts.PartsFlapPos)/pi*180,0,1,0);
glRotatef(Mix(MOX.Parts[k].z1,MOX.Parts[k].z2,RenderOpts.PartsFlapPos)/pi*180,0,0,-1);
glTranslate(-PartModify[param].Move[1],-PartModify[param].Move[2],-PartModify[param].Move[3]);
end;
end;

procedure RenderUVMap(ID:integer);
begin

if RenderOpts.Wire then begin
  glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
  glBindTexture(GL_TEXTURE_2D, 0);
  glColor3f(1,1,1);
end;

glCallList(MoxUVCall[ID]);

if RenderOpts.Wire then
  glPolygonMode(GL_FRONT,GL_FILL);

end;


end.
