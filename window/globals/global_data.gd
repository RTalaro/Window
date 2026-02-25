extends Node

const PLAYER: PackedScene = preload("res://scripts/player/player.tscn")

var player: Player
var game_window: NodeBase

func _ready() -> void:
	var p: Node = PLAYER.instantiate()
	p.position = get_window().size / 2
	add_child(p)
	
	player = p

func update_instance(p: Player, window: NodeBase):
	# Not sure if this is redundant, but I'm just worried about 
	# different names when using get_node()
	player = p
	game_window = window
