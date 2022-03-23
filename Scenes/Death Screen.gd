extends Node2D


func _on_Yes_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_1.tscn")

func _on_No_Button_pressed():
	get_tree().change_scene("res://Scenes/Start Screen.tscn")
