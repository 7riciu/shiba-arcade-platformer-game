extends CharacterBody2D

# Movement

@export var speed : int = 150
@export_range(0, 1) var deceleration = 0.1
@export_range(0, 1) var acceleration = 0.1

@export var jump_force : int = -300
@export_range(0, 1) var decelerate_jump = 0.5

@export var gravity : int = 800

@export var max_health = 100
var health = max_health

@export var attack_damage = 20
var is_attacking = false
var attack_cooldown = false

@onready var player_sprite = $AnimatedSprite2D
@onready var healthbar = $HealthBar
@onready var attack_area = $AttackArea
@onready var spawn_point = get_node("/root/game/SpawnPoint")

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

	# Attack
	if Input.is_action_just_pressed("Attack") and not attack_cooldown:
		attack()

	healthbar.value = health
	
func attack():
	is_attacking = true
	attack_cooldown = true
	attack_area.monitoring = true

	await get_tree().create_timer(0.2).timeout
	attack_area.monitoring = false
	is_attacking = false

	await get_tree().create_timer(0.5).timeout
	attack_cooldown = false

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and is_attacking:
		body.take_damage(attack_damage)
		
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()
		
func die():
	print("You died")
	reset_player()
	
func reset_player():
	global_position = spawn_point.global_position
	velocity = Vector2.ZERO
	health = max_health
	healthbar.value = health
