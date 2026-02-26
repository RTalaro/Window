extends Node

const PLAYER: PackedScene = preload("res://scripts/player/player.tscn")
const BORDER_WINDOW: PackedScene = preload("uid://ccexg66yj5j51")

var player: Player
var game_window: NodeBase
var offset: Vector2i

func _ready() -> void:
	var p: Node = PLAYER.instantiate()
	p.position = get_window().size / 2
	add_child(p)
	player = p
	
	var bw: Node = BORDER_WINDOW.instantiate()
	add_child(bw)
	game_window = bw

func update_instance(p: Player, window: NodeBase):
	# Not sure if this is redundant, but I'm just worried about 
	# different names when using get_node()
	player = p
	game_window = window
