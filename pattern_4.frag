// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.141592

vec2 rotate(vec2 st, float angle) {
    float radian = PI / 180.0 * angle;
    st -= 0.5;
    st =  mat2(cos(radian),-sin(radian),
            sin(radian),cos(radian)) * st;
    st += 0.5;
    return st;
}

float semo(vec2 st) {
    vec2 s = step(st, vec2(st.x, st.x));
    return 1.0 - s.x * s.y;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st *= 3.;
    st = mod(st, 1.);
    
    st *= 2.;        
    float x = step(1., st.x);
    float y = step(1., st.y);
    if (x == 1.){
    	st = rotate(st, 90.);    
    } 
    if (x == 1. && y == 1.) {
        st = rotate(st, 90.);     
    }
    if (x == 0. && y == 1.) {
       st = rotate(st, -90.);     
    }
  
    st = mod(st, 1.);        
    float s = semo(st);
    vec3 color = vec3(s);
    
    gl_FragColor = vec4(color,1.0);
}