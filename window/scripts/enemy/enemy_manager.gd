extends Node

@export var enemy_list : Array[PackedScene]

func _ready() -> void:
	GlobalSignals.enemy_dead.connect(enemy_dead)
	
func enemy_dead() -> void:
	print("an enemy died")
	print(get_child_count())
	if get_child_count() == 0:
		print("all enemies are dead")
	return
