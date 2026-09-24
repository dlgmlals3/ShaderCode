// ============================================================
// 05. Ripple - STEP 5
// 파동으로 배경 굴절시키기
//
// 목표:
//   - 파원 3개 합을 height(p, t) 함수로 묶는다.
//   - 체크무늬 배경 checker(p)를 만든다.
//   - 높이의 기울기 grad로 uv를 밀어서 배경이 일렁이게 만든다.
//
// 알아야 할 것:
//   - 체크무늬: floor(p * 8.0)으로 칸 번호를 만들고, (x + y)를 2로 나눈 나머지
//     mod(x + y, 2.0)로 0 또는 1을 정한다.
//   - 기울기(미분)는 아주 가까운 두 점의 높이 차이로 구할 수 있다.
//       hx = height(p + vec2(e, 0.0)) - height(p)    (e = 0.002 정도)
//       hy = height(p + vec2(0.0, e)) - height(p)
//       grad = vec2(hx, hy) / e
//   - 물 표면이 기울어진 쪽으로 바닥이 밀려 보이는 게 굴절이다.
//       duv = uv + grad * 세기
//   - 배경은 uv가 아니라 밀린 duv로 찍는다. 파동 h 자체는 더 이상 화면에 안 찍는다.
//   - height를 세 번 부르므로 파동 계산이 3배가 된다. 지금은 괜찮다.
//
// 확인:
//   - 체크무늬가 파동을 따라 일렁인다. 파동을 직접 찍지 않아도 물결이 보인다.
//   - 세기를 0.0으로 두면 체크무늬가 멈춘다. (굴절이 꺼진 상태)
//
// 참고 답안:
//   - ans/ripple_05_refraction.glsl
// 다음:
//   - 06_ripple.glsl
// ============================================================

// -> 04_ripple.glsl 의 ripple 함수를 여기에 옮겨 붙인다.


// [TODO 1] height 함수
//   - float height(vec2 p, float t)
//   - STEP 4의 mainImage 안에 있던 "h += ripple(...)" 3줄과 "/ 3.0"을 이 안으로 옮긴다.
//   - uv 대신 p를 쓴다.

// [TODO 2] checker 함수
//   - float checker(vec2 p)
//   - cell = floor(p * 8.0)
//   - return mod(cell.x + cell.y, 2.0)

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    // -> 04_ripple.glsl 에서 완성한 uv 줄만 옮겨 붙인다.


    // [TODO 3] 높이와 기울기
    //   - h = height(uv, iTime)
    //   - e = 0.002
    //   - hx, hy를 위 설명대로 구하고 grad = vec2(hx, hy) / e

    // [TODO 4] 굴절
    //   - duv = uv + grad * 0.0015
    //   - bg = checker(duv)
    //   - col = vec3(bg * 0.6 + 0.2)   (완전 검정/흰색보다 눈이 편하다)
    //   - 0.0015를 0.0, 0.005로 바꿔 보고 기록할 것.

    fragColor = vec4(col, 1.0);
}
