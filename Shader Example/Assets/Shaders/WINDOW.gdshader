shader_type spatial;
render_mode unshaded;

uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D depth : hint_depth_texture, filter_linear_mipmap;

uniform float bluriness : hint_range(0.0, 5.0, 0.1);



void fragment() {
	vec3 screen_texture = textureLod(screen, SCREEN_UV, bluriness).rgb;
	ALBEDO = screen_texture;
}
