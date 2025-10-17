extends Area2D

var touched_killzone = false

func _ready():
	self.body_entered.connect(in_killzone)
	
func in_killzone(body):
	if body.is_in_group("player"):
		body.reset_player()
