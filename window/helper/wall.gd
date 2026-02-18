extends ItemBase

@export var window : Window

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	size = sprite_2d.get_rect().size

func _process(_delta: float) -> void:
	if window:
		position = window.position + Vector2i($Sprite2D.get_rect().size / 2)
