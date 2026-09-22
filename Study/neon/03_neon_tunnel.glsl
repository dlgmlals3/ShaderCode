// ============================================================
// 03. Neon Tunnel - STEP 3
// 시간으로 동심원 움직이기
//
// 목표:
//   - STEP 2의 waves 안에 iTime을 더하거나 빼서 움직임을 만든다.
//   - iTime * speed 에서 speed 값으로 속도를 조절한다.
//   - +iTime과 -iTime의 방향 차이를 직접 비교한다.
//
// 알아야 할 것:
//   - iTime은 초 단위로 계속 증가하는 시간 값이다.
//   - sin(r * N - iTime * speed)는 시간이 지나며 줄무늬가 이동해 보인다.
//   - 부호를 바꾸면 움직이는 방향이 반대로 보인다.
//
// 확인:
//   - 동심원이 멈춰 있지 않고 계속 안쪽/바깥쪽으로 움직인다.
//
// 참고 답안:
//   - ans/neon_03_time_motion.glsl
// 다음:
//   - 04_neon_tunnel.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float waves = sin(r * 100.0 - iTime * 4.0);
    float ringline = smoothstep(0.5, 0.95, waves);

    col = vec3(ringline);

    fragColor = vec4(col, 1.0);
}
