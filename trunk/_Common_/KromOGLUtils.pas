unit KromOGLUtils;
{$IFDEF VER140} {$DEFINE WDC} {$ENDIF}  // Delphi 6
{$IFDEF VER150} {$DEFINE WDC} {$ENDIF}  // Delphi 7
{$IFDEF VER220} {$DEFINE WDC} {$ENDIF}  // Delphi XE
{$IFDEF VER230} {$DEFINE WDC} {$ENDIF}  // Delphi XE2
interface
uses
  dglOpenGL,
  {$IFDEF FPC} GL, {$ENDIF}
  SysUtils, Windows, Forms, KromUtils;

type KCode = (kNil=0,kPoint=1,kSpline=2,kSplineAnchor=3,kSplineAnchorLength=4,
              kPoly=5,kSurface=6,kObject=7,kButton=8);  //1..31 are ok

    KAlign = (kaLeft, kaCenter, kaRight);

    TColor4 = cardinal;

    procedure SetRenderFrameAA(DummyFrame,RenderFrame:HWND; AntiAliasing:byte; out h_DC: HDC; out h_RC: HGLRC);
    procedure SetRenderFrame(RenderFrame:HWND; out h_DC: HDC; out h_RC: HGLRC);

    procedure SetRenderDefaults;
    procedure CheckGLSLError(FormHandle:hWND; Handle: GLhandleARB; Param: GLenum; ShowWarnings:boolean; Text:string);
    procedure BuildFont(h_DC:HDC; FontSize:integer; FontWeight:word=FW_NORMAL);
    procedure glPrint(text: AnsiString);
    function ReadClick(X, Y: word): Vector3f;
    procedure glkScale(x:single);
    procedure glkQuad(Ax,Ay,Bx,By,Cx,Cy,Dx,Dy:single);
    procedure glkRect(Ax,Ay,Bx,By:single);
    procedure glkMoveAALines(DoShift:boolean);
    procedure SetupVSync(aVSync:boolean);
    procedure kSetColorCode(TypeOfValue:KCode;IndexNum:integer);
    procedure kGetColorCode(RGBColor:Pointer;var TypeOfValue:KCode;var IndexNum:integer);

const
    MatModeDefaultV:string=
    'varying vec3 kBlend;'+#10+#13+
    'void main(void)'+#10+#13+
    '{ '+#10+#13+
    'kBlend = gl_SecondaryColor.rgb;'+#10+#13+
    'gl_Position = ftransform();'+#10+#13+
    '}';

    MatModeDefaultF:string=
    'varying vec3 kBlend;'+#10+#13+
    'void main(void)'+#10+#13+
    '{ '+#10+#13+
    'vec3 kColor = smoothstep(0.4375,.5625,kBlend.rgb);'+#10+#13+
    'gl_FragColor = vec4(kColor.rgb,1);'+#10+#13+
    '}';


implementation


function SetDCPixelFormat(h_DC:HDC; PixelFormat:Integer):boolean;
var
  nPixelFormat: Integer;
  PixelDepth:integer;
  pfd: TPixelFormatDescriptor;
begin
  PixelDepth := 32; //32bpp is common

  with pfd do begin
    nSize           := SizeOf(TPIXELFORMATDESCRIPTOR); // Size Of This Pixel Format Descriptor
    nVersion        := 1;                    // The version of this data structure
    dwFlags         := PFD_DRAW_TO_WINDOW    // Buffer supports drawing to window
                       or PFD_SUPPORT_OPENGL // Buffer supports OpenGL drawing
                       or PFD_DOUBLEBUFFER;  // Supports double buffering
    iPixelType      := PFD_TYPE_RGBA;        // RGBA color format
    cColorBits      := PixelDepth;           // OpenGL color depth
    cRedBits        := 0;                    // Number of red bitplanes
    cRedShift       := 0;                    // Shift count for red bitplanes
    cGreenBits      := 0;                    // Number of green bitplanes
    cGreenShift     := 0;                    // Shift count for green bitplanes
    cBlueBits       := 0;                    // Number of blue bitplanes
    cBlueShift      := 0;                    // Shift count for blue bitplanes
    cAlphaBits      := 0;                    // Not supported
    cAlphaShift     := 0;                    // Not supported
    cAccumBits      := 0;                    // No accumulation buffer
    cAccumRedBits   := 0;                    // Number of red bits in a-buffer
    cAccumGreenBits := 0;                    // Number of green bits in a-buffer
    cAccumBlueBits  := 0;                    // Number of blue bits in a-buffer
    cAccumAlphaBits := 0;                    // Number of alpha bits in a-buffer
    cDepthBits      := 16;                   // Specifies the depth of the depth buffer
    cStencilBits    := 0;                    // Turn off stencil buffer
    cAuxBuffers     := 0;                    // Not supported
    iLayerType      := PFD_MAIN_PLANE;       // Ignored
    bReserved       := 0;                    // Number of overlay and underlay planes
    dwLayerMask     := 0;                    // Ignored
    dwVisibleMask   := 0;                    // Transparent color of underlay plane
    dwDamageMask    := 0;                    // Ignored
  end;

  if PixelFormat = 0 then
    nPixelFormat := ChoosePixelFormat(h_DC, @pfd)
  else
    nPixelFormat := PixelFormat;

  if nPixelFormat = 0 then begin
    MessageBox(0, 'Unable to find a suitable pixel format', 'Error', MB_OK or MB_ICONERROR);
    Result := false;
    exit;
  end;

  //Even with known pixel format we still need to supply some PFD structure
  if not SetPixelFormat(h_DC, nPixelFormat, @pfd) then begin
    MessageBox(0, 'Unable to set the pixel format', 'Error', MB_OK or MB_ICONERROR);
    Result := false;
    exit;
  end;

  Result := true;
end;


function GetMultisamplePixelFormat(h_dc: HDC; AntiAliasing:byte): integer;
var
  pixelFormat: integer;
  ValidFormat: boolean;
  NumFormats: GLUint;
  iAttributes: array of GLint;
begin
  Result := 0;

  if not WGL_ARB_multisample or not Assigned(wglChoosePixelFormatARB) then
    Exit;

  SetLength(iAttributes,21);
  iAttributes[0] := WGL_DRAW_TO_WINDOW_ARB;
  iAttributes[1] := 1;
  iAttributes[2] := WGL_SUPPORT_OPENGL_ARB;
  iAttributes[3] := 1;
  iAttributes[4] := WGL_ACCELERATION_ARB;
  iAttributes[5] := WGL_FULL_ACCELERATION_ARB;
  iAttributes[6] := WGL_COLOR_BITS_ARB;
  iAttributes[7] := 24;
  iAttributes[8] := WGL_ALPHA_BITS_ARB;
  iAttributes[9] := 8;
  iAttributes[10] := WGL_DEPTH_BITS_ARB;
  iAttributes[11] := 16;
  iAttributes[12] := WGL_STENCIL_BITS_ARB;
  iAttributes[13] := 0;
  iAttributes[14] := WGL_DOUBLE_BUFFER_ARB;
  iAttributes[15] := 1;
  iAttributes[16] := WGL_SAMPLE_BUFFERS_ARB;
  iAttributes[17] := 1;
  iAttributes[18] := WGL_SAMPLES_ARB;
  iAttributes[19] := AntiAliasing;
  iAttributes[20] := 0;

  //Try to find mode with slightly worse AA before giving up
  repeat
    iAttributes[19] := AntiAliasing;
    ValidFormat := wglChoosePixelFormatARB(h_dc, @iattributes[0], nil, 1, @pixelFormat, @NumFormats);
    if ValidFormat and (NumFormats >= 1) then
    begin
      Result := pixelFormat;
      exit;
    end;
    AntiAliasing := AntiAliasing div 2;
  until(AntiAliasing < 2);
end;


procedure SetContexts(RenderFrame:HWND; PixelFormat:integer; out h_DC: HDC; out h_RC: HGLRC);
begin
  h_DC := GetDC(RenderFrame);

  if h_DC = 0 then
  begin
    MessageBox(HWND(nil), 'Unable to get a device context', 'Error', MB_OK or MB_ICONERROR);
    exit;
  end;

  if not SetDCPixelFormat(h_DC, PixelFormat) then
    exit;

  h_RC := wglCreateContext(h_DC);

  if h_RC = 0 then
  begin
    MessageBox(HWND(nil), 'Unable to create an OpenGL rendering context', 'Error', MB_OK or MB_ICONERROR);
    exit;
  end;

  if not wglMakeCurrent(h_DC, h_RC) then
  begin
    MessageBox(HWND(nil), 'Unable to activate OpenGL rendering context', 'Error', MB_OK or MB_ICONERROR);
    exit;
  end;
end;


procedure SetRenderFrame(RenderFrame:HWND; out h_DC: HDC; out h_RC: HGLRC);
begin
  InitOpenGL;
  SetContexts(RenderFrame, 0, h_DC, h_RC);
  ReadExtensions;
  ReadImplementationProperties;
end;


{The key problem is this: the function we use to get WGL extensions is, itself, an OpenGL extension.
Thus like any OpenGL function, it requires an OpenGL context to call it. So in order to get the
functions we need to create a context, we have to... create a context.

Fortunately, this context does not need to be our final context. All we need to do is create a dummy
context to get function pointers, then use those functions directly. Unfortunately, Windows does not
allow recreation of a rendering context within a single HWND. We must destroy previous HWND context
and create final HWND context after we are finished with the dummy context.}
procedure SetRenderFrameAA(DummyFrame,RenderFrame:HWND; AntiAliasing:byte; out h_DC: HDC; out h_RC: HGLRC);
var PixelFormat:integer;
begin
  InitOpenGL;
  SetContexts(DummyFrame, 0, h_DC, h_RC);
  ReadExtensions;
  ReadImplementationProperties;

  PixelFormat := GetMultisamplePixelFormat(h_DC, AntiAliasing);
  wglMakeCurrent(h_DC, 0);
  wglDeleteContext(h_RC);

  SetContexts(RenderFrame, PixelFormat, h_DC, h_RC);
  ReadExtensions;
  ReadImplementationProperties;
end;


procedure SetRenderDefaults;
begin
  glClearColor(0, 0, 0, 0); 	   //Background
  glClear (GL_COLOR_BUFFER_BIT);
  glShadeModel(GL_SMOOTH);                 //Enables Smooth Color Shading
  glPolygonMode(GL_FRONT,GL_FILL);
  glEnable(GL_NORMALIZE);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA); //Set alpha mode
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glEnable(GL_COLOR_MATERIAL);                 //Enable Materials
  glEnable(GL_TEXTURE_2D);                     // Enable Texture Mapping
end;


procedure CheckGLSLError(FormHandle:hWND; Handle: GLhandleARB; Param: GLenum; ShowWarnings:boolean; Text:string);
var l,glsl_ok:GLint; s:PChar; i:integer; ShowMessage:boolean;
begin
  glGetObjectParameterivARB(Handle, Param, @glsl_ok);
  s := StrAlloc(1000); //Allocate space
  glGetInfoLogARB(Handle, StrBufSize(s), l, PGLcharARB(s));
//Intent to hide all Warning messages
  ShowMessage:=ShowWarnings;
  for i:=1 to length(s) do
  if (s[i]=#13)and(i+1<length(s)) then
  if (s[i+1]<>'W')and(s[i+1]<>'L')and(not ShowMessage) then ShowMessage:=true;
  if ShowMessage and (s[0]<>'') then
  begin
    s := StrPCopy(s,Text + StrPas(s));
    MessageBox(HWND(nil), s,'GLSL Log', MB_OK);
  end;
  StrDispose(s); //Free-up space
end;


procedure BuildFont(h_DC:HDC; FontSize:integer; FontWeight:word=FW_NORMAL);
var Font: HFONT;
begin
//New parameter FontSize=16
  font:=CreateFont(-abs(FontSize),0,0,0,FontWeight,0,0,0,ANSI_CHARSET,
  OUT_TT_PRECIS,CLIP_DEFAULT_PRECIS,
  ANTIALIASED_QUALITY,FF_DONTCARE or DEFAULT_PITCH,
  'Terminal');
  SelectObject(h_dc,font);
  wglUseFontBitmaps(h_dc,0,128,20000);
end;


procedure glPrint(text: AnsiString);
begin
  if text = '' then exit;
  glPushAttrib(GL_LIST_BIT);
  glListBase(20000);
  glCallLists(length(text),GL_UNSIGNED_BYTE,PAnsiChar(@text[1]));
  glPopAttrib;
end;


function ReadClick(X, Y: word): Vector3f;
var viewport:TVector4i;
    projection:TMatrix4d;
    modelview:TMatrix4d;
    vx,vy:integer;
    vz:single; //required to match GL_FLOAT - single
    wx,wy,wz:GLdouble;
begin
  glGetIntegerv(GL_VIEWPORT,@viewport);
  glGetDoublev(GL_PROJECTION_MATRIX,@projection);
  glGetDoublev(GL_MODELVIEW_MATRIX,@modelview);

  vx := x;
  vy := y;

  glReadPixels(vx, vy, 1, 1, GL_DEPTH_COMPONENT, GL_FLOAT, @vz);

  if vz=1 then begin
    Result.x:=1000000; //Something out of working range
    Result.y:=0;
    Result.z:=0;
  end else begin
    //This function uses OpenGL parameters, not dglOpenGL
    gluUnProject(vx, vy, vz, modelview, projection, viewport, @wx, @wy, @wz);
    Result.x:=wx;
    Result.y:=wy;
    Result.z:=wz;
  end;
end;


procedure kSetColorCode(TypeOfValue:KCode;IndexNum:integer);
begin
glColor4ub(IndexNum mod 256,
          (IndexNum mod 65536) div 256,    // 1,2,4(524288) 8,16,32,64,128 //0..31
          (IndexNum mod 524288) div 65536+byte(TypeOfValue)*8,255);
end;


procedure kGetColorCode(RGBColor:Pointer;var TypeOfValue:KCode;var IndexNum:integer);
begin
IndexNum:=pword(cardinal(RGBColor))^+((pbyte(cardinal(RGBColor)+2)^)mod 8)*65536;
TypeOfValue:=KCode((pbyte(cardinal(RGBColor)+2)^)div 8);
end;

procedure glkScale(x:single);
begin
  glScalef(x,x,x);
end;

procedure glkQuad(Ax,Ay,Bx,By,Cx,Cy,Dx,Dy:single);
begin
  glvertex2f(Ax,Ay);
  glvertex2f(Bx,By);
  glvertex2f(Cx,Cy);
  glvertex2f(Dx,Dy);
end;

{Same as glkQuad, but requires on TopLeft and BottomRight coords}
procedure glkRect(Ax,Ay,Bx,By:single);
begin
  glvertex2f(Ax,Ay);
  glvertex2f(Bx,Ay);
  glvertex2f(Bx,By);
  glvertex2f(Ax,By);
end;

{Lines are drawn between pixels, thus when AA turned on they get blurred.
We can negate this by using 0.5 offset
Still it's unclear if that works on all GPUs the same..}
//After we apply this command we can draw lines over pixels
//when everythings done either shift back or PopMatrix
procedure glkMoveAALines(DoShift:boolean);
const Value=0.5;
begin
if DoShift then glTranslatef(Value,Value,0)
           else glTranslatef(-Value,-Value,0);
end;


procedure SetupVSync(aVSync:boolean);
begin
  if WGL_EXT_swap_control then
    wglSwapIntervalEXT(byte(aVSync));
end;


end.
