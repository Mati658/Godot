extends Node2D

var btn_anterior
var flag_primer_btn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_botin_get_botin(padre, abuelo, hijo):
	if !flag_primer_btn and btn_anterior != hijo:
		btn_anterior.button_pressed = false
	
	# print(padre.name)
	flag_primer_btn = false
	btn_anterior = hijo
	# print(padre.name)
