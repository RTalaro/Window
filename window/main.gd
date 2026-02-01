extends Node

func _ready() -> void:
	$BorderWindow.window.world_2d = get_window().world_2d
