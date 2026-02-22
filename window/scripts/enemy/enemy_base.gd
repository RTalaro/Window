class_name EnemyBase
extends CharacterBody2D

@export var speed: float = 100.0
@export var wander_speed: float = 40.0

var player: Node2D
var chasing: bool = false

var wander_dir: Vector2 = Vector2.ZERO
var wander_time: float = 0.0

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func recieve_knockback(delta):
	velocity = knockback
	knockback_timer -= delta
	if knockback_timer <= 0.0:
		knockback = Vector2.ZERO

func wander(delta):
	wander_time -= delta
	if wander_time <= 0:
		wander_time = randf_range(1.0, 2.5)
		wander_dir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	velocity = wander_dir * wander_speed
