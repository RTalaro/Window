extends CharacterBody2D

@export var speed: int = 400
@export var despawn_time: int = 3
@export var piercing: int = 0
@export var target_direction: Vector2 = Vector2(1, 0)

var attack_damage: float = 10.0
var knockback_force: float = 150.0
var stun_time: float = 10.0
var knockback_timer: float = 0.12

var target: int = 1
@onready var target_collision: Area2D = $TargetCollision

func _ready() -> void: 
	target_collision.set_collision_mask_value(target, true)
	despawn()

func _physics_process(_delta: float) -> void:
	velocity = target_direction * speed
	move_and_slide()


func despawn() -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()


func _on_target_collision_area_entered(area):
	if piercing <= 0:
		queue_free()
	piercing -= 1
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		
		var attack: Attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_dir = (area.position - position).normalized()
		attack.knockback_force = knockback_force
		attack.knockback_timer = knockback_timer
		attack.attack_position = global_position
		attack.stun_time = stun_time
		
		hitbox.damage(attack)
