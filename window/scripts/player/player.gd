extends CharacterBodyBase

var window: Window

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	window = get_window()

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide() # If using move_and_slide, collisions will be with static bodies

	#position.x = clamp(position.x, 0, window.size.x)
	#position.y = clamp(position.y, 0, window.size.y)
	
func get_input() -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	if input_direction.x == -1:
		sprite.flip_h = true
	if input_direction.x == 1:
		sprite.flip_h = false
	velocity = input_direction * 500
