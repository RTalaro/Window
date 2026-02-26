extends Window

signal map_ready

@onready var anims = $AnimationPlayer
@onready var window = $Window
@onready var menu = $Window/Menu
@onready var credits_button = $Window/Menu/Buttons/Credits
@onready var play_button = $Window/Menu/Buttons/Play
@onready var options_button = $Window/Menu/Buttons/Options
@onready var title_left = $TitleL
@onready var title_right = $TitleR


func _ready():
	set_windows()
	handle_signals()


func set_windows() -> void:
	# redundancy due to animation bugs
	title_left.position = Vector2i(640, 440)
	title_right.position = Vector2i(1280, 440)
	title_left.size = Vector2i(640, 720)
	title_right.size = Vector2i(640, 720)
	title_left.visible = false
	title_right.visible = false

func handle_signals() -> void:
	window.connect("close_requested", _on_title_close)
	play_button.connect("button_up", _on_play_button_up)
	options_button.connect("button_up", _on_options_button_up)
	credits_button.connect("button_up", _on_credits_button_up)


func _on_title_close() -> void:
	# TO-DO: shrink animation
	get_tree().quit()

func _on_play_button_up() -> void:
	anims.play("start_game")
	await anims.animation_finished
	map_ready.emit()

func _on_options_button_up() -> void:
	pass

func _on_credits_button_up() -> void:
	pass
