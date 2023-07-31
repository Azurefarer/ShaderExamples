shader_type particles;

uniform float scale;


void start() {
	if (RESTART_POSITION) {
		TRANSFORM = mat4(vec4(scale,0,0,0),vec4(0,scale,0,0),vec4(0,0,1,0),vec4(0,0,0,1));
	}
		TRANSFORM = EMISSION_TRANSFORM * TRANSFORM;
}

void process() {
	CUSTOM.y += DELTA / LIFETIME;
	float phase = float(NUMBER % uint(6));	//NUMBER increments by one with each particle
	float phaseScale = phase / 6.0;
	
	if (RESTART) {
		VELOCITY.x = 500.0;

		TRANSFORM[0] = vec4(phase/6.0, 0.0, 0.0, 0.0);
		TRANSFORM[1] = vec4(0.0, phase/6.0, 0.0, 0.0);	
		CUSTOM.y = 0.0;
	}
	
	COLOR.a = 1.0 - phase/6.0;

}
