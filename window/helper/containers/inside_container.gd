extends NodeBase

@export var ITEM: PackedScene

var item: ItemBase

var parent_window: Window

@onready var window: Window = $Window
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	item = ITEM.instantiate()
	add_child(item)
	
	item.window = window
	window.title = item.name
	
	window.size = item.size
	
	# Need to find a way to set this for all windows in main
	window.world_2d = get_window().world_2d
	
func _process(_delta: float) -> void:
	area_2d.position = Vector2(window.position)
	@warning_ignore("integer_division")
	area_2d.position += Vector2(window.size / 2)

func enter_window() -> void:
	window.borderless = true

func exit_window() -> void:
	window.borderless = false
