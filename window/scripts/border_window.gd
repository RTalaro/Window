extends Node

@onready var top: CollisionShape2D = $StaticBody2D/Top
@onready var down: CollisionShape2D = $StaticBody2D/Down
@onready var left: CollisionShape2D = $StaticBody2D/Left
@onready var right: CollisionShape2D = $StaticBody2D/Right

@onready var window: Window = $Window

func _process(delta: float) -> void:
	$StaticBody2D.position = window.position


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
