extends CharacterBody2D

@onready var bunny_sprite = $AnimatedSprite2D
@onready var attack_area = $AttackArea
@onready var player_ref = get_node("/root/game/Player")

var frame_time: float = 0.5
var up_frame_time: float = 1.5
var down_frame_time: float = 1.5

var is_down = false

func _ready() -> void:
	is_down = false
	bunny_sprite.play("up")
	$CollisionShape2D.position = Vector2(0, -32)
	_smash_cycle()

func _smash_cycle():
	await get_tree().create_timer(up_frame_time).timeout
	bunny_sprite.play("middle")
	$CollisionShape2D.position = Vector2(0, -6)

	await get_tree().create_timer(frame_time).timeout
	bunny_sprite.play("down")
	$CollisionShape2D.position = Vector2(0, 43)
	is_down = true
	if is_down and attack_area.is_entered:
		player_ref.reset_player()

	await get_tree().create_timer(down_frame_time).timeout
	bunny_sprite.play("middle")
	$CollisionShape2D.position = Vector2(0, -6)
	is_down = false

	await get_tree().create_timer(frame_time).timeout
	bunny_sprite.play("up")
	$CollisionShape2D.position = Vector2(0, -32)

	_smash_cycle()
