// Answer 07: STEP 7 drops + vignette
// Matches: Study/ripple/07_ripple.glsl

float ripple(vec2 p, vec2 origin, float t, float period, float phase)
{
    float life = fract(t / period + phase);
    float age = life * period;

    float r = length(p - origin);
    float wave = sin(r * 40.0 - age * 10.0);
    float falloff = exp(-r * 3.0);

    float frontR = age * 0.25;
    float front = smoothstep(frontR + 0.02, frontR - 0.05, r);
    float fade = 1.0 - life;

    return wave * falloff * front * fade;
}

float height(vec2 p, float t)
{
    float h = 0.0;
    h += ripple(p, vec2(-0.30,  0.10), t, 3.0, 0.00);
    h += ripple(p, vec2( 0.25, -0.15), t, 4.0, 0.35);
    h += ripple(p, vec2( 0.05,  0.30), t, 3.5, 0.70);
    return h;
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

    vec3 deep = vec3(0.02, 0.12, 0.28);
    vec3 shallow = vec3(0.10, 0.45, 0.65);
    vec3 water = mix(deep, shallow, bg);

    vec2 lightDir = normalize(vec2(0.6, 0.8));
    float shade = dot(grad, lightDir) * 0.02;

    vec3 col = water + vec3(0.35, 0.45, 0.50) * shade;

    float vignette = smoothstep(0.9, 0.3, length(uv));
    col *= vignette;
    col = clamp(col, 0.0, 1.0);

    fragColor = vec4(col, 1.0);
}
