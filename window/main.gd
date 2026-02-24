extends Node

func _ready() -> void:
	%Player.global_position = $BorderWindow/Window.position
	%Player.global_position.y -= 2000
	%Player.hitbox_collision.disabled = true
	%Player.scale = Vector2(0.25, 1.75)
	get_window().set_canvas_cull_mask_bit(1, false)
	get_window().set_canvas_cull_mask_bit(2, false)
	
	await $ItemManager.move_items()
	var tween: Tween = create_tween()
	await tween.tween_property(%Player, "global_position", 
	Vector2($BorderWindow/Window.position + ($BorderWindow/Window.size / 2)), 0.5).finished
	$BorderWindow.add_trauma(0.75)
	%Player.scale = Vector2(1, 1)

	%Player.hitbox_collision.disabled = false
	%Player.gpu_particles_2d.restart()
