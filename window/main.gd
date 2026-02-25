extends Node

var player
var game_window

func _ready() -> void:
	GlobalSignals.get_node("Player").reparent(self)
	GlobalSignals.get_node("BorderWindow").reparent(self)
	player = $Player
	game_window = $BorderWindow
	#%Player.global_position = $BorderWindow/Window.position
	#%Player.global_position.y -= 2000
	#%Player.hitbox_collision.disabled = true
	#%Player.scale = Vector2(0.25, 1.75)
	get_window().set_canvas_cull_mask_bit(1, false)
	get_window().set_canvas_cull_mask_bit(2, false)
	$BorderWindow/Window/Camera2D/TileMapLayer.collision_enabled = true
	var tween: Tween = create_tween()
	await tween.tween_property($BorderWindow/Window/Camera2D/TileMapLayer, "modulate",
	Color(1, 1, 1, 1), 0.5)
	await $ItemManager.move_items()
	#var tween: Tween = create_tween()
	#await tween.tween_property(%Player, "global_position", 
	#Vector2($BorderWindow/Window.position + ($BorderWindow/Window.size / 2)), 0.5).finished
	#$BorderWindow.add_trauma(0.75)
	#%Player.scale = Vector2(1, 1)
#
	#%Player.hitbox_collision.disabled = false
	#%Player.gpu_particles_2d.restart()
