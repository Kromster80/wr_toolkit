  uniform vec3 FogCol;
  uniform vec3 SunCol;
  varying vec4 kColor;
  varying vec3 kBlend;

  varying vec3 N;

  uniform sampler2D Tex1;
  uniform sampler2D Tex2;
  uniform sampler2D Tex3;

  void main(void)
  {
    vec4 Lay1  = texture2D(Tex1, gl_TexCoord[1].xy);
    vec4 Lay2  = texture2D(Tex2, gl_TexCoord[1].zw);
    vec4 Lay3  = texture2D(Tex3, gl_TexCoord[2].xy);

    vec3 Nn = normalize(N);	        		// Normal
    vec3 Ln = gl_LightSource[0].position.xyz; 		// Normalized in render code

    float a = smoothstep (0.4375, 0.5625, kBlend.r)*Lay3.a;
    float c = smoothstep (0.4375, 0.5625, kBlend.b)*Lay1.a*Lay2.a;
    float ShadowCol = smoothstep (0.4375, 0.5625, kColor.a);
    float Diff = max(0.,dot(Nn,Ln))*1.8;

    vec3 TexColor =(Lay1.rgb*(1.-c)+Lay2.rgb*c)*(1.-a)+Lay3.rgb*a;

    gl_FragColor = vec4(TexColor*(SunCol*Diff*ShadowCol+kColor.rgb),1);

    gl_FragColor = vec4(mix(gl_FragColor.rgb,FogCol,gl_TexCoord[2].z),gl_FragColor.a);
  }
