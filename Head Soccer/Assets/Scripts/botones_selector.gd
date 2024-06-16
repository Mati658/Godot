extends Control

var seleccion_anterior

# Called when the node enters the scene tree for the first time.
func _ready():
	seleccion_anterior = get_node("botines")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_botines_get_seleccion(seleccion):
	seleccion_anterior.button_pressed = false
	seleccion.button_pressed = true
	self.seleccion_anterior = seleccion
