/*

Toon Shader by Bluesailor

3 components:
Two-tone shading : Specular highlights (for flair) : Rim Lighting

*/
shader_type spatial;
render_mode ambient_light_disabled, skip_vertex_transform;

uniform vec4 color : source_color = vec4(1.0);
uniform sampler2D tex : source_color, hint_default_white;

uniform float light_energy : hint_range(0.0, 1.0, 0.05);

uniform float shadow : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float shadow_width : hint_range(0.001, 0.5, 0.05) = 0.0;
uniform vec4 shadow_color : source_color;

uniform float shininess : hint_range(0.0, 0.5) = 0.1;
uniform float specular_intensity : hint_range(0.0, 0.25, 0.025) = 0.075;
uniform float specular_smoothness : hint_range(0.0,0.5) = 0.01;

uniform float rim_smoothness : hint_range(0.0, 0.5, 0.05);
uniform float rim_tolerance : hint_range(0.0, 1.0, 0.05);

void vertex() {
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	NORMAL = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
	
}

void fragment() {

//	ALBEDO = NORMAL;

	ALBEDO = pow(texture(tex, UV).rgb, vec3(1.0)) * color.rgb;
	
}

void light(){
	
//Two-Tone Shading
//	float two_tone;
	float NdotL = dot(NORMAL, LIGHT) * ATTENUATION;
	NdotL = mix(shadow - shadow_width, shadow + shadow_width, NdotL);	
//	if (NdotL < .5) {
//		two_tone = 0.0;
//	}
//	if (NdotL >= .5) {
//		two_tone = 1.0;
//	}
	
//Specular Lighting
/*
NOTE:
PHONG Shading
SPECULAR RGB = LIGHT_COLOR * ALBEDO * specular_intensity(material) *
					(COSINE(angle between VIEWER and REFLECTED LIGHT) *
					MAGNITUDE of VIEW vecter and REFLECTION vector)
					raised to the power of the SPECULAR POWER(shininess value)
specular.rgb = LIGHT_COLOR.rgb * ALBEDO * specular_intensity * dot(VIEW, LIGHT) ** shininess
*/
	vec3 specular;
//	specular.rgb = mix(LIGHT_COLOR.rgb,  ALBEDO, 0.5) * specular_intensity * pow(dot(VIEW, LIGHT), shininess);
	vec3 H = normalize(VIEW + LIGHT);
	float NdotH = max(0, dot(NORMAL, H));
	float specular_strength = pow(NdotH, 1.0 / shininess);
	specular = vec3(smoothstep(0.5 - specular_smoothness, 0.5 + specular_smoothness, specular_strength));
	
//Rim lighting
//	vec3 rim;
//	float NdotV = 1.0 - dot(normalize(NORMAL), normalize(VIEW));
//	float rimIntensity = NdotV * NdotL;
//
//	rim = vec3(mix(1.0 - rim_tolerance - rim_smoothness, 1.0 - rim_tolerance + rim_smoothness, rimIntensity));

	// rim
	float rimDot = 1.0 - dot(VIEW, NORMAL);
	float rimIntensity = rimDot * NdotL;
	vec3 rim = vec3(smoothstep(1.0 - rim_tolerance - rim_smoothness, 1.0 - rim_tolerance + rim_smoothness, rimIntensity));
	
	
	DIFFUSE_LIGHT += mix(ALBEDO * shadow_color.rgb, (ALBEDO + (rim + specular) * specular_strength) * LIGHT_COLOR.rgb * 0.33, NdotL + 0.33 * (smoothstep(1.0 - rim_tolerance - rim_smoothness, 1.0 - rim_tolerance + rim_smoothness, rimIntensity)));


}
