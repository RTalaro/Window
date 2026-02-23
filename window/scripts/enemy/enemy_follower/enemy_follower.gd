extends EnemyBase

func _init() -> void:
	speed = 100.0
	wander_speed = 40.0

	chasing = false

	wander_dir = Vector2.ZERO
	wander_time = 0.0

	knockback = Vector2.ZERO
	knockback_timer = 0.0


func _physics_process(delta):
	if knockback_timer > 0.0:
		recieve_knockback(delta)
	else:
		movement(delta)
	move_and_slide()


func movement(delta):
	if chasing and player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
	else:
		wander(delta)


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		chasing = true


func _on_detection_area_body_exited(body):
	if body == player:
		chasing = false
