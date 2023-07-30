/*

Toon Shader by Bluesailor

3 components:
Two-tone shading : Specular highlights (for flair) : Rim Lighting

*/
shader_type spatial;
render_mode ambient_light_disabled;

uniform vec4 color : source_color = vec4(1.0);
uniform sampler2D tex : source_color, hint_default_white;

uniform float shadow : hint_range(0.0, 1.0) = 0.5;
uniform float shadow_width : hint_range(0.001, 0.5) = 0.0;
uniform vec4 shadow_color: source_color = vec4(0.705);

uniform float _specular_smoothness : hint_range(0.0,0.5) = 0.01;
uniform float _specular_strength : hint_range(0.0,0.25) = 0.075;
uniform float _glossiness : hint_range(0.0,0.5) = 0.1;

uniform float _rim_size : hint_range(0,1) = 0.5;
uniform float _rim_smoothness : hint_range(0.0,0.5) = 0.01;



void fragment() {
	
//	float colorval = .25*sin(TIME*2.0) + .5;
//
//	ALBEDO = vec3(colorval, colorval + 0.1, colorval + 0.1);
//	RIM = 1.0;
//	RIM_TINT = 0.0;

	ALBEDO = pow(texture(tex, UV).rgb, vec3(1.0)) * color.rgb;
	
}

void light(){
/* Two-Tone Shading
	float toonFinal;
	float toon = dot(NORMAL, LIGHT);
	if (toon < .5) {
		toonFinal = 0.0;
	} 
	if (toon >= .5) {
		toonFinal = 1.0;
	}
*/
	float NdotL = dot(NORMAL, LIGHT) * ATTENUATION;
	NdotL = smoothstep(shadow - shadow_width, shadow + shadow_width, NdotL);
	
	// specular
	vec3 H = normalize(VIEW + LIGHT);
	float NdotH = max(0, dot(NORMAL, H));
	float specular_intensity = pow(NdotH, 1.0 / _glossiness);
	vec3 specular = vec3(smoothstep(0.5 - _specular_smoothness, 0.5 + _specular_smoothness, specular_intensity));
	
	// rim
	float rimDot = 1.0 - dot(VIEW, NORMAL);
	float rim_intensity = rimDot * NdotL;
	vec3 rim = vec3(smoothstep(1.0 -_rim_size - _rim_smoothness, 1.0 -_rim_size + _rim_smoothness, rim_intensity));

DIFFUSE_LIGHT = mix(ALBEDO * shadow_color.rgb, (ALBEDO + (rim + specular) * _specular_strength) * LIGHT_COLOR.rgb * 0.33, NdotL + 0.33 * (smoothstep(1.0 -_rim_size - _rim_smoothness, 1.0 -_rim_size + _rim_smoothness, rimDot)));


//	DIFFUSE_LIGHT += toonFinal  * ALBEDO;

	
}
