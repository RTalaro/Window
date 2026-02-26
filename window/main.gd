extends Control


@onready var timer = $Timer
@onready var title = $Title
@onready var map = $Map

func _ready():
	check_OS()
	await title.map_ready
	map.visible = true
	title.queue_free()
	transition_to_overworld()


func transition_to_overworld() -> void:
	GlobalData.create_game()
	GlobalData.player.gpu_particles_2d.restart()
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")

func check_OS():
	var user_os = OS.get_name()
	if user_os == "Windows":
		theme = load("res://Themes/Modern11/Modern11.tres")
		pass
	elif user_os == "OSX":
		# set Theme for Mac
		pass
