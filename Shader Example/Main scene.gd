extends Node2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close"):
		get_tree().quit()



#func _unhandled_input(event : InputEvent) -> void:
#	if event is InputEventKey:
#		if event.pressed and event.keycode == KEY_ESCAPE:
#			get_tree().quit()
