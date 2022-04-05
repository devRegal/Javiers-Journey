extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("reset_level"):
		get_tree().change_scene(get_tree().current_scene.filename)


func _on_Down_The_Well_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			var position : Vector2 = get_node("Checkpoints/Checkpoint D1").global_position
			body.last_checkpoint_location = position
			GlobalVariables.last_major_checkpoint_location = position


func _on_Checkpoint_D2_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			body.last_checkpoint_location = get_node("Checkpoints/Checkpoint D2").global_position


func _on_Checkpoint_D3_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			var position : Vector2 = get_node("Checkpoints/Checkpoint D3").global_position
			body.last_checkpoint_location = position
			GlobalVariables.last_major_checkpoint_location = position



func _on_Checkpoint_D4_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			body.last_checkpoint_location = get_node("Checkpoints/Checkpoint D4").global_position
