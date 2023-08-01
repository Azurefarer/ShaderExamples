extends GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = get_parent().texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	doBasicParticleProcessMaterial()
	process_material.set_shader_parameter("tex_anim_offset",(get_parent().frame+0.0)/(get_parent().hframes-1))

func doBasicParticleProcessMaterial():
	$GPUParticles2D.process_material.anim_offset_max = (get_parent().frame+0.0)/get_parent().hframes
	$GPUParticles2D.process_material.anim_offset_min = $GPUParticles2D.process_material.anim_offset_max
