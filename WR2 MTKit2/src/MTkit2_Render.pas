unit MTkit2_Render;
interface
uses
  OpenGL, dglOpenGL, KromOGLUtils, KromUtils, SysUtils, Math, Windows,
  TGATexture, PTXTexture, MTkit2_COB;

type
  TBlinkerPreviewMode = (bmNone, bmHeadBreaks, bmBlinkers, bmReverse, bmNitro);

  procedure RenderInit;
  function LoadFresnelShader: Boolean;
  function RenderShaders: Boolean;
  procedure RenderLights(aSelected: Integer; aMode: TBlinkerPreviewMode; aShowDummy, aVectors: Boolean);
  procedure RenderCOB(aCOB: TModelCOB; aVerticeId: Integer; aShowIds: Boolean);
  procedure RenderCPO(ID: Integer);
  procedure RenderGrid;
  procedure RenderUVGrid(ShowGrid: Boolean);
  procedure CompileCommonObjects;

const
  MAX_MAT_CLASS = 4;


implementation
uses
  MTkit2_Unit1, MTkit2_Defaults, MTkit2_CPO, MTkit2_MOX, MTkit2_Tree;

var
  po, fs: array [0..MAX_MAT_CLASS, 0..MAX_MAT_CLASS] of Integer;

procedure RenderInit;
begin
  glClear (GL_COLOR_BUFFER_BIT);
  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glEnable(GL_NORMALIZE);
  glEnable(GL_BLEND);
  glDepthFunc(GL_LEQUAL);		            // Blending possible
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glEnable(GL_CULL_FACE);                           //Excludes backfacing polys from rendering
  glCullFace(GL_BACK);                              //adds few FPS
  glEnable(GL_LIGHT0);
  glEnable(GL_LIGHT1);
  glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);
  glLightfv(GL_LIGHT0, GL_SPECULAR, @LightSpec);
  glLightfv(GL_LIGHT0, GL_DIFFUSE, @LightDiff);
  glLightfv(GL_LIGHT1, GL_POSITION, @LightPos2);
  glLightfv(GL_LIGHT1, GL_SPECULAR, @LightSpec2);
  glLightfv(GL_LIGHT1, GL_DIFFUSE, @LightDiff2);
  glEnable(GL_COLOR_MATERIAL);                 //Enable Materials
  glEnable(GL_TEXTURE_2D);                     //Enable Texture Mapping
  LoadTexturePTX(ExeDir+'MTKit2 Data\Env.ptx', EnvTexture);
  LoadTexture(ExeDir+'MTKit2 Data\Spec.TGA', SpecTexture,0);
  LoadTexture(ExeDir+'MTKit2 Data\Spec2.TGA', Spec2Texture,0);
  LoadTexturePTX(ExeDir+'MTKit2 Data\lensflare.ptx', LensFlareTex);
  LoadTexturePTX(ExeDir+'MTKit2 Data\selection.ptx', SelectionTex);
  LoadTexturePTX(ExeDir+'MTKit2 Data\flame.ptx', FlameTex);
  LoadTexturePTX(ExeDir+'MTKit2 Data\Dummy.ptx', DummyTex);
  glTexGenf(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
  glTexGenf(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
end;


function LoadFresnelShader: Boolean;
var
  vs: Integer;
  c: array [1..MAX_READ_BUFFER] of AnsiChar;
  src: PAnsiChar; // PGLcharARB = PAnsiChar;
  ff:file;
  fname:string;
  i,k,NumRead:Integer;
  s: AnsiString;
begin
  Result := false;
  try
    s := PAnsiChar(glGetString(GL_VERSION));

    if s < '2.0' then begin //return format is "Major.Minor.Minor - Misc", we check first two  numbers as version
      if not fileexists('krom.dev') then
        MessageBox(Form1.Handle,
          PChar('You need at least OpenGL 2.0 to run MTKit2'+eol+
          'Your OpenGL version is '+glGetString(GL_VERSION)+' by '+glGetString(GL_RENDERER)+eol+
          eol+
          'MTKit2 will now run in compatibility mode'), 'OpenGL', MB_OK);
      exit;
    end;

    Assert(Assigned(glCreateShaderObjectARB));

    for i:=0 to MAX_MAT_CLASS do for k:=0 to MAX_MAT_CLASS do
    begin
      po[i,k]:=glCreateProgramObjectARB;
      fs[i,k]:=glCreateShaderObjectARB(GL_FRAGMENT_SHADER_ARB);
    end;

    vs:=glCreateShaderObjectARB(GL_VERTEX_SHADER_ARB); //one for all

    if not fileexists(ExeDir+'MTKit2 Data\Common.vert')
    or not fileexists(ExeDir+'MTKit2 Data\Common.frag') then
    begin
      MessageBox(Form1.Handle, 'Unable to locate "MTKit2 Data\Common.vert" or "MTKit2 Data\Common.frag"', 'Error', MB_OK or MB_ICONERROR);
      exit;
    end;

    assignfile(ff,ExeDir+'MTKit2 Data\Common.vert');
    reset(ff,1);
    blockread(ff,c,10000,NumRead);
    closefile(ff);
    c[NumRead+1]:=#0;
    src := PAnsiChar(@c[1]);
    glShaderSourceARB(vs, 1, @src, @NumRead);

    for i:=0 to MAX_MAT_CLASS do for k:=0 to MAX_MAT_CLASS do
    begin
      fname:=int2fix(i,2)+' '+int2fix(k,2);
      if fileexists(ExeDir+'MTKit2 Data\'+fname+'.frag') then
        fname:='MTKit2 Data\'+fname+'.frag'
      else
        fname:='MTKit2 Data\Common.frag';

      assignfile(ff,ExeDir+fname);
      reset(ff,1);
      blockread(ff,c,10000,NumRead);
      closefile(ff);
      c[NumRead+1]:=#0;
      src := PAnsiChar(@c[1]);
      glShaderSourceARB(fs[i,k], 1, @src, @NumRead);
    end;

    glCompileShaderARB(vs);
    CheckGLSLError(vs, GL_OBJECT_COMPILE_STATUS_ARB, 'Compile VS');

    for i:=0 to MAX_MAT_CLASS do
    for k:=0 to MAX_MAT_CLASS do
    begin
      glCompileShaderARB(fs[i,k]);
      CheckGLSLError(fs[i,k], GL_OBJECT_COMPILE_STATUS_ARB, Format('FS compile %2d %2d', [I,K]));

      glAttachObjectARB(po[i,k],vs);
      glAttachObjectARB(po[i,k],fs[i,k]);
      glLinkProgramARB(po[i,k]);
      CheckGLSLError(po[i,k],GL_OBJECT_LINK_STATUS_ARB, Format('PO link %2d %2d', [I,K]));
      glValidateProgramARB(po[i,k]);
      CheckGLSLError(po[i,k],GL_OBJECT_VALIDATE_STATUS_ARB, Format('PO validate %2d %2d', [I,K]));
    end;

    Result := true;
  except
    //
  end;
end;

function RenderShaders: Boolean;
var
  Mat_Ambi, Mat_Diff, Mat_Spec, Mat_Spec2, Mat_Refl, Mat_Dirt, Mat_ReflF: Integer;
  S_Tex1, S_Tex2, S_Tex3, S_Tex4: Integer;
  mc2,mc3,mc4: Byte;
  i,k,h: Integer;
begin
  for i:=1 to MOX.Header.PartCount do
  begin
    glPushMatrix;
    glMultMatrixf(@MOX.Parts[i].Matrix);

    // Flap everything correctly
    if RenderOptions.ShowDamage or (I = SelectedTreeNode) then
    begin
      glRotatef(Mix(MOX.Parts[i].x1, MOX.Parts[i].x2, RenderOptions.PartsFlapPos)/Pi*180,1,0,0);
      glRotatef(Mix(MOX.Parts[i].y1, MOX.Parts[i].y2, RenderOptions.PartsFlapPos)/Pi*180,0,1,0);
      glRotatef(Mix(MOX.Parts[i].z1, MOX.Parts[i].z2, RenderOptions.PartsFlapPos)/Pi*180,0,0,-1);
    end;

    for k:=MOX.Parts[i].FirstMat+1 to MOX.Parts[i].FirstMat+MOX.Parts[i].NumMat do
    begin
      //if (RenderOpts.ShowMaterial<>0)and(MatID<>MOX.Sid[k,1]+1) then exit;

      mc2 := Material[MOX.Chunks[k].SidA+1].MatClass[2];
      mc3 := Material[MOX.Chunks[k].SidA+1].MatClass[3];
      mc4 := Material[MOX.Chunks[k].SidA+1].MatClass[4];

      glUseProgramObjectARB(po[mc2,mc3]);
      S_Tex1 := glGetUniformLocationARB(po[mc2,mc3], 'Tex1');
      S_Tex2 := glGetUniformLocationARB(po[mc2,mc3], 'Tex2');
      S_Tex3 := glGetUniformLocationARB(po[mc2,mc3], 'Tex3');
      S_Tex4 := glGetUniformLocationARB(po[mc2,mc3], 'Tex4');
      Mat_Ambi := glGetUniformLocationARB(po[mc2,mc3], 'Mat_Ambi');
      Mat_Diff := glGetUniformLocationARB(po[mc2,mc3], 'Mat_Diff');
      Mat_Spec := glGetUniformLocationARB(po[mc2,mc3], 'Mat_Spec1');
      Mat_Spec2:= glGetUniformLocationARB(po[mc2,mc3], 'Mat_Spec2');
      Mat_Refl := glGetUniformLocationARB(po[mc2,mc3], 'Mat_Refl');
      Mat_Dirt := glGetUniformLocationARB(po[mc2,mc3], 'Mat_DirtAm');
      Mat_ReflF:= glGetUniformLocationARB(po[mc2,mc3], 'Mat_ReflFres');

      glActiveTexture(GL_TEXTURE0); glBindTexture(GL_TEXTURE_2D, MoxTex[MOX.Chunks[k].SidA+1]);

      if (Form1.CBVinyl.ItemIndex>0) and (mc4 and 1 = 1) then
        glBindTexture(GL_TEXTURE_2D, VinylsTex);

      glActiveTexture(GL_TEXTURE1); glBindTexture(GL_TEXTURE_2D, 1); //EnvMap
      glActiveTexture(GL_TEXTURE2); glBindTexture(GL_TEXTURE_2D, DirtTex);
      glActiveTexture(GL_TEXTURE3); glBindTexture(GL_TEXTURE_2D, ScratchTex);
      glUniform1iARB(S_Tex1, 0);
      glUniform1iARB(S_Tex2, 1);
      glUniform1iARB(S_Tex3, 2);
      glUniform1iARB(S_Tex4, 3);

      with Material[MOX.Chunks[k].SidA+1].Color[ColID] do
      begin
        glUniform3fARB(Mat_Diff ,Dif.R/255,Dif.G/255,Dif.B/255);
        glUniform3fARB(Mat_Ambi ,Amb.R/255,Amb.G/255,Amb.B/255);
        glUniform3fARB(Mat_Spec ,Sp1.R/255,Sp1.G/255,Sp1.B/255);
        glUniform3fARB(Mat_Spec2,Sp2.R/255,Sp2.G/255,Sp2.B/255);
        if mc4 and 8 = 8 then
        begin
          glUniform3fARB(Mat_Refl, Ref.R/255, Ref.G/255, Ref.B/255); //ReflectionControl /on
          glUniform1fARB(Mat_ReflF, 1);                              //ReflectionControl /on
        end else
        begin
          glUniform1fARB(Mat_ReflF, 0);                            //ReflectionControl /off
          glUniform3fARB(Mat_Refl, Byte(Ref.R<>0), Byte(Ref.G<>0), Byte(Ref.B<>0)); //Fresnel /on/off
        end;
        glUniform1fARB(Mat_Dirt, (Form1.TBDirt.Position/100) * Byte(mc4 and 4 = 4));
      end;

      glCallList(MoxCall[k]);
    end;

    if MOX.Parts[i].Child=-1 then
    begin
      glPopMatrix;
      h:=i;
      while(h>1)and(MOX.Parts[h].NextInLevel=-1) do begin
        glPopMatrix;
        h:=MOX.Parts[h].Parent+1;
      end;
    end;
  end;

  glUseProgramObjectARB(0);
  glActiveTexture(GL_TEXTURE0);
end;


procedure RenderCOB(aCOB: TModelCOB; aVerticeId: Integer; aShowIds: Boolean);
var
  i,h: Integer;
begin
  if aCOB.Head.PointQty = 0 then Exit;

  glBindTexture(GL_TEXTURE_2D, 0); //UV map texture

  glPushMatrix;
    glTranslate(aCOB.Head.X, aCOB.Head.Y, aCOB.Head.Z);
    glCallList(Pivot);
  glPopMatrix;

  glColor4f(0.7, 0.6, 0.5, 0.6);

  glBegin(GL_TRIANGLES);
    for i:= 0 to aCOB.Head.PolyQty - 1 do
      for h:=3 downto 1 do
      begin
        glNormal3fv(@aCOB.Normals[i].X);
        glvertex3fv(@aCOB.Vertices[aCOB.Faces[i,h]].X);
      end;
  glEnd;

  glDepthFunc(GL_ALWAYS);
  glColor4f(1, 0.9, 0.6, 1);
  glPolygonMode(GL_FRONT, GL_LINE);

  glBegin(GL_TRIANGLES);
    for i:=0 to aCOB.Head.PolyQty - 1 do
    for h:=3 downto 1 do
    begin
      glNormal3fv(@aCOB.Normals[i].X);
      glVertex3fv(@aCOB.Vertices[aCOB.Faces[i,h]].X);
    end;
  glEnd;

  glPolygonMode(GL_FRONT, GL_FILL);
  glDepthFunc(GL_LEQUAL);
  glDisable(GL_LIGHTING);

  if aShowIds then
  for i:=0 to aCOB.Head.PointQty - 1 do
  begin
    glColor4f(0.75, 0.75, 0.75, 1);
    glRasterPos3fv(@aCOB.Vertices[i].X);
    glPrint(IntToStr(i + 1));
  end;

  if aVerticeId >= 0 then
  begin
    glColor4f(1, 1, 1, 1);
    glDepthFunc(GL_ALWAYS);

    glBegin(GL_POINTS);
      glVertex3fv(@aCOB.Vertices[aVerticeId].X);
    glEnd;

    glRasterPos3fv(@aCOB.Vertices[aVerticeId].X);
    glPrint(IntToStr(aVerticeId + 1));
    glDepthFunc(GL_LEQUAL);
  end;
end;


procedure RenderCPO(ID:Integer);
var
  i,k,h,ci,qty:Integer;
  a,b,c:Integer;
begin
  glDisable(GL_LIGHTING);
  glBindTexture(GL_TEXTURE_2D, 0); //UV map texture

  for i:=1 to CPOHead.Qty do
  begin
    glPushMatrix;
    Matrix2Angles(CPO[i].Matrix9,9,@a,@b,@c);
    glTranslate(CPO[i].PosX,CPO[i].PosY,CPO[i].PosZ);
    glRotate(c,0,0,-1); glRotate(b,0,-1,0); glRotate(a,-1,0,0);
    glCallList(Pivot); //Pivot
    if ID=i then glColor4f(1,1,1,1)
            else glColor4f(1,0.9,0.6,1);
      //Bounding box
      if CPO[i].Format=2 then
      begin
          glScale(abs(CPO[i].ScaleX),abs(CPO[i].ScaleY),abs(CPO[i].ScaleZ));
          glCallList(BBoxW);
          if ID=i then glColor4f(0.8,0.5,0.4,0.3)
                   else glColor4f(0.7,0.6,0.5,0.3);
          glCallList(BBox);
      end;
      //Shape
      if CPO[i].Format=3 then
      begin
          glBegin(gl_Points);
            for h:=1 to CPO[i].VerticeCount do
              glVertex3fv(@CPO[i].Vertices[h]);
          glEnd;

          ci:=0;
          for k:=1 to CPO[i].PolyCount do begin
            inc(ci);
            qty:=CPO[i].Indices[ci];
            glBegin(gl_line_strip);
              for h:=1 to qty do begin
                inc(ci);
                glVertex3fv(@CPO[i].Vertices[CPO[i].Indices[ci]+1]);
              end;
            glEnd;
          end;

          if ID=i then glColor4f(0.8,0.5,0.4,0.3)
                   else glColor4f(0.7,0.6,0.5,0.3);

          ci:=0;
          for k:=1 to CPO[i].PolyCount do
          begin
            inc(ci);
            qty:=CPO[i].Indices[ci];
            glBegin(gl_Polygon);
              for h:=qty downto 1 do
                glVertex3fv(@CPO[i].Vertices[CPO[i].Indices[ci+h]+1]);
              inc(ci,qty);
            glEnd;
          end;

      end;
    glPopMatrix;
  end;
  glEnable(GL_LIGHTING);
end;


procedure RenderLights(aSelected: Integer; aMode: TBlinkerPreviewMode; aShowDummy, aVectors: Boolean);
var
  I: Integer;
  c: Integer;
  cam: array [1..3]of Single;
begin
  glDisable(GL_LIGHTING);
  glDepthFunc(GL_ALWAYS); //Render on top of all
  glBlendFunc(GL_SRC_ALPHA,GL_ONE);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

  //Prepare viewport vector
  Angles2Vector(-xRot, yRot, 0, cam[1], cam[2], cam[3]);
  Normalize(cam[1],cam[2],cam[3]);

  for I := 1 to MOX.Header.BlinkerCount do
  begin
    if aVectors then
    begin
      glBindTexture(GL_TEXTURE_2D, 0);
      glPushMatrix;
        glTranslate(MOX.Blinkers[I].Matrix[4,1],MOX.Blinkers[I].Matrix[4,2],MOX.Blinkers[I].Matrix[4,3]);
        //glMultMatrixf(@MOX.Blinkers[I].Matrix);
        glBegin(GL_LINES);
        glColor4ub(MOX.Blinkers[I].R,MOX.Blinkers[I].G,MOX.Blinkers[I].B,0);
        glVertex3f(MOX.Blinkers[I].Matrix[3,1]*10,MOX.Blinkers[I].Matrix[3,2]*10,MOX.Blinkers[I].Matrix[3,3]*10);
        glColor4ub(MOX.Blinkers[I].R,MOX.Blinkers[I].G,MOX.Blinkers[I].B,255);
        glVertex3f(0,0,0);
        glEnd;
      glPopMatrix;
    end;

    glPushMatrix;

    // Prepare texture
    case MOX.Blinkers[I].BlinkerType of
      1:      begin
                glColor3f(1,1,1);
                glBindTexture(GL_TEXTURE_2D, FlameTex);
                glMultMatrixf(@MOX.Blinkers[I].Matrix);
              end;
      2..9:   begin
                glBindTexture(GL_TEXTURE_2D, LensFlareTex);
                glTranslate(MOX.Blinkers[I].Matrix[4,1],MOX.Blinkers[I].Matrix[4,2],MOX.Blinkers[I].Matrix[4,3]);
                glRotatef(xRot, 0,-1, 0);
                glRotatef(yRot,-1, 0, 0);
                //find DOT between view and blinker vector
                c := Round(
                (DotProduct(MOX.Blinkers[I].Matrix[3,1],
                            MOX.Blinkers[I].Matrix[3,2],
                            MOX.Blinkers[I].Matrix[3,3],
                            cam[1], cam[2], cam[3]
                            )-0.325)*255*(1/(1-0.325))); //use 0.325 .. 1.0 as 0..1
                c := EnsureRange(c, 0, 255);
                glColor4ub(MOX.Blinkers[I].R,MOX.Blinkers[I].G,MOX.Blinkers[I].B,c); //set visibility according to DOT
              end;

      16..24: begin
                glColor3f(1,1,1);
                glBindTexture(GL_TEXTURE_2D, DummyTex);
                glMultMatrixf(@MOX.Blinkers[I].Matrix);
              end;
    end;

    case MOX.Blinkers[I].BlinkerType of
      1:    //Nitro Flame
            begin
              glDepthFunc(GL_LEQUAL);
              if aMode = bmNitro then
                glScale(MOX.Blinkers[I].sMin, MOX.Blinkers[I].sMin, MOX.Blinkers[I].sMax + RandomS(0.125))
              else
                glkScale(MOX.Blinkers[I].sMin);
              glCallList(FlameSprite);
              glDepthFunc(GL_ALWAYS);
            end;
      2,3:  //HeadLights //BrakeLights
            if aMode = bmHeadBreaks then
              glkScale(MOX.Blinkers[I].sMax)
            else
              glkScale(MOX.Blinkers[I].sMin);
      4:    //ReverseLights
            if aMode = bmReverse then
              glkScale(MOX.Blinkers[I].sMin)
            else
              glkScale(0);
      5,6:  // Left and Right
            if (aMode = bmBlinkers) and (Round(GetTickCount/500)mod 2 = 0) then
              glkScale(MOX.Blinkers[I].sMin)
            else
              glkScale(0);
      7:    // Start gate
            if (MOX.Blinkers[I].BlinkerType <> 8) and (Round(GetTickCount/500)mod 2 = 0) then
              glkScale(MOX.Blinkers[I].sMin) else glkScale(0);
      8:    // Strobe
            if (MOX.Blinkers[I].BlinkerType <> 8) and (Round(GetTickCount/500)mod 2 = 0) then
              glkScale(MOX.Blinkers[I].sMin) else glkScale(0);
      9:    // Flashing
            begin //Emergency
              if round(GetTickCount/1000*3) mod 2 = 0 then glscale(1,-1,1);
              glkScale(MOX.Blinkers[I].sMin);
            end;
      16:   // MotorLocaion
            begin
              glColor4f(1,1,1,1);
              glkScale(0.8/zoom);
            end;
      20:   // AFC11 WheelPosition
            begin
              glColor4f(0,0.8,0,1);
              glkScale(0.8/zoom);
            end;
      24:   // AFC11 TowingPoint
            begin
              glColor4f(0,0.8,0.8,1);
              glkScale(0.8/zoom);
            end;
    end;

    case MOX.Blinkers[I].BlinkerType of
      //1:     glCallList(FlameSprite);
      2..9:   glCallList(Sprite1Side);
      16..24: if aShowDummy then glCallList(Sprite2Side);
    end;

    glPopMatrix;

    if I = aSelected then
    begin
      glPushMatrix;
      try
        glMultMatrixf(@MOX.Blinkers[I].Matrix);
        glRotate((Round(GetTickCount/15)mod 90),0,0,1);
        glColor4f(0, 0, 1, 1);
        glBindTexture(GL_TEXTURE_2D, SelectionTex);
        glkScale(0.8 / zoom);
        glCallList(Sprite2Side);
      finally
        glPopMatrix;
      end;
    end;
  end;
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glDepthFunc(GL_LEQUAL);
  glEnable(GL_LIGHTING);
end;


procedure RenderGrid;
var
  i,h:Integer;
  xx,zz:Integer;
  Step: array [1..2]of Integer;
begin
XX:=25;
ZZ:=40;
Step[1]:=2;
Step[2]:=10;
glBegin(GL_LINES);
  for h:=1 to 2 do begin
    if h=1 then glColor4f(1,1,1,0.25);
    if h=2 then glColor4f(0.3,0.3,0.3,0.5);
    for i:=-xx div Step[h] to xx div Step[h] do begin
      glVertex3f(i*Step[h],0,-zz-1);
      glVertex3f(i*Step[h],0, zz+1);
    end;
    for i:=-zz div Step[h] to zz div Step[h] do begin
      glVertex3f(-xx-1,0,i*Step[h]);
      glVertex3f( xx+1,0,i*Step[h]);
    end;
  end;
  glColor4f(0,0,0,0.5);
    glVertex3f(0,0,-zz-2);
    glVertex3f(0,0, zz+3);
    glVertex3f(-xx-2,0,0);
    glVertex3f( xx+2,0,0);

    glVertex3f(0.7,0, zz+1.5);
    glVertex3f(0,0, zz+3);
    glVertex3f(0,0, zz+3);
    glVertex3f(-0.7,0, zz+1.5);
glEnd;
end;

procedure RenderUVGrid(ShowGrid:Boolean);
var
  i:Integer;
begin
  glBegin(GL_LINES);

    if ShowGrid then
    begin
      glColor4f(1,1,1,0.4);
      for i:=1 to 19 do
      begin
        glVertex2f(i/20, 0);
        glVertex2f(i/20, 1);
      end;
      for i:=1 to 19 do
      begin
        glVertex2f( 0,i/20);
        glVertex2f( 1,i/20);
      end;
    end;

    glColor4f(0,0,0,0.5);
    glVertex2f(0, 0);
    glVertex2f(0, 1.05);
    glVertex2f(0 ,0);
    glVertex2f(1.05 ,0);
    glVertex2f(1, 0);
    glVertex2f(1, 1);
    glVertex2f(0 ,1);
    glVertex2f(1 ,1);
    //U arrow
    glVertex2f(1, 0.025);
    glVertex2f(1.05, 0);
    glVertex2f(1.05, 0);
    glVertex2f(1, -0.025);
    //V arrow
    glVertex2f(0.025, 1);
    glVertex2f(0, 1.05);
    glVertex2f(0 ,1.05);
    glVertex2f(-0.025 ,1);
  glEnd;
end;

procedure CompileCommonObjects;
var
  I, K: Integer;
begin
  // Big cross
  Pivot := glGenLists(1);
  glNewList(Pivot, GL_COMPILE);
    glBegin(GL_LINES);
      glColor4f(1,0.3,0.3,1);
      glVertex3f(10,0,0); glVertex3f(-10,0,0);
      glVertex3f(9,0,0.5); glVertex3f(10,0,0);
      glVertex3f(9,0,-0.5); glVertex3f(10,0,0);
      glColor4f(0.3,1,0.3,1);
      glVertex3f(0,0,10); glVertex3f(0,0,-10);
      glVertex3f(0.5,0,9); glVertex3f(0,0,10);
      glVertex3f(-0.5,0,9); glVertex3f(0,0,10);
      glColor4f(0.3,0.3,1,1);
      glVertex3f(0,10,0); glVertex3f(0,-10,0);
      glVertex3f(0,9,0.5); glVertex3f(0,10,0);
      glVertex3f(0,9,-0.5); glVertex3f(0,10,0);
    glEnd;
  glEndList;

  // Box
  BBox := glGenLists(1);
  glNewList(BBox, GL_COMPILE);
    glBegin(GL_QUADS);
      for I:=1 to 6 do
      for K:=4 downto 1 do
        glVertex3fv(@BBoxV[BBoxI[I,K]]);
    glEnd;
  glEndList;

  // Wirebox
  BBoxW := glGenLists(1);
  glNewList(BBoxW, GL_COMPILE);
    for I:=1 to 6 do
    begin
      glBegin(GL_LINE_STRIP);
        for K:=4 downto 1 do
          glvertex3fv(@BBoxV[BBoxI[I,K]]);
      glEnd;
    end;
  glEndList;

  // Small cross
  Center := glGenLists(1);
  glNewList(Center, GL_COMPILE);
    glBegin(GL_LINES);
      glColor4f(1,0.5,0.5,1);
      glvertex3f(4,0,0); glvertex3f(-4,0,0);
      glvertex3f(3.5,0,0.5); glvertex3f(3.5,0,-0.5);
      glvertex3f(3.5,0.5,0); glvertex3f(3.5,-0.5,0);
      glColor4f(0.5,1,0.5,1);
      glvertex3f(0,0,4); glvertex3f(0,0,-4);
      glvertex3f(0.5,0,3.5); glvertex3f(-0.5,0,3.5);
      glvertex3f(0,0.5,3.5); glvertex3f(0,-0.5,3.5);
      glColor4f(0.5,0.5,1,1);
      glvertex3f(0,4,0); glvertex3f(0,-4,0);
      glvertex3f(0,3.5,0.5); glvertex3f(0,3.5,-0.5);
      glvertex3f(0.5,3.5,0); glvertex3f(-0.5,3.5,0);
    glEnd;
  glEndList;

  Dummy := glGenLists(1);
  glNewList(Dummy, GL_COMPILE);
    glBegin(GL_LINES);
      glColor4f(1,0.5,0.5,1);
      glvertex3f(5,0,0); glvertex3f(-5,0,0);
      glColor4f(0.5,1,0.5,1);
      glvertex3f(0,0,5); glvertex3f(0,0,-5);
      glColor4f(0.5,0.5,1,1);
      glvertex3f(0,5,0); glvertex3f(0,-5,0);
    glEnd;
  glEndList;

  Sprite1Side := glGenLists(1);
  glNewList(Sprite1Side, GL_COMPILE);
    glBegin(GL_POLYGON);
      glNormal3f(0,0,-1);//why it doesn`t works this way ? i don`t know
      glTexCoord2fv(@OSpriteUV[4]); glvertex2fv(@OSprite[4]);
      glTexCoord2fv(@OSpriteUV[3]); glvertex2fv(@OSprite[3]);
      glTexCoord2fv(@OSpriteUV[2]); glvertex2fv(@OSprite[2]);
      glTexCoord2fv(@OSpriteUV[1]); glvertex2fv(@OSprite[1]);
    glEnd;
  glEndList;

  Sprite2Side := glGenLists(1);
  glNewList(Sprite2Side, GL_COMPILE);
    glBegin(GL_QUADS);
      glNormal3f(0,0,-1);//why it doesn`t works this way ? i don`t know
      for I:=1 to 4 do
      begin
        glTexCoord2fv(@OSpriteUV[I]);
        glvertex2fv(@OSprite[I]);
      end;
      for I:=4 downto 1 do
      begin //Make the sprite doublesided
        glTexCoord2fv(@OSpriteUV[I]);
        glvertex2fv(@OSprite[I]);
      end;
    glEnd;
  glEndList;

  FlameSprite := glGenLists(1);
  glNewList(FlameSprite, GL_COMPILE);
    glBegin(GL_TRIANGLES);
      for I:=1 to 98 do for K:=3 downto 1 do
      begin
        glNormal3fv(@OFlameN[OFlameP[I,K]]);
        glTexCoord2fv(@OFlameUV[OFlameP[I,K]]);
        glvertex3fv(@OFlame[OFlameP[I,K]]);
      end;
    glEnd;
  glEndList;

  SelectionSphere:=glGenLists(1);
  glNewList(SelectionSphere, GL_COMPILE);
    glBegin (GL_LINE_LOOP);
      glColor4f(0.85,0.25,0.25,0.85);
      for I:=1 to 32 do glvertex3f(0, ORadius[I,1]*5, ORadius[I,2]*5);
    glEnd;
    glBegin(GL_LINE_LOOP);
      glColor4f(0.25,0.85,0.25,0.85);
      for I:=1 to 32 do glvertex3f(ORadius[I,1]*5, ORadius[I,2]*5, 0);
    glEnd;
    glBegin(GL_LINE_LOOP);
      glColor4f(0.25,0.25,0.85,0.85);
      for I:=1 to 32 do glvertex3f(ORadius[I,1]*5, 0, ORadius[I,2]*5);
    glEnd;
  glEndList;
end;


end.
