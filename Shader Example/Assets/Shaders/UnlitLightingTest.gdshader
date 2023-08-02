shader_type spatial;

uniform sampler2D tex : hint_default_white;

void vertex() {
	NORMAL = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
}

void fragment() {
	ALBEDO = texture(tex, UV).rgb;

}

void light() {
	float NdotL = dot(NORMAL, LIGHT);
	
	DIFFUSE_LIGHT = NdotL * ALBEDO;
	

}
