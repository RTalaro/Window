extends EnemyBase

@export var charge_speed: float = 600.0
@export var charge_trigger: float = 500.0
@export var charge_distance: float = 350.0
@export var charge_cooldown: float = 3

var charging: bool = false
var charge_dir: Vector2 = Vector2.ZERO
var charge_travel: float = 0.0

var cooldown_timer: float = 0.0


func movement(delta):
	if chasing and player:

		if charging:
			velocity = charge_dir * charge_speed
			charge_travel += charge_speed * delta

			if charge_travel >= charge_distance:
				charging = false
				charge_travel = 0.0
				cooldown_timer = charge_cooldown

		else:
			var to_player: Vector2 = player.global_position - global_position
			var dist: float = to_player.length()
			var dir: Vector2 = to_player.normalized()

			velocity = dir * speed

			if cooldown_timer > 0:
				cooldown_timer -= delta
			elif dist <= charge_trigger:
				charging = true
				charge_dir = dir
	else:
		wander(delta)


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		chasing = true

func _on_detection_area_body_exited(body):
	if body == player:
		chasing = false
