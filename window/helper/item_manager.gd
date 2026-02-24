extends Node

var pos = [Vector2i(0, 36), Vector2i(0, 1250), Vector2i(2400, 36)]

func move_items():
	var count = 0
	for i in get_children():
		await i.tween_to_pos(pos[count])
		count += 1
	return
