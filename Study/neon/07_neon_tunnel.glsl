// ============================================================
// 07. Neon Tunnel - STEP 7
// Glow 만들기
//
// 목표:
//   - glow = 작은수 / (abs(waves) + 작은수)를 만든다.
//   - centerGlow = 작은수 / (r + 작은수)를 만든다.
//   - hard line과 glow를 더해 네온처럼 번지는 빛을 만든다.
//   - 마지막에 1.0 - exp(-col)로 너무 강한 빛을 부드럽게 눌러준다.
//
// 알아야 할 것:
//   - abs(waves)는 waves가 0에 가까운 곳을 찾기 쉽게 한다.
//   - 분모가 0에 가까우면 값이 커지므로 빛 번짐처럼 보인다.
//   - 분모에 작은 값을 더하지 않으면 너무 밝게 터질 수 있다.
//
// 확인:
//   - 단색 선이 아니라 주변이 번지는 네온 느낌이 난다.
//
// 참고 답안:
//   - ans/neon_07_glow.glsl
// 다음:
//   - 08_neon_tunnel.glsl
// ============================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 col = vec3(0.0);

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float r = length(uv); 
    float depth = 1.0 / (r + 0.05);

    float deg = atan(uv.y, uv.x);
    float wave = sin(depth * 2.0 - iTime * 2.0);
    float laser = sin(deg * 13.0 + iTime * 2.8);
    float farRadius = smoothstep(0.0, 0.05, r);
    // [TODO 1] glow용 원본값 보관
    //   - smoothstep을 거치면 wave/laser가 0~1 마스크로 바뀌어서
    //     "선 중심에서 얼마나 떨어졌는지" 정보가 사라진다.
    //   - smoothstep 하기 전의 sin 값을 다른 변수에 따로 남겨둘 것.
    //     (예: waveRaw, laserRaw 같은 이름)
    //   - 선의 중심은 sin이 1.0인 곳이므로, glow 분모에는
    //     abs(1.0 - raw) 또는 (1.0 - raw)를 쓰면 중심에서 0이 된다.

    float wavec = smoothstep(0.7, 0.95, wave);
    float laserc = smoothstep(0.3, 0.95, laser);
    float mask = mix(wavec, 1.0, laserc) * farRadius;

    // [TODO 2] 선 주변 glow 만들기
    //   - glow = 작은수 / (선 중심과의 거리 + 작은수)
    //   - wave용, laser용 각각 하나씩 만든다.
    //   - "작은수"를 0.01, 0.05, 0.1로 바꿔보며 번짐 폭이 어떻게 변하는지 볼 것.
    //   - 두 glow도 mask처럼 screen(mix(a, 1.0, b))이나 덧셈으로 합친다.
    //   - farRadius를 곱해서 중심 구멍은 그대로 어둡게 유지한다.
    float glow = 0.2 / (abs(wave) + 0.535);
    glow = glow * farRadius;

    // [TODO 3] 중심 glow 만들기
    //   - centerGlow = 작은수 / (r + 작은수)
    //   - 터널 끝(화면 중심)에서 빛이 새어나오는 느낌.
    //   - 너무 세면 화면 전체가 하얘지니 작은수를 작게 잡을 것.
    float centerGlow = 0.01 / (r + 0.003);

    float t = sin(deg * 2.0 + iTime * 0.5) * 0.5 + 0.5;
    vec3 waveColor = vec3(0.0, 0.85, 1.0);
    vec3 laserColor = vec3(1.0, 0.15, 0.75);
    col = mix(waveColor, laserColor, t) * mask;

    // [TODO 4] hard line + glow 합치기
    //   - col에 (색상 * glow)를 더한다. mask처럼 곱하는 게 아니라 "더하기".
    //   - centerGlow는 흰색이나 waveColor에 곱해서 더해본다.
    //   - 더한 뒤 값이 1.0을 넘는 픽셀이 생기는 게 정상이다. (다음 단계에서 누른다)
    col = col + (waveColor * glow) + (laserColor * centerGlow);


// [TODO 5] 톤 매핑    
    col = 1.0 - exp(-col);
    
    fragColor = vec4(col, 1.0);
}
