extends CharacterBody2D

@export var speed = 100
@export var max_health = 60
@export var attack_damage = 50
@export var attack_interval = 1.0

var health = max_health
var can_attack = true

@onready var healthbar = $HealthBar
@onready var attack_area = $AttackArea
@onready var player_ref = get_node("/root/player")

func _ready():
	attack_area.connect("body_entered", Callable(self, "_on_attack_area_body_entered"))
	attack_area.connect("body_exited", Callable(self, "_on_attack_area_body_exited"))

func _physics_process(delta):
	if player_ref:
		var dir = sign(player_ref.global_position.x - global_position.x)
		velocity.x = dir * speed
	else:
		velocity.x = 0

	velocity.y += 900 * delta
	move_and_slide()

	healthbar.value = health

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
	player_ref.take_damage(attack_damage)

	await get_tree().create_timer(attack_interval).timeout
	can_attack = true

	# Keep attacking if still touching the player
	if player_ref and attack_area.get_overlapping_bodies().has(player_ref):
		attack_player()

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
