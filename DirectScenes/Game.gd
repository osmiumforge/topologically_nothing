extends Spatial
func _ready():
	$Label.text = "Seed: %s" % ShapeOptions.shape_seed
func _process(_d):
	if Input.is_action_just_pressed("shape_next"):
		ShapeOptions.shape_seed += 1
		ShapeOptions.generate_coefficients()
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("shape_custom"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene("res://DirectScenes/CustomSeed.tscn")
