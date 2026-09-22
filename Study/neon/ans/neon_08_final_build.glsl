// Answer 08: STEP 8 final polish
// Matches: Study/neon/08_neon_tunnel.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float a = atan(uv.y, uv.x);
    float depth = 1.0 / (r + 0.08);

    float waves = sin(depth * 8.0 - iTime * 4.0);
    float ringline = smoothstep(0.55, 0.95, waves);

    float spokes = sin(a * 16.0 + depth * 0.35 + iTime * 0.25);
    float spokeLine = smoothstep(0.88, 1.0, spokes);

    float glow = 0.025 / (abs(waves) + 0.035);
    float centerGlow = 0.015 / (r + 0.02);
    float mask = ringline + spokeLine * 0.45 + glow * 0.35 + centerGlow;

    vec3 colorA = vec3(0.0, 0.85, 1.0);
    vec3 colorB = vec3(1.0, 0.15, 0.75);
    float t = sin(a * 2.0 + depth * 0.2 + iTime * 0.5) * 0.5 + 0.5;
    vec3 neon = mix(colorA, colorB, t);

    float vignette = smoothstep(0.95, 0.15, r);

    vec3 col = neon * mask * vignette;
    col = 1.0 - exp(-col);

    fragColor = vec4(col, 1.0);
}
