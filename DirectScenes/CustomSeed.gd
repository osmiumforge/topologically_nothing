extends Control



func _start():
	ShapeOptions.shape_seed = int($VBoxContainer/SpinBox.value)
	get_tree().change_scene("res://DirectScenes/Game.tscn")
