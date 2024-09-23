float N12(vec2 p) {
    p = fract(p * vec2(243.21, 152.1));
    p += dot(p, p + 351.1);
    return fract(p.x * p.y);
}

vec2 N22(vec2 st) {
    float r = N12(st);
    return vec2(r, N12(st + r));
}

vec2 getPos(vec2 id, vec2 st) {
    vec2 r = N22(id);
    vec2 offset = cos(r * iTime) * .4;
    return st + offset;
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

    float f = smoothstep(width, width - width *.1, d);
    f *= smoothstep(1.5, .5, length(a - b));
    
    return f;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - 0.5*iResolution.xy)/iResolution.y;
    vec3 col = vec3(0);    
    vec2 repeat = vec2(10);
    vec2 st = fract(uv * repeat) - .5;
    vec2 id = floor(uv * repeat);

    vec2 st2 = getPos(id, st);
    float f = smoothstep(0.1, 0.05, length(st2));
    float outline = 0.;
    if (st.x < -.45 || st.y > .45) outline = 1.;

    col = f * vec3(1);
    //col += outline * vec3(1,0,0);
    col = vec3(1) * renderLine(uv, vec2(0.), vec2(.2), .1);
    
    fragColor = vec4(col, 1.0);
}