shader_type spatial;
render_mode unshaded;

uniform sampler2D BG;

void vertex() {
	VERTEX.x *= 300.0;
	VERTEX.y *= 150.0;
}

void fragment() {
	ALBEDO = texture(BG, UV).rgb;
}
