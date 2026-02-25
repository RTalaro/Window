extends Node

var pos = [Vector2i(2400, 36), Vector2i(0, 1250), Vector2i(0, 36)]

func slide_in() -> void:
	var count: int = 0
	# Loop could be done in a cleaner way
	for i in get_children():
		await i.tween_to_pos(pos[count])
		count += 1
	return
	
func slide_out() -> void:
	for i in get_children():
		await i.tween_to_pos(Vector2i(-400, 36))
	return
