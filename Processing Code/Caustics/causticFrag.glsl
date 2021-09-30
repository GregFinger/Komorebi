// based on:
// https://www.shadertoy.com/view/XtKfRG
// alternatives:
// https://www.shadertoy.com/view/3d3yRj
// https://www.shadertoy.com/view/3sscRs
// https://www.shadertoy.com/view/MdKXDm

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform int time;

void main() {
  float timer = float(time) * 0.001;
  vec2 p = gl_FragCoord.st;
  mat3 m = mat3(-2, -1, 2, 3, -2, 1, 1, 2, 2);
  vec3 a = vec3( p / 4e2, timer / 4. ) * m, 
    b = a * m * .4, 
    c = b * m * .3;
  vec4 k = vec4(pow(
    min(min(   length(.5 - fract(a)), 
    length(.5 - fract(b))
    ), length(.5 - fract(c)
    )), 7.) * 25.);
  gl_FragColor = k;
}
