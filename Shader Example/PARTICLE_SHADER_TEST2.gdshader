shader_type particles;

uniform bool fadeCont; //if TRUE after image will continuously fade
uniform float fadeStep : hint_range(2.0, 10.0); //if fadeCont = FALSE this is the rate at which the after image will fade
uniform float scale : hint_range(0.0, 2.0, .05) = 1.0;
uniform float red : hint_range(0.0, 0.2, 0.005);
uniform float green : hint_range(0.0, 0.2, 0.005);
uniform float blue : hint_range(0.0, 0.2, 0.005);
uniform float tex_anim_offset;

void start() {

	if (RESTART_POSITION) {
		TRANSFORM = mat4(vec4(scale,0,0,0),vec4(0,scale,0,0),vec4(0,0,1,0),vec4(0,0,0,1));
	}
		TRANSFORM = EMISSION_TRANSFORM * TRANSFORM;
}

void process() {
	CUSTOM.y += DELTA / LIFETIME;
	CUSTOM.w = 1.0;
	float tv = CUSTOM.y / CUSTOM.w;

	
	COLOR.rgb = vec3(COLOR.r * red, COLOR.g * green, COLOR.b * blue) * 10.0;
	
	if (fadeCont) {
		COLOR.a = 1.0 - tv;
	} else {
		COLOR.a = floor((1.0 - tv) * fadeStep) / fadeStep;
		}
	if (RESTART) {
		CUSTOM.z = tex_anim_offset;	
		CUSTOM.y = 0.0;
		COLOR = vec4(1.0);
	}


}
