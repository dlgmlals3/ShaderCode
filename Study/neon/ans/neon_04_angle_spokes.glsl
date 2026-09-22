// Answer 04: STEP 4 angle spokes
// Matches: Study/neon/04_neon_tunnel.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float waves = sin(r * 100.0 - iTime * 4.0);
    float ringline = smoothstep(0.5, 0.95, waves);

    float a = atan(uv.y, uv.x);
    float spokes = sin(a * 16.0 + iTime * 0.8);
    float spokeLine = smoothstep(0.88, 1.0, spokes);

    vec3 col = vec3(ringline + spokeLine * 0.6);
    fragColor = vec4(col, 1.0);
}
