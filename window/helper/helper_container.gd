extends Node

@onready var window: Window = $Window
@onready var area_2d: Area2D = $Area2D
@onready var wall: Node2D = $Wall

var parent_window : Window


func _ready() -> void:
	window.size = wall.sprite_2d.get_rect().size
	window.world_2d = get_window().world_2d # Need to find a way to set this for all windows in main
	
func _process(delta: float) -> void:
	area_2d.position = Vector2(window.position)
	area_2d.position += Vector2(window.size / 2)

func enter_window() -> void:
	window.borderless = true

func exit_window() -> void:
	window.borderless = false
