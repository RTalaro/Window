class_name Player
extends CharacterBodyBase

var window: Window

var sprite_action: String = "idle"
var sprite_direction: String = "front"
var animation_name: String

@export var MAX_SPEED: float = 400.0
@export var ACCELERATION: float = 50.0
@export var FRICTION: float = 25.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var hitbox_collision: CollisionShape2D = $HitboxComponent/CollisionShape2D

func _ready() -> void:
	window = get_window()

func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide() # If using move_and_slide, collisions will be with static bodies

	#position.x = clamp(position.x, 0, window.size.x)
	#position.y = clamp(position.y, 0, window.size.y)
	
func get_input(delta: float) -> void:
	var input_direction: Vector2 = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left"),
	Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	
	var velocity_weight_x: float = 1.0 - exp( -(ACCELERATION if input_direction.x else FRICTION) * delta)
	velocity.x = lerp(velocity.x, input_direction.x * MAX_SPEED, velocity_weight_x)
	
	var velocity_weight_y: float = 1.0 - exp( -(ACCELERATION if input_direction.y else FRICTION) * delta)
	velocity.y = lerp(velocity.y, input_direction.y * MAX_SPEED, velocity_weight_y)
	
	update_animation(input_direction)

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
