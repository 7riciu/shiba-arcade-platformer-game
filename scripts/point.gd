extends Area2D

@onready var points_ui = get_tree().get_first_node_in_group("ui")
@onready var points_collected = get_tree().get_first_node_in_group("ui")

func _ready() -> void:
	self.body_entered.connect(point_touched)
	
func point_touched(body):
	if body.is_in_group("player"):
		points_ui.points_count()
		queue_free()
