// ============================================================
// 06. Ripple - STEP 6
// 물 색과 빛
//
// 목표:
//   - 체크무늬 0/1을 깊은 물색 deep과 얕은 물색 shallow로 바꾼다.
//   - 기울기 grad가 빛 방향 lightDir을 향하는 정도로 밝기를 더한다.
//   - clamp로 0~1 범위를 정리한다.
//
// 알아야 할 것:
//   - mix(deep, shallow, bg): bg가 0이면 deep, 1이면 shallow.
//   - dot(a, b)는 두 벡터가 같은 방향이면 양수, 반대면 음수, 직각이면 0이다.
//   - dot(grad, lightDir)가 양수인 곳은 빛을 향한 경사면이라 밝고, 음수면 그늘이라 어둡다.
//   - grad는 값이 커서(최대 수십) 0.02 정도를 곱해 줄여야 한다.
//   - 더한 뒤 음수나 1 초과가 생기므로 clamp(col, 0.0, 1.0)으로 정리한다.
//   - Neon에서 쓴 1.0 - exp(-col)과 비교해 볼 것. 어두운 색이 어떻게 달라지나.
//
// 확인:
//   - 파란 물 위에 체크무늬가 비치고, 물결의 한쪽 면은 밝고 반대쪽은 어둡다.
//   - lightDir을 vec2(-0.6, -0.8)로 뒤집으면 밝은 면과 어두운 면이 바뀐다.
//
// 참고 답안:
//   - ans/ripple_06_water_color.glsl
// 다음:
//   - 07_ripple.glsl
// ============================================================

// -> 05_ripple.glsl 의 ripple, height, checker 함수를 여기에 옮겨 붙인다.


void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    // -> 05_ripple.glsl 에서 완성한 mainImage 코드를 아래에 옮겨 붙인다. (col = vec3(bg ...) 줄은 지운다)


    // [TODO 1] 물 색
    //   - deep = vec3(0.02, 0.12, 0.28)
    //   - shallow = vec3(0.10, 0.45, 0.65)
    //   - water = mix(deep, shallow, bg)

    // [TODO 2] 빛
    //   - lightDir = normalize(vec2(0.6, 0.8))
    //   - shade = dot(grad, lightDir) * 0.02
    //   - col = water + vec3(0.35, 0.45, 0.50) * shade

    // [TODO 3] 범위 정리
    //   - col = clamp(col, 0.0, 1.0)
    //   - 1.0 - exp(-col)로 바꿔서 비교해 보고 기록할 것.

    fragColor = vec4(col, 1.0);
}
