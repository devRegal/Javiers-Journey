extends KinematicBody2D


var vel : Vector2 = Vector2()
var input_direction : Vector2 = Vector2()

export var top_speed : int = 45
export var acceleration : int = 65
export var deceleration : int = 80
export var speed_power : float = 0.96

export var jump_force : int = 80
var jump_timer : float = 0.0
var coyote_time : float = 0.1
export var gravity : int = 160
export var jump_cut_mult : float = 0.8
export var fall_gravity_mult : float = 2.0

var double_jump_available : bool = true

export var slide_gravity : int = 30

var state : String = "idle"
var direction : String = "right"
onready var sprite : AnimatedSprite = get_node("AnimatedSprite")

var hearts : int = 3
var empty_heart = preload("res://UI Elements/empty_heart.png")


func update_input_direction():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_direction.x = round(input_direction.x)
	input_direction.y = round(input_direction.y)
	

func update_movement(delta):
	var desired_speed : float = top_speed * input_direction.x
	var speed_difference : float = desired_speed - vel.x
	var desired_acceleration : float = 0.0
	if sign(desired_speed) == sign(vel.x):
		desired_acceleration = acceleration
	else:
		desired_acceleration = deceleration
	vel.x += pow(abs(speed_difference) * desired_acceleration, speed_power) * sign(speed_difference) * delta
	if abs(vel.x) < 0.5:
		vel.x = 0.0

func jump_and_fall(delta):
	if is_on_floor():
		jump_timer = 0.0
		state = "idle"
	else:
		jump_timer += delta
		if vel.y < 0:
			vel.y += gravity * delta
			if !Input.is_action_pressed("jump"):
				vel.y += abs(vel.y * (1 - jump_cut_mult))
		else:
			vel.y += gravity * delta * fall_gravity_mult
	if jump_timer < coyote_time and Input.is_action_just_pressed("jump"):
		vel.y -= jump_force
		
func double_jump():
	if is_on_floor() or is_on_wall():
		double_jump_available = true
	if Input.is_action_just_pressed("jump") and double_jump_available == true:
		if !is_on_wall() and !is_on_floor():
			vel.y = -jump_force
			double_jump_available = false

func wall_slide():
	if state == "sliding":
		vel.y = slide_gravity

func update_direction():
	if vel.x > 0 and direction == "left":
		self.scale.x *= -1
		direction = "right"
	elif vel.x < 0 and direction == "right":
		self.scale.x *= -1
		direction = "left"

func update_state():
	if is_on_floor() and vel.x == 0:
		state = "idle"
	elif is_on_floor() and vel.x != 0:
		state = "running"
	elif is_on_wall() and -input_direction.x == get_slide_collision(0).normal.x and vel.y >= 0:
		state = "sliding"
	elif vel.y > 0:
		state = "falling"
	elif vel.y < 0:
		state = "jumping"
		
func update_animation():
	if state == "idle":
		sprite.play("Idle")
	elif state == "sliding" or is_on_wall():
		sprite.play("Sliding")
	elif state == "running":
		sprite.play("Running")
	elif state == "jumping":
		sprite.play("Jump Up")
	elif state == "falling":
		sprite.play("Fall Down")

func update_hud():
	if hearts < 3:
		get_parent().get_node("HUD").get_node("Heart3").set_texture(empty_heart)
	if hearts < 2:
		get_parent().get_node("HUD").get_node("Heart2").set_texture(empty_heart)

func die():
	if hearts < 1:
		get_tree().change_scene("res://Scenes/Death Screen.tscn")

func _physics_process(delta):

	vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)

	update_input_direction()
	update_movement(delta)
	jump_and_fall(delta)
	double_jump()
	wall_slide()

	update_direction()
	update_state()
	update_animation()

	update_hud()
	die()
