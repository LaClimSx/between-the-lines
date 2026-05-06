shader_type canvas_item;
uniform float confidence = 1.;

void fragment() {
	float neg_confidence = 1. - confidence;
  	vec4 sample = texture(TEXTURE, UV);
	float greyscale = (sample.x+sample.y+sample.z)/3.;
	COLOR = vec4(vec3(greyscale*neg_confidence + sample.x*confidence, greyscale*neg_confidence + sample.y*confidence, greyscale*neg_confidence + sample.z*confidence),sample.a);
}