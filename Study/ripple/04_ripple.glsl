// ============================================================
// 04. Ripple - STEP 4
// 여러 파원 합성
//
// 목표:
//   - 파동 하나를 만드는 함수 ripple(p, origin, t)를 mainImage 위에 만든다.
//   - 서로 다른 위치의 파원 3개를 더해서 간섭 무늬를 만든다.
//
// 알아야 할 것:
//   - GLSL 함수 형태:
//       float ripple(vec2 p, vec2 origin, float t)
//       {
//           ...
//           return 값;
//       }
//   - 함수는 mainImage보다 위에 있어야 한다. (위에서 아래로 읽는다)
//   - 파동은 더하면 합쳐진다. 마루+마루는 더 높고, 마루+골은 상쇄된다.
//   - 3개를 더하면 -3~3이 되니 3.0으로 나눠 -1~1로 되돌린다.
//   - 파원마다 t에 다른 값을 더하면 시작 타이밍이 어긋나 보인다.
//   - 마우스 origin은 잠시 빼고 고정 좌표 3개를 쓴다. (STEP 8에서 다시 쓴다)
//
// 확인:
//   - 파동이 겹치는 곳에 격자/그물 같은 간섭 무늬가 보인다.
//   - 파원을 1개만 남기면 STEP 3과 같은 화면이 나와야 한다.
//
// 참고 답안:
//   - ans/ripple_04_multi_source.glsl
// 다음:
//   - 05_ripple.glsl
// ============================================================

// [TODO 1] ripple 함수를 여기에 만든다.
//   - 입력: 픽셀 좌표 p, 파원 origin, 시간 t
//   - 안에서: r = length(p - origin), wave = sin(r * 40.0 - t * 5.0), falloff = exp(-r * 3.0)
//   - 반환: wave * falloff
//   - STEP 3에서 mainImage 안에 있던 계산을 그대로 옮기면 된다.

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    // -> 03_ripple.glsl 에서 완성한 uv 줄만 옮겨 붙인다. (origin, wave, falloff는 함수로 갔다)


    // [TODO 2] 파원 3개 합치기
    //   - h = 0.0 으로 시작
    //   - h += ripple(uv, vec2(-0.30, 0.10), iTime)
    //   - h += ripple(uv, vec2( 0.25, -0.15), iTime + 1.0)
    //   - h += ripple(uv, vec2( 0.05, 0.30), iTime + 2.5)
    //   - h /= 3.0
    //   - col = vec3(h * 0.5 + 0.5)

    fragColor = vec4(col, 1.0);
}
