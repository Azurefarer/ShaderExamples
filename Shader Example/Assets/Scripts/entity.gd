extends CharacterBody3D

var mouse_pos


func _ready() -> void:
	pass
	
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		mouse_pos = event.position
		print(event.position)
		$PIVOT.look_at(Vector3(mouse_pos.x, 0.0, mouse_pos.y))
	if Input.is_action_pressed("forward"):
		velocity.z = -10.0
	if Input.is_action_pressed("back"):
		velocity.z = 10.0
	if Input.is_action_pressed("left"):
		velocity.x = -10.0
	if Input.is_action_pressed("right"):
		velocity.x = 10.0
	if Input.is_action_just_released("forward"):
		velocity.z = 0.0
	if Input.is_action_just_released("back"):
		velocity.z = 0.0
	if Input.is_action_just_released("left"):
		velocity.x = 0.0
	if Input.is_action_just_released("right"):
		velocity.x = 0.0			
	
func _process(delta: float) -> void:
	
	
	
	move_and_slide()
	
