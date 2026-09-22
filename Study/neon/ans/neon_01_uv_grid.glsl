// Answer 01: STEP 1 centered UV
// Matches: Study/neon/01_neon_tunnel.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    vec3 col = vec3(uv, 0.0);
    fragColor = vec4(col, 1.0);
}
