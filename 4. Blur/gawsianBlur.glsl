
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

    const float kernelSize = 3.0;
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
