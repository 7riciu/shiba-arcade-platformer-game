extends Area2D

var can_enter = false

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func _process(_delta: float) -> void:
	if can_enter and Input.is_action_just_pressed("Collect"):
		get_tree().change_scene_to_file("res://scenes/basicEnemy.tscn")

func on_body_entered(body):
	if body.is_in_group("player"):
		can_enter = true
		
func on_body_exited(body):
	if body.is_in_group("player"):
		can_enter = false
