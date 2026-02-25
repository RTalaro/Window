extends Node

var player: Player
var game_window: NodeBase

@onready var item_manager: Node = $ItemManager
@onready var enemy_manager: Node = $EnemyManager

func _ready() -> void:
	if GlobalData.player:
		player = GlobalData.player
		GlobalData.player.reparent(self)
	if GlobalData.game_window:
		game_window = GlobalData.game_window
		GlobalData.game_window.reparent(self)
	
	get_window().set_canvas_cull_mask_bit(1, false)
	get_window().set_canvas_cull_mask_bit(2, false)
	
	await get_tree().create_timer(0.5).timeout
	
	var tween: Tween = create_tween()
	game_window.tile_map.collision_enabled = true
	tween.tween_property(game_window.tile_map, "modulate", Color(1, 1, 1, 1), 1.5)
	await item_manager.slide_in()
	
	enemy_manager.spawn_enemy()
	
func transition_back() -> void:
	var tween: Tween = create_tween()
	game_window.tile_map.collision_enabled = false
	tween.tween_property(game_window.tile_map, "modulate", Color(1, 1, 1, 0), 1.5)
	await item_manager.slide_out()
	
	player.reparent(GlobalData)
	game_window.reparent(GlobalData)
	GlobalData.update_instance(player, game_window)
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")
