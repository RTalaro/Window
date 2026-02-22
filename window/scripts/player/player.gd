extends CharacterBodyBase

var window: Window

var sprite_action: String = "idle"
var sprite_direction: String = "front"
var animation_name: String

@export var speed: float = 400

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	window = get_window()

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide() # If using move_and_slide, collisions will be with static bodies

	#position.x = clamp(position.x, 0, window.size.x)
	#position.y = clamp(position.y, 0, window.size.y)
	
func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	update_animation(input_direction)
	velocity = input_direction * speed

func update_animation(input_direction: Vector2) -> void:
	if input_direction:
		sprite_action = "walk"
	else:
		sprite_action = "idle"
	var horizontal_dir = Input.get_axis("Left", "Right")
	var vertical_dir = Input.get_axis("Up", "Down")
	match horizontal_dir:
		-1.0:
			# True = facing left
			sprite.flip_h = true
			sprite_direction = "side"
		1.0:
			sprite.flip_h = false
			sprite_direction = "side"
		0.0:
			match vertical_dir:
				-1.0:
					sprite_direction = "back"
				1.0:
					sprite_direction = "front"
	animation_name = sprite_action + "_" + sprite_direction
	sprite.play(animation_name)
