  uniform vec3 SunCol;
  varying vec4 kColor;

  varying vec3 N;

  void main(void)
  {
    vec3 Nn = normalize(N);	        		// Normal
    vec3 Ln = gl_LightSource[0].position.xyz; 		// Normalized in render code

    float Diff = max(0.,dot(Nn,Ln))*1.8;
    float ShadowCol = smoothstep (0.4375, 0.5625, kColor.a);

    gl_FragColor = vec4(kColor.rgb*(SunCol*Diff*ShadowCol+kColor.rgb),1);
  }