shader_type particles;

uniform float scale : hint_range(0.0, 2.0, .05);


void start() {
	if (RESTART_POSITION) {
		TRANSFORM = mat4(vec4(scale,0,0,0),vec4(0,scale,0,0),vec4(0,0,1,0),vec4(0,0,0,1));
	}
		TRANSFORM = EMISSION_TRANSFORM * TRANSFORM;
		
}

void process() {
	if (RESTART) {
//		TRANSFORM[0] = vec4(0.1*cos(TIME), 0.1*sin(TIME), 0.0, 0.001*sin(TIME));		//X AXIS SCALE
//		TRANSFORM[1] = vec4(-0.1*sin(TIME), 0.1*cos(TIME), 0.0, 0.0);	//Y AXIS SCALE
//		TRANSFORM[2] = vec4(0.0, 0.0, 0.0, 0.1);							//Z AXIS SCALE
//		TRANSFORM[3] = EMISSION_TRANSFORM[3];								//POSITION

		COLOR.a = 1.0;
		CUSTOM.y = 0.0;
	}
	

	CUSTOM.y += DELTA / LIFETIME;
	CUSTOM.w = 1.0;

	COLOR.a = 1.0 - CUSTOM.y;
	
}
