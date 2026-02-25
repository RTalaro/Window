extends Node

@export var enemy_list : Array[PackedScene]

func _ready() -> void:
	GlobalSignals.enemy_dead.connect(enemy_dead)

func spawn_enemy() -> void:
	var enemy = enemy_list[0].instantiate()
	enemy.position = get_window().size / 2
	add_child(enemy)
	
func enemy_dead() -> void:
	print("an enemy died")
	print(get_child_count())
	if get_child_count() == 0:
		print("all enemies are dead")
		await get_tree().create_timer(1.0).timeout
		get_parent().transition_back()
	return
