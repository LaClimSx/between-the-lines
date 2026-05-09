shader_type canvas_item;
uniform float start_x = 0.;
uniform float end_x = 0.;

void fragment() {
	float curr_x = FRAGCOORD.x;
	vec4 color = vec4(0., 0., 0., 0.);
	if (curr_x > start_x && curr_x < end_x) {
		color = vec4(0., 0., 0., 1.);
	}

	COLOR=color;
}