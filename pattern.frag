// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.141592

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float circle(in vec2 _st, in float _radius) 
{
	vec2 l = _st - vec2(0.5); // move to zero origin
    
    return 1. - smoothstep(_radius - (_radius * 0.1),
                           _radius + (_radius * 0.1),
	           				dot(l, l) * 3.);
}

float circle2(in vec2 st, in vec2 center, in float radius)  {
    vec2 l = st - center;
    float f = sqrt(dot(l, l));
    float a = 1. - step(radius, f);    
    //float f = distance(st, center);
    //float a = 1. - smoothstep(radius-0.01, radius+0.01, f);
    return a;
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;    
    
    //st *= 3.;
    //st = fract(st);
    //st = mod(st, 1.);
    float c = circle(st, 0.3);
    //float c = circle2(st, vec2(0.5), 0.3);
    vec3 color = vec3(c, 0., 0.);
    gl_FragColor = vec4(color,1.0);
}