#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  vec4 texColor = texture2D(texture, vertTexCoord.st);
  if(texColor.a < 0.35){
    discard;
  }
  gl_FragColor = texColor * vertColor;
}
