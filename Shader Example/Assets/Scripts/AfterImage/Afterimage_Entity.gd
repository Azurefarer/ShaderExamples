extends GPUParticles2D
# Called when the node enters the scene tree for the first time.
@export var viewportTexture : bool
func _ready():
	if !viewportTexture:
		texture = get_parent().texture

func _process(delta):
	process_material.set_shader_parameter("tex_anim_offset",(get_parent().frame+0.0)/(get_parent().hframes-1))
