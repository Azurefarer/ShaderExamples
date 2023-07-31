shader_type particles;

uniform float scale : hint_range(0.0, 2.0, .05);


uniform float tex_anim_speed : hint_range(0, 23, 1);


void start() {
//
//	float tex_anim_offset;
//
	if (RESTART_POSITION) {
		TRANSFORM = mat4(vec4(scale,0,0,0),vec4(0,scale,0,0),vec4(0,0,1,0),vec4(0,0,0,1));
	}
		TRANSFORM = EMISSION_TRANSFORM * TRANSFORM;
//		CUSTOM.z = tex_anim_offset;
		
}

void process() {
	
	float tex_anim_offset;
	
	if (RESTART) {
//		TRANSFORM[0] = vec4(0.1*cos(TIME), 0.1*sin(TIME), 0.0, 0.001*sin(TIME));		//X AXIS SCALE
//		TRANSFORM[1] = vec4(-0.1*sin(TIME), 0.1*cos(TIME), 0.0, 0.0);	//Y AXIS SCALE
//		TRANSFORM[2] = vec4(0.0, 0.0, 0.0, 0.1);							//Z AXIS SCALE
//		TRANSFORM[3] = EMISSION_TRANSFORM[3];								//POSITION
		tex_anim_offset = 3.0 /23.0;
		COLOR.a = 1.0;
		CUSTOM.y = 0.0;
	}
	
	
	CUSTOM.y += DELTA / LIFETIME;
	float tv = CUSTOM.y / CUSTOM.w;
	
	CUSTOM.z = (tex_anim_offset) + tv * tex_anim_speed;

	
	CUSTOM.w = 1.0;

	COLOR.a = 1.0 - CUSTOM.y;
	
}
