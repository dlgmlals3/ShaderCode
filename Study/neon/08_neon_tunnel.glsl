// ============================================================
// 08. Neon Tunnel - STEP 8
// 마무리 연출
//
// 목표:
//   - vignette로 화면 가장자리를 어둡게 만든다.
//   - depth와 angle을 조금 섞어 spokeLine에 약한 나선 느낌을 준다.
//   - 최종 col = neon * mask * vignette 구조를 정리한다.
//
// 알아야 할 것:
//   - smoothstep(0.95, 0.15, r)처럼 edge0 > edge1이면 중심은 밝고 바깥은 어둡다.
//   - vignette는 더하는 값이 아니라 곱하는 마스크다.
//   - depth + angle 조합을 쓰면 동심원/방사형 선이 살짝 비틀린다.
//
// 확인:
//   - 10초 이상 봐도 괜찮은 네온 터널 루프처럼 보인다.
//
// 참고 답안:
//   - ans/neon_08_final_build.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float r = length(uv);
    float a = atan(uv.y, uv.x);
    float depth = 1.0 / (r + 0.08);

    float waves = sin(depth * 8.0 - iTime * 4.0);
    float ringline = smoothstep(0.55, 0.95, waves);

    float spokes = sin(a * 16.0 + depth * 0.35 + iTime * 0.25);
    float spokeLine = smoothstep(0.88, 1.0, spokes);

    float glow = 0.025 / (abs(waves) + 0.035);
    float centerGlow = 0.015 / (r + 0.02);
    float mask = ringline + spokeLine * 0.45 + glow * 0.35 + centerGlow;

    vec3 colorA = vec3(0.0, 0.85, 1.0);
    vec3 colorB = vec3(1.0, 0.15, 0.75);
    float t = sin(a * 2.0 + depth * 0.2 + iTime * 0.5) * 0.5 + 0.5;
    vec3 neon = mix(colorA, colorB, t);

    float vignette = smoothstep(0.95, 0.15, r);

    col = neon * mask * vignette;
    col = 1.0 - exp(-col);

    fragColor = vec4(col, 1.0);
}
