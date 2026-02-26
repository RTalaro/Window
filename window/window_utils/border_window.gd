extends NodeBase

var window_elements = []
@export var window_initial: Vector2i
# Window shake
var decay: float = 0.8
var max_offset: Vector2 = Vector2(100, 75)
var trauma: float = 0.0
var trauma_power: int = 2
@export var locked: bool = true

@onready var window: Window = $Window
@onready var area_2d: Area2D = $Area2D
@onready var tile_map: TileMapLayer = $Window/Camera2D/TileMapLayer
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var room_trigger: Area2D = $RoomTrigger

func _ready() -> void:
	window.world_2d = get_window().world_2d
	if (window_initial):
		window.position = window_initial
	else:
		window_initial = window.position
	_on_window_size_changed()
	
	
func _process(delta: float) -> void:
	if (!window): return
	@warning_ignore("integer_division")
	area_2d.position = Vector2(window.position) + Vector2(window.size / 2)
	if room_trigger:
		room_trigger.position = area_2d.position
	if locked:
		window.position = window_initial
		
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
func _on_window_size_changed() -> void:
	if collision_shape_2d:
		collision_shape_2d.shape.size = Vector2i(window.size.x, window.size.y)

func _on_area_2d_area_entered(area: Area2D) -> void:
	window_elements.append(area.get_parent())
	area.get_parent().enter_window()

func _on_area_2d_area_exited(area: Area2D) -> void:
	window_elements.erase(area.get_parent())
	area.get_parent().exit_window()

func add_trauma(amount) -> void:
	print(window_initial)
	trauma = min(trauma + amount, 1.0)

func shake() -> void:
	var amount: float = pow(trauma, trauma_power)
	var offset_x: int = max_offset.x * amount * randi_range(-1, 1)
	var offset_y: int = max_offset.y * amount * randi_range(-1, 1)
	window.position.x = window_initial.x + offset_x
	window.position.y = window_initial.y + offset_y
