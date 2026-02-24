extends Node

@export var enemy_list : Array[PackedScene]

func _ready() -> void:
	GlobalSignals.enemy_dead.connect(enemy_dead)
	
func enemy_dead() -> void:
	print("an enemy died")
	print(get_child_count())
	if get_child_count() == 0:
		print("all enemies are dead")
		await get_tree().create_timer(1.0).timeout
		print("player exit transition")
		%Player.gpu_particles_2d.restart()
		var tween: Tween = create_tween()
		tween.tween_property(%Player, "modulate", Color(1, 1, 1, 0), 1.0)
	return
