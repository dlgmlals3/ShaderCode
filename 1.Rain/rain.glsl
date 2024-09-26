struct ray 
{
  vec3 o;
  vec3 d;
};

vec3 clossestPoint(ray r, vec3 p) {
  return r.o + max(0., dot(p - r.o, r.d)) * r.d;
}

float DistRay(ray r, vec3 p) {
  return length(p - clossestPoint(r, p));
}

ray GetRay(vec2 uv, vec3 camPos, vec3 lookat, float zoom) {
  ray a;
  a.o = camPos;
  vec3 f = normalize(lookat - camPos);
  vec3 r = cross(vec3(0,1,0), f);
  vec3 u = cross(f, r);
  
  vec3 c = a.o + f * zoom;
  vec3 i = c + r * uv.x + u * uv.y;
  a.d = normalize(i - a.o);
  return a;
}

float Bokeh(ray r, vec3 p, float size, float blur) {
  float d = DistRay(r, p);
  size *= length(p);
  float c = smoothstep(size, size * (1. - blur), d);
  c *= mix(.6, 1., smoothstep(size * .8, size, d));
  return c;
}

vec3 streetLight(ray r, float t) {
  float side = step(r.d.x, 0.);
  r.d.x = abs(r.d.x);

  float s = 1. / 10.;
  float m = 0.;

  for (float i=0.; i<1.; i+=s) {
    float ti = fract(t + i + side * s * .5);
    vec3 p = vec3(2., 2., 100.-ti*100.);
    m += Bokeh(r, p, 0.03, .1) * ti * ti;
  }
  return vec3(1., .7, .3) * m;
}

float random(float t) {
  return fract(sin(t * 4342.) * 3425.);
}



vec3 headLight(ray r, float t) {
  float side = step(r.d.x, 0.);
  float s = 1. / 30.;
  float m = 0.;

  float w1 = 0.25;
  float w2 = w1 * 1.25;
   
  for (float i=0.; i<1.; i+=s) {
    if (random(i) > .3) continue;
   
    float ti = fract(t + i);
    
    float z = 100.-ti*100.;
    float fade = ti * ti * ti * ti * ti * ti;
    float focus = smoothstep(0.7 , 1., ti);
    float size = mix(.03, .015, focus);
    
    m += Bokeh(r, vec3(-1.+w1, 0.15, z), size, .1) * fade;
    m += Bokeh(r, vec3(-1.-w1, 0.15, z), size, .1) * fade;
    m += Bokeh(r, vec3(-1.+w2, 0.15, z), size, .1) * fade;
    m += Bokeh(r, vec3(-1.-w2, 0.15, z), size, .1) * fade;
    
    float ref = 0.;
    ref += Bokeh(r, vec3(-1.+w1, -0.15, z), size*3., 1.) * fade;
    ref += Bokeh(r, vec3(-1.-w1, -0.15, z), size*3., 1.) * fade;
    m += ref * focus;
  

  }
  return vec3(.9, .9, 1.) * m;
}

vec3 tailLight(ray r, float t) {
  float side = step(r.d.x, 0.);
  float s = 1. / 5.;
  float m = 0.;

  float w1 = 0.25;
  float w2 = w1 * 1.25;
   
  for (float i=0.; i<1.; i+=s) {
    float n = random(i);
    if (n > .5) continue;
   
    float lane = step(.25, n); // 0 ~ 1
    float ti = fract(t + i);
    float blink = step(sin(200. * ti), 0.)* 5. * lane * step(0.9, ti);
    
    float z = 100.-ti*100.;
    float fade = ti * ti * ti * ti * ti;
    float focus = smoothstep(0.8 , 1., ti);
    
    float size = mix(.03, .015, focus);
    
    float laneshift = smoothstep(1., .96, ti);
    float x = 1.5 - lane * laneshift;
    
    m += Bokeh(r, vec3(x+w1, 0.15, z), size, .1) * fade;
    m += Bokeh(r, vec3(x-w1, 0.15, z), size, .1) * fade;    
    m += Bokeh(r, vec3(x+w2, 0.15, z), size, .1) * fade * (1. + blink);
    m += Bokeh(r, vec3(x-w2, 0.15, z), size, .1) * fade;
    
    float ref = 0.;
    ref += Bokeh(r, vec3(x+w1, -0.15, z), size*3., 1.) * fade *(1. + blink * .1);
    ref += Bokeh(r, vec3(x-w1, -0.15, z), size*3., 1.) * fade;
    m += ref * focus;
  
  }
  return vec3(1.,.1,.03) * m;
}

vec4 random2(float t) {
  return fract(sin(
   t * vec4(4342., 1014., 3456., 9564.)) * vec4(3425., 3245., 5324., 2123.));
}
vec4 N14(float t) {
  return fract(sin(
    t * vec4(123., 1024.,3435, 9564.)) * vec4(6547., 345., 8799., 1441.));
}


// 1. x, y 변경
vec3 environtLight(ray r, float t) {
  float side = step(r.d.x, 0.);
  r.d.x = abs(r.d.x);
  float s = 1. / 10.;
  
  vec3 m = vec3(0.);
  
  for (float i=0.; i<1.; i+=s) {
    float ti = fract(t + i + side * s * .5);   
    vec4 ran = N14(i + side * 100.);  
    float fade = .8;
    
    float occlusion = sin(ti * 6.28 * 5.) * .5 + .5;
    fade *= occlusion;
    float x = mix(2.5, 10., ran.x);
    float y = mix(.1, 1.5, ran.y);
  
    vec3 p = vec3(x, y, 50.-ti*50.);
    m += Bokeh(r, p, 0.03, .1) * ran.xzy * fade;
  }
  
  return m;
}

vec2 Rain(vec2 uv) {
    vec2 a = vec2(23, 5);
    vec2 b = vec2(23, 25);
    float t = iTime;

    vec2 st = uv * a;
    vec2 id = floor(st);
    
    // random
    st.y += t;
    float n = fract(sin(id.x * 3242.) * 3524.);
    st.y += n;
    uv.y += n;
    id = floor(st);
    t += fract(sin(id.x * 21. + id.y * 324.) * 42.) * 6.28; // random
    
    // rain 
    st = fract(st) - .5;
    float y = -sin(t + sin(t + sin(t) * .5)) * .4;
    vec2 p1 = vec2(0, y);
    vec2 o1 = (st - p1) / a;
    float d = length(o1);
    float m1 = smoothstep(0.015, 0.01, d);    
    
    // rain2 
    vec2 st2 = uv * b;
    st2 = fract(st2) - .5;
    vec2 o2 = st2 / b;
    float d1 = length(o2);
    float exist = smoothstep(-.1, .1, st.y - p1.y);
    float size = 0.02 * (0.5 - st.y);
    float m2 = smoothstep(size, 0., d1) * exist;
        
    vec2 c1 = vec2(m1 * o1 * 50.);
    vec2 c2 = vec2(m2 * o2 * 50.);
    //if (st.x > 0.44 || st.y > 0.48) m1 = 1.;
    //return vec2(m1 + m2);
    return c1 + c2;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord.xy - 0.5*iResolution.xy)/iResolution.y;
    vec2 mouseUv = iMouse.xy / iResolution.xy;
    
    vec3 camPos = vec3(.5, .2, 0);
    vec3 lookat = vec3(.5, .2, 1.);
    vec2 rain = Rain(uv * 2.) * .5;

    uv.x += sin(uv.y * 40.) * .005; // 지글지글
    uv.y += sin(uv.x * 170.) * .003;

    ray r = GetRay(uv - rain *.5, camPos, lookat, 2.);
    float t = iTime * 0.1 + mouseUv.x;
    
    vec3 col = streetLight(r, t);
    col += headLight(r, t);
    col += tailLight(r, t * .5);
    col += environtLight(r, t);    

    col += uv.y * vec3(0.2, 0.3, 0.7);  
    //col = vec3(rain, 0);
    fragColor = vec4(col,1.0);
}