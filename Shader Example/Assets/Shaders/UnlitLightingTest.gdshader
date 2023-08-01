shader_type spatial;

void vertex() {
	NORMAL = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
}

void fragment() {
	ALBEDO = NORMAL;
}

void light() {

	vec3 L = (INV_VIEW_MATRIX * vec4(LIGHT, 0.0)).xyz;

	DIFFUSE_LIGHT += L;

}
