extends NodeBase

@onready var area_2d: Area2D = $Area2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@onready var window: Window = $Window

var window_elements = []

func _ready() -> void:
	window.world_2d = get_window().world_2d
	_on_window_size_changed()
	window_initial = window.position
	
	
func _process(delta: float) -> void:
	@warning_ignore("integer_division")
	area_2d.position = Vector2(window.position) + Vector2(window.size / 2)
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func add_trauma(amount) -> void:
	trauma = min(trauma + amount, 1.0)

func _on_window_size_changed() -> void:
	if collision_shape_2d:
		collision_shape_2d.shape.size = Vector2i(window.size.x, window.size.y)


func _on_area_2d_area_entered(area: Area2D) -> void:
	window_elements.append(area.get_parent())
	area.get_parent().enter_window()

func _on_area_2d_area_exited(area: Area2D) -> void:
	window_elements.erase(area.get_parent())
	area.get_parent().exit_window()
	
	
var decay = 0.8
var max_offset = Vector2(100, 75)
var trauma = 0.0
var trauma_power = 2

var window_initial = Vector2i(471, 28)

func shake() -> void:
	var amount = pow(trauma, trauma_power)
	var offset_x = max_offset.x * amount * randi_range(-1, 1)
	var offset_y = max_offset.y * amount * randi_range(-1, 1)
	window.position.x = window_initial.x + offset_x
	window.position.y = window_initial.y + offset_y
