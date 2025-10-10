extends CharacterBody2D

@onready var points_ui = get_tree().get_first_node_in_group("ui")
@onready var collect_area = $CollectArea
@onready var flower_sprite = $AnimatedSprite2D

func _ready() -> void:
	flower_sprite.play("default")

func flower_collectable():
	if collect_area.can_collect and not collect_area.collected:
		flower_sprite.play("default outline")

	elif collect_area.collected:
		flower_sprite.play("collected")
