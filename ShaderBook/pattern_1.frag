// Author: heemin.lee
// Title: pattern 1

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.14159265358979323846

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);    
}

float box(vec2 _st, vec2 _size, float _smoothEdges){
    _size = vec2(0.5)-_size*0.5;
    vec2 aa = vec2(_smoothEdges*0.5);
    vec2 uv = smoothstep(_size,_size+aa,_st);
    uv *= smoothstep(_size,_size+aa,vec2(1.0)-_st);
    return uv.x*uv.y;
}

void main(void){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
	float zoom = 5.;
    
    
    if (st.y > 1. / zoom * 1. && st.y < 1. / zoom * 2.) 
    {
    	st.x += 0.5;    
    }
    else if (st.y > 1. / zoom * 3. && st.y < 1. / zoom * 4.) 
    {
    	st.x += 0.5;    
    }    
    st = tile(st, zoom);
    
    vec2 size = vec2(0.95);
	color = vec3(box(st, size, 0.001));
    gl_FragColor = vec4(color,1.0);
}
