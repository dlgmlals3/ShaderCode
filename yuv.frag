// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.141592

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

mat3 yuv2rgb = mat3(1.0, 0.0, 1.13983,
                  1.0, -0.39465, -0.58060,
                  1.0, 2.03211, 0.0);

mat3 rgb2yuv = mat3(0.2126, 0.7152, 0.0722,
                   -0.9991, -0.33609, 0.43600,
                   0.615, -0.5586, -0.05639);

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
	
    vec3 color = vec3(0.0);    
    st -= 0.5;
    st *= 2.0;
    color = yuv2rgb * vec3(0.5, st.x, st.y);
    gl_FragColor = vec4(color,1.0);
}