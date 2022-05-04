extends CanvasLayer

func _ready():
	OS.set_window_maximized(true)
	GlobalVariables.last_major_checkpoint_location = Vector2(-20, -260)

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Level_1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
