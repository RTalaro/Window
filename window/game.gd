extends Node

var player: Player
var game_window: NodeBase

@onready var item_manager: Node = $ItemManager
@onready var enemy_manager: Node = $EnemyManager

func _ready() -> void:
	if GlobalData.player:
		GlobalData.player.reparent(self)
	if GlobalData.game_window:
		GlobalData.game_window.reparent(self)
	
	get_window().set_canvas_cull_mask_bit(1, false)
	get_window().set_canvas_cull_mask_bit(2, false)
	
	await get_tree().create_timer(0.5).timeout
	await item_manager.slide_in()
	#await $ItemManager.move_items()
	#var tween: Tween = create_tween()
	#await tween.tween_property(%Player, "global_position", 
	#Vector2($BorderWindow/Window.position + ($BorderWindow/Window.size / 2)), 0.5).finished
	#$BorderWindow.add_trauma(0.75)
	#%Player.scale = Vector2(1, 1)
#
	#%Player.hitbox_collision.disabled = false
	#%Player.gpu_particles_2d.restart()
