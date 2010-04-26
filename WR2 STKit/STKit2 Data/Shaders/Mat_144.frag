  uniform vec3 FogCol;
  uniform vec3 SunCol;
  varying vec4 kColor;
  varying vec3 kBlend;

  varying vec4 V;
  varying vec3 N;
  varying vec4 E;

  uniform sampler2D Tex1;
  uniform sampler2D Tex2;

  void main(void)
  {
    vec3 Ln = gl_LightSource[0].position.xyz; 		// Normalized in render code
    vec3 Nn = normalize(N);	        		// Normal
    vec3 In = normalize(V.xyz*E.w - E.xyz*V.w);		// View direction
    vec3 Hn = normalize(Ln -In);			// Half way between view & light

    vec4 Lay1  = texture2D(Tex1, gl_TexCoord[0].xy);
    vec4 Lay2  = texture2D(Tex2, gl_TexCoord[0].zw);

    float c = smoothstep (0.4375, 0.5625, kBlend.b);

    float ShadowCol = smoothstep (0.4375, 0.5625, kColor.a);
    float Spec = pow(max(0.,dot(Nn,Hn)),32.)*ShadowCol;
    float Diff = max(0.,dot(Nn,Ln))*1.8;

    vec3 TexColor = (Lay1.rgb+Spec*Lay1.a)*(1.-c)+(Lay2.rgb+Spec*Lay2.a/2.)*c;

    gl_FragColor = vec4(TexColor*(SunCol*Diff*ShadowCol+kColor.rgb),1);

     gl_FragColor = vec4(mix(gl_FragColor.rgb,FogCol,gl_TexCoord[2].z),gl_FragColor.a);

  }