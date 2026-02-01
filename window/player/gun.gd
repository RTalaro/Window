extends Sprite2D

@onready var bullet_spawn: Marker2D = $BulletSpawn
const BULLET = preload("res://player/bullet.tscn")

func _process(_delta):
	look_at(get_global_mouse_position())

func shoot() -> void:
	var new_bullet = BULLET.instantiate()
	new_bullet.position = bullet_spawn.global_position
	new_bullet.look_at(get_global_mouse_position())
	new_bullet.target_direction = (get_global_mouse_position() - bullet_spawn.global_position).normalized()
	get_tree().root.add_child(new_bullet)
