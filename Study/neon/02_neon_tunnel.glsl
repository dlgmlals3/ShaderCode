// ============================================================
// 02. Neon Tunnel - STEP 2
// 거리로 동심원 만들기
//
// 목표:
//   - r = 중심에서 현재 픽셀까지의 거리.
//   - r에 sin을 걸어 거리 방향으로 반복되는 파동 waves를 만든다.
//   - smoothstep으로 파동의 밝은 부분만 남겨 ringline을 만든다.
//
// 알아야 할 것:
//   - length(uv)는 벡터의 길이, 즉 중심으로부터의 거리다.
//   - 같은 거리 r을 가진 픽셀들은 원 모양으로 모인다.
//   - sin(r * N)에서 N이 커질수록 동심원이 촘촘해진다.
//   - smoothstep(edge0, edge1, x)는 x를 부드럽게 0~1로 바꾼다.
//
// 확인:
//   - 최종적으로 검은 배경에 흰 동심원이 보여야 한다.
//
// 참고 답안:
//   - ans/neon_02_distance_rings.glsl
// 다음:
//   - 03_neon_tunnel.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float waves = sin(r * 100.0);
    float ringline = smoothstep(0.5, 0.95, waves);

    col = vec3(ringline);

    fragColor = vec4(col, 1.0);
}
