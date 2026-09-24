// Answer 03: STEP 3 origin + falloff
// Matches: Study/ripple/03_ripple.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    vec2 origin = vec2(0.0);
    if (iMouse.xy != vec2(0.0))
        origin = (iMouse.xy - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv - origin);
    float wave = sin(r * 40.0 - iTime * 5.0);
    float falloff = exp(-r * 3.0);
    float h = wave * falloff;

    vec3 col = vec3(h * 0.5 + 0.5);
    fragColor = vec4(col, 1.0);
}
