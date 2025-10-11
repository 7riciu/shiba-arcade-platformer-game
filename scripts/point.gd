extends Area2D

@onready var points_ui = get_tree().get_first_node_in_group("points")

func _ready() -> void:
	self.body_entered.connect(point_touched)
	
func point_touched(body):
	if body.is_in_group("player"):
		points_ui.map_points_count()
		queue_free()
