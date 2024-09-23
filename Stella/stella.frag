float N12(vec2 p) {
  p = fract(p * vec2(12.242, 32.35));
  p += dot(p, p + 341.43);
  return fract(p.x * p.y);
}

vec2 N22(vec2 p) {
  float n = N12(p);
  return vec2(n, N12(p + n));
}

vec2 getPos(vec2 id, vec2 offset) {
  vec2 n = N22(id + offset);
  vec2 k = cos(n * iTime) * .4;
  return offset + k;
}

float getDist(vec2 p, vec2 a, vec2 b) {
    vec2 ap = p - a;
    vec2 ab = b - a;

    float d = clamp(dot(ap, ab) / length(ab), 0., 1.);
    vec2 p1 = a + (normalize(ab) * d);
    float l = length(p - p1);
    return l;
}

float getDist2(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float t = clamp(dot(pa, ba) / dot(ba, ba), 0., 1.);
    return length(pa - ba * t);
}

float renderLine(vec2 p, vec2 a, vec2 b, float width) {
    float d = getDist2(p, a, b);
    float f = smoothstep(width, width - width *.1, d);
    f *= smoothstep(1.5, .5, length(a - b));
    
    return f;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - 0.5*iResolution.xy)/iResolution.y;
    vec3 col = vec3(1);
    vec2 tile = vec2(8, 4);
    vec2 st = fract(uv * tile) - .5;
    
    vec2 id = floor(uv * tile);
    
    float m1 = 0.;
    float m2 = 0.;
    vec2 p[9];
    int i=0;
    for (float x=-1.; x<=1.; x+=1.) {
      for (float y=-1.; y<=1.; y+=1.) {
        p[i++] = getPos(id, vec2(x,y));
      }
    }
    
    float lw= 0.03;
    for (int i=0; i<9; i++) {
       m1 += renderLine(st, p[4], p[i], lw);
    }
    m1 += renderLine(st, p[1], p[3], lw);
    m1 += renderLine(st, p[1], p[5], lw);
    m1 += renderLine(st, p[3], p[7], lw);
    m1 += renderLine(st, p[5], p[7], lw);
    
    col = m1 * vec3(1);
    //if (st.x > 0.45 || st.y > 0.45) col = vec3(1,0,0);
    col  = N12(uv) * vec3(1);
    fragColor = vec4(col, 1.0);
}