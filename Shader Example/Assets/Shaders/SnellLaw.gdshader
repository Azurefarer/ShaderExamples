// Simple, N1 - N2, Snell's Law shader
// Total Internal Reflection shader
shader_type spatial;
render_mode unshaded;

uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D depth : hint_depth_texture, filter_linear_mipmap;

uniform float n1;
uniform float n2;

uniform vec4 window_tint : source_color;

uniform float bluriness : hint_range(0.0, 5.0, 0.1);

vec3 rot3(vec3 baseV, float theta_i, float theta_r) {
	float thetaDiff = theta_i - theta_r;
	mat3 rotM = mat3 (vec3(cos(thetaDiff), -sin(thetaDiff), 0.0), vec3(sin(thetaDiff), cos(thetaDiff), 0.0), vec3(0.0, 0.0, 1.0));
	vec3 rotV = rotM * baseV;
	return rotV;
}

void vertex() {

}

void fragment() {
// Critical Angle
	float critical_angle = asin(n2/n1);
// Snell's Law
	float incident_angle = acos(dot(NORMAL, VIEW));
	float refrac_angle = asin((n1 / n2) * sin(clamp(incident_angle, 0.0, critical_angle)));
	
	vec3 refrac_unit_CDW = rot3(VIEW, incident_angle, refrac_angle);
	vec3 refrac_offset = .01 * (refrac_unit_CDW - VIEW);
	vec2 refrac_SCREEN_UV = vec2(SCREEN_UV.x + refrac_offset.x, SCREEN_UV.y + refrac_offset.y);
	
	vec3 screen_texture_refrac = textureLod(screen, refrac_SCREEN_UV, bluriness).rgb;
	
	ALBEDO = screen_texture_refrac;
}
