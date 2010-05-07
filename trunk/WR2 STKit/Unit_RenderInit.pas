unit Unit_RenderInit;
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses
  {$IFDEF VER140} OpenGL, {$ENDIF}
  {$IFDEF FPC} GL, {$ENDIF}
  Unit1, KromOGLUtils, dglOpenGL, Defaults, PTXTexture, KromUtils, Unit_Render, Windows, sysutils;

procedure RenderInit();
procedure KnowFPS();
function  LoadShader():boolean;

var
    vs,ovs:GLhandleARB;  //Shader objects
    po,fs: array[1..ShadQty]of GLhandleARB;  //Shader objects
    opo,ofs: array[0..ObjShadQty]of GLhandleARB;  //Shader objects
    S_MtlCol,S_SunCol,S_SunPos,S_FogCol,S_FogPos: integer;
    S_Tex1,S_Tex2,S_Tex3,S_Tex4: integer;        //Texture handles
    T_TA1,T_TA2,T_TB1,T_TB2,T_TC1,T_TC2: integer;//TransformMatrix handles

implementation

procedure RenderInit();
begin
  ReadExtensions;
  ReadImplementationProperties;
  BuildFont(h_DC,14);
  Form1.MemoLWO.Lines.Add('Builded fonts in '+ElapsedTime(@OldTime));

  glClear (GL_COLOR_BUFFER_BIT);
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
  Form1.MemoLWO.Lines.Add('Load shaders in '+ElapsedTime(@OldTime));
  LoadTexturePTX(ExeDir+'STKit2 Data\EnvMap.ptx', EnvMap);
  LoadTexturePTX(ExeDir+'STKit2 Data\FlareTex.ptx', FlareTex);
  LoadTexturePTX(ExeDir+'STKit2 Data\Black.ptx', BlackTex);
  LoadTexturePTX(ExeDir+'STKit2 Data\White.ptx', WhiteTex);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  glPointSize(PointSize);
end;

procedure KnowFPS();
begin
  FrameTime:=GetTickCount-OldTickCount;
  OldTickCount:=GetTickCount;
    if (FPSLag<>1)and(FrameTime<FPSLag) then begin
    sleep(FPSLag-FrameTime);
    FrameTime:=FPSLag;
    end;
  if FrameTime>1000 then FrameTime:=1000;
  inc(OldFrameTimes,FrameTime);
  inc(FrameCount);
  if OldFrameTimes>=FPS_INTERVAL then begin
    Form1.StatusBar1.Panels[0].Text:=' '+floattostr(round((1000/(OldFrameTimes/FrameCount))*10)/10)+' fps ('+inttostr(1000 div FPSLag)+')';
    OldFrameTimes:=0; FrameCount:=0;
  end; //FPS calculation complete
end;

function LoadShader():boolean;
var src: PChar; // PGLcharARB = PChar;
    ff: file;
    c:array[1..16384] of char;
    i,NumRead:integer;
    ShowGLSLWarning:boolean;
    s:string;
begin
ShowGLSLWarning:=false;
Result:=false;

s:=glGetString(GL_VERSION); //return format is "Major.Minor.Minor - Misc"
if s<'2.0' then begin       //we check first two  numbers as version
  if not fileexists('krom.dev') then
    MyMessageBox(Form1.Handle,
      'You need at least OpenGL 2.0 to run STKit2'+zz+
      'Your OpenGL version is '+glGetString(GL_VERSION)+' by '+glGetString(GL_RENDERER)+zz+zz+
      'STKit2 will now run in compatibility mode', 'OpenGL', MB_OK);
  UseShaders:=false;
  exit;
end;

    vs:=glCreateShaderObjectARB(GL_VERTEX_SHADER_ARB);
    s:=ExeDir+'STKit2 Data\Shaders\Mat_GLSL.vert';
        if fileexists(s) then begin
        assignfile(ff,s); reset(ff,1);
        blockread(ff,c,16384,NumRead); closefile(ff);
        c[NumRead+1]:=#0; src:=PChar(StrPas(@c));
        end else src:=@MatModeDefaultV;
    glShaderSourceARB(vs, 1, @src, @NumRead);

    for i:=1 to ShadQty do begin
    po[i]:=glCreateProgramObjectARB;
    fs[i]:=glCreateShaderObjectARB(GL_FRAGMENT_SHADER_ARB);
    s:=ExeDir+'STKit2 Data\Shaders\'+MatModeF[i]+'.frag';
        if fileexists(s) then begin
        assignfile(ff,s); reset(ff,1);
        blockread(ff,c,16384,NumRead); closefile(ff);
        c[NumRead+1]:=#0; src:=PChar(StrPas(@c));
        end else src:=@MatModeDefaultF;
    glShaderSourceARB(fs[i], 1, @src, @NumRead);
    end;
Form1.MemoLWO.Lines.Add('Loaded GLSL files');

glCompileShaderARB(vs);
CheckGLSLError(Form1.Handle, vs, GL_OBJECT_COMPILE_STATUS_ARB, ShowGLSLWarning,'VS ');
  for i:=1 to ShadQty do begin
  glCompileShaderARB(fs[i]);
  CheckGLSLError(Form1.Handle, fs[i], GL_OBJECT_COMPILE_STATUS_ARB, ShowGLSLWarning,'FS '+inttostr(i)+' ');
  glAttachObjectARB(po[i],vs);
  glAttachObjectARB(po[i],fs[i]);
  glLinkProgramARB(po[i]);
  CheckGLSLError(Form1.Handle, po[i], GL_OBJECT_LINK_STATUS_ARB, ShowGLSLWarning,'PO '+inttostr(i)+' ');
  glValidateProgramARB(po[i]);
  CheckGLSLError(Form1.Handle, po[i], GL_OBJECT_VALIDATE_STATUS_ARB, ShowGLSLWarning,'PO '+inttostr(i)+' ');
  end;
Form1.MemoLWO.Lines.Add('Compiled GLSL files');

    ovs:=glCreateShaderObjectARB(GL_VERTEX_SHADER_ARB);
    s:=ExeDir+'STKit2 Data\Shaders\Obj_GLSL.vert';
    assignfile(ff,s); reset(ff,1);
    blockread(ff,c,16384,NumRead); closefile(ff);
    c[NumRead+1]:=#0; src:=PChar(StrPas(@c));
    glShaderSourceARB(ovs, 1, @src, @NumRead);

    for i:=0 to ObjShadQty do begin
    opo[i]:=glCreateProgramObjectARB;
    ofs[i]:=glCreateShaderObjectARB(GL_FRAGMENT_SHADER_ARB);
    s:=ExeDir+'STKit2 Data\Shaders\Obj'+int2fix(i,2)+'00.frag';
    if not fileexists(s) then s:=ExeDir+'STKit2 Data\Shaders\Obj_GLSL.frag';
        assignfile(ff,s); reset(ff,1);
        blockread(ff,c,16384,NumRead); closefile(ff);
        c[NumRead+1]:=#0; src:=PChar(StrPas(@c));
        glShaderSourceARB(ofs[i], 1, @src, @NumRead);
    end;
Form1.MemoLWO.Lines.Add('Loaded Object GLSL files');

glCompileShaderARB(ovs);
CheckGLSLError(Form1.Handle, ovs, GL_OBJECT_COMPILE_STATUS_ARB, ShowGLSLWarning,'VS ');
  for i:=0 to ObjShadQty do begin
  glCompileShaderARB(ofs[i]);
  CheckGLSLError(Form1.Handle, ofs[i], GL_OBJECT_COMPILE_STATUS_ARB, ShowGLSLWarning,'FS '+inttostr(i)+' ');
  glAttachObjectARB(opo[i],vs);
  glAttachObjectARB(opo[i],ofs[i]);
  glLinkProgramARB(opo[i]);
  CheckGLSLError(Form1.Handle, opo[i], GL_OBJECT_LINK_STATUS_ARB, ShowGLSLWarning,'PO '+inttostr(i)+' ');
  glValidateProgramARB(opo[i]);
  CheckGLSLError(Form1.Handle, opo[i], GL_OBJECT_VALIDATE_STATUS_ARB, ShowGLSLWarning,'PO '+inttostr(i)+' ');
  end;
Form1.MemoLWO.Lines.Add('Compiled Object GLSL files');

UseShaders:=true;
end;


end.
