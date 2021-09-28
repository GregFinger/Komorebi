#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 resolution;

uniform vec2 size; // The pixel space scale of the rectangle.
uniform float radius; // The radius of the corners (in pixels).
uniform float edgeSoftness; // How soft the edges should be (in pixels). Higher values could be used to simulate a drop shadow.

float roundedBoxSDF(vec2 CenterPosition, vec2 Size, float Radius) {
    return length(max(abs(CenterPosition)-Size+Radius,0.0))-Radius;
}

void main() {

  vec4 col = texture2D(texture, vertTexCoord.st);
  vec2 pixSize = size * resolution;
  // Calculate distance to edge.   
  float distance = roundedBoxSDF(gl_FragCoord.xy - vec2(resolution)/2.0, pixSize / 2.0f, radius);

  // Smooth the result (free antialiasing).
  float smoothedAlpha = 1.0f-smoothstep(0.0f, edgeSoftness * 2.0f, distance);

  // Return the resultant shape.
  vec4 quadColor = vec4(col.rgb * smoothedAlpha, col.a);

  gl_FragColor = quadColor;
}
