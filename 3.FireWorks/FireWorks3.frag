//10. 컬러 변수를 만들자 - sin, floor()  * .25 + .75 를 통해 밝은 색상
//11. floor(iTime)을 하게되면 색상 애니메이션의 어떤 효과가 있는지 파악
//12. 파티클 페이드아웃 페이드인, 파티클이 부드럽게 없어짐.
//13. explosion looping
//14. 폭발 지점을 산란 시키자 offset 변수 만들자. 
// - 테스트하는 방법은 col += .001/lenght(uv - offs)
// - offs 는 Hash 함수 사용 && 특정 변위값 곱한다.
// 15. 폭발 지점도 항상 바뀌어야 다.

#define NUM_PARTICLE 95.
#define NUM_EXPLOSION 5.

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

float Explosion(vec2 uv, float t) {
    float explod = 0.;
    for (float i=0.; i< NUM_PARTICLE; i++) {
        vec2 dir = HashPolar12((i + .1)); // 6
        
        float brightness = mix(.0001, .0007, smoothstep(.1, .7, t)); // 7
        brightness *= smoothstep(1., .7, t); // 12
        float sparkle = sin(t * i * .5) * .5 + .5; // 8
        
        float d = length(uv - dir * t);         
        explod += brightness * sparkle / d;
    }    
    return explod;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    vec3 col = vec3(0.);
    
    float firewalks = 0.;
    for (float i=0.; i < NUM_EXPLOSION; i++) { // 13
        float t = iTime + (i / NUM_EXPLOSION); // 15
        float ft = floor(t); // 11
    
        vec3 color = sin(4. * vec3(.34, .54, .43) * ft) * .25 + .75; // 10
        vec2 offs = Hash12(i + 1. + ft) - .5; // 14
        offs *= vec2(1.77, 1.);
        col += Explosion(uv - offs, fract(t)) * color;
    }
    fragColor = vec4(col,1.0);
}