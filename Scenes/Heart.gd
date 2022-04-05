extends Node2D



func _on_Area2D_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			if body.hearts < 3:
				body.hearts += 1
				queue_free()
