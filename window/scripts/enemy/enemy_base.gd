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
var attack_damage: float = 10.0
var knockback_force: float
var knockback_timer: float
var stun_time: float

@onready var damage_component: Area2D = $DamageComponent
@onready var enemy_player_detection: Area2D = $EnemyPlayerDetection


func _ready() -> void:
	damage_component.area_entered.connect(_on_damage_area_entered)
	enemy_player_detection.body_entered.connect(_on_detection_area_body_entered)
	enemy_player_detection.body_exited.connect(_on_detection_area_body_exited)

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
	
func shoot(bullet: PackedScene) -> void:
	if (!player): return
	var new_bullet: Node = bullet.instantiate()
	new_bullet.target = 4
	new_bullet.global_position = global_position
	new_bullet.look_at(player.global_position)
	var dir = player.global_position - global_position
	new_bullet.target_direction = (dir).normalized()
	get_tree().root.add_child(new_bullet)
	
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
		

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		chasing = true

func _on_detection_area_body_exited(body):
	if body == player:
		chasing = false
