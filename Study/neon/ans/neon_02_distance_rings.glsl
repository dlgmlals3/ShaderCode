// Answer 02: STEP 2 distance rings
// Matches: Study/neon/02_neon_tunnel.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float waves = sin(r * 100.0);
    float ringline = smoothstep(0.5, 0.95, waves);

    vec3 col = vec3(ringline);
    fragColor = vec4(col, 1.0);
}
