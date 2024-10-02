// glsl-canvas
// 가우시안 가중치를 계산해서 가우시안 커널을 마음대로 변경하자
// https://velog.io/@zzaerynn_/CV-Gaussian-Filter

#extension GL_OES_standard_derivatives : enable

#ifdef GL_ES
precision mediump float;
#endif

#define pow2(x) (x * x)

uniform vec2 u_resolution;
uniform float u_time;

const float pi = atan(1.0) * 4.0;
const int samples = 10; // 가우시안 차수
const float sigma = float(samples) * 0.25;

uniform sampler2D u_texture; // ../Pictures/5.png

float gaussian(vec2 i) {
    return 1.0 / (2.0 * pi * pow2(sigma)) * exp(-((pow2(i.x) + pow2(i.y)) / (2.0 * pow2(sigma))));
}

vec3 blur(vec2 uv, vec2 scale) {
    vec3 col = vec3(0.0);
    float accum = 0.0;
    float weight;
    vec2 offset;
    
    for (int x = -samples / 2; x < samples / 2; ++x) {
        for (int y = -samples / 2; y < samples / 2; ++y) {
            offset = vec2(x, y);
            weight = gaussian(offset);
            col += texture2D(u_texture, uv + scale * offset).rgb * weight;
            accum += weight;
        }
    }
    
    return col / accum;
}

void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution;
	vec4 texture = texture2D(u_texture, uv);
    vec3 color = texture.rgb;
    vec2 imageResolution = vec2(438, 448);
    vec2 texelSize = 1. / imageResolution;

    color.rgb = blur(uv, texelSize);

    gl_FragColor = vec4(color, 1.0);
}
