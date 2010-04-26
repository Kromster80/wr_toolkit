# version 110

  uniform vec4 FogPos;
  varying vec4 V;
  varying vec3 Vact;
  varying vec3 N;
  varying vec4 E;
  varying vec4 kColor;

  void main(void)
  {
    Vact = gl_Vertex.xyz;
    V = gl_ModelViewMatrix*gl_Vertex;			
    N = gl_NormalMatrix*gl_Normal;			//Gets normalized per-pixel in FS
    E = gl_ProjectionMatrixInverse*vec4(0,0,-1,1);
    kColor = gl_Color;
    float FogRange = 0.0;

    if(FogPos.w > 0.0)    {
			FogRange = clamp( distance(FogPos.xz,Vact.xz) / FogPos.w,0.0,1.0);
			FogRange = FogRange*FogRange;
			}

    gl_TexCoord[0] = vec4(gl_MultiTexCoord0.x,gl_MultiTexCoord0.y,FogRange,0);

    gl_Position = ftransform();				//transform vertex
  }