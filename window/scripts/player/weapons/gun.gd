extends Sprite2D

@export var cooldown: float = 1.0
@export var automatic: bool = false
@export var bullet_speed: float = 400.0
@export var bullet_damage: int = 10

var can_shoot: bool = true

const BULLET: PackedScene = preload("res://scripts/player/weapons/bullet.tscn")

@onready var bullet_spawn: Marker2D = $BulletSpawn
@onready var timer: Timer = $Timer


func _process(_delta):
	look_at(get_global_mouse_position())


func shoot() -> void:
	if can_shoot:
		can_shoot = false
		timer.start(cooldown)
		var new_bullet: Node = BULLET.instantiate()
		new_bullet.speed = bullet_speed
		new_bullet.attack_damage = bullet_damage
		new_bullet.target = 7
		new_bullet.position = bullet_spawn.global_position
		new_bullet.look_at(get_global_mouse_position())
		new_bullet.target_direction = (get_global_mouse_position() - global_position).normalized()
		get_tree().root.add_child(new_bullet)
		
		if !automatic:
			Input.action_release("Left Click")


func _on_timer_timeout() -> void:
	can_shoot = true
