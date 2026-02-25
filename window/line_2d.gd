extends Line2D


func line_break():
	var tween: Tween = create_tween()
	tween.parallel()
	await tween.tween_property(self, "position:y", 1500, 0.75).as_relative().finished
	modulate = Color(0, 0, 0, 0)
	position.y = 778
	return
