extends Node2D

@export var window : Window

@onready var sprite_2d: Sprite2D = $Sprite2D


func _process(delta: float) -> void:
	position = window.position + Vector2i($Sprite2D.get_rect().size / 2)
