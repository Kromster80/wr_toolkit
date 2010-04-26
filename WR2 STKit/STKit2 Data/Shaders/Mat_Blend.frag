  varying vec3 kBlend;

  void main(void)
  {
     gl_FragColor = vec4(smoothstep (0.4375, 0.5625, kBlend),1);
  }