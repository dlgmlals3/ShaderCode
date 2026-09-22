// ============================================================
// 05. Neon Tunnel - STEP 5
// 가짜 깊이감 만들기
//
// 목표:
//   - depth = 1.0 / (r + offset)을 만든다.
//   - r 대신 depth를 sin에 넣어 중심 쪽으로 빨려 들어가는 터널 느낌을 만든다.
//   - offset 값을 바꿔 중심에서 너무 강하게 튀는 문제를 확인한다.
//
// 알아야 할 것:
//   - r은 중심에서 0이고 바깥으로 갈수록 커진다.
//   - 1 / r은 반대로 중심에서 매우 커진다.
//   - 그래서 depth를 쓰면 줄무늬가 중심 근처에 몰린다.
//
// 확인:
//   - 단순 동심원이 아니라 중심 쪽으로 줄무늬가 몰리는 터널 느낌이 난다.
//
// 참고 답안:
//   - ans/neon_05_depth_tunnel.glsl
// 다음:
//   - 06_neon_tunnel.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{    
    vec3 waveColor = vec3(1.0, 0.5, 0.0);
    vec3 lineColor = vec3(0.0, 0.5, 0.0);
    

    vec3 col = vec3(0.0);

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float r = length(uv);
    float depth = 1.0 / (r + 0.08);
    /*
    R이 작아질수록 급격하게 커지는 dpeth를 통해 빨려들어가는 듯한 느낌
    r = 1.0  -> depth = 0.93
    r = 0.8  -> depth = 1.14
    r = 0.6  -> depth = 1.47
    r = 0.4  -> depth = 2.08
    r = 0.2  -> depth = 3.57
    r = 0.0  -> depth = 12.5
    */

    //float waves = sin(r * 98. + iTime * 2.0);
    float waves = sin(depth * 5. - iTime * 2.0);

    float d = atan(uv.y, uv.x);
    float lines = sin(d * 20. + iTime * 2.0);
    
    // 눈에 보이지는 않지만 검은색 영역이 음수값임
    // or 연산으로 합치기전에 해당 부분 0으로 만들기 위해 smoothstep 사용
    waves = smoothstep(0.5, 0.95, waves);
    lines = smoothstep(0.88, 0.99, lines);

    col = (waves) * lineColor;
    col += (lines) * lineColor;
    fragColor = vec4(col, 1.0);
}
