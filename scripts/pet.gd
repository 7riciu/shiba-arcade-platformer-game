extends Area2D

@onready var pet_sprite = $AnimatedSprite2D
@onready var points_ui = get_tree().get_first_node_in_group("points")
@onready var player_sprite = get_tree().get_first_node_in_group("player")

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
		
func _process(_delta):
	if not pet and can_pet and Input.is_action_just_pressed("Collect"):
		pet = true
		points_ui.pet_points_count()
		player_sprite.gain_heart()
