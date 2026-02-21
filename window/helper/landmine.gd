extends ItemBase
@export var window: Window
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosion_area: Area2D = $ExplosionArea

var attack_damage: float = 200.0
var knockback_force: float = 100.0
var stun_time: float = 10.0

func _ready() -> void:
	size = sprite_2d.get_rect().size

func _process(_delta: float) -> void:
	if window:
		position = window.position + Vector2i(sprite_2d.get_rect().size / 2)


func damage_area() -> void:
	for area in explosion_area.get_overlapping_areas():
		if area is HitboxComponent:
			var hitbox: HitboxComponent = area
			
			var attack: Attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.attack_position = global_position
			attack.stun_time = stun_time
			
			hitbox.damage(attack)
			
	get_parent().queue_free()


func _on_trigger_area_area_entered(area: Area2D) -> void:
	sprite_2d.modulate = Color(1, 0, 0)
	await get_tree().create_timer(1).timeout
	damage_area()
