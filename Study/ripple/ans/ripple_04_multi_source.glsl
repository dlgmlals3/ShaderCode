// Answer 04: STEP 4 multi source
// Matches: Study/ripple/04_ripple.glsl

float ripple(vec2 p, vec2 origin, float t)
{
    float r = length(p - origin);
    float wave = sin(r * 40.0 - t * 5.0);
    float falloff = exp(-r * 3.0);
    return wave * falloff;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float h = 0.0;
    h += ripple(uv, vec2(-0.30,  0.10), iTime);
    h += ripple(uv, vec2( 0.25, -0.15), iTime + 1.0);
    h += ripple(uv, vec2( 0.05,  0.30), iTime + 2.5);
    h /= 3.0;

    vec3 col = vec3(h * 0.5 + 0.5);
    fragColor = vec4(col, 1.0);
}
