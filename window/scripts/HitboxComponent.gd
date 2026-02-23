extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
	if get_parent() is EnemyBase:
		get_parent().knockback = attack.knockback_dir * attack.knockback_force
		get_parent().knockback_timer = attack.knockback_timer
		
	# Not great implementation, but gives i-frames to the player
	if get_parent() is Player:
		set_deferred("monitoring", false)
		await get_tree().create_timer(1.0).timeout
		set_deferred("monitoring", true)
