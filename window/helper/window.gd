extends Window

@onready var camera_2d: Camera2D = $Camera2D

var mouse_offset : Vector2
var dragged : bool

func _process(delta: float) -> void:
	camera_2d.position = position

func _physics_process(delta: float) -> void:
	if dragged:
		position = Vector2i(get_window().get_mouse_position() - mouse_offset) + position

func _input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("Left Click"):
			mouse_offset = event.position
			dragged = true
		if event.is_action_released("Left Click"):
			dragged = false
