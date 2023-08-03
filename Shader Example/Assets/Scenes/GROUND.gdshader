shader_type spatial;


uniform sampler2D normal;


void vertex() {
	VERTEX.y = mix(texture(normal, UV).x, texture(normal, UV).y, 0.5);
	COLOR.rgb = VERTEX;
	
}

void fragment() {
	ALBEDO = COLOR.rgb;
}
