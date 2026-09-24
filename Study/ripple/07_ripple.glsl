// ============================================================
// 07. Ripple - STEP 7
// 물방울 떨어뜨리기 (마무리 연출)
//
// 목표:
//   - 각 파원이 일정 주기로 "떨어지고, 퍼지고, 사라지기"를 반복하게 만든다.
//   - vignette로 화면 가장자리를 어둡게 한다.
//
// 알아야 할 것:
//   - life = fract(t / period + phase)
//       0에서 1까지 갔다가 다시 0으로 돌아오는, 주기가 period초인 시계다.
//       phase를 파원마다 다르게 주면 떨어지는 타이밍이 어긋난다.
//   - age = life * period : 이번 물방울이 떨어진 뒤 흐른 초.
//   - 파동 위상은 iTime이 아니라 age로 계산해야 물방울마다 새로 시작한다.
//       wave = sin(r * 40.0 - age * 10.0)  -> 파동 속도는 10 / 40 = 0.25
//   - 파면 반지름 frontR = age * 0.25 (파동 속도와 같게). 그보다 바깥은 아직 파동이
//     도착하지 않았으니 0이어야 한다.
//       front = smoothstep(frontR + 0.02, frontR - 0.05, r)   (edge0 > edge1: 안쪽 1, 바깥 0)
//   - fade = 1.0 - life : 시간이 갈수록 약해진다.
//   - 이제 파동이 동시에 겹치는 일이 적으니 height에서 3.0으로 나누지 않아도 된다.
//   - vignette = smoothstep(0.9, 0.3, length(uv)) : 곱하는 마스크.
//
// 확인:
//   - 파원마다 다른 타이밍에 물방울이 떨어지고, 원이 퍼지다가 사라진다.
//   - 파동 바깥 경계가 보이고, 그 밖은 잔잔하다.
//
// 참고 답안:
//   - ans/ripple_07_drops.glsl
// 다음:
//   - 08_ripple.glsl
// ============================================================

// -> 06_ripple.glsl 의 ripple, height, checker 함수를 여기에 옮겨 붙인다.


// [TODO 1] ripple 함수 고치기
//   - 인자를 (vec2 p, vec2 origin, float t, float period, float phase)로 늘린다.
//   - life, age를 만든다.
//   - wave는 t 대신 age로 계산한다.
//   - front, fade를 만들어 반환값에 곱한다: wave * falloff * front * fade

// [TODO 2] height 함수 고치기
//   - ripple 호출 3개에 period, phase를 넣는다.
//       예: (t, 3.0, 0.0), (t, 4.0, 0.35), (t, 3.5, 0.70)
//   - / 3.0 을 지운다.

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    // -> 06_ripple.glsl 에서 완성한 mainImage 코드를 아래에 옮겨 붙인다.


    // [TODO 3] vignette
    //   - vignette = smoothstep(0.9, 0.3, length(uv))
    //   - clamp 하기 전에 col *= vignette

    fragColor = vec4(col, 1.0);
}
