extends NodeBase

@onready var window: Window = $Window
@onready var area_2d: Area2D = $Area2D
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var turret: Node2D = $Turret

var parent_window : Window

var last_position : Vector2i
var velocity : Vector2i

func _ready() -> void:
	window.title = turret.name
	
	window.size = turret.base.get_rect().size
	# Need to find a way to set this for all windows in main
	window.world_2d = get_window().world_2d
	
	
func _process(_delta: float) -> void:
	area_2d.position = Vector2(window.position)
	area_2d.position += Vector2(window.size / 2)
	
	velocity = window.position - last_position
	
	if rigid_body_2d.move_and_collide(velocity):
		area_2d.position = rigid_body_2d.position
		window.position = area_2d.position - Vector2(window.size / 2)
	last_position = window.position
	
	
