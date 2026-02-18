extends Node

@onready var main_window: Node = $BorderWindow
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	@warning_ignore("integer_division")
	main_window.window.position = Vector2i(get_window().size / 2 - (main_window.window.size / 2))
	player.position = main_window.window.position + Vector2i(main_window.window.size / 2)
