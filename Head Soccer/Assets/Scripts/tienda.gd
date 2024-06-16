extends Control

var h_scrollbar
var last_mouse_pos = Vector2.ZERO
var seleccion_control
var spawn_base
var spawn_derecha = -359
var spawn_izquierda = -359
var flag_lado = false	#false -> izquierda		true -> derecha
var scroll_block = false
var flag_valor = 0
var valor_neg = -550
var valor_pos = 550
var valor_spawn_pos = 1100
var valor_spawn_neg = -1100
var options_node
var btn_anterior_selector
var selec_actual
var dict_spawn
# Called when the node enters the scene tree for the first time.
func _ready():
	self.options_node = $options
	self.options_node.load_config()
	$Label_coins.text = str(self.options_node.coins)
	$botones/botines.button_pressed = true
	h_scrollbar = get_node("HScrollBar")
	self.dict_spawn = {"botines": { "spawn_derecha": -359, "spawn_izquierda": -359 },
						"heads": {"spawn_derecha": -359, "spawn_izquierda": -359 },
						"pelotas": {"spawn_derecha": -359, "spawn_izquierda": -359 },
						"poderes" : {"spawn_derecha": -0, "spawn_izquierda": -0 },
						"particulas" : {"spawn_derecha": -0, "spawn_izquierda": -578 },
						"estelas" : {"spawn_derecha": -0, "spawn_izquierda": -578 },
						"mapas" : {"spawn_derecha": -0, "spawn_izquierda": -0 },
						"obstaculos" : {"spawn_derecha": -0, "spawn_izquierda": -578 }
						}
						
	self.spawn_base = -359
	
	self.flag_lado = true
	self.selec_actual = $RichTextLabel/obstaculos
	self.seleccion_control = $RichTextLabel/obstaculos/CanvasGroup	
	spawn_seleccion(Vector2(-self.spawn_base + get_hijos(-self.spawn_base, self.selec_actual), 0))
	self.flag_lado = false
	spawn_seleccion(Vector2(-self.spawn_base + get_hijos(-self.spawn_base, self.selec_actual), 0))

	self.selec_actual = $RichTextLabel/mapas
	self.seleccion_control = $RichTextLabel/mapas/CanvasGroup	
	spawn_seleccion(Vector2(-self.spawn_base + get_hijos(-self.spawn_base, self.selec_actual), 0))
	self.flag_lado = true
	spawn_seleccion(Vector2(-self.spawn_base + get_hijos(-self.spawn_base, self.selec_actual), 0))

	self.selec_actual = $RichTextLabel/poderes
	self.seleccion_control = $RichTextLabel/poderes/CanvasGroup
	spawn_seleccion(Vector2(-self.spawn_base + get_hijos(-self.spawn_base, self.selec_actual), 0))
	self.flag_lado = false
	spawn_seleccion(Vector2(self.spawn_base + -get_hijos(-self.spawn_base, self.selec_actual) , 0))

	self.selec_actual = $RichTextLabel/pelotas
	self.seleccion_control = $RichTextLabel/pelotas/CanvasGroup
	spawn_seleccion(Vector2(self.spawn_base + -get_hijos(-self.spawn_base, self.selec_actual) , 0))

	self.selec_actual = $RichTextLabel/heads
	self.seleccion_control = $RichTextLabel/heads/CanvasGroup
	spawn_seleccion(Vector2(self.spawn_base + -get_hijos(-self.spawn_base, self.selec_actual) , 0))

	self.selec_actual = $RichTextLabel/botines
	self.seleccion_control = $RichTextLabel/botines/CanvasGroup
	spawn_seleccion(Vector2(self.spawn_base + -get_hijos(-self.spawn_base, self.selec_actual) , 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.get_control(self.selec_actual).position.x = -h_scrollbar.value 

func get_control(seleccion):
	return get_node("RichTextLabel/{seleccion}".format({"seleccion":seleccion.name}))

func get_hijos(spawn : int, seleccion):
	# var hijo = "RichTextLabel/{seleccion}/CanvasGroup".format({"seleccion":seleccion.name})
	return (get_node("RichTextLabel/{seleccion}/CanvasGroup".format({"seleccion":seleccion.name})).get_child_count() * 289) - spawn
	

func _on_rich_text_label_gui_input(event):
	if event is InputEventMouse and event.button_mask == 1 and !scroll_block:
		var delta = event.position.x - last_mouse_pos.x
		h_scrollbar.value -= delta * 1 
		
		if h_scrollbar.value >= flag_valor:
			valor_neg = h_scrollbar.value -550
			valor_pos = h_scrollbar.value +550
			if  valor_pos  >= self.valor_spawn_pos and valor_pos <= self.valor_spawn_pos * 1.2:
				self.flag_lado = true
				spawn_seleccion(Vector2(self.spawn_derecha + get_hijos(self.spawn_derecha, self.selec_actual), 0))
				self.valor_spawn_pos = valor_pos + 1100
		elif h_scrollbar.value <= flag_valor:
			valor_neg = h_scrollbar.value -550
			valor_pos = h_scrollbar.value +550
			if  valor_neg  <= self.valor_spawn_neg and valor_neg >= self.valor_spawn_neg * 1.2:
				self.flag_lado = false
				spawn_seleccion(Vector2(self.spawn_izquierda - get_hijos(-self.spawn_izquierda, self.selec_actual), 0))
				self.valor_spawn_neg = valor_neg - 1100
			
		flag_valor = h_scrollbar.value
	last_mouse_pos = event.position

func spawn_seleccion(pos_x : Vector2):
	var position2

	var nuevos_seleccion = self.seleccion_control.duplicate()
	if self.flag_lado:	#derecha
		nuevos_seleccion.position.x = self.dict_spawn[self.selec_actual.name]["spawn_derecha"]
		position2 = nuevos_seleccion.position + pos_x
		self.spawn_derecha = position2.x
		self.dict_spawn[self.selec_actual.name]["spawn_derecha"] = self.spawn_derecha
	else:				#izquierda
		nuevos_seleccion.position.x =  self.dict_spawn[self.selec_actual.name]["spawn_izquierda"]
		position2 = nuevos_seleccion.position + pos_x
		self.spawn_izquierda = position2.x
		self.dict_spawn[self.selec_actual.name]["spawn_izquierda"] = self.spawn_izquierda

	nuevos_seleccion.position = position2

	for botines in nuevos_seleccion.get_children():
		botines.get_child(0).button_pressed = false
	self.get_control(self.selec_actual).add_child(nuevos_seleccion)
	

func _on_botin_1_gui_input(event):
	if event is InputEventMouseMotion and !scroll_block:
		if event is InputEventMouse and event.button_mask == 1:
			var delta = event.position.x - last_mouse_pos.x
			h_scrollbar.value -= (delta * 0.15)
		last_mouse_pos = event.position
	# print(h_scrollbar.value)


func _on_btn_atras_button_up():
	Transicion.change_scene("res://scenes/menu.tscn")


func _on_btn_botines_get_seleccion(seleccion):
	$botones/boton_sound.play()
	self.reestablecer_valores()
	self.selec_actual = seleccion

	if seleccion.name == "particulas" or seleccion.name == "estelas":
		scroll_block = true
	else:
		scroll_block = false

	self.seleccion_control = get_node("RichTextLabel/{seleccion}/CanvasGroup".format({"seleccion":seleccion.name}))
	self.cambiar_scroll("RichTextLabel/{seleccion}".format({"seleccion":seleccion.name}), 
	"RichTextLabel/{seleccion_anterior}".format({"seleccion_anterior":$botones.seleccion_anterior.name}))

	self.establecer_botones()

	if self.btn_anterior_selector != null:
		self.btn_anterior_selector.button_pressed = false

func cambiar_scroll(control_actual, control_anterior):
	get_node(control_actual).visible = true
	if control_actual != control_anterior:
		get_node(control_anterior).visible = false
	


func _on_btn_botin_get_botin(padre, abuelo, hijo):
	self.btn_anterior_selector = hijo

func reestablecer_valores():
	h_scrollbar.value = 0
	valor_neg = h_scrollbar.value -550
	valor_pos = h_scrollbar.value +550
	self.valor_spawn_pos = 1100
	self.valor_spawn_neg = -1100


func establecer_botones():
	if selec_actual.name == "pelotas" or selec_actual.name == "particulas" or selec_actual.name == "estelas":
		$botones/particulas.visible = true
		$botones/estelas.visible = true
		$botones/obstaculos.visible = false
	else:
		if selec_actual.name == "mapas" or selec_actual.name == "obstaculos":
			$botones/obstaculos.visible = true
			$botones/particulas.visible = false
			$botones/estelas.visible = false
		else:
			$botones/particulas.visible = false
			$botones/estelas.visible = false
			$botones/obstaculos.visible = false
