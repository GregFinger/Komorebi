// https://www.shadertoy.com/view/ltScRG

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
uniform sampler2D texture;
uniform vec2 resolution;
varying vec4 vertTexCoord;

const int samples = 10;
const int LOD = 1;         // gaussian done on MIPmap at scale LOD
const int sLOD = 2; // tile size = 2^LOD
const float sigma = float(samples) * .25;

float gaussian(vec2 i) {
    return exp( -.5* dot(i/=sigma,i) ) / ( 6.28 * sigma*sigma );
}

vec4 blur(sampler2D sp, vec2 U, vec2 scale) {
    vec4 outp = vec4(0);  
    const int s = samples/sLOD;
    
    for ( int i = 0; i < s*s; i++ ) {
        float t = mod(float(i),float(s));
        vec2 d = vec2(t, i/s)*float(sLOD) - float(samples)/2.;
        float g = gaussian(d);
        vec2 uv = vertTexCoord.xy;
        uv += (scale * d);
        float p = float(LOD);
        vec4 tex = texture2D( texture, uv, p);
        outp += g * tex;
    }
    
    return outp / outp.a;
}

void main()
{
  gl_FragColor = blur( texture, vertTexCoord.xy, 1./resolution.xy );
}
