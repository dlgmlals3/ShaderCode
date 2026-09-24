// Answer 02: STEP 2 wave motion
// Matches: Study/ripple/02_ripple.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float wave = sin(r * 40.0 - iTime * 5.0);
    float h = wave * 0.5 + 0.5;

    vec3 col = vec3(h);
    fragColor = vec4(col, 1.0);
}
