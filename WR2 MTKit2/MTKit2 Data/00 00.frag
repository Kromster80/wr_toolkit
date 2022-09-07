//5*3+1+11 = 27
  uniform vec3 Mat_Ambi;		//Input parameters
  uniform vec3 Mat_Diff;
  uniform vec3 Mat_Spec1;
  uniform vec3 Mat_Spec2;
  uniform vec3 Mat_Refl;
  uniform float Mat_DirtAm;
  uniform float Mat_ReflFres;
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
    vec3 Hn = normalize(Ln - In);			// Half way between view & light

    //Basis components
    vec3  Env_Ambi  = vec3(0.25,0.3125,0.4375);
    float Env_Diff  = max(0.0,dot(Nn,Ln));
    float Env_Spec1 = pow(max(0.0,dot(Nn,Hn))+0.006,512.0)/16.0;
    float Env_Spec2 = pow(max(0.0,dot(Nn,Hn)),4.0); //Big specular
    float Env_Fres  = 1.0;

    // Calculate Fresnel value if material requires it
    if (Mat_ReflFres == 0.0) {
      Env_Fres = pow(1.0 + dot(In, Nn), 3.0) * 0.7 + 0.078125;
    }

      vec3 R = reflect(In, Nn);
      R.z += 1.0;
      R.xy = (R.xy / length(R) + 1.0) * 0.5;
      R.y = 1.0 - R.y;

    vec4 Mat_Tex   = texture2D(Tex1, gl_TexCoord[0].xy);
    vec3 Mat_Env   = texture2D(Tex2, R.xy).rgb;
    vec4 Mat_Dirt  = texture2D(Tex3, gl_TexCoord[0].xy);
    vec4 Mat_Scrat = texture2D(Tex4, gl_TexCoord[0].xy);

    if ( Mat_Scrat.a <= ( 1.0 - Mat_DirtAm ) ) { Mat_Dirt.a = 0.0; }

    vec3 Out_Spec1 = Mat_Spec1 * Env_Spec1;                    //Small Specular, not the most accurate, but ok
    vec3 Out_Spec2 = Mat_Spec2 * Env_Spec2 * 2.0;              //Big Specular
    vec3 Out_Refl  = Mat_Refl * Env_Fres;
	
// 	vec3 _Diff  = mix( Diff , _Tex.rgb , _Tex.a );
//	     _Diff  = mix( _Diff , _Dirt.rgb , _Dirt.a );
    
    vec3 Color = mix((Mat_Diff+Mat_Spec2) * Env_Ambi, Mat_Diff * 2.0, Env_Diff); //Apply diffuse solution
         Color = mix(Color, Mat_Tex.rgb * (mix(Env_Ambi / 2.0, vec3(1.0), Env_Diff)), Mat_Tex.a); //Apply diffuse texture
	 Color = mix( Color , Mat_Dirt.rgb , Mat_Dirt.a );		 //Apply Dirt texture

	Color += (Mat_Ambi*2.0 + Out_Spec1 + Out_Spec2 ) * ( 1.0 - Mat_Tex.a )* ( 1.0 - Mat_Dirt.a );

  Color = mix(Color, Mat_Env , Out_Refl * ( 1.0 - Mat_Tex.a )* ( 1.0 - Mat_Dirt.a ));

  gl_FragColor = vec4(Color, 1.0);
}