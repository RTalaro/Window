extends Sprite2D

@export var slot_one: PackedScene
@export var slot_two: PackedScene

var current_weapon: Sprite2D
var alt_weapon: Sprite2D


func _ready() -> void:
	var weapon_one: Node = slot_one.instantiate()
	weapon_one.offset = offset
	current_weapon = weapon_one
	add_child(weapon_one)
	
	var weapon_two: Node = slot_two.instantiate()
	weapon_two.offset = offset
	weapon_two.visible = false
	alt_weapon = weapon_two
	add_child(weapon_two)

func _process(_delta: float) -> void:
	if get_global_mouse_position().x >= global_position.x:
		current_weapon.flip_v = false
	else:
		current_weapon.flip_v = true
	look_at(get_global_mouse_position())
	if !GlobalData.can_shoot: return
	if Input.is_action_just_pressed("Slot1"):
		swap_weapon()
	if Input.is_action_just_pressed("Slot2"):
		swap_weapon()
	if Input.is_action_just_pressed("Scroll"):
		swap_weapon()
	if Input.is_action_pressed("Left Click"):
		current_weapon.shoot()

func swap_weapon() -> void:
	var temp: Sprite2D = current_weapon
	current_weapon = alt_weapon
	alt_weapon = temp
	
	alt_weapon.visible = false
	current_weapon.visible = true
