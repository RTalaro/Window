extends CharacterBody2D

@export var speed: float = 100.0
@export var wander_speed: float = 40.0

var player : Node2D
var chasing: bool = false

var wander_dir: Vector2 = Vector2.ZERO
var wander_time: float = 0.0


func _physics_process(delta):
	if chasing and player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
	else:
		wander(delta)

	move_and_slide()


func wander(delta):
	wander_time -= delta
	if wander_time <= 0:
		wander_time = randf_range(1.0, 2.5)
		wander_dir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	velocity = wander_dir * wander_speed


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		chasing = true


func _on_detection_area_body_exited(body):
	if body == player:
		chasing = false
