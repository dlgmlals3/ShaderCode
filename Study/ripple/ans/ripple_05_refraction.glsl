// Answer 05: STEP 5 refraction
// Matches: Study/ripple/05_ripple.glsl

float ripple(vec2 p, vec2 origin, float t)
{
    float r = length(p - origin);
    float wave = sin(r * 40.0 - t * 5.0);
    float falloff = exp(-r * 3.0);
    return wave * falloff;
}

float height(vec2 p, float t)
{
    float h = 0.0;
    h += ripple(p, vec2(-0.30,  0.10), t);
    h += ripple(p, vec2( 0.25, -0.15), t + 1.0);
    h += ripple(p, vec2( 0.05,  0.30), t + 2.5);
    return h / 3.0;
}

float checker(vec2 p)
{
    vec2 cell = floor(p * 8.0);
    return mod(cell.x + cell.y, 2.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float h = height(uv, iTime);
    float e = 0.002;
    float hx = height(uv + vec2(e, 0.0), iTime) - h;
    float hy = height(uv + vec2(0.0, e), iTime) - h;
    vec2 grad = vec2(hx, hy) / e;

    vec2 duv = uv + grad * 0.0015;
    float bg = checker(duv);

    vec3 col = vec3(bg * 0.6 + 0.2);
    fragColor = vec4(col, 1.0);
}
