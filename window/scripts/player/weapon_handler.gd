extends Node2D

@export var slot_one: PackedScene
@export var slot_two: PackedScene

var current_weapon: Sprite2D
var alt_weapon: Sprite2D


func _ready() -> void:
	var weapon_one: Node = slot_one.instantiate()
	current_weapon = weapon_one
	add_child(weapon_one)
	
	var weapon_two: Node = slot_two.instantiate()
	weapon_two.visible = false
	alt_weapon = weapon_two
	add_child(weapon_two)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Left Click"):
		current_weapon.shoot()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Slot1"):
		swap_weapon()
	if event.is_action_pressed("Slot2"):
		swap_weapon()


func swap_weapon() -> void:
	var temp: Sprite2D = current_weapon
	current_weapon = alt_weapon
	alt_weapon = temp
	
	alt_weapon.visible = false
	current_weapon.visible = true
