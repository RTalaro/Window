extends Node

func _ready() -> void:
	if GlobalSignals.get_node("Player"):
		remove_child($Player)
		remove_child($BorderWindow)
		GlobalSignals.get_node("Player").reparent(self)
		GlobalSignals.get_node("BorderWindow").reparent(self)
		var tween: Tween = create_tween()
		$Line2D.position.x -= 1000
		$Line2D2.position.x += 1000
		var tween2: Tween = create_tween()
		tween.tween_property($Line2D, "position:x", -10, 1.0).set_ease(Tween.EASE_IN)
		tween2.tween_property($Line2D2, "position:x", 1928, 1.0).set_ease(Tween.EASE_IN)
	$BorderWindow/Window/Camera2D/TileMapLayer.collision_enabled = false
	$BorderWindow/Window/Camera2D/TileMapLayer.modulate = Color(1, 1, 1, 0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("entered")
	$BorderWindow/Area2D2.queue_free()
	$BorderWindow.add_trauma(0.75)
	print("player")
	$Line2D.rotation = -45
	$Line2D2.rotation = 45
	$Line2D.line_break()
	await $Line2D2.line_break()
	call_deferred("transition_to_game")
	
func transition_to_game() -> void:
	$Player.reparent(GlobalSignals)
	$BorderWindow.reparent(GlobalSignals)
	get_tree().change_scene_to_file("res://main.tscn")
