// 0. 가운데 밝은점 만들어보기
// 1. hash 함수 생성
// 2. hash를 랜덤함수로 렌더링해보자
// 3. hash 함수 -.5 만들어서 -.5~.5 영역으로 설정 뒤, uv 값에 더해줌
// 4. hash 함수와 time 함수를 통하여 한점이 움직이는 애니메이션 만듬

// 5. 1~4과정을 for loop를 묶고 hash 함수 내부 파라메터를 수정하여 사각 형태의 explosion 만들어봄
// 6. polar hash 함수 생성
// 7. 원형 폭발과정 렌더링
// 8. 원형 잔해 mix를 통하여 밝기 조절
// 9. 원형 잔해 폭발 random 하게 조절 (bright 수정) --> Explosion 함수로..

// Tomorrow

#define NUM_PARTICLE 50.
#define NUM_EXPLOSION 5.
 
vec2 Hash12(float t) {
    float x = fract(sin(t * 1243.165) * 145.524);
    float y = fract(sin((t + x) * 121.672) * 2415.12);
    return vec2(x, y);
}
vec2 HashPolar12(float t) {
    float theta = fract(sin(t*673.2) * 435.3) * 6.2832;
    float r = fract(sin((t + theta) * 121.62) * 241.12);
    return vec2(sin(theta), cos(theta)) * r;
}
float Explosion(vec2 uv, float t) {
    float explod = 0.;
    for (float i=0.; i< NUM_PARTICLE; i++) {
        vec2 dir = HashPolar12((i + .1) * .01); // 6
         
        float brightness = mix(.0003, .001, smoothstep(.1, .5, t)); // 7
        brightness *= smoothstep(1., .7, t); // 12
        float sparkle = sin(t * i * .5) * .5 + .5; // 8
        
        float d = length(uv - dir * t);         
        explod += brightness * sparkle / d;
    }    
    return explod;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 col = vec3(0.);
    vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    float sparkle = 0.;
    float t = fract(iTime);

    float firewalks = 0.;
    for (float i=0.; i < NUM_EXPLOSION; i++) { // 13
        
        float t = iTime + (i / NUM_EXPLOSION); // 15
        float ft = floor(t); // 11
    
        vec3 color = sin(4. * vec3(.34, .54, .43) * ft) * .25 + .75; // 10
        vec2 offs = Hash12(i + 1. + ft) - .5; // 14
        offs *= vec2(1.77, 1.);
        col += Explosion(uv - offs, fract(t) * .4) * color;
    }
   
    fragColor = vec4(col,1.0);
}