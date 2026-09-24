// Answer 08: STEP 8 final build
// Matches: Study/ripple/08_ripple.glsl
// 변형: (a) 마우스 파원 추가, (b) 체크무늬 -> 대각 줄무늬, (d) 밤바다 팔레트

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

    // (a) 마우스 클릭 위치에 네 번째 파원. 주기 2초.
    if (iMouse.xy != vec2(0.0))
    {
        vec2 m = (iMouse.xy - 0.5 * iResolution.xy) / iResolution.y;
        h += ripple(p, m, t, 2.0, 0.0);
    }
    return h;
}

// (b) 대각선 줄무늬 배경
float stripes(vec2 p)
{
    return step(0.5, fract((p.x + p.y) * 6.0));
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
    float bg = stripes(duv);

    // (d) 밤바다 팔레트
    vec3 deep = vec3(0.01, 0.04, 0.12);
    vec3 shallow = vec3(0.04, 0.22, 0.38);
    vec3 water = mix(deep, shallow, bg);

    vec2 lightDir = normalize(vec2(0.6, 0.8));
    float shade = dot(grad, lightDir) * 0.02;

    vec3 col = water + vec3(0.30, 0.55, 0.70) * shade;

    float vignette = smoothstep(0.9, 0.3, length(uv));
    col *= vignette;
    col = clamp(col, 0.0, 1.0);

    fragColor = vec4(col, 1.0);
}
