extends Node

@export var enemy_list : Array[PackedScene]
var current_wave: int = 0
var wave_count: int = 3 # How many waves there are

func _ready() -> void:
	GlobalSignals.enemy_dead.connect(enemy_dead)

func spawn_enemy() -> void:
	var enemy = enemy_list.pick_random().instantiate()
	enemy.position = get_window().size / 2
	add_child(enemy)
	
func enemy_dead() -> void:
	print("an enemy died")
	print(get_child_count())
	if get_child_count() == 0:
		if (current_wave < wave_count):
			current_wave += 1
			print("spawning more enemies")
			await get_tree().create_timer(1.0).timeout
			spawn_enemy()
		elif (current_wave == wave_count):
			print("all enemies are dead")
			await get_tree().create_timer(1.0).timeout
			get_parent().transition_back()
	return
