/*

Toon Shader by Bluesailor

3 components:
Two-tone shading : Specular highlights (for flair) : Rim Lighting

*/
shader_type spatial;
render_mode ambient_light_disabled;

uniform vec4 color : source_color = vec4(1.0);
uniform sampler2D tex : source_color, hint_default_white;

uniform float light_energy : hint_range(0.0, 1.0, 0.05);

uniform float shadow : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float shadow_width : hint_range(0.001, 0.5, 0.05) = 0.0;
uniform vec4 shadow_color: source_color = vec4(0.705);

uniform float _specular_smoothness : hint_range(0.0, 0.5) = 0.01;
uniform float _specular_strength : hint_range(0.0, 0.25, 0.025) = 0.075;
uniform float _glossiness : hint_range(0.0, 0.5) = 0.1;
uniform float shininess : hint_range(0.0, 0.5) = 0.1;
uniform float specular_intensity : hint_range(0.0, 0.25, 0.025) = 0.075;

uniform float _rim_size : hint_range(0, 1, 0.05) = 0.5;
uniform float _rim_smoothness : hint_range(0.0, 0.5, 0.025) = 0.01;
uniform float rim_tolerance : hint_range(0.0, 1.0, 0.05);



void fragment() {

	ALBEDO = COLOR.rgb;

//	ALBEDO = pow(texture(tex, UV).rgb, vec3(1.0)) * color.rgb;
	
}

void light(){
	
//Two-Tone Shading
	float two_tone;
	float NdotL = dot(NORMAL, LIGHT);
	
	if (NdotL < .5) {
		two_tone = 0.0;
	}
	if (NdotL >= .5) {
		two_tone = 1.0;
	}
	
//Specular Lighting
/*
NOTE:
SPECULAR RGB = LIGHT_COLOR * ALBEDO * specular_intensity(material) *
					(COSINE(angle between VIEWER and REFLECTED LIGHT) *
					MAGNITUDE of VIEW vecter and REFLECTION vector)
					raised to the power of the SPECULAR POWER(shininess value)
specular.rgb = LIGHT_COLOR.rgb * ALBEDO * specular_intensity * dot(VIEW, LIGHT) ** shininess
*/
	vec3 specular;
	specular.rgb = LIGHT_COLOR.rgb * ALBEDO * specular_intensity * pow(dot(VIEW, LIGHT), shininess);
	
//Rim lighting
	float rim;
	float NdotV = dot(normalize(NORMAL), normalize(VIEW));
	if (NdotV < rim_tolerance) {
		rim = 0.0;
	}
	if (NdotV >= rim_tolerance) {
		rim = 1.0;
	}
	
	
	
	DIFFUSE_LIGHT += vec3(mix(two_tone * ALBEDO, rim * ALBEDO, 0.1));// * (LIGHT_COLOR.rgb * light_energy);
	SPECULAR_LIGHT += specular;

}
