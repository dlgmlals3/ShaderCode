// 다시 점검
// Fade in Fade out
// rotate uv
// uv mouse effect
// 별자리 color 작업
// 별자리 그레디언트 작업

float N12(vec2 p) {
    p = fract(p * vec2(243.21, 152.1));
    p += dot(p, p + 351.1);
    return fract(p.x * p.y);
}

vec2 N22(vec2 st) {
    float r = N12(st);
    return vec2(r, N12(st + r));
}

float getDist(vec2 p, vec2 a, vec2 b) {
    vec2 ap = p - a;
    vec2 ab = b - a;
    float t = dot(ab, ap) / dot(ab, ab);
    t = clamp(t, 0., 1.);
    return length(ap - (t * ab));
}

float renderLine(vec2 p, vec2 a, vec2 b, float width) {
    float d = getDist(p, a, b);
    float line = smoothstep(width * 1.5, width, d);
    float dist2 = length(a - b);
    
    float alpha = smoothstep(1.2, .5, dist2);
    line = line * alpha * .5;
    //line += smoothstep(.05, .03, abs(dist2 - 3.75)); 
    return line;
}

vec2 getPos(vec2 id, vec2 offset) {
    vec2 r = N22(id + offset);
    vec2 k = cos(r * iTime) * .4;
    return k + offset;
}

float layer(vec2 uv) {
    vec2 repeat = vec2(6);
    vec2 st = fract(uv * repeat) - .5;
    vec2 id = floor(uv * repeat);

    vec2 p1 = getPos(id, st);
    vec2 p2[9];    
    int p2Index = 0;
    for (float i=-1.; i<=1.; i+=1.) {
        for (float j=-1.; j<=1.; j+=1.) {           
            p2[p2Index++] = getPos(id, vec2(i, j));        
        }
    }

    float line = 0.;    
    float lw= 0.02;
    float t = iTime * 5.;

    for (int i=0; i<9; i++) {
        line += renderLine(st, p2[4], p2[i], lw);

        vec2 d = (p2[i] - st) * 25.;
        float sparkle = 1. / dot(d, d);
        line += sparkle * (sin(t + fract(p2[i].x) * 10.) * .5 + .5);
    }
    line += renderLine(st, p2[1], p2[3], lw);
    line += renderLine(st, p2[1], p2[5], lw);
    line += renderLine(st, p2[3], p2[7], lw);
    line += renderLine(st, p2[5], p2[7], lw);
    return line;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - 0.5*iResolution.xy)/iResolution.y;
    vec2 mouse = (iMouse.xy / iResolution.xy) - .5;
    vec3 col = vec3(0);    
   
    float t = iTime * .1; 
    float gradient = uv.y;
    
    // rotation
    float s = sin(t);
    float c = cos(t);
    mat2 rot = mat2(c, -s, s, c);
    uv *= rot;
    mouse *= rot;
    float line = 0.;
  
    for (float i=0.; i<1.; i+= 1./4.) {
        float z = fract(i + t);
        float size = mix(1.5, .5, z);
        float fade = smoothstep(0., .2, z) * smoothstep(1., .8, z);
        line += layer(uv * size + i * 10. - mouse) * fade;
    }
    
    // color
    vec3 base = sin(t * vec3(.345, .456, .657)) * .4 + .6;
    col = line * base;
    col += -gradient * base;
    //col = vec3(1) * renderLine(uv, vec2(0.), vec2(.2), .1);
    fragColor = vec4(col, 1.0);
}