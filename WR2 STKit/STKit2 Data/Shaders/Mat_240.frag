  uniform vec3 FogCol;
  uniform vec3 SunCol;
  varying vec4 kColor;

  varying vec4 V;
  varying vec3 N;
  varying vec4 E;

  uniform sampler2D Tex1;

  void main(void)
  {
    vec3 Ln = gl_LightSource[0].position.xyz; 		// Normalized in render code
    vec3 Nn = normalize(N);	        		// Normal
    vec3 In = normalize(V.xyz*E.w - E.xyz*V.w);		// View direction
    vec3 Hn = normalize(Ln -In);			// Half way between view & light

     vec4   Lay1 = texture2D(Tex1, gl_TexCoord[0].xy);

if ( Lay1.a < 0.05) discard;

     float ShadowCol = smoothstep (0.4375, 0.5625, kColor.a);
     float Diff = max(0.,dot(Nn,Ln));
     float Spec = pow(max(0.,dot(Nn,Hn)),16.)*ShadowCol*0.5;

     vec3 TexColor = Lay1.rgb*(1.+Spec);

     gl_FragColor = vec4(TexColor*(SunCol*Diff*ShadowCol+kColor.rgb),Lay1.a);

     gl_FragColor = vec4(mix(gl_FragColor.rgb,FogCol,gl_TexCoord[2].z),gl_FragColor.a);

  }