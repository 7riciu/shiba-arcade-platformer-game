extends Control

@onready var level_one = $Level1
@onready var level_two = $Level2
@onready var level_three = $Level3

func _ready():
	level_one.pressed.connect(level_one_start)

func level_one_start():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
