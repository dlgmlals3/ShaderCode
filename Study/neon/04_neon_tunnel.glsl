// ============================================================
// 04. Neon Tunnel - STEP 4
// 각도로 방사형 선 만들기
//
// 목표:
//   - a = 중심 기준 현재 픽셀의 각도. atan 사용.
//   - a에 sin을 걸어 중심에서 뻗어나가는 spokeLine을 만든다.
//   - a에 iTime을 더해 천천히 회전시킨다.
//   - col에 ringline과 spokeLine을 같이 넣는다. 더하기/곱하기 둘 다 시험한다.
//
// 알아야 할 것:
//   - atan(y, x)의 결과 범위는 -PI ~ PI.
//   - 오른쪽은 0, 위는 +PI/2, 왼쪽은 +-PI, 아래는 -PI/2.
//   - 같은 각도 a를 가진 픽셀들은 중심에서 바깥으로 뻗는 선 위에 모인다.
//   - length는 거리, atan은 방향이다. 둘을 합쳐 극좌표라고 부른다.
//
// 확인:
//   - col = vec3(a); 로 찍어보면 방향에 따라 밝기가 달라진다.
//   - 최종적으로 동심원 + 방사형 선이 같이 보여야 한다.
//
// 참고 답안:
//   - ans/neon_04_angle_spokes.glsl
// 다음:
//   - 05_neon_tunnel.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);    
    float waves = sin(r * 100.0 - iTime * 2.8);

    float deg = atan(uv.y, uv.x);
    float spoke = sin(deg * 15.0 + iTime * .8);
    float col1 = smoothstep(0.0, 0.9, waves);
    float col2 = smoothstep(0.88, 0.99, spoke);
    
    col = vec3(col1 + col2 * 0.5);
    fragColor = vec4(col, 1.0);
}
