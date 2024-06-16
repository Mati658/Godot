extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	MusicManager.set_music("res://Assets/Audio/Musica/musica1.wav")
	get_tree().paused = false
	get_parent().save_config()
	Transicion.change_scene("res://scenes/menu.tscn")
