unit Unit_RenderInit;
interface
uses
  OpenGL,
  Unit1, KromOGLUtils, dglOpenGL, Unit_Defaults, PTXTexture, KromUtils, Unit_Render, Windows, SysUtils;

procedure RenderInit;
procedure KnowFPS;
function  LoadShader: Boolean;

var
  vs, ovs: GLhandleARB;  // Shader objects
  po, fs: array [1..ShadQty] of GLhandleARB;  // Shader objects
  opo, ofs: array [0..ObjShadQty] of GLhandleARB;  // Shader objects
  S_MtlCol, S_SunCol, S_SunPos, S_FogCol, S_FogPos: Integer;
  S_Tex1, S_Tex2, S_Tex3, S_Tex4: Integer;        // Texture handles
  T_TA1, T_TA2, T_TB1, T_TB2, T_TC1, T_TC2: Integer;// TransformMatrix handles


implementation


procedure RenderInit;
begin
  BuildFont(h_DC, 14);
  Form1.MemoLWO.Lines.Add('Builded fonts in ' + ElapsedTime(@OldTime));

  glClear(GL_COLOR_BUFFER_BIT);
  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glEnable(GL_NORMALIZE);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glDepthFunc(GL_LESS);                                 // Blending possible
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glEnable(GL_CULL_FACE);                               //Excludes backfacing polys from rendering
  glCullFace(GL_BACK);                                  //adds few FPS
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);
  glLightfv(GL_LIGHT0, GL_SPECULAR, @LightSpec);
  glLightfv(GL_LIGHT0, GL_DIFFUSE, @LightDiff);
  glEnable(GL_COLOR_MATERIAL);
  glEnable(GL_TEXTURE_2D);
  Form1.MemoLWO.Lines.Add('Attempt to init GLSL ');
  LoadShader();
  Form1.MemoLWO.Lines.Add('Load shaders in ' + ElapsedTime(@OldTime));
  LoadTexturePTX(fOptions.ExeDir+STKit2_Data_Path+'\EnvMap.ptx', EnvMap);
  LoadTexturePTX(fOptions.ExeDir+STKit2_Data_Path+'\FlareTex.ptx', FlareTex);
  LoadTexturePTX(fOptions.ExeDir+STKit2_Data_Path+'\Black.ptx', BlackTex);
  LoadTexturePTX(fOptions.ExeDir+STKit2_Data_Path+'\White.ptx', WhiteTex);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  glPointSize(PointSize);
end;


procedure KnowFPS;
begin
  FrameTime:=GetTickCount-OldTickCount;
  OldTickCount:=GetTickCount;
  if (fOptions.FPSLag<>1) and (FrameTime<fOptions.FPSLag) then
  begin
    sleep(fOptions.FPSLag-FrameTime);
    FrameTime := fOptions.FPSLag;
  end;
  if FrameTime>1000 then FrameTime:=1000;
  inc(OldFrameTimes,FrameTime);
  inc(FrameCount);
  if OldFrameTimes >= FPS_INTERVAL then
  begin
    Form1.StatusBar1.Panels[0].Text:=' '+floattostr(round((1000/(OldFrameTimes/FrameCount))*10)/10)+' fps ('+inttostr(1000 div fOptions.FPSLag)+')';
    OldFrameTimes:=0; FrameCount:=0;
  end; //FPS calculation complete
end;


function LoadShader: Boolean;
var
  src: PAnsiChar; // PGLcharARB = PAnsiChar;
  ff: file;
  c: array [1..16384] of AnsiChar;
  i,NumRead:integer;
  s: AnsiString;
begin
  Result:=false;

  s := PAnsiChar(glGetString(GL_VERSION));

  if s < '2.0' then  //return format is "Major.Minor.Minor - Misc", we check first two  numbers as version
  begin
    if not fileexists('krom.dev') then
      MessageBox(Form1.Handle,
        PChar('You need at least OpenGL 2.0 to run STKit2'+eol+
        'Your OpenGL version is '+glGetString(GL_VERSION)+' by '+glGetString(GL_RENDERER)+eol+
        eol+
        'STKit2 will now run in compatibility mode'), 'OpenGL', MB_OK);
    UseShaders := false;
    exit;
  end;

  Assert(Assigned(glCreateShaderObjectARB));

  vs := glCreateShaderObjectARB(GL_VERTEX_SHADER_ARB);
  s := fOptions.ExeDir+STKit2_Data_Path+'\Shaders\Mat_GLSL.vert';
  if fileexists(s) then
  begin
    assignfile(ff,s);
    reset(ff,1);
    blockread(ff,c,16384,NumRead);
    closefile(ff);
    c[NumRead+1]:=#0;
    src := PAnsiChar(@c[1]);
  end else
    src:=@MatModeDefaultV;
  glShaderSourceARB(vs, 1, @src, @NumRead);

  for i:=1 to ShadQty do
  begin
    po[i]:=glCreateProgramObjectARB;
    fs[i]:=glCreateShaderObjectARB(GL_FRAGMENT_SHADER_ARB);
    s:=fOptions.ExeDir+STKit2_Data_Path+'\Shaders\'+MatModeF[i]+'.frag';
    if fileexists(s) then
    begin
      assignfile(ff,s);
      reset(ff,1);
      blockread(ff,c,16384,NumRead);
      closefile(ff);
      c[NumRead+1]:=#0;
      src:=PAnsiChar(@c[1]);
    end else
      src:=@MatModeDefaultF;
    glShaderSourceARB(fs[i], 1, @src, @NumRead);
  end;
  Form1.MemoLWO.Lines.Add('Loaded GLSL files');

  glCompileShaderARB(vs);
  CheckGLSLError(vs, GL_OBJECT_COMPILE_STATUS_ARB, 'VS ');
  for i:=1 to ShadQty do
  begin
    glCompileShaderARB(fs[i]);
    CheckGLSLError(fs[i], GL_OBJECT_COMPILE_STATUS_ARB, 'FS '+inttostr(i)+' ');
    glAttachObjectARB(po[i],vs);
    glAttachObjectARB(po[i],fs[i]);
    glLinkProgramARB(po[i]);
    CheckGLSLError(po[i], GL_OBJECT_LINK_STATUS_ARB, 'PO '+inttostr(i)+' ');
    glValidateProgramARB(po[i]);
    CheckGLSLError(po[i], GL_OBJECT_VALIDATE_STATUS_ARB, 'PO '+inttostr(i)+' ');
  end;
  Form1.MemoLWO.Lines.Add('Compiled GLSL files');

  ovs:=glCreateShaderObjectARB(GL_VERTEX_SHADER_ARB);
  s:=fOptions.ExeDir+STKit2_Data_Path+'\Shaders\Obj_GLSL.vert';
  assignfile(ff,s); reset(ff,1);
  blockread(ff,c,16384,NumRead); closefile(ff);
  c[NumRead+1]:=#0; src:=PAnsiChar(@c[1]);
  glShaderSourceARB(ovs, 1, @src, @NumRead);

  for i:=0 to ObjShadQty do
  begin
    opo[i]:=glCreateProgramObjectARB;
    ofs[i]:=glCreateShaderObjectARB(GL_FRAGMENT_SHADER_ARB);
    s:=fOptions.ExeDir+STKit2_Data_Path+'\Shaders\Obj'+int2fix(i,2)+'00.frag';
    if not fileexists(s) then s:=fOptions.ExeDir+STKit2_Data_Path+'\Shaders\Obj_GLSL.frag';
    assignfile(ff,s); reset(ff,1);
    blockread(ff,c,16384,NumRead); closefile(ff);
    c[NumRead+1]:=#0; src:=PAnsiChar(@c[1]);
    glShaderSourceARB(ofs[i], 1, @src, @NumRead);
  end;

  Form1.MemoLWO.Lines.Add('Loaded Object GLSL files');

  glCompileShaderARB(ovs);
  CheckGLSLError(ovs, GL_OBJECT_COMPILE_STATUS_ARB, 'VS ');
  for i:=0 to ObjShadQty do
  begin
    glCompileShaderARB(ofs[i]);
    CheckGLSLError(ofs[i], GL_OBJECT_COMPILE_STATUS_ARB, 'FS '+inttostr(i)+' ');
    glAttachObjectARB(opo[i],vs);
    glAttachObjectARB(opo[i],ofs[i]);
    glLinkProgramARB(opo[i]);
    CheckGLSLError(opo[i], GL_OBJECT_LINK_STATUS_ARB, 'PO '+inttostr(i)+' ');
    glValidateProgramARB(opo[i]);
    CheckGLSLError(opo[i], GL_OBJECT_VALIDATE_STATUS_ARB, 'PO '+inttostr(i)+' ');
  end;
  Form1.MemoLWO.Lines.Add('Compiled Object GLSL files');

  UseShaders:=true;
end;


end.
