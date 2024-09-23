float N12(vec2 p) {
    p = fract(p * vec2(3521.2, 2414.5));
    p += dot(p, p + 152.5);
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
    col += outline * vec3(1,0,0);
    
    //col = N12(uv) * vec3(1.); // test
    fragColor = vec4(col, 1.0);
}