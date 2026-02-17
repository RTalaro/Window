extends ItemBase

@onready var pivot_point: Node2D = $PivotPoint
@onready var bullet_spawn: Marker2D = $PivotPoint/Gun/Marker2D

@export var target : CharacterBody2D
@export var window : Window

const BULLET = preload("res://scripts/player/weapons/bullet.tscn")

func _ready() -> void:
	size = Vector2i(128, 128)

func _process(_delta):
	if (target):
		pivot_point.look_at(target.position)
	if (window):
		position = window.position + Vector2i(size / 2)
	
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

# quick fix added for hifi video
func _on_turret_detection_area_exited(_area: Area2D) -> void:
	target = null
	$TurretDetection.monitoring = false
	$TurretDetection.monitoring = true
	
