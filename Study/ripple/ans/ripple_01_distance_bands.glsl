// Answer 01: STEP 1 distance bands
// Matches: Study/ripple/01_ripple.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float bands = fract(r * 5.0);

    vec3 col = vec3(bands);
    fragColor = vec4(col, 1.0);
}
