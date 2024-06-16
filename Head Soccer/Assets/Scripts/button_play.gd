extends Button
var VBOXTipos
var selector

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	if get_parent() is VBoxContainer:
		Transicion.change_scene("res://scenes/mundo.tscn")
	elif get_parent() is Control:
		$btn_vs.visible = true

