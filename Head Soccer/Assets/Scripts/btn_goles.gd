extends Button
var VBOXModos
var selector
# Called when the node enters the scene tree for the first time.
func _ready():
	selector = self.get_parent().get_parent()
	# self.VBOXModos = get_parent().get_parent().get_node("VBoxModos")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_up():
	self.flat = false
	selector.modo_juego = "goles"
	selector.flag_btn1 = true

func _on_btn_tiempo_button_up():
	self.flat = true
	selector.modo_juego = "tiempo"
	selector.flag_btn1 = true
