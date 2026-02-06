extends NodeBase

@onready var static_body_2d: StaticBody2D = $StaticBody2D

@onready var top: CollisionShape2D = $StaticBody2D/Top
@onready var down: CollisionShape2D = $StaticBody2D/Down
@onready var left: CollisionShape2D = $StaticBody2D/Left
@onready var right: CollisionShape2D = $StaticBody2D/Right

@onready var area_2d: Area2D = $Area2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@onready var window: Window = $Window

var window_elements = []

func _ready() -> void:
	$Window.world_2d = get_window().world_2d

func _process(_delta: float) -> void:
	static_body_2d.position = window.position
	@warning_ignore("integer_division")
	area_2d.position = Vector2(window.position) + Vector2(window.size / 2)

func _on_window_size_changed() -> void:
	if (top):
		top.shape.set_b(Vector2i(window.size.x, 0))
	if (down):
		down.shape.set_a(Vector2i(0, window.size.y))
		down.shape.set_b(Vector2i(window.size.x, window.size.y))
	if (left):
		left.shape.set_b(Vector2i(0, window.size.y))
	if (right):
		right.shape.set_a(Vector2i(window.size.x, 0))
		right.shape.set_b(Vector2i(window.size.x, window.size.y))
	if (collision_shape_2d):
		collision_shape_2d.shape.size = Vector2i(window.size.x, window.size.y)
		#collision_shape_2d.shape.get_rect().size = Vector2i(window.size.x, window.size.y)


func _on_area_2d_area_entered(area: Area2D) -> void:
	window_elements.append(area.get_parent())
	area.get_parent().enter_window()

func _on_area_2d_area_exited(area: Area2D) -> void:
	window_elements.erase(area.get_parent())
	area.get_parent().exit_window()
