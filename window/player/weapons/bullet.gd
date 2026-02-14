extends CharacterBody2D

@export var speed : int = 400
@export var despawn_time : int = 3
@export var piercing : int = 0
@export var target_direction : Vector2 = Vector2(1, 0)

func _ready() -> void: 
	despawn()

func _physics_process(_delta: float) -> void:
	velocity = target_direction * speed
	move_and_slide()

func despawn() -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()


func _on_target_collision_body_entered(body: Node2D) -> void:
	if (piercing <= 0):
		queue_free()
	piercing -= 1
		
