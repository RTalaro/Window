extends EnemyBase

var shoot_distance: float = 200.0
var distance_buffer: float = 10.0

func _init() -> void:
	speed = 100.0
	wander_speed = 40.0

	chasing = false

	wander_dir = Vector2.ZERO
	wander_time = 0.0

	knockback = Vector2.ZERO
	knockback_timer = 0.0



func movement(delta):
	if chasing and player:
		var to_player: Vector2 = player.global_position - global_position
		var dist: float = to_player.length()
		var dir: Vector2 = to_player.normalized()

		if dist < (shoot_distance - distance_buffer):
			velocity = -dir * speed
		elif dist > (shoot_distance + distance_buffer):
			velocity = dir * speed
		else:
			var tangent: Vector2 = Vector2(-dir.y, dir.x)
			velocity = tangent * speed
	else:
		wander(delta)


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		chasing = true

func _on_detection_area_body_exited(body):
	if body == player:
		chasing = false
