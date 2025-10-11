extends Label

var points_collected = 0

func map_points_count():
	points_collected += 1
	self.text = "Points : " + str(points_collected)

func basic_enemy_points_count():
	points_collected += 10
	self.text = "Points : " + str(points_collected)

func flower_points_count():
	points_collected += 10
	self.text = "Points : " + str(points_collected)
	
func pet_points_count():
	points_collected += 5
	self.text = "Points : " + str(points_collected)
