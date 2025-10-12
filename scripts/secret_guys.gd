extends Area2D

@onready var secret_sprite = $AnimatedSprite2D
@onready var secret_ui = get_tree().get_first_node_in_group("secret guys")

var can_collect = false
var collected = false

func _ready():
	self.body_entered.connect(near_secret)
	self.body_exited.connect(not_near_secret)
	
func near_secret(body):
	if body.is_in_group("player"):
		can_collect = true

func not_near_secret(body):
	if body.is_in_group("player"):
		can_collect = false
		
func _process(delta):
	if not collected and can_collect and Input.is_action_just_pressed("Collect"):
		collected = true
		secret_ui.add_secret()
