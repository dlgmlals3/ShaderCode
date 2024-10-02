// glsl-canvas
// 3 x 3 가우시안 커널 싱글 패스 가우시안 블러
// https://www.sciencedirect.com/topics/engineering/gaussian-blur
// 차수가 높을수록 흐려진다.
// 
// 만일 가우시안 차수를 고정시킨다면 궂이 가우시안 가중치를 계산할 필요가 없다.
// 가우시안 함수의 값을 사용하여 생성한 카우시안 커널을 생성한다.
// 3 x 3 가우시안 커널은 다음과 같이 나타낸다.
/*
1/16 [ 1, 2, 1]
     [ 2, 4, 2]
     [ 1, 2, 1]
*/

#extension GL_OES_standard_derivatives : enable

#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_position;
varying vec4 v_normal;
varying vec2 v_texcoord;
varying vec4 v_color;
uniform mat4 u_projectionMatrix;
uniform mat4 u_modelViewMatrix;
uniform mat4 u_normalMatrix;
uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_pos;

uniform sampler2D u_texture; // ../Pictures/5.png
// uniform vec2 u_textureResolution;

void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution;
	vec4 texture = texture2D(u_texture, uv);
    vec3 color = texture.rgb;

    vec2 imageResolution = vec2(438, 448);
    vec2 texelSize = 1. / imageResolution;

    vec3 boxBlurColor = vec3(0.0);

    float gaussianDivisor = 16.0;
    vec3 gaussianBlurColor = vec3(0.0);
    gaussianBlurColor += texture2D(u_texture, uv + vec2(-1, 1) * texelSize).rgb * 1.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(0, 1) * texelSize).rgb * 2.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(1, 1) * texelSize).rgb * 1.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(-1, 0) * texelSize).rgb * 2.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(0, 0) * texelSize).rgb * 4.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(1, 0) * texelSize).rgb * 2.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(-1, -1) * texelSize).rgb * 1.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(0, -1) * texelSize).rgb * 2.0;
    gaussianBlurColor += texture2D(u_texture, uv + vec2(1, -1) * texelSize).rgb * 1.0;
    gaussianBlurColor /= gaussianDivisor;
    color = gaussianBlurColor;
    gl_FragColor = vec4(color, 1.0);
}
