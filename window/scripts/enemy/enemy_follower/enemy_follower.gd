extends EnemyBase

func _init() -> void:
	speed = 100.0
	wander_speed = 40.0

	chasing = false

	wander_dir = Vector2.ZERO
	wander_time = 0.0

	knockback = Vector2.ZERO
	knockback_timer = 0.0
	
	health = 40


func movement(delta):
	if chasing and player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
	else:
		wander(delta)
