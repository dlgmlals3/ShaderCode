// 0. 가운데 밝은점 만들어보기
// 1. hash 함수 생성
// 3. hash 함수 -.5 만들어서 -.5~.5 영역으로 설정 뒤, uv 값에 더해줌
// 4. hash 함수와 time 함수를 통하여 한점이 움직이는 애니메이션 만듬
// 5. 1~4과정을 for loop를 묶고 여러개의 파티클을 생성하자.

#define NUM_PARTICLE 95.

vec2 Hash12(float t) { // 1
    float x = fract(sin(t * 674.4) * 453.2);
    float y = fract(sin((t + x) * 714.2) * 263.3);
    return vec2(x, y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 col = vec3(0.);
    vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    
    for (float i=0.; i < NUM_PARTICLE; i++) { // 5
        float t = fract(iTime);
        vec2 dir = Hash12((i + .1))-.5;
        float d = length(uv - dir * t); 
        
        float brightness = .001;
        col += brightness / d;
    }
    fragColor = vec4(col,1.0);
}