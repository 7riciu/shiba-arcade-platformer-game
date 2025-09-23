extends CharacterBody2D

@export var speed : int = 150
@export_range(0, 1) var deceleration = 0.1
@export_range(0, 1) var acceleration = 0.1

@export var jump_force : int = -300
@export_range(0, 1) var decelerate_jump = 0.5

@export var gravity : int = 800

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:

	# Move left-right
	var direction = Input.get_axis("Left", "Right")

	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	# Flip around
	if direction == 1:
		player_sprite.flip_h = false
	elif direction == -1:
		player_sprite.flip_h = true

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y = jump_force * decelerate_jump

	move_and_slide()
