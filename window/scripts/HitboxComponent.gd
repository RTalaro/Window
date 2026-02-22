extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
	if get_parent() is EnemyBase:
		get_parent().knockback = attack.knockback_dir * attack.knockback_force
		get_parent().knockback_timer = attack.knockback_timer
