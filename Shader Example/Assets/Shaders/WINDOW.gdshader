shader_type spatial;
render_mode unshaded;

uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D depth : hint_depth_texture, filter_linear_mipmap;

uniform vec4 window_tint : source_color;

uniform float bluriness : hint_range(0.0, 5.0, 0.1);

void vertex() {
	VERTEX *= 2.5;
}

void fragment() {
	
	vec3 screen_texture = textureLod(screen, SCREEN_UV, bluriness).rgb;

//	vec3 refrac = 1.0 - 0.005 * dot(NORMAL, CAMERA_DIRECTION_WORLD) * normalize(CAMERA_DIRECTION_WORLD);
	vec3 refrac = 1.0 - 0.1 * dot(NORMAL, VIEW) * normalize(VIEW);
	vec2 light_offset = vec2(SCREEN_UV.x + refrac.x, SCREEN_UV.y + refrac.y);
	
	vec3 screen_texture_refrac = textureLod(screen, light_offset, bluriness).rgb;
	ALBEDO = mix(screen_texture, screen_texture_refrac, 1.0);
//	ALPHA = 0.8;
}
