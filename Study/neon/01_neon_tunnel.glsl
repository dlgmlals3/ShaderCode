// ============================================================
// 01. Neon Tunnel - STEP 1
// 중심 UV 만들기
//
// 목표:
//   - fragCoord를 화면 중심 기준 좌표 uv로 바꾼다.
//   - 화면 비율이 달라도 모양이 찌그러지지 않게 iResolution.y로 나눈다.
//
// 알아야 할 것:
//   - fragCoord는 픽셀 좌표다. 왼쪽 아래가 (0,0), 오른쪽 위가 iResolution.xy.
//   - fragCoord - 0.5 * iResolution.xy 를 하면 화면 중심이 (0,0)이 된다.
//   - x, y를 둘 다 iResolution.y로 나누면 원이 원으로 보인다.
//
// 확인:
//   - col = vec3(uv, 0.0); 로 찍으면 오른쪽 위가 밝고 왼쪽 아래가 어둡다.
//
// 참고 답안:
//   - ans/neon_01_uv_grid.glsl
// 다음:
//   - 02_neon_tunnel.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    col = vec3(uv, 0.0);

    fragColor = vec4(col, 1.0);
}
