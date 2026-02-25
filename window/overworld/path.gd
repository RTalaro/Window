extends Line2D

func line_break():
	var tween: Tween = create_tween()
	return tween.tween_property(self, "position:y", 1500, 2).as_relative().finished
