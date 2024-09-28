//11. 컬러 변수를 만들자. 컬러 변수는 sin, floor()  * .25 + .75 를 통해 
// 밝은 색상으로 만들자.
//12  floor(iTime)을 하게되면 색상 애니메이션의 어떤 효과가 있는지 파악
//13  파티클 페이드아웃 페이드인 
//14 explosion 여러개 만들자.
//15. offset 변수 만들자. 
// 폭발 지점을 산란 시키자. 테스트하는 방법은 col += .001/lenght(uv - offs)
// offs 는 Hash 함수 사용 && 특정 변위값 곱한다.
// 폭발 지점도 항상 바뀌어야 다.
// 16. 폭발 타이밍도 바뀌어야 한다.

#define NUM_PARTICLE 95.

vec2 Hash12(float t) {
    float x = fract(sin(t * 674.4) * 453.2);
    float y = fract(sin((t + x) * 714.2) * 263.3);
    return vec2(x, y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 col = vec3(0.);
    vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    
    for (float i=0.; i < NUM_PARTICLE; i++) {
        float t = fract(iTime);
        vec2 dir = Hash12((i + .1))-.5;
        float d = length(uv - dir * t); 
        
        float brightness = .001;
        col += brightness / d;
    }
    fragColor = vec4(col,1.0);
}