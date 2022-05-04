extends KinematicBody2D

const WALK_SPEED = 100
onready var player = get_node("/root/Level 1/Player")
var velocity = Vector2()
export var direction = -1
var movespeed = 50

var gravity = 20




func _ready():
	var res = load("res://Animations/bear.res") # resource is loaded when line is executed
	
	get_node("AnimatedSprite").frames = res
	
	
	
	if direction == 1 : 
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	
func _physics_process(delta):
	
	if is_on_wall() or not $FloorChecker.is_colliding() and is_on_floor():
		direction = direction * -1
		
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction 
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		
		
		
	
	
	velocity.y += gravity
	 
	velocity.x = movespeed * direction
	
	
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_TopChecker_body_entered(body):
	
	if body.is_in_group("Player"):
		
		
		$AnimatedSprite.play("Angry")
		movespeed = 0
		velocity.y = 0
		gravity = 0
		
		set_collision_layer_bit(0,false)
		set_collision_mask_bit(0,false)
		$TopChecker.set_collision_layer_bit(0,false)
		$TopChecker.set_collision_mask_bit(0,false)
		
		$SideChecker.set_collision_layer_bit(0,false)
		$SideChecker.set_collision_mask_bit(0,false)
		
	
	
		get_node("CollisionShape2D").disabled = true
		get_node( "TopChecker/CollisionShape2D").disabled =true
		get_node( "SideChecker/CollisionShape2D").disabled =true
		
		
		
		
		body.vel.y -= 300
		$Timer.start()


func _on_SideChecker_body_entered(body):
	if body:
		if body.is_in_group("Player"):
			body.hearts -= 1
			



func _on_Timer_timeout():
	queue_free()
