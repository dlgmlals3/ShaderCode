// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {
	vec2 st = gl_FragCoord.xy / u_resolution.xy;           	
	st.x *= u_resolution.x / u_resolution.y;
    
    st = st * 2. - 1.;
    float d = length(abs(st)- vec2(0.5));
    
    vec3 color = vec3(fract(d * 9.));
    //vec3 color = vec3(d);
	gl_FragColor = vec4(color, 1.0);
}