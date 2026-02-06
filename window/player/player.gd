extends CharacterBodyBase

var window : Window

func _ready() -> void:
	window = get_window()

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide() # If using move_and_slide, collisions will be with static bodies

	#position.x = clamp(position.x, 0, window.size.x)
	#position.y = clamp(position.y, 0, window.size.y)
	
func get_input() -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * 500
	
	#if Input.is_action_just_pressed("Left Click"):
		#$Gun.shoot()
