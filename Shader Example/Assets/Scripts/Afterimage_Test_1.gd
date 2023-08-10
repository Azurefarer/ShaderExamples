extends Control

var startPos = Vector2(0,0)
var camStartPos = Vector2(0,0)
var superOngoing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = $Ken.position
	camStartPos = $Camera2D.position
	$ElenaStage/AnimationPlayer.play("BG")
	$Ken/KEN_ANIM.play("Stance")
	$SubViewport/paletteKEN/PaletteKEN_ANIM.play("Stance")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reset_pressed():
	if superOngoing:
		return
	$Ken.position = startPos
	$SubViewport/paletteKEN.position = startPos
	$Camera2D.position = camStartPos
	$Ken/KEN_ANIM.play("Stance")
	$SubViewport/paletteKEN/PaletteKEN_ANIM.play("Stance")
	superOngoing = false


func _on_super_1_pressed():
	if superOngoing:
		return
	superOngoing = true
	$Ken/KEN_ANIM.play("Super1")
	$SubViewport/paletteKEN/PaletteKEN_ANIM.play("Super1")
	await get_tree().create_timer(2.2).timeout
	$Ken/KEN_ANIM.play("Stance")
	$SubViewport/paletteKEN/PaletteKEN_ANIM.play("Stance")
	superOngoing = false
