class_name Player
extends CharacterBodyBase

var window: Window

var sprite_action: String = "idle"
var sprite_direction: String = "front"
var sprite_side: String = ""
var animation_name: String

var can_move: bool = true
var can_shoot: bool = true

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
	if !can_move: return
	var input_direction: Vector2 = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left"),
	Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	
	var velocity_weight_x: float = 1.0 - exp( -(ACCELERATION if input_direction.x else FRICTION) * delta)
	velocity.x = lerp(velocity.x, input_direction.x * MAX_SPEED, velocity_weight_x)
	
	var velocity_weight_y: float = 1.0 - exp( -(ACCELERATION if input_direction.y else FRICTION) * delta)
	velocity.y = lerp(velocity.y, input_direction.y * MAX_SPEED, velocity_weight_y)
	
	update_animation(input_direction)

func update_animation(input_direction: Vector2) -> void:
	if input_direction:
		sprite_action = "run_"
	else:
		sprite_action = "idle_"
	
	var angle: float = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
	if angle > 0 and angle < 45:
		sprite_direction = "front_side"
	elif angle > 45 and angle < 135:
		sprite_direction = "front"
	elif angle > 135 and angle < 180:
		sprite_direction = "front_side"
		#sprite.flip_h = true
	elif angle < 0 and angle > -45:
		sprite_direction = "back_side"
		#sprite.flip_h = true
	elif angle < -45 and angle > -135:
		sprite_direction = "back"
	elif angle < -135 and angle > -180:
		sprite_direction = "back_side"
		#sprite.flip_h = true
	if get_global_mouse_position().x >= global_position.x:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

	animation_name = sprite_action + sprite_direction
	sprite.play(animation_name)
