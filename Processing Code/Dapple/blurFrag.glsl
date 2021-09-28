// https://www.shadertoy.com/view/Xltfzj

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec2 resolution;
varying vec4 vertTexCoord;
varying vec4 vertColor;
uniform sampler2D texture;

  // GAUSSIAN BLUR SETTINGS {{{
uniform float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
uniform float Quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
uniform float Size = 4.0; // BLUR SIZE (Radius)
  // GAUSSIAN BLUR SETTINGS }}}

float Pi = 6.28318530718; // Pi*2


void main() {  
  vec2 uv = vertTexCoord.st;

  vec2 Radius = Size/resolution.xy;

  // Normalized pixel coordinates (from 0 to 1)
  // Pixel colour
  vec4 Color = texture(texture, uv);

  // Blur calculations
  for ( float d=0.0; d<Pi; d+=Pi/Directions)
  {
    for (float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
    {
      Color += texture(texture, uv+vec2(cos(d), sin(d))*Radius*i);
    }
  }

  // Output to screen
  Color /= Quality * Directions - 15.0;

  gl_FragColor = Color;
}
