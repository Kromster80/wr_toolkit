//5*3+1+11 = 27
  uniform vec3 Ambi;		//Input parameters
  uniform vec3 Diff;
  uniform vec3 Spec1;
  uniform vec3 Spec2;
  uniform vec3 Refl;
  uniform float DirtAm;
  uniform float ReflFres;
  uniform sampler2D Tex1;
  uniform sampler2D Tex2;
  uniform sampler2D Tex3;
  uniform sampler2D Tex4;
  varying vec4 V;
  varying vec3 N;
  varying vec4 E;


  void main(void)
  {
    vec3 Ln = normalize(gl_LightSource[0].position.xyz);// Light
    vec3 Nn = normalize(N);	        		// Normal
    vec3 In = normalize(V.xyz*E.w - E.xyz*V.w);		// View direction
    vec3 Hn = normalize(Ln -In);			// Half way between view & light

    //Basis components
    vec3  Ambient   = vec3(0.25,0.3125,0.4375);
    float Diffuse   = max(0.0,dot(Nn,Ln));
    float Specular1 = pow(max(0.0,dot(Nn,Hn))+0.006,512.0)/16.0;
    float Specular2 = pow(max(0.0,dot(Nn,Hn)),4.0); //Big specular
    float Fresnel   = 1.0;
      
    if ( ReflFres == 0.0 )
    {     Fresnel   = pow(1.0+dot(In,Nn),3.0)*0.7+0.078125;    }
    
      vec3 R = reflect(In,Nn);
      R.z += 1.0;
      R.xy = ( R.xy/length(R) + 1.0 ) * 0.5;
      R.y = 1.0 - R.y;
      

    vec3 _Diff  = Diff*2.0;
    vec3 _Spec1 = Spec1 * Specular1;                    //Small Specular, not the most accurate, but ok
    vec3 _Spec2 = Spec2 * Specular2 * 2.0;              //Big Specular
    vec3 _Refl  = Refl*Fresnel;
    vec4 _Tex   = texture2D(Tex1, gl_TexCoord[0].xy);
    vec3 _Env   = texture2D(Tex2, R.xy).rgb;
    vec4 _Dirt  = texture2D(Tex3, gl_TexCoord[0].xy);
    vec4 _Scrat = texture2D(Tex4, gl_TexCoord[0].xy);
    
    vec3 Color = mix(Diff*Ambient,_Diff,Diffuse);
	    Color += Ambi*2.0;
        Color += _Spec1;
        Color += _Spec2;
        Color  = mix(Color,_Env,_Refl);
        Color  = mix(Color,_Tex.rgb,_Tex.a);
        
	if ( _Scrat.a > ( 1.0 - DirtAm ) ) 
	{
        Color  = mix( Color , _Dirt.rgb , _Dirt.a );
	}

    gl_FragColor = vec4(Color, _Tex.a);

  }