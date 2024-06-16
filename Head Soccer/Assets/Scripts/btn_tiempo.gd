extends Button
var VBOXModos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# self.VBOXModos = get_parent().get_parent().get_node("VBoxModos")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	self.flat = false


func _on_btn_goles_button_up():
	self.flat = true
