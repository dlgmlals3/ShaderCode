// glsl-canvas
// Fast gawsian 어디가더 빨라졌는지 확인
// 16x acceleration of https://www.shadertoy.com/view/4tSyzy
// by applying gaussian at intermediate MIPmap level.
// 2 패스 3 패스 가우시안 블러만들어보자.
#extension GL_OES_standard_derivatives : enable

#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_texture; // ../Pictures/5.png
uniform vec2 u_resolution;
uniform float u_time;

const int samples = 35;
const int LOD = 2;         // gaussian done on MIPmap at scale LOD
float sLOD = pow(2., float(LOD));

// 1 << LOD; // tile size = 2^LOD
const float sigma = float(samples) * .25;

float gaussian(vec2 i) {
    return exp( -.5* dot(i/=sigma,i) ) / ( 6.28 * sigma*sigma );
}

float modular(float a, float b) {
    return a - (b * floor(a/b));
}

vec4 blur(vec2 U, vec2 scale) {
    vec4 O = vec4(0);  
    int s = int(float(samples)/sLOD);
    
    for (int i = 0; i < s*s; i++) {
        float m = modular(float(i), float(s));
        vec2 d = vec2(m, i/s)*float(sLOD) - float(samples)/2.;
        O += gaussian(d) * texture2D( u_texture, U + scale * d);
    }
    
    return O / O.a;
}


void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution;
	vec4 texture = texture2D(u_texture, uv);
    vec3 color = texture.rgb;
    
    vec2 imageResolution = vec2(438, 448);
    vec2 texelSize = 1. / imageResolution;

    //vec3 t = blur(uv, texelSize).rgb;

    gl_FragColor = vec4(color, 1.0);
}