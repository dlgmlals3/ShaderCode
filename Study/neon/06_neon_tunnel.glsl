// ============================================================
// 06. Neon Tunnel - STEP 6
// 네온 색 입히기
//
// 목표:
//   - colorA, colorB 두 색을 만든다.
//   - t 값을 0~1로 만들어 mix(colorA, colorB, t)에 넣는다.
//   - 흰색 마스크였던 ringline/spokeLine에 색을 곱한다.
//
// 알아야 할 것:
//   - vec3(0.0, 0.85, 1.0)은 RGB 색이다.
//   - mix(A, B, 0.0)은 A, mix(A, B, 1.0)은 B다.
//   - sin 값은 -1~1이므로 *0.5 + 0.5를 하면 0~1이 된다.
//   - 색에 마스크를 곱하면 선이 있는 곳에만 색이 보인다.
//
// 확인:
//   - 검은 배경 위에 두 색이 섞인 네온 선이 보인다.
//
// 참고 답안:
//   - ans/neon_06_color_palette.glsl
// 다음:
//   - 07_neon_tunnel.glsl
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

    float spokes = sin(a * 16.0 + iTime * 0.8);
    float spokeLine = smoothstep(0.88, 1.0, spokes);

    float mask = ringline + spokeLine * 0.45;

    vec3 colorA = vec3(0.0, 0.85, 1.0);
    vec3 colorB = vec3(1.0, 0.15, 0.75);
        
    //float t = sin(a * 2.0 + depth * 0.2 + iTime * 0.5) * 0.5 + 0.5;
    float t = sin(a * 3. + depth * 0.5 + iTime * 1.5) * 0.5 + 0.5;
    vec3 neon = mix(colorA, colorB, t);

    col = neon * mask;

    fragColor = vec4(col, 1.0);
}
