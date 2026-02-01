extends Node2D

func _ready() -> void:
	$BorderWindow.window.world_2d = get_window().world_2d
