extends CanvasLayer

@onready var points_ui = $PointsCount

var points_collected = 0

func map_points_count():
	points_collected += 1
	points_ui.text = "Points : " + str(points_collected)

func basic_enemy_points_count():
	points_collected += 10
	points_ui.text = "Points : " + str(points_collected)

func flower_points_count():
	points_collected += 10
	points_ui.text = "Points : " + str(points_collected)
