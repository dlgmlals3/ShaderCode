// 6. polar hash 함수 생성 원형 폭발-- ok
// 7. 파티클이 어둡다가 -> 밝아지도록 만들기- smoothstep(t) mix
// 8. 파티클 Sparkle 구현 - sin ( t, i )
// 9. Explosion 함수 만들자.

#define NUM_PARTICLE 95.
#define PI 3.141592

vec2 Hash12(float t) { // 1
    float x = fract(sin(t * 674.4) * 453.2);
    float y = fract(sin((t + x) * 714.2) * 263.3);
    return vec2(x, y);
}

vec2 HashPolar12(float t) {
    float theta = fract(sin(t * 674.4) * 453.2) * PI * PI;
    float r = fract(sin((t + theta) * 714.2) * 263.3) * .3;
    return vec2(sin(theta), cos(theta)) * r;
}

float Explosion(float i, vec2 uv) {
    float explod = 0.;
    float t = fract(iTime);
    vec2 dir = HashPolar12((i + .1)); // 6
    float d = length(uv - dir * t); 

    float brightness = mix(.0001, .0007, smoothstep(.1, .7, t)); // 7
    float sparkle = sin(t * i * .5) * .5 + .5; // 8
    explod += brightness * sparkle / d;
    return explod;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 col = vec3(0.);
    vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    
    float firewalks = 0.;
    for (float i=0.; i < NUM_PARTICLE; i++) { // 5
        firewalks += Explosion(i, uv);
    }
    
    col = vec3(firewalks);
    fragColor = vec4(col,1.0);
}