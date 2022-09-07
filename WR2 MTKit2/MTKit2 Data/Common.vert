#version 110
  varying vec4 V;
  varying vec3 N;
  varying vec4 E;

  void main(void)
  {
    V = gl_ModelViewMatrix*gl_Vertex;			
    N = gl_NormalMatrix*gl_Normal;			//Gets normalized per-pixel in FS
    E = gl_ProjectionMatrixInverse*vec4(0,0,-1,1);

    gl_TexCoord[0] = gl_MultiTexCoord0;			//UVmap #1

    gl_Position = ftransform();				//transform vertex
  }