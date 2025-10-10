extends CanvasLayer

@onready var points_ui = $PointsCount

var points_collected = 0

func points_count():
	points_collected += 1
	points_ui.text = "Points : " + str(points_collected)
