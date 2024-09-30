
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
    gl_FragColor = vec4(color, 1.0);
}
