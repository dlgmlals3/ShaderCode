// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


float circle (vec2 st, float radius) {
    vec2 l = st - vec2(0.5);
    float s = 1. - step(sqrt(dot(l, l)), radius);
    return s;
}

vec2 move(in vec2 st) {
    st *= 2.;
    vec2 index = step(st, vec2(1.));
    float speed = 0.5;
    float time = u_time * speed;
    
    if (fract(time) > 0.5) {
        ///*
        if (index.x == 1.) {
            st.y += fract(time) * 2.;
        } 
        else {
            st.y -= fract(time) * 2.;
        }
        //*/
    }
    else {
        ///*
        if (index.y == 1.) {
            st.x += fract(time) * 2.;
        } 
        else  {
            st.x -= fract(time) * 2.;
        }
        //*/
    }
    return fract(st);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
	float radius = 0.3;
	
    st *= 7.;
    st = mod(st, 1.);
    
    st = move(st);
    
    
    
    vec3 color = vec3(circle(st, radius));
    gl_FragColor = vec4(color,1.0);
}