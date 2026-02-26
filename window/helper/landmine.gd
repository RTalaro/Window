extends ItemBase

var attack_damage: float = 50.0
var knockback_force: float = 100.0
var stun_time: float = 10.0
var triggered: bool = false

@export var window: Window
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var trigger_area: Area2D = $TriggerArea
@onready var explosion_area: Area2D = $ExplosionArea
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	size = sprite_2d.get_rect().size * sprite_2d.scale

func _process(_delta: float) -> void:
	if window:
		position = window.position + Vector2i(size / 2)

func _on_trigger_area_area_entered(_area: Area2D) -> void:
	if triggered: return # Stops landmines from triggering multiple times
	sprite_2d.frame = 1
	var tween: Tween = create_tween()
	triggered = true
	tween.tween_property(sprite_2d, "modulate", Color(1, 0, 0), 0.8)
	await get_tree().create_timer(1).timeout
	gpu_particles_2d.restart()
	damage_area()
	
func damage_area() -> void:
	sprite_2d.modulate = Color(0, 0, 0, 0)
	for area in explosion_area.get_overlapping_areas():
		if area is HitboxComponent:
			var hitbox: HitboxComponent = area
			
			var attack: Attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.attack_position = global_position
			attack.stun_time = stun_time
			
			hitbox.damage(attack)

	# This is stupid LOL
	if get_parent().get_parent().get_parent().game_window:
		get_parent().get_parent().get_parent().game_window.add_trauma(0.7)
	recharge_mine()

func recharge_mine() -> void:
	trigger_area.monitoring = false
	explosion_area.monitoring = false
	var tween: Tween = create_tween()
	tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 1), 5)
	await get_tree().create_timer(5).timeout
	trigger_area.monitoring = true
	explosion_area.monitoring = true
	triggered = false
	sprite_2d.frame = 0
