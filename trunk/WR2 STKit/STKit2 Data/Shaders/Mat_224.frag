  uniform vec3 FogCol;
  varying vec3 kBlend;
  varying vec4 kColor;

  varying vec4 V;
  varying vec3 N;
  varying vec4 E;

  uniform sampler2D Tex1;
  uniform sampler2D Tex4;

  void main(void)
  {
    vec4 Lay1 = texture2D(Tex1, gl_TexCoord[1].xy);

    vec3 Ln = gl_LightSource[0].position.xyz; 		// Normalized in render code
    vec3 Nn = Lay1.rgb;
    vec3 In = normalize(V.xyz*E.w - E.xyz*V.w);		// View direction
    vec3 Hn = normalize(Ln -In);			// Half way between view & light

    vec3 R = reflect(In,Nn);
    vec3 Env = texture2D(Tex4, 0.5+0.5*R.xy).xyz*0.5;
    float ShadowCol = smoothstep (0.4375, 0.5625, kColor.a);
    float Spec = pow(max(0.,dot(normalize(N),Hn)),16.)*ShadowCol;

    Env = Env + Spec*pow(Lay1.a+0.125,16.);

    float fresnel = pow(1.+dot(In,Nn),5.);
    float c = smoothstep (0.4375, 0.5625, kBlend.b);

    gl_FragColor = vec4(Env*(ShadowCol+kColor.rgb),0.25+Lay1.a/2.0)*c;

    gl_FragColor = vec4(mix(gl_FragColor.rgb,FogCol,gl_TexCoord[2].z),gl_FragColor.a);
  }