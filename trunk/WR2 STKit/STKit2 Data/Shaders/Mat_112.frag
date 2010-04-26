  uniform vec3 FogCol;
  uniform vec3 SunCol;
  varying vec4 kColor;

  varying vec4 V;
  varying vec3 N;
  varying vec4 E;

  uniform sampler2D Tex1;
  uniform sampler2D Tex4;

  void main(void)
  {
    vec3 Ln = gl_LightSource[0].position.xyz; 		// Normalized in render code
    vec3 Nn = normalize(N);	        		// Normal
    vec3 In = normalize(V.xyz*E.w - E.xyz*V.w);		// View direction
    vec3 Hn = normalize(Ln -In);			// Half way between view & light
    vec3 R = reflect(In,Nn);                            //Env map

    vec4 Lay0  = texture2D(Tex1, gl_TexCoord[0].xy);
    vec3 Env = texture2D(Tex4, .5+.5*R.xy).xyz*.5;

    float Diff = max(0.,dot(Nn,Ln))*1.8;
    float ShadowCol = smoothstep (0.4375, 0.5625, kColor.a);
    float Spec = pow(max(0.,dot(Nn,Hn)),16.)*ShadowCol*0.25;
    float Spec2= pow(max(0.,dot(Nn,Hn)),128.)*ShadowCol;

    vec3 TexColor = Lay0.rgb*(1.-Lay0.a*0.5+Spec)+(Env+Spec2)*Lay0.a/2.*ShadowCol;

     gl_FragColor = vec4(TexColor*(SunCol*Diff*ShadowCol+kColor.rgb),1);

     gl_FragColor = vec4(mix(gl_FragColor.rgb,FogCol,gl_TexCoord[2].z),gl_FragColor.a);

  }