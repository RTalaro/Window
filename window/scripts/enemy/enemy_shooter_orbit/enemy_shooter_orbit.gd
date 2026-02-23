extends EnemyBase

var shoot_distance: float = 200.0
var distance_buffer: float = 10.0
var can_shoot: bool = true

const BULLET = preload("res://scripts/player/weapons/bullet.tscn")
@onready var timer = $Timer

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
			if can_shoot:
				shoot(BULLET)
				can_shoot = false
				timer.start()
	else:
		wander(delta)


func _on_timer_timeout():
	can_shoot = true
