extends NodeBase

# NEED TO CLEANUP, A BUNCH IS JUST HARDCODED KINDA

@onready var hitbox_component: HitboxComponent = $HitboxComponent

@onready var collision_shape_2d: CollisionShape2D = $HitboxComponent/CollisionShape2D
@onready var window: Window = $Window
var position: Vector2

const BULLET: PackedScene = preload("res://scripts/player/weapons/bullet.tscn")

func _ready() -> void:
	collision_shape_2d.shape.size = Vector2i(window.size.x, window.size.y)

var move_dir = Vector2i(10, 0)

func _process(_delta: float) -> void:
	hitbox_component.position = Vector2(window.position)
	
	if (window.position.x > get_window().size.x or window.position.x < 0):
		move_dir *= -1
	window.position += move_dir
	position = window.position

func shoot() -> void:
	if !GlobalData.player: return
	var new_bullet: Node = BULLET.instantiate()
	new_bullet.target = 4
	new_bullet.attack_damage = 1
		@warning_ignore("integer_division")
	new_bullet.global_position = window.position + (window.size / 2)
	new_bullet.look_at(GlobalData.player.global_position)
	var dir = GlobalData.player.global_position - Vector2(window.position)
	new_bullet.target_direction = (dir).normalized()
	get_tree().root.add_child(new_bullet)
	

func _on_timer_timeout() -> void:
	shoot()
