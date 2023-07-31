shader_type canvas_item;

uniform sampler2D gradient;
uniform sampler2D tex : repeat_enable, filter_linear_mipmap;



void fragment() {
	vec4 sampled_wave = textureLod(tex, UV, 1.0);
	vec4 vingette = texture(gradient, UV);
	
	sampled_wave.a = vingette.r;
	
	
	COLOR = sampled_wave;
}
