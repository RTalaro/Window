extends Window

# THE BASIC WINDOW SCRIPT, SETS CAMERA POSITION AND ALLOWS FULL WINDOW DRAGGING

var mouse_offset: Vector2
var dragged: bool
var tween: Tween

@export var in_window: bool = false # Doubles as a bool to do tween or not

@onready var camera_2d: Camera2D = $Camera2D

# Added for overworld prototyping
func _ready() -> void:
	camera_2d.position = position

func _process(_delta: float) -> void:
	camera_2d.position = position

func _physics_process(_delta: float) -> void:
	if dragged:
		position = Vector2i(get_window().get_mouse_position() - mouse_offset) + position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("Left Click"):
			mouse_offset = event.position
			dragged = true
			stop_movement()
		if event.is_action_released("Left Click"):
			dragged = false
			start_movement()

func start_movement() -> void:
	if (in_window): return
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", 50, 1).as_relative()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", -50, 1).as_relative()
	
func stop_movement() -> void:
	if (tween):
		tween.stop()
