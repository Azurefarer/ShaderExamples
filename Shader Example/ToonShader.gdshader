/*

Toon Shader by Bluesailor

3 components:
Two-tone shading : Specular highlights (for flair) : Rim Lighting

*/
shader_type spatial;
render_mode ambient_light_disabled;

uniform vec4 color : source_color = vec4(1.0);
uniform sampler2D tex : source_color, hint_default_white;

uniform float shadow : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float shadow_width : hint_range(0.001, 0.5, 0.05) = 0.0;
uniform vec4 shadow_color: source_color = vec4(0.705);

uniform float _specular_smoothness : hint_range(0.0, 0.5) = 0.01;
uniform float _specular_strength : hint_range(0.0, 0.25, 0.025) = 0.075;
uniform float _glossiness : hint_range(0.0, 0.5) = 0.1;

uniform float _rim_size : hint_range(0, 1, 0.05) = 0.5;
uniform float _rim_smoothness : hint_range(0.0, 0.5, 0.025) = 0.01;



void fragment() {

	ALBEDO = COLOR.rgb;

//	ALBEDO = pow(texture(tex, UV).rgb, vec3(1.0)) * color.rgb;
	
}

void light(){
	
 //Two-Tone Shading
	float toonFinal;
	float toon = dot(NORMAL, LIGHT);
	if (toon < .5) {
		toonFinal = 0.0;
	} 
	if (toon >= .5) {
		toonFinal = 1.0;
	}

	DIFFUSE_LIGHT += toonFinal * ALBEDO;

	
}
