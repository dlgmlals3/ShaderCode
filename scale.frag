// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.141592

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

mat2 rotate(float _angle) {
    return mat2(cos(_angle), -sin(_angle), sin(_angle), cos(_angle));
}

mat2 scale(vec2 _scale) {
    return mat2(_scale.x, 0.0, 0.0, _scale.y);
}

float box(vec2 st, vec2 origin, vec2 size) {
    vec2 leftbottom = origin - (size / 2.);
    vec2 righttop = origin + (size / 2.);
    
    float boundary = 0.01;
    vec2 result = smoothstep(leftbottom - boundary, leftbottom, st) * (1. - smoothstep(righttop, righttop + boundary, st));
    return result.x * result.y;
}

float cross(vec2 st) {    
    return box(st, vec2(0.0), vec2(0.5, 0.1)) + box(st, vec2(0.0), vec2(0.1, 0.5)) ;
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    st = st * 2. - 1.;
    
    st -= vec2(0.1);
    //st *= rotate(u_time * PI);
    st += vec2(0.1);
    
    st *= scale(vec2(sin(u_time * 4.) + 2.));
    
    vec3 color = vec3(cross(st));    
    gl_FragColor = vec4(color,1.0);
}