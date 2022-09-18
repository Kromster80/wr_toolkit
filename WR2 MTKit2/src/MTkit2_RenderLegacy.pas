unit MTkit2_RenderLegacy;
interface
uses
  OpenGL, dglOpenGL, KromOGLUtils, KromUtils, Math;

  procedure RenderOpenGL;
  procedure RenderDiffuse(aID,aPartID:integer; aParam:string; t:Single);
  procedure RenderSpec(aID,aPartID:integer; aParam:string; t:Single);
  procedure RenderSpecular(aID,aPartID:integer; aParam:string; t:Single);
  procedure RenderSpecular2(aID,aPartID:integer; aParam:string; t:Single);
  procedure RenderReflection(aID,aPartID:integer; aParam:string; t:Single);
  procedure RenderTexture(aID,aPartID:integer; aParam:string; t:Single);
  procedure RenderDirt(aParam:string; t:Single);
  procedure RenderDummy;
  procedure RenderPivotSetup(aParam,param2,p3:integer);
  procedure RenderWireframe(aWireColor: Cardinal);
  procedure TransformAndCall(aID, aPartID: Integer; aMode: Byte);
  procedure TransformParent(aParam:integer);
  procedure RenderUVMap(aID:integer);

implementation
uses
  MTkit2_Unit1, MTkit2_MOX, MTkit2_Defaults, Windows, SysUtils;

procedure RenderOpenGL;
var
  h: Integer;
  id, partId: Integer;
begin
  h:=0; partId:=1;
  for id:=1 to MOX.Header.ChunkCount do
  begin
    // define detail
    if id > (MOX.Parts[partId].NumMat + h) then
    begin
      inc(h, MOX.Parts[partId].NumMat);
      inc(partId);
    end;

    if (ActivePage=apMTL)
    or (SelectedTreeNode=0)
    or (not RenderOptions.ShowPart)
    or ((RenderOptions.ShowPart) and (partId = SelectedTreeNode)) then //skip render of unseen parts
      case Material[MOX.Chunks[id].SidA+1].MatClass[2] of
        0:  case Material[MOX.Chunks[id].SidA+1].MatClass[3] of
              0:  begin                                                                        //++
                    RenderDiffuse(id,partId,'SetTrans',0);
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'SetTrans',0);
                    RenderSpecular(id,partId,'SetTrans',0);
                  end;
            end;
        3:  case Material[MOX.Chunks[id].SidA+1].MatClass[3] of
              0:  begin                                                                        //++
                    RenderDiffuse(id,partId,'SetTrans',0);
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderTexture(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'',1);
                    RenderSpecular(id,partId,'SetTrans',0);
                  end;
             1:   begin                                                                        //++
                    RenderDiffuse(id,partId,'',0);                                                           //wheels
                    RenderSpecular2(id,partId,'',0);
                    RenderTexture(id,partId,'**',0);
                    RenderReflection(id,partId,'Blend',0);
                    RenderSpecular(id,partId,'',0);
                  end;
             2:   begin                                                                        //++
                    RenderDiffuse(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/400);              //wheels
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderTexture(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'',0);
                    RenderSpecular(id,partId,'SetTrans',0);
                  end;
             3:   begin                                                                        //++
                    RenderDiffuse(id,partId,'SetTrans',0.25+Material[MOX.Chunks[id].SidA+1].Transparency/70);          //wheels
                    RenderSpecular2(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                    RenderTexture(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                    RenderReflection(id,partId,'Blend',0);
                    RenderSpecular(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                  end;
             4:   if Material[MOX.Chunks[id].SidA+1].Transparency<=50 then                         //++
                  begin
                    RenderDiffuse(id,partId,'SetTrans',0);
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderTexture(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'',1);
                    RenderSpecular(id,partId,'SetTrans',0);
                  end;
            end;

        4:  case Material[MOX.Chunks[id].SidA+1].MatClass[3]of
              0:  begin                                                                        //+
                    RenderDiffuse(id,partId,'SetTrans',0);
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'',1);
                    RenderSpecular(id,partId,'SetTrans',0);
                    RenderTexture(id,partId,'SetTrans',0);
                  end;
              1:  begin                                                                        //+
                    RenderDiffuse(id,partId,'',0);                                                           //wheels
                    RenderSpecular2(id,partId,'',0);
                    RenderReflection(id,partId,'Blend',0);
                    RenderSpecular(id,partId,'',0);
                    RenderTexture(id,partId,'**',0);
                  end;
              2:  begin                                                                        //+
                    RenderDiffuse(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/400);
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'',0);
                    RenderSpecular(id,partId,'SetTrans',0);
                    RenderTexture(id,partId,'SetTrans',0);
                  end;
              3:  begin                                                                        //+
                    RenderDiffuse(id,partId,'SetTrans',0.25+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                    RenderSpecular2(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                    RenderReflection(id,partId,'Blend',1);
                    RenderSpecular(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                    RenderTexture(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                  end;
              4:  if Material[MOX.Chunks[id].SidA+1].Transparency<=50 then
                  begin
                    RenderDiffuse(id,partId,'SetTrans',0);
                    RenderSpecular2(id,partId,'SetTrans',0);
                    RenderReflection(id,partId,'',1);
                    RenderSpecular(id,partId,'SetTrans',0);
                    RenderTexture(id,partId,'SetTrans',0);
                  end;
            end;
      end;
  end;

  h:=0; partId:=1;
  for id:=1 to MOX.Header.ChunkCount do
  begin
    // define detail
    if id > (MOX.Parts[partId].NumMat + h) then
    begin
      inc(h, MOX.Parts[partId].NumMat);
      inc(partId);
    end;

  //mat:=Material[MOX.Chunks[id].SidA+1].Transparency;
  if (ActivePage=apMTL)
  or (SelectedTreeNode=0)
  or (not RenderOptions.ShowPart)
  or ((RenderOptions.ShowPart)and(partId=SelectedTreeNode)) then //skip render of unseen parts
    case Material[MOX.Chunks[id].SidA+1].MatClass[2] of
      0:  case Material[MOX.Chunks[id].SidA+1].MatClass[3]of
            1:  begin                                                                       //++
                  RenderDiffuse(id,partId,'',1);                                                           //wheels
                  RenderSpecular2(id,partId,'',1);
                  RenderReflection(id,partId,'Blend',1);
                  RenderSpecular(id,partId,'',1);
                end;
            2:  begin                                                                       //++
                  RenderDiffuse(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/400);              //wheels
                  RenderSpecular2(id,partId,'',1);
                  RenderReflection(id,partId,'',1);
                  RenderSpecular(id,partId,'',1);
                end;
            3:  begin                                                                       //++
                  RenderDiffuse(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);           //wheels
                  RenderSpecular2(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                  RenderReflection(id,partId,'Blend',1);
                  RenderSpecular(id,partId,'SetTrans',0.2+Material[MOX.Chunks[id].SidA+1].Transparency/70);
                end;
            4:  if Material[MOX.Chunks[id].SidA+1].Transparency<=50 then                          //+
                begin
                  RenderDiffuse(id,partId,'SetTrans',0);
                  RenderSpecular2(id,partId,'SetTrans',0);
                  RenderReflection(id,partId,'SetTrans',0);
                  RenderSpecular(id,partId,'SetTrans',0);
                end;
          end;
      1:  case Material[MOX.Chunks[id].SidA+1].MatClass[3]of
            0:  begin                                                                       //++
                  RenderDiffuse(id,partId,'SetTrans',0.33);
                  RenderTexture(id,partId,'14',0);
                  RenderReflection(id,partId,'SetTrans',0.33);
                  RenderSpecular2(id,partId,'SetTrans',0.33);
                  RenderSpecular(id,partId,'SetTrans',0.33);
                end;
            1:  begin
                  if MoxTex[MOX.Chunks[id].SidA+1]=0 then RenderDiffuse(id,partId,'',1);                                                           //only texture need to reflect
                  RenderTexture(id,partId,'11',0);                                                         //++
                  RenderReflection(id,partId,'',1);                                                        //wheels
                  RenderSpecular2(id,partId,'',1);
                  RenderSpecular(id,partId,'',1);
                end;
            2:  begin                                                                       //++
                  RenderDiffuse(id,partId,'SetTrans',0.75);                                                //wheels
                  RenderTexture(id,partId,'14',0);
                  RenderReflection(id,partId,'SetTrans',0.75);
                  RenderSpecular2(id,partId,'SetTrans',0.75);
                  RenderSpecular(id,partId,'SetTrans',0.75);
                end;
            3:  RenderTexture(id,partId,'1*',0);                                                       //++ wheels
            4:  begin                                                                       //++
                  glEnable(GL_ALPHA_TEST);                                                       //only texture reflects
                  glAlphaFunc(GL_GREATER,Material[MOX.Chunks[id].SidA+1].Transparency/50);
                  RenderTexture(id,partId,'14',0);
                  glDisable(GL_ALPHA_TEST);
                  RenderReflection(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/50);
                  RenderSpecular2(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/50);
                  RenderSpecular(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/50);
                end;
          end;
      2:  case Material[MOX.Chunks[id].SidA+1].MatClass[3]of
            0:  begin                                                                       //only texture reflects
                  RenderDiffuse(id,partId,'SetTrans',0.33);                                                //++
                  RenderTexture(id,partId,'14',0);
                  RenderReflection(id,partId,'SetTrans',0.33);
                  RenderSpecular2(id,partId,'SetTrans',0.33);
                  RenderSpecular(id,partId,'SetTrans',0.33);
                end;
            1:  begin                                                                       //only texture reflects
                  RenderTexture(id,partId,'11',0);                                                         //++
                  RenderReflection(id,partId,'',1);                                                        //wheels
                  RenderSpecular2(id,partId,'',1);
                  RenderSpecular(id,partId,'',1);
                end;
            2:  begin                                                                       //+
                  RenderDiffuse(id,partId,'SetTrans',0.75);                                                //wheels
                  RenderTexture(id,partId,'14',0);
                  RenderReflection(id,partId,'SetTrans',0.75);
                  RenderSpecular2(id,partId,'SetTrans',0.75);
                  RenderSpecular(id,partId,'SetTrans',0.75);
                end;
            3:  RenderTexture(id,partId,'11',0);                                                      //only texture reflects wheels
            4:  begin                                                                       //++
                  glEnable(GL_ALPHA_TEST);                                                       //only texture reflects
                  glAlphaFunc(GL_GREATER,Material[MOX.Chunks[id].SidA+1].Transparency/50);
                  RenderTexture(id,partId,'14',0);
                  glDisable(GL_ALPHA_TEST);
                  RenderReflection(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/50);
                  RenderSpecular2(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/50);
                  RenderSpecular(id,partId,'SetTrans',Material[MOX.Chunks[id].SidA+1].Transparency/50);
                end;
          end;
    end;
  end;
end;

procedure RenderDiffuse(aID,aPartID:integer; aParam:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
  glBindTexture(GL_TEXTURE_2D, 0); //UV map texture

  if aParam='Mask' then
    glBindTexture(GL_TEXTURE_2D, MoxTex[MOX.Chunks[aID].SidA+1]); //UV map texture

  Dif[0]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Dif.R/180,1);
  Dif[1]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Dif.G/180,1);
  Dif[2]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Dif.B/180,1);
  Dif[3]:=1-Material[MOX.Chunks[aID].SidA+1].Transparency/100;

  if aParam='SetTrans' then
    Dif[3]:=1-t;

  glColor4fv(@Dif);
  TransformAndCall(aID,aPartID, 1);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
end;

procedure RenderSpec(aID,aPartID:integer; aParam:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA,GL_ONE);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glEnable(GL_TEXTURE_GEN_S);     // Enable spherical
    glEnable(GL_TEXTURE_GEN_T);     // Environment Mapping
  Dif[3]:=1-Material[MOX.Chunks[aID].SidA+1].Transparency/100;
  if aParam='SetTrans' then Dif[3]:=1-t;
  glColor4fv(@Dif);
  TransformAndCall(aID,aPartID, 0);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glDisable(GL_TEXTURE_GEN_S);     // Disable
    glDisable(GL_TEXTURE_GEN_T);     // Spherical
end;

procedure RenderSpecular(aID,aPartID:integer; aParam:string; t:Single);
begin
  glBindTexture(GL_TEXTURE_2D, SpecTexture);
  Dif[0]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Sp1.R/180,1);
  Dif[1]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Sp1.G/180,1);
  Dif[2]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Sp1.B/180,1);
  RenderSpec(aID,aPartID,aParam,t);
end;

procedure RenderSpecular2(aID,aPartID:integer; aParam:string; t:Single);
begin
  glBindTexture(GL_TEXTURE_2D, Spec2Texture);
  Dif[0]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Sp2.R/150,1);
  Dif[1]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Sp2.G/150,1);
  Dif[2]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Sp2.B/150,1);
  RenderSpec(aID,aPartID,aParam,t);
end;


procedure RenderReflection(aID,aPartID:integer; aParam:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  if (Material[MOX.Chunks[aID].SidA+1].Color[ColID].Ref.R=0) and (not RenderChrome) then Exit;
  glBindTexture(GL_TEXTURE_2D, EnvTexture);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
    glEnable(GL_TEXTURE_GEN_S);     // Enable spherical
    glEnable(GL_TEXTURE_GEN_T);     // Environment Mapping

  Dif[0]:=1; Dif[1]:=1; Dif[2]:=1;
  if (Material[MOX.Chunks[aID].SidA+1].MatClass[4] and 8) <> 0 then //if 8
    Dif[3]:=Material[MOX.Chunks[aID].SidA+1].Color[ColID].Ref.R/255//keep a bit transparent
  else
  if RenderChrome then
    Dif[3]:=0.8
  else
    Dif[3]:=0.2;

  if aParam='Blend' then
    Dif[3]:=Dif[3]*(1-Material[MOX.Chunks[aID].SidA+1].Transparency/100);

  glColor4fv(@Dif);
  TransformAndCall(aID,aPartID, 0);
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
    glDisable(GL_TEXTURE_GEN_S);     // Disable
    glDisable(GL_TEXTURE_GEN_T);     // Spherical
end;


procedure RenderTexture(aID,aPartID:integer; aParam:string; t:Single);
begin
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
  if MoxTex[MOX.Chunks[aID].SidA+1]=0 then exit;
  glBindTexture(GL_TEXTURE_2D, MoxTex[MOX.Chunks[aID].SidA+1]); //UV map texture

  if (Form1.CBVinyl.ItemIndex+1>1) then
    if (Material[MOX.Chunks[aID].SidA+1].MatClass[4] AND 1 = 1) then
      glBindTexture(GL_TEXTURE_2D, VinylsTex); //UV map texture

  Dif[0]:=1; Dif[1]:=1; Dif[2]:=1; Dif[3]:=1-Material[MOX.Chunks[aID].SidA+1].Transparency/100;
  if aParam='SetTrans' then Dif[3]:=1-t;
  if aParam[1]='1' then begin
    Dif[0]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Dif.R/180,1);
    Dif[1]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Dif.G/180,1);
    Dif[2]:=min(Material[MOX.Chunks[aID].SidA+1].Color[ColID].Dif.B/180,1);
  end;
  if aParam[2]='4' then Dif[3]:=1-t;
  glColor4fv(@Dif);
  TransformAndCall(aID,aPartID, 1);
end;

procedure RenderDirt(aParam:string; t:Single);
var h,aID,IDk:integer;
begin
  if (DirtTex=0) or (t=0) then exit;
  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER, 1-t/100);
  glBindTexture(GL_TEXTURE_2D, DirtTex); //UV map texture
  glColor3f(1,1,1);
  h:=0; IDk:=1;
  for aID:=1 to MOX.Header.ChunkCount do
  begin
    if aID>(MOX.Parts[IDk].NumMat+h) then begin inc(h,MOX.Parts[IDk].NumMat); inc(IDk); end; //define detail
    if (SelectedTreeNode=0)or(ActivePage=apParts)or(not(RenderOptions.ShowPart)or //skip render of unseen parts
       (RenderOptions.ShowPart)and(IDk=SelectedTreeNode)) then
      if Material[MOX.Chunks[aID].SidA+1].MatClass[4] and 4=4 then
        TransformAndCall(aID,IDk, 1);
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

procedure RenderPivotSetup(aParam, param2, p3: Integer);
var
  i,k:integer;
begin
  if Form1.PageControl2.ActivePageIndex <> 0 then Exit;
  if (aParam > MOX.Header.VerticeCount) or (aParam <= 0) then Exit;

  glDisable(GL_LIGHTING);
  glPushMatrix;
    TransformParent(SelectedTreeNode);
    glBindTexture(GL_TEXTURE_2D, 0);
    k:=MOX.Chunks[MOX.Parts[SelectedTreeNode].FirstMat+1].FirstVtx-1;
    for i:=1 to param2 do
    begin
      glColor4f(0.9,0.9,0.9,1);
      glRasterPos3f(MOX.Vertice[i+k].X,MOX.Vertice[i+k].Y,MOX.Vertice[i+k].Z);
      glPrint(inttostr(i));
    end;
    glColor4f(1,0,0,1);
    glRasterPos3f(MOX.Vertice[aParam].X,MOX.Vertice[aParam].Y,MOX.Vertice[aParam].Z);
    glPrint(inttostr(p3));
  glPopMatrix;
  glEnable(GL_LIGHTING);
end;


procedure RenderWireframe(aWireColor: Cardinal);
var
  h,aID,IDk: Integer;
begin
  glPolygonMode(GL_FRONT, GL_LINE);
  glBindTexture(GL_TEXTURE_2D, 0);
  glColor3ubv(@aWireColor);
  h:=0; IDk:=1;
  for aID:=1 to MOX.Header.ChunkCount do
  begin
    // Define detail
    if aID > (MOX.Parts[IDk].NumMat + h) then
    begin
      Inc(h, MOX.Parts[IDk].NumMat);
      Inc(IDk);
    end;

    // Skip render of unseen parts
    if (SelectedTreeNode = 0)
    or (ActivePage = apParts)
    or (not RenderOptions.ShowPart or RenderOptions.ShowPart and (IDk = SelectedTreeNode)) then
      TransformAndCall(aID,IDk, 1);
  end;
  glPolygonMode(GL_FRONT, GL_FILL);
end;


procedure TransformAndCall(aID, aPartID: Integer; aMode: Byte);
begin
  if (Form1.cbShowMaterial.Checked) and (MOX.Chunks[aID].SidA + 1 <> MatID) then Exit;

  if RenderOptions.UVMap then
  begin
    if aMode=1 then
      RenderUVMap(aID)
  end else
  begin
    glPushMatrix;
    TransformParent(aPartID);
    glCallList(MoxCall[aID]);
    glPopMatrix;
  end;
end;

procedure TransformParent(aParam:integer);
var
  k:integer;
  currentLev,depthLev:integer; //Depth Level
begin
if aParam=0 then exit;
DepthLev:=8;
repeat
CurrentLev:=1; k:=aParam;
while (MOX.Parts[k].Parent>=0)and(CurrentLev<>DepthLev) do begin
k:=MOX.Parts[k].Parent+1;
inc(CurrentLev); end;
DepthLev:=CurrentLev; //set depth for first run
dec(DepthLev);        //-1
glMultMatrixf(@MOX.Parts[k].Matrix);
if RenderOptions.ShowDamage then begin //Flap everything correctly
glTranslate(PartModify[aParam].Move[1],PartModify[aParam].Move[2],PartModify[aParam].Move[3]); //Shift part in proper place for rotation
glRotatef(Mix(MOX.Parts[k].x1,MOX.Parts[k].x2,RenderOptions.PartsFlapPos)/Pi*180,1,0,0);
glRotatef(Mix(MOX.Parts[k].y1,MOX.Parts[k].y2,RenderOptions.PartsFlapPos)/Pi*180,0,1,0);
glRotatef(Mix(MOX.Parts[k].z1,MOX.Parts[k].z2,RenderOptions.PartsFlapPos)/Pi*180,0,0,-1);
glTranslate(-PartModify[aParam].Move[1],-PartModify[aParam].Move[2],-PartModify[aParam].Move[3]);
end;
until(DepthLev=0);
if (not RenderOptions.ShowDamage)and(aParam=SelectedTreeNode) then begin //
glTranslate(PartModify[aParam].Move[1],PartModify[aParam].Move[2],PartModify[aParam].Move[3]); //Shift part in proper place for rotation
glRotatef(Mix(MOX.Parts[k].x1,MOX.Parts[k].x2,RenderOptions.PartsFlapPos)/Pi*180,1,0,0);
glRotatef(Mix(MOX.Parts[k].y1,MOX.Parts[k].y2,RenderOptions.PartsFlapPos)/Pi*180,0,1,0);
glRotatef(Mix(MOX.Parts[k].z1,MOX.Parts[k].z2,RenderOptions.PartsFlapPos)/Pi*180,0,0,-1);
glTranslate(-PartModify[aParam].Move[1],-PartModify[aParam].Move[2],-PartModify[aParam].Move[3]);
end;
end;

procedure RenderUVMap(aID:integer);
begin

if RenderOptions.Wire then begin
  glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
  glBindTexture(GL_TEXTURE_2D, 0);
  glColor3f(1,1,1);
end;

glCallList(MoxUVCall[aID]);

if RenderOptions.Wire then
  glPolygonMode(GL_FRONT, GL_FILL);
end;


end.
