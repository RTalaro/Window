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
		if get_parent() is EnemyBase or get_parent() is NodeBase:
			get_parent().queue_free()
			await get_parent().tree_exited
			GlobalSignals.enemy_dead.emit()
		if get_parent() is ItemBase:
			get_parent().rebuild_wall()
			return
		if get_parent() is Player:
			await get_tree().create_timer(0.5).timeout
			get_tree().quit()
			
		get_parent().queue_free()
		
func get_all_children(node) -> Array:
	var nodes = []
	for n in node.get_children():
		if n.get_child_count() > 0:
			nodes.append(n)
			nodes.append_array(get_all_children(n))
		else:
			nodes.append(n)
	return nodes
