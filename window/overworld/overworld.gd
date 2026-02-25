extends Node

var player: Player
@onready var border_window: Node = $BorderWindow

func _ready() -> void:
	if GlobalData.player:
		GlobalData.player.reparent(self)
		player = GlobalData.player
		game_to_overworld()
	if GlobalData.game_window:
		border_window.queue_free()
		GlobalData.game_window.reparent(self)
	border_window.tile_map.collision_enabled = false
	border_window.tile_map.modulate = Color(1, 1, 1, 0)
	border_window.room_trigger.area_entered.connect(room_trigger_entered, CONNECT_APPEND_SOURCE_OBJECT)

func game_to_overworld() -> void:
	# Hardcoding nodes for now, but will change ($Left / $Right)
	$Left.position.x -= 1000
	$Right.position.x += 1000
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Left, "modulate", Color(1, 1, 1, 1), 1.0).as_relative().set_ease(Tween.EASE_IN)
	tween.tween_property($Right, "modulate", Color(1, 1, 1, 1), 1.0).as_relative().set_ease(Tween.EASE_IN)
	tween.tween_property($Left, "position:x", 1000, 1.0).as_relative().set_ease(Tween.EASE_IN)
	tween.tween_property($Right, "position:x", -1000, 1.0).as_relative().set_ease(Tween.EASE_IN)

func room_trigger_entered(area: Area2D, source: Area2D) -> void:
	overworld_to_game(source.get_parent())
	source.queue_free()

func overworld_to_game(window: NodeBase) -> void:
	window.add_trauma(0.75)
	$Left.line_break()
	await $Right.line_break()
	player.reparent(GlobalData)
	window.reparent(GlobalData)
	GlobalData.update_instance(player, window)
	get_tree().change_scene_to_file("res://game.tscn")
	
	
	
