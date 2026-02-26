extends Node

var player

func _ready() -> void:
	player = GlobalData.player
	player.global_position = $BorderWindow/Window.position
	player.global_position.y -= 2000
	player.hitbox_collision.disabled = true
	player.scale = Vector2(0.25, 1.75)
	var tween: Tween = create_tween()
	await tween.tween_property(player, "global_position", 
	Vector2($BorderWindow/Window.position + ($BorderWindow/Window.size / 2)), 0.5).finished
	$BorderWindow.add_trauma(0.75)
	player.scale = Vector2(1, 1)

	player.hitbox_collision.disabled = false
	player.gpu_particles_2d.restart()
