class_name Attack

var attack_damage: int = 1
var attack_position: Vector2 = Vector2(0,0)
var stun_time: float = 1.0

var knockback_dir: Vector2 = Vector2.ZERO
var knockback_force: float = 0.0
var knockback_timer: float = 0.0

# Constructor for cleaner implementation in other areas
func set_variables(atk_dmg: int, atk_pos: Vector2, stun: float, 
					kb_dir: Vector2, kb_force: float, kb_timer: float) -> void:
	attack_damage = atk_dmg
	attack_position = atk_pos
	stun_time = stun
	knockback_dir = kb_dir
	knockback_force = kb_force
	knockback_timer = kb_timer
	return 
