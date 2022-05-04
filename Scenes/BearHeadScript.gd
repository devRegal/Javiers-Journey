extends KinematicBody2D


onready var player = get_node("/root/Level 1/Player")
var velocity = Vector2()
export var direction = -1
var movespeed = 10

var gravity = 20




func _on_Timer_timeout():
	queue_free()

func _on_TopChecker_body_entered(body):
	
	if body.is_in_group("Player"):
		
		
		$AnimatedSprite.play("Glasses Breaking")
		
		set_collision_layer_bit(0,false)
		set_collision_mask_bit(0,false)
		$TopChecker.set_collision_layer_bit(0,false)
		$TopChecker.set_collision_mask_bit(0,false)
		
		$SideChecker.set_collision_layer_bit(0,false)
		$SideChecker.set_collision_mask_bit(0,false)
		
	
	
		get_node("CollisionPolygon2D").disabled = true
		get_node( "TopChecker/CollisionShape2D").disabled =true
		get_node( "SideChecker/CollisionPolygon2D").disabled =true

		$Timer.start()
		
		body.vel.y -= 300
		body.vel.x -= 200
		





func _on_SideChecker_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			body.hearts -= 1
			


