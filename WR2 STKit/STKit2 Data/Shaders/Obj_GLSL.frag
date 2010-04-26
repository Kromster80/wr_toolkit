  varying vec4 kColor;

  varying vec3 N;

  uniform sampler2D Tex1;

  void main(void)
  {
     vec4 Tex  = texture2D(Tex1, gl_TexCoord[1].xy);

     vec3 Nn = normalize(N);	        		// Normal
     vec3 Ln = normalize(gl_LightSource[0].position.xyz);

     float Diff = max(0.,dot(Nn,Ln))*1.8;

     gl_FragColor = vec4( Tex.rgb*Diff, Tex.a);
  }