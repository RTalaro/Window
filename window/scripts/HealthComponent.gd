extends Node2D
class_name HealthComponent

@export var MAX_HEALTH: float = 10.0
var health: float


func _ready():
	health = MAX_HEALTH

func set_health(hp: int):
	health = hp
	
func set_init_health(hp: int):
	MAX_HEALTH = hp
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free()
