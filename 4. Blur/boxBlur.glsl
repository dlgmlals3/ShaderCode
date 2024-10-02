// glsl-canvas
// 싱글 패스박스 블러
// 내 픽셀 주위로 정사각형태의 픽셀을 얼마나 반영할 것인가 ?
// 3 x 3 커널 : 한변의 길이 7 (-3 ~ 3), 1픽셀 계산할때 총 49번의 연산
// 전부 더해주고 마지막에 더한 픽셀의 개수 만큼 boxBlurDivisor로 나누어 줌.
// float boxBlurDivisor = pow(2.0 * kernelSize + 1.0 , 2.0);

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

    const float kernelSize = 5.0;
    vec3 boxBlurColor = vec3(0.0);

    float boxBlurDivisor = pow(2.0 * kernelSize + 1.0 , 2.0);
    // kernelSize = 1.0, then boxBlurDivisor = 9.0 // 3 by 3
    // kernelSize = 2.0, then boxBlurDivisor = 25.0 // 4 by 4  
    // kernelSize = 3.0, then boxBlurDivisor = 49.0 // 6 by 6
    
    for (float i = -kernelSize; i <= kernelSize; i++) {
        for (float j = -kernelSize; j <= kernelSize; j++) {
            vec4 texture = texture2D(u_texture, uv + vec2(i, j) * texelSize);
            boxBlurColor = boxBlurColor + texture.rgb;
        }
    }
    boxBlurColor /= boxBlurDivisor;
    color = boxBlurColor;
    gl_FragColor = vec4(color, 1.0);
}
