extends Node

@export var enemy_list : Array[PackedScene]

func _ready() -> void:
	GlobalSignals.enemy_dead.connect(enemy_dead)
	spawn_enemy()

func spawn_enemy() -> void:
	var enemy = enemy_list[0].instantiate()
	enemy.position = Vector2(1500, 1000)
	enemy.modulate = Color(0, 0, 0, 0)
	add_child(enemy)
	
	var tween: Tween = create_tween()
	await tween.tween_property(enemy, "modulate", Color(1, 1, 1, 1), 0.5)
	
func enemy_dead() -> void:
	print("an enemy died")
	print(get_child_count())
	if get_child_count() == 0:
		print("all enemies are dead")
		await get_tree().create_timer(1.0).timeout
		print("player exit transition")
		var tween: Tween = create_tween()
		#get_parent().player.gpu_particles_2d.restart()
		get_parent().player.reparent(GlobalSignals)
		get_parent().game_window.reparent(GlobalSignals)
		get_tree().change_scene_to_file("res://overworld.tscn")
	return
