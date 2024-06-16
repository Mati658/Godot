extends Node

@onready var audio_player = $AudioStreamPlayer

func _ready():
	if not audio_player.playing:
		audio_player.stream = preload("res://Assets/Audio/Musica/musica1.wav")
		audio_player.play()

func set_music(music_path: String):
	audio_player.stream = load(music_path)
	audio_player.play()
