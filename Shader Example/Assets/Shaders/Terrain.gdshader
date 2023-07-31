shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap;




void fragment() {
	
	vec4 SCREEN = textureLod(SCREEN_TEXTURE, SCREEN_UV, 1.0);
	
	
	COLOR = SCREEN;
	
}
