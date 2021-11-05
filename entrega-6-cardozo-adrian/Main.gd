extends Node

onready var player = $Environment/Player
onready var background: AudioStreamPlayer = $Background
onready var background_birds: AudioStreamPlayer = $BackgroundBirds
onready var game_over_audio: AudioStreamPlayer = $GameOver

export (AudioStream) var game_over_sfx: AudioStream

func _ready():
	randomize()
	player.initialize(self)

func _unhandled_input(event):
	if event.is_action("restart"):
		_restart_level()

func _restart_level():
	get_tree().reload_current_scene()



func game_over():
	background.stop()
	background_birds.stop()
	game_over_audio.stream = game_over_sfx
	game_over_audio.play()
