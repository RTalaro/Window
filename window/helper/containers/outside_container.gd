extends NodeBase

@export var ITEM: PackedScene

var item: ItemBase
var parent_window: Window

var last_position: Vector2i
var velocity: Vector2i

@onready var window: Window = $Window
@onready var area_2d: Area2D = $Area2D
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D


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
	
	velocity = window.position - last_position
	
	if rigid_body_2d.move_and_collide(velocity):
		area_2d.position = rigid_body_2d.position
		@warning_ignore("integer_division")
		window.position = area_2d.position - Vector2(window.size / 2)
	last_position = window.position
	
	
