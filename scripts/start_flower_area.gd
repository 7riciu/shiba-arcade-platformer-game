extends Area2D

@onready var flower_sprite = $AnimatedSprite2D
@onready var points_ui = get_tree().get_first_node_in_group("points")

var can_collect = false
var collected = false

func _ready():
	self.body_entered.connect(is_collectable)
	self.body_exited.connect(is_not_collectable)
	flower_sprite.play("default")

func is_collectable(body):
	if body.is_in_group("player"):
		can_collect = true
		if not collected:
			flower_sprite.play("default outline")
		else:
			flower_sprite.play("collected")

func is_not_collectable(body):
	if body.is_in_group("player"):
		can_collect = false
		if not collected:
			flower_sprite.play("default")
		else:
			flower_sprite.play("collected")
			
func _process(delta: float) -> void:
	if not collected and can_collect and Input.is_action_just_pressed("Collect"):
		flower_sprite.play("collected")
		collected = true
		points_ui.flower_points_count()
