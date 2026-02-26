extends Node

var player: Player

@onready var ladder: Area2D = $Rooms/BorderWindow6/Ladder # TEMP TO MAKE A WIN CONDITION


func _ready() -> void:
	for i in $Paths.get_children():
		i.modulate = Color(1, 1, 1, 0)

	if GlobalData.player:
		GlobalData.player.reparent(self)
		player = GlobalData.player
		game_to_overworld()

	if GlobalData.game_window:
		GlobalData.game_window.queue_free()
		GlobalData.game_window = null
	for border_window in $Rooms.get_children():
		if GlobalData.room_flags.has(border_window.name): # If it exists in the flag
			var check_flag: bool = GlobalData.room_flags[border_window.name]
			border_window.room_trigger.visible = !check_flag
			border_window.room_trigger.monitoring = !check_flag
		
		border_window.tile_map.collision_enabled = false
		border_window.tile_map.modulate = Color(1, 1, 1, 0)
		border_window.room_trigger.area_entered.connect(room_trigger_entered, CONNECT_APPEND_SOURCE_OBJECT)
		
	if all_values_true():
		ladder.position -= Vector2(1000, 1000)
		ladder.visible = true
		ladder.monitoring = true
	else:
		ladder.visible = false
		ladder.monitoring = false

func all_values_true() -> bool:
	for value in GlobalData.room_flags.values():
		if !value: return false
	return true			
	
func game_to_overworld() -> void:
	move_map(GlobalData.offset)

	for i in $Paths.get_children():
			var tween: Tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(i, "modulate", Color(1, 1, 1, 1), 1.0).as_relative().set_ease(Tween.EASE_IN)
	return

func room_trigger_entered(_area: Area2D, source: Area2D) -> void:
	overworld_to_game(source.get_parent())
	source.queue_free()

func overworld_to_game(window: NodeBase) -> void:
	window.add_trauma(0.75)
	#$Left.line_break()
	
	
	for i in $Paths.get_children():
		i.line_break()
	await $Paths/VPath.line_break()
	player.reparent(GlobalData)
	window.reparent(GlobalData)
	GlobalData.update_instance(player, window)
	get_tree().change_scene_to_file("res://game.tscn")

func move_screen(pos: Vector2i) -> void:
	GlobalData.offset += pos
	$Triggers.call_deferred("set_process_mode", ProcessMode.PROCESS_MODE_DISABLED)
	GlobalData.can_shoot = false
	await get_tree().process_frame
	for i in $Rooms.get_children():
		i.locked = false
		var tween: Tween = create_tween()
		tween.tween_property(i.window, "position", pos, 0.75).as_relative()
		
	for i in $Paths.get_children():
		var tween: Tween = create_tween()
		tween.tween_property(i, "position", Vector2(pos), 0.75).as_relative()

	var tween: Tween = create_tween()
	tween.tween_property(player, "position", Vector2(pos * 0.9), 0.75).as_relative().finished
		
	await get_tree().create_timer(1.0).timeout
	$Triggers.process_mode = Node.PROCESS_MODE_INHERIT
	GlobalData.can_shoot = true
	for i in $Rooms.get_children():
		i.window_initial = i.window.position
	ladder.position = $Rooms/BorderWindow6.window_initial + Vector2i(1280 / 2, 720 / 2)

# Moves all the map components to simulate the player staying in the same spot
func move_map(offset: Vector2i) -> void:
	if offset == Vector2i.ZERO: return
	for i in $Rooms.get_children():
		i.locked = false
		i.window.position += offset
		
	for i in $Paths.get_children():
		i.position += Vector2(offset)
		
	for i in $Rooms.get_children():
		i.window_initial = i.window.position

func _on_top_area_entered(_area: Area2D) -> void:
	move_screen(Vector2i(0, 1600))

func _on_bottom_area_entered(_area: Area2D) -> void:
	move_screen(Vector2i(0, -1600))

func _on_left_area_entered(_area: Area2D) -> void:
	move_screen(Vector2i(2560, 0))

func _on_right_area_entered(_area: Area2D) -> void:
	move_screen(Vector2i(-2560, 0))


func _on_ladder_area_entered(area: Area2D, source: Area2D) -> void:
	var tween: Tween = create_tween()
	await tween.tween_property(player, "position", source.position, 0.75).finished
	player.position.y -= 2000
	source.position.y -= 2000
	player.reparent(GlobalData)
	GlobalData.update_instance(player, null)
	await move_screen(Vector2i(0, -1600))
	get_tree().change_scene_to_file("res://playtest_win.tscn")
