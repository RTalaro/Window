class_name EnemyBase
extends CharacterBodyBase

@export var speed: float = 100.0
@export var wander_speed: float = 40.0

var player: Node2D
var chasing: bool = false

var wander_dir: Vector2 = Vector2.ZERO
var wander_time: float = 0.0

var knockback: Vector2 = Vector2.ZERO

# Attack Info
var attack_damage: float
var knockback_force: float
var knockback_timer: float
var stun_time: float

@onready var damage_component: Area2D = $DamageComponent

func _ready() -> void:
	damage_component.area_entered.connect(_on_damage_area_entered)

func _physics_process(delta):
	if knockback_timer > 0.0:
		recieve_knockback(delta)
	else:
		movement(delta)
	move_and_slide()
	
func recieve_knockback(delta):
	velocity = knockback
	knockback_timer -= delta
	if knockback_timer <= 0.0:
		knockback = Vector2.ZERO

func movement(_delta):
	return
		
func wander(delta):
	wander_time -= delta
	if wander_time <= 0:
		wander_time = randf_range(1.0, 2.5)
		wander_dir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	velocity = wander_dir * wander_speed
	
func _on_damage_area_entered(area) -> void:
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		
		var attack: Attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_dir = (area.position - position).normalized()
		attack.knockback_force = knockback_force
		attack.knockback_timer = knockback_timer
		attack.attack_position = global_position
		attack.stun_time = stun_time
		
		print("damaged")
		hitbox.damage(attack)
