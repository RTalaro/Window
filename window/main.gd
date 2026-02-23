extends Node

func _ready() -> void:
	get_window().set_canvas_cull_mask_bit(1, false)
	get_window().set_canvas_cull_mask_bit(2, false)
