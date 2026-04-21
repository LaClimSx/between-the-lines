shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float warmth : hint_range(-1.0, 1.0) = 0.0;
// -1.0 = cooler, 0 = neutral, 1.0 = warmer

void fragment() {
    vec4 src = textureLod(screen_texture, SCREEN_UV, 0.0);

    // Simple temperature shift
    vec3 warm_tint = vec3(1.08, 1.00, 0.92);
    vec3 cool_tint = vec3(0.92, 1.00, 1.08);

    vec3 tinted = src.rgb;
    if (warmth > 0.0) {
        tinted = mix(src.rgb, src.rgb * warm_tint, warmth);
    } else {
        tinted = mix(src.rgb, src.rgb * cool_tint, -warmth);
    }

    COLOR = vec4(tinted, src.a);
}