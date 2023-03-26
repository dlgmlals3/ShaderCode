// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float box(vec2 origin, vec2 size, vec2 st) {
	vec2 sw = origin - (size / 2.);
    vec2 ne = origin + (size / 2.);
    vec2 area = step(sw, st) * (1. - step(ne, st));
    return area.x * area.y;
}

float cross(vec2 origin, vec2 st) {
    float a = box(vec2(0.), vec2(0.3, 0.1), st);
    float b = box(vec2(0.), vec2(0.1, 0.3), st);
    return a+b;
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    st = st * 2. - 1.;
    vec2 translate = vec2(sin(u_time), cos(u_time));
    st += translate * 0.5;
    vec3 color = vec3(cross(vec2(0.0), st));
    gl_FragColor = vec4(color, 1);
}











