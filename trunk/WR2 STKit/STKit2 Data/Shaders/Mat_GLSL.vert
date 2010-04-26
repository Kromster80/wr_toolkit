# version 110

  uniform vec4 TA1;
  uniform vec4 TA2;
  uniform vec4 TB1;
  uniform vec4 TB2;
  uniform vec4 TC1;
  uniform vec4 TC2;
  uniform vec4 FogPos;
  varying vec4 V;
  varying vec3 N;
  varying vec4 E;
  varying vec3 kBlend;
  varying vec4 kColor; //18(20) varying + 12 texcoords + 4 lightpos = 36

  void main(void)
  {
    V = gl_ModelViewMatrix*gl_Vertex;			
    N = gl_NormalMatrix*gl_Normal;			//Gets normalized per-pixel in FS
    E = gl_ProjectionMatrixInverse*vec4(0,0,-1,1);

    //smoothstep 0.4375><0.5625 should be done in PS otherwise it gets clamped(?) unnice
    kBlend = gl_SecondaryColor.rgb;//blend1,blend2,blend3
    kColor = vec4 (gl_Color.rgb * 2.0, gl_Color.a ); //shadow 

    float FogRange = 0.0;
    if(FogPos.w > 0.0)  {
			FogRange = clamp( distance(FogPos.xz,gl_Vertex.xz) / FogPos.w,0.0,1.0);
			FogRange = FogRange * FogRange;
			}
    gl_TexCoord[0] = vec4(gl_MultiTexCoord0.x,gl_MultiTexCoord0.y, 			//UV
                          gl_MultiTexCoord0.x*TB1.x+gl_MultiTexCoord0.y*TB1.y+TB1.w,	//UV*Matrix2
                          gl_MultiTexCoord0.x*TB2.x+gl_MultiTexCoord0.y*TB2.y+TB2.w);	
    gl_TexCoord[1] = vec4(gl_Vertex.x*TA1.x+gl_Vertex.y*TA1.y+gl_Vertex.z*TA1.z+TA1.w,	//Mat1
                          gl_Vertex.x*TA2.x+gl_Vertex.y*TA2.y+gl_Vertex.z*TA2.z+TA2.w,
    			  gl_Vertex.x*TB1.x+gl_Vertex.y*TB1.y+gl_Vertex.z*TB1.z+TB1.w,	//Mat2
                          gl_Vertex.x*TB2.x+gl_Vertex.y*TB2.y+gl_Vertex.z*TB2.z+TB2.w);
    gl_TexCoord[2] = vec4(gl_Vertex.x*TC1.x+gl_Vertex.y*TC1.y+gl_Vertex.z*TC1.z+TC1.w,	//Mat3
                          gl_Vertex.x*TC2.x+gl_Vertex.y*TC2.y+gl_Vertex.z*TC2.z+TC2.w,FogRange,0);
    gl_Position = ftransform();				//transform vertex
  }