extends Node2D

@onready var pivot_point: Node2D = $PivotPoint
@onready var bullet_spawn: Marker2D = $PivotPoint/Gun/Marker2D
@onready var sprite_2d : Sprite2D = $Base

@export var target : CharacterBody2D

const BULLET = preload("res://player/weapons/bullet.tscn")

@export var window : Window

@onready var base: Sprite2D = $Base

func _process(_delta):
	if (target):
		pivot_point.look_at(target.position)
	if (window):
		position = window.position + Vector2i(base.get_rect().size / 2)
	
func shoot() -> void:
	var new_bullet = BULLET.instantiate()
	new_bullet.position = bullet_spawn.global_position
	new_bullet.look_at(target.position)
	new_bullet.target_direction = (target.position - bullet_spawn.global_position).normalized()
	get_tree().root.add_child(new_bullet)


func _on_attack_cooldown_timeout() -> void:
	if (target):
		shoot()


func _on_turret_detection_area_entered(area: Area2D) -> void:
	target = area.get_parent()


func _on_turret_detection_area_exited(_area: Area2D) -> void:
	target = null
