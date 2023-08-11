shader_type spatial;
render_mode cull_disabled;

uniform sampler2D walls : filter_linear_mipmap;

void vertex() {
	
}

void fragment() {
	vec4 wallTex = texture(walls, vec2(UV.x, clamp(UV.y, 0.25, 0.75)));
	ALBEDO = wallTex.rgb;
//	ALBEDO = vec3(UV, 0.0);
}