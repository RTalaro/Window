extends CharacterBody2D

@export var speed : int = 400
var target_direction : Vector2 = Vector2(1, 0)
var despawn_time : int = 3

func _ready() -> void: 
	despawn()

func _physics_process(_delta: float) -> void:
	velocity = target_direction * speed
	move_and_slide()

func despawn() -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()
