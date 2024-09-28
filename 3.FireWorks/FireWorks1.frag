// 0. 가운데 밝은점 만들어보기
// 1. hash 함수 생성
// 3. hash 함수 -.5 만들어서 -.5~.5 영역으로 설정 뒤, uv 값에 더해줌
// 4. hash 함수와 time 함수를 통하여 한점이 움직이는 애니메이션 만듬
// 5. 1~4과정을 for loop를 묶고 여러개의 파티클을 생성하자.

// 6. polar hash 함수 생성 원형 폭발
// 8. smoothstep(t) mix를 통하여 bright 적용
// 9. 폭발 반짝 파티클 마다 반짝 효과 구현 sin ( t, i )
// 10. Explosion 함수 만들자.

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






// Tomorrow

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