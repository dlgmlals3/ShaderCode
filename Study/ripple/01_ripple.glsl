// ============================================================
// 01. Ripple - STEP 1
// 중심 UV와 거리 띠 (fract)
//
// 목표:
//   - Neon에서 쓴 중심 UV를 다시 만든다.
//   - r = length(uv)로 중심까지의 거리를 구한다.
//   - fract(r * N)으로 톱니 모양 동심원 띠 bands를 만든다.
//
// 알아야 할 것:
//   - fract(x)는 x의 소수 부분만 남긴다. 결과는 항상 0.0~1.0 사이를 반복한다.
//   - fract(r * 5.0)은 r이 0.2 늘어날 때마다 0에서 1로 다시 올라간다.
//   - sin은 부드럽게 오르내리지만 fract는 1에서 0으로 뚝 떨어지는 경계가 생긴다.
//
// 확인:
//   - 중심에서 바깥으로 검정->흰색이 반복되는 톱니 동심원이 보인다.
//   - N을 5.0에서 20.0으로 바꾸면 띠가 촘촘해진다.
//
// 참고 답안:
//   - ans/ripple_01_distance_bands.glsl
// 다음:
//   - 02_ripple.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    // [TODO 1] 중심 UV
    //   - fragCoord를 화면 중심이 (0,0)인 uv로 바꾼다. (Neon STEP 1과 같다)
    //   - x, y 모두 iResolution.y로 나눈다.
    fragCoord = fragCoord - 0.5 * iResolution.xy;
    vec2 uv = fragCoord / iResolution.y;

    // [TODO 2] 거리
    //   - r = length(uv)
    float r = length(uv);

    // [TODO 3] fract 띠
    float bands = fract(r * 35.0);
    //   - bands = fract(r * 5.0)
    //   - col = vec3(bands) 로 찍어서 확인한다.
    //   - 비교: col = vec3(sin(r * 30.0) * 0.5 + 0.5) 와 무엇이 다른지 볼 것.

    // fract : 톱니 모양
    // sin :부드러운 곡선
    col = vec3(bands);
    //col = vec3(sin(r * 100.0) * 0.5 + 0.5);
    fragColor = vec4(col, 1.0);
}
