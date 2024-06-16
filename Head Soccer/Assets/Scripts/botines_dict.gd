extends Node

var info_text
var indice
var contador 
var options_node
var btn_comprar
var seleccion
var dict_seleccion
var dict_seleccion_desbloqueados
# Called when the node enters the scene tree for the first time.
func _ready():
	self.options_node = get_node("/root/tienda/options")
	self.options_node.load_config()
	self.btn_comprar = get_node("/root/tienda/botones/btn_comprar")
	self.info_text = get_node("/root/tienda/info")
	self.seleccion = "botines"
	self.get_dict(seleccion)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_botines_get_seleccion(seleccion):
	self.seleccion = seleccion.name
	self.get_dict(seleccion.name)

func get_dict(seleccion):
	match seleccion:
		"botines":
			self.dict_seleccion = self.options_node.botines_dict
			self.dict_seleccion_desbloqueados = self.options_node.botines_desbloqueados
		"heads":
			self.dict_seleccion = self.options_node.heads_dict
			self.dict_seleccion_desbloqueados = self.options_node.heads_desbloqueadas
		"pelotas":
			self.dict_seleccion = self.options_node.pelotas_dict
			self.dict_seleccion_desbloqueados = self.options_node.pelotas_desbloqueadas
		"poderes":
			self.dict_seleccion = self.options_node.poderes_dict
			self.dict_seleccion_desbloqueados = self.options_node.poderes_desbloqueados
		"particulas":
			self.dict_seleccion = self.options_node.particulas_dict
		"estelas":
			self.dict_seleccion = self.options_node.estelas_dict
		"mapas":
			self.dict_seleccion = self.options_node.mapas_dict
		"obstaculos":
			self.dict_seleccion = self.options_node.obstaculos_dict


func _on_btn_botin_get_botin(padre, abuelo, hijo):
	self.indice = -1
	# print(self.dict_seleccion)
	for item in self.dict_seleccion.values():
		self.indice += 1
		# print(item)
		if item["nombre"] == padre.name:
			if item["comprado"]:
				self.btn_comprar.disabled = true
				self.btn_comprar.text = ""
				self.btn_comprar.icon = load("res://Assets/images/botones/Btn comprado.png")
				self.btn_comprar.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			else:
				self.btn_comprar.disabled = false
				self.btn_comprar.icon = load("res://Assets/images/objetos_escena/coin.png")
				self.btn_comprar.icon_alignment = HORIZONTAL_ALIGNMENT_LEFT
				self.btn_comprar.text = str(item["precio"])
			
			if self.seleccion == "poderes":
				self.info_text.text = item["info"]
			else:
				self.info_text.text = ""

			break


func _on_btn_comprar_button_up():
	if self.options_node.coins >= self.dict_seleccion[self.indice]["precio"]:

		self.options_node.coins -= self.dict_seleccion[self.indice]["precio"]

		self.contador = 0
		
		match self.seleccion:
			"botines":
				for item in self.dict_seleccion_desbloqueados["p1"]:
					self.contador += 1
				self.options_node.botines_dict[self.indice]["comprado"] = true
				self.options_node.botines_desbloqueados["p1"][self.contador] = self.options_node.botines_dict[self.indice]["sprite"]
				self.options_node.botines_desbloqueados["p2"][self.contador] = self.options_node.botines_dict[self.indice]["sprite_reverse"]
			"heads":
				for item in self.dict_seleccion_desbloqueados["p1"]:
					self.contador += 1
				self.options_node.heads_dict[self.indice]["comprado"] = true
				self.options_node.heads_desbloqueadas["p1"][self.contador] = self.options_node.heads_dict[self.indice]["sprite_reverse"]
				self.options_node.heads_desbloqueadas["p2"][self.contador] = self.options_node.heads_dict[self.indice]["sprite"]
			"pelotas":
				self.options_node.pelotas_dict[self.indice]["comprado"] = true
				self.contador = self.options_node.pelotas_desbloqueadas.size()
				self.options_node.pelotas_desbloqueadas[self.contador] = self.options_node.pelotas_dict[self.indice]["sprite"]
			"poderes":
				self.options_node.poderes_dict[self.indice]["comprado"] = true
				var tipo = self.options_node.poderes_dict[self.indice]["tipo"]
				if tipo == "good" or tipo == "bad":
					self.contador = self.options_node.poderes_desbloqueados[tipo].size()
					self.options_node.poderes_desbloqueados[tipo][self.contador] = {"poder": self.options_node.poderes_dict[self.indice]["poder"] ,"sprite" : self.options_node.poderes_dict[self.indice]["sprite"]}
					if self.options_node.poderes_dict[self.indice + 1]["nombre"] == self.options_node.poderes_dict[self.indice]["nombre"]:
						self.contador = self.options_node.poderes_desbloqueados["bad"].size()
						self.options_node.poderes_desbloqueados["bad"][self.contador] ={"poder": self.options_node.poderes_dict[self.indice+1]["poder"] ,"sprite" : self.options_node.poderes_dict[self.indice+1]["sprite"]}
				else:	
					self.contador = self.options_node.poderes_desbloqueados["good"].size()
					self.options_node.poderes_desbloqueados["good"][self.contador] = {"poder": self.options_node.poderes_dict[self.indice]["poder"] ,"sprite" : self.options_node.poderes_dict[self.indice]["sprite"]}
					self.contador = self.options_node.poderes_desbloqueados["bad"].size()
					self.options_node.poderes_desbloqueados["bad"][self.contador] = {"poder": self.options_node.poderes_dict[self.indice]["poder"] ,"sprite" : self.options_node.poderes_dict[self.indice]["sprite"]}
			"particulas":
				self.options_node.particulas_dict[self.indice]["comprado"] = true
			"estelas":
				self.options_node.estelas_dict[self.indice]["comprado"] = true
			"mapas":
				self.options_node.mapas_dict[self.indice]["comprado"] = true
				self.contador = self.options_node.mapas_desbloqueados.size()
				self.options_node.mapas_desbloqueados[self.contador] = {"nombre" : self.options_node.mapas_dict[self.indice]["nombre"], "sprite" : self.options_node.mapas_dict[self.indice]["sprite"]}
			"obstaculos":
				self.options_node.obstaculos_dict[self.indice]["comprado"] = true
				self.contador = self.options_node.obstaculos_desbloqueados.size()
				self.options_node.obstaculos_desbloqueados[self.contador] = {"nombre" = self.options_node.obstaculos_dict[self.indice]["nombre"], "sprite" = self.options_node.obstaculos_dict[self.indice]["sprite"]}

		get_node("/root/tienda/botones/comprado_sound").play()
		self.options_node.save_config()
		self.btn_comprar.disabled = true
		self.btn_comprar.text = ""
		self.btn_comprar.icon = load("res://Assets/images/botones/Btn comprado.png")
		self.btn_comprar.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		self.get_dict(self.seleccion)
		var label_coin = get_node("/root/tienda/Label_coins")
		label_coin.text = str(self.options_node.coins)		

