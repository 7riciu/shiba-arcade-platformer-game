extends TextureRect

@onready var player_sprite = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	self.visible = true

func _process(_delta: float) -> void:
	if player_sprite.heart_count < 3:
		self.visible = false
