// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rect(vec2 coord, vec2 origin, vec2 size) {
    float xMargin = (1. - size.x) / 2.0;
    float yMargin = (1. - size.y) / 2.0;
    vec2 bl = step(vec2(xMargin, yMargin), coord);    
   	vec2 ur = step(vec2(xMargin, yMargin), 1.0 - coord);
    return bl.x * bl.y * ur.x * ur.y;
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution.xy;           
    float pct = rect(st, vec2(0.0), vec2(0.5, 0.1));
    vec3 color = vec3(pct);
	gl_FragColor = vec4(color, 1.0);
}