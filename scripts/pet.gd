extends Area2D

var can_pet = false
var pet = false

func _ready():
	self.body_entered.connect(near_pet)
	self.body_exited.connect(not_near_pet)
	
func near_pet(body):
	if body.is_in_group("player"):
		can_pet = true

func not_near_pet(body):
	if body.is_in_group("player"):
		can_pet = false
