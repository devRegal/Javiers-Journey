extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_maximized(true)
	
func _process(delta):
	if Input.is_action_just_pressed("reset_level"):
		get_tree().change_scene(get_tree().current_scene.filename)
