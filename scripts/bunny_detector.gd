extends Area2D

var is_entered = false

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		is_entered = true
		print("Bunny area entered")
	
func _on_body_exited(body):
	if body.is_in_group("player"):
		is_entered = false
		print("Bunny area exited")
