extends Node2D


func _ready():
	OS.set_window_maximized(true)
	
func _process(delta):
	if Input.is_action_just_pressed("reset_level"):
		get_tree().change_scene(get_tree().current_scene.filename)
