extends NodeBase

@onready var area_2d: Area2D = $Area2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@onready var window: Window = $Window

var window_elements = []

func _ready() -> void:
	window.world_2d = get_window().world_2d
	_on_window_size_changed()

func _process(_delta: float) -> void:
	@warning_ignore("integer_division")
	area_2d.position = Vector2(window.position) + Vector2(window.size / 2)

func _on_window_size_changed() -> void:
	if collision_shape_2d:
		collision_shape_2d.shape.size = Vector2i(window.size.x, window.size.y)


func _on_area_2d_area_entered(area: Area2D) -> void:
	window_elements.append(area.get_parent())
	area.get_parent().enter_window()

func _on_area_2d_area_exited(area: Area2D) -> void:
	window_elements.erase(area.get_parent())
	area.get_parent().exit_window()
