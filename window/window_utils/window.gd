extends Window

@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	transient = true
	close_requested.connect(queue_free)
	
func _process(_delta: float) -> void:
	camera_2d.position = position
