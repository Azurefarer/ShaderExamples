shader_type spatial;
//render_mode skip_vertex_transform, unshaded;
render_mode unshaded;

uniform vec4 color : source_color;

void vertex() {
//	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
//	NORMAL = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
}

void fragment() {
	
	ALBEDO = vec3(dot(NORMAL, VIEW));
}

//void light() {
//	float NdotL = dot(NORMAL, LIGHT);
//
//	DIFFUSE_LIGHT = NdotL * ALBEDO;
//}
