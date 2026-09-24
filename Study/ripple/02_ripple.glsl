// ============================================================
// 02. Ripple - STEP 2
// 퍼져나가는 파동
//
// 목표:
//   - sin(r * freq - iTime * speed)로 바깥으로 퍼지는 파동 wave를 만든다.
//   - wave(-1~1)를 0~1 높이 h로 바꾼다. smoothstep으로 자르지 않는다.
//
// 알아야 할 것:
//   - Neon에서는 smoothstep으로 선만 남겼지만, 물결은 부드러운 언덕이라 sin을 그대로 쓴다.
//   - wave * 0.5 + 0.5 는 -1~1 을 0~1 로 옮기는 공식이다.
//   - r * freq - iTime * speed: 시간이 지나면 같은 위상이 더 큰 r로 이동한다. 그래서 바깥으로 퍼진다.
//   - 파동이 1초에 이동하는 거리는 speed / freq 다.
//
// 확인:
//   - 부드러운 밝기의 동심원이 중심에서 바깥으로 계속 퍼진다.
//   - 부호를 + iTime으로 바꾸면 안쪽으로 모인다.
//
// 참고 답안:
//   - ans/ripple_02_wave_motion.glsl
// 다음:
//   - 03_ripple.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    // -> 01_ripple.glsl 에서 완성한 코드를 아래에 옮겨 붙인다. (bands 줄은 지워도 된다)


    // [TODO 1] 파동
    //   - wave = sin(r * 40.0 - iTime * 5.0)
    //   - 40.0은 촘촘함(freq), 5.0은 속도(speed).

    // [TODO 2] 높이로 바꾸기
    //   - h = wave * 0.5 + 0.5
    //   - col = vec3(h)
    //   - smoothstep을 걸었을 때와 비교해서 왜 여기서는 안 쓰는지 기록할 것.

    fragColor = vec4(col, 1.0);
}
