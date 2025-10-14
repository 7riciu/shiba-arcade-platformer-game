extends CharacterBody2D

@export var speed : int = 200
@export_range(0, 1) var deceleration = 0.1
@export_range(0, 1) var acceleration = 0.1

@export var jump_force : int = -400

@export var gravity : int = 800

@export var max_health = 100
var player_health = max_health

@export var attack_power = 20
var is_attacking = false
var attack_cooldown = false

@onready var player_sprite = $AnimatedSprite2D
@onready var attack_area = $AttackArea
@onready var spawn_point = get_node("/root/game/SpawnPoint")

func _physics_process(delta):
	
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

	# Animation
	if not is_on_floor():
		player_sprite.play("jump")
		player_sprite.frame = 3
		player_sprite.stop()
	elif direction != 0:
		player_sprite.play("walk")
	else:
		player_sprite.play("idle")

	move_and_slide()

	# Attack
	if Input.is_action_just_pressed("Attack") and not attack_cooldown:
		attack()

func attack():
	is_attacking = true
	attack_cooldown = true
	attack_area.monitoring = true

	await get_tree().create_timer(0.1).timeout
	attack_area.monitoring = false
	is_attacking = false

	await get_tree().create_timer(0.1).timeout
	attack_cooldown = false

func _on_attack_area_body_entered(body):
	if body.is_in_group("enemy") and is_attacking:
		body.enemy_take_damage(attack_power)
		
func player_take_damage(amount):
	player_health -= amount
	if player_health <= 0:
		die()

func die():
	print("You died")
	reset_player()
	
func reset_player():
	global_position = spawn_point.global_position
	velocity = Vector2.ZERO
	player_health = max_health
