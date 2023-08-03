shader_type spatial;


uniform vec3 soil1 : source_color;
uniform vec3 soil2 : source_color;
uniform vec3 grass : source_color;

uniform sampler2D normal1 : filter_linear_mipmap;
uniform sampler2D normal2 : filter_linear_mipmap;


void vertex() {
	vec3 soil = mix(soil1, soil2, VERTEX.y);
	VERTEX.y = texture(normal1, UV).x * texture(normal2, UV).z;
	COLOR.rgb = mix(soil, grass, VERTEX.y);
	
}

void fragment() {
	ALBEDO = COLOR.rgb;
}

void light() {
	float NdotL = dot(NORMAL, LIGHT) * ATTENUATION;
	
	DIFFUSE_LIGHT = ALBEDO * LIGHT_COLOR.rgb * NdotL;
	
}
