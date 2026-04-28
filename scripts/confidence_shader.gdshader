shader_type canvas_item;
uniform float confidence;


void fragment() {
  COLOR = texture(TEXTURE, UV); // Read from texture again.
  COLOR.b = 1.0; //set blue channel to 1.0
}