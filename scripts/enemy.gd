extends CharacterBody2D

@onready var points_ui = get_tree().get_first_node_in_group("ui")
@onready var attack_area = $AttackArea
@onready var player_ref = null

@export var speed = 100
@export var max_health = 20
@export var attack_power = 40
@export var attack_interval = 1.0

var enemy_health = max_health
var can_attack = true

func _physics_process(delta):
	
	# Moves towards player
	if player_ref:
		var dir = sign(player_ref.global_position.x - global_position.x)
		velocity.x = dir * speed
	else:
		velocity.x = 0

	velocity.y += 900 * delta
	move_and_slide()

func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body
		attack_player()

func _on_attack_area_body_exited(body):
	if body == player_ref:
		player_ref = null

func attack_player():
	if not can_attack or not player_ref:
		return

	can_attack = false
	
	player_ref.player_take_damage(attack_power)

	await get_tree().create_timer(attack_interval).timeout
	can_attack = true

	# Keep attacking if still touching the player
	if player_ref and attack_area.get_overlapping_bodies().has(player_ref):
		attack_player()

func enemy_take_damage(amount):
	enemy_health -= amount
	if enemy_health <= 0:
		enemy_die()

func enemy_die():
	print("Enemy dead")
	points_ui.basic_enemy_points_count()
	queue_free()
