extends Window

# THE BASIC WINDOW SCRIPT, SETS CAMERA POSITION AND ALLOWS FULL WINDOW DRAGGING

var mouse_offset: Vector2
var dragged: bool = false
var tween: Tween

var in_window: bool = false # Doubles as a bool to do tween or not

@onready var camera_2d: Camera2D = $Camera2D

func _process(_delta: float) -> void:
	camera_2d.position = position

func _physics_process(_delta: float) -> void:
	if dragged:
		position = Vector2i(get_window().get_mouse_position() - mouse_offset) + position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("Left Click"):
			print("window first")
			mouse_offset = event.position
			GlobalData.can_shoot = false
			dragged = true
			stop_movement()
		if event.is_action_released("Left Click"):
			GlobalData.can_shoot = true
			dragged = false
			start_movement()

func start_movement() -> void:
	if (in_window):
		stop_movement()
		return
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", 50, 1).as_relative()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", -50, 1).as_relative()
	
func stop_movement() -> void:
	if (tween):
		tween.stop()
