// Answer 05: STEP 5 fake depth
// Matches: Study/neon/05_neon_tunnel.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float a = atan(uv.y, uv.x);
    float depth = 1.0 / (r + 0.08);

    float waves = sin(depth * 8.0 - iTime * 4.0);
    float ringline = smoothstep(0.55, 0.95, waves);

    float spokes = sin(a * 16.0 + iTime * 0.8);
    float spokeLine = smoothstep(0.88, 1.0, spokes);

    vec3 col = vec3(ringline + spokeLine * 0.45);
    fragColor = vec4(col, 1.0);
}
