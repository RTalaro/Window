extends ItemBase

@export var window : Window

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var wall_collilsion: CollisionShape2D = $WallCollision/CollisionShape2D
@onready var hitbox_collision: CollisionShape2D = $HitboxComponent/CollisionShape2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	size = sprite_2d.get_rect().size

func _process(_delta: float) -> void:
	if window:
		position = window.position + Vector2i(sprite_2d.get_rect().size / 2)

func rebuild_wall() -> void:
	gpu_particles_2d.restart()
	sprite_2d.visible = false
	wall_collilsion.set_deferred("disabled", true)
	hitbox_collision.set_deferred("disabled", true)
	await get_tree().create_timer(3).timeout
	sprite_2d.visible = true
	wall_collilsion.set_deferred("disabled", false)
	hitbox_collision.set_deferred("disabled", false)
	
	var size_y: float = size.y / 2.0
	scale = Vector2(1, 0)
	position.y += size_y
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1, 1), 1)
	tween.tween_property(self, "position", position - Vector2(0, size_y), 1)
	gpu_particles_2d.restart()
