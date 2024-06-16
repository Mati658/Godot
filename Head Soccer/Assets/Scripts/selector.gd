extends Control

signal get_mapa(mapa_sprite : int, obstaculo_nombre : String)
signal get_pelota(sprite)
signal get_personaje1(personaje1_head, personaje1_botin)
signal get_personaje2(personaje2_head, personaje2_botin)
signal get_modo_juego(modo_juego, flag_extras)
signal get_jugador(flag_jugador)

var mapa_rect
var obstaculos_rect
var dict_heads_p1
var dict_heads_p2
var dict_botines_p1
var dict_botines_p2
var dict_mapas
var mapa_int = 0
var obstaculos_int = 0
var p1_head_int = 0
var p2_head_int = 0
var p1_botin_int = 0
var p2_botin_int = 0
var pelota_int = 0
var flag_btn1 = false
var flag_btn2 = false
var modo_juego
var flag_extras
var pelota
var personaje1_head
var personaje1_botin
var personaje2_head
var personaje2_botin
var options_node
var flag_jugador  #true = persona | false = IA

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.process_mode = AudioStreamPlayer.PROCESS_MODE_ALWAYS
	mapa_rect = $ColorRect/mapa_rect
	obstaculos_rect = $ColorRect/obstaculo_rect
	pelota = get_node("pelota/Sprite2D")
	var personaje1 = $personaje_2 
	var personaje2 = $personaje_1
	personaje1_head = personaje1.head	#NO ES UN ERROR EL PERSONAJE. O SEA, SÍ ES UN ERROR DE CUANDO NOMBRÉ LOS PERSONAJES POR PRIMERA VEZ, PERO BUENO YA ESTÁ
	personaje1_botin = personaje1.botin
	personaje2_head = personaje2.head
	personaje2_botin = personaje2.botin
	options_node = $options
	options_node.load_config()

	mapa_rect.texture = load(options_node.mapas_desbloqueados[self.mapa_int]["sprite"])
	obstaculos_rect.texture = load(options_node.obstaculos_desbloqueados[self.obstaculos_int]["sprite"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag_btn1 == false or flag_btn2 == false:
		$btn_play.disabled = true
	else:
		$btn_play.disabled = false
#-------------------------------------HEAD------------------------------------
func _on_btn_p_2_l_button_up():
	if p2_head_int > 0:
		p2_head_int -= 1
	else:
		p2_head_int = self.options_node.heads_desbloqueadas["p2"].size() -1

	personaje2_head.texture = load(self.options_node.heads_desbloqueadas["p2"][p2_head_int])

func _on_btn_p_2_r_button_up():
	if p2_head_int < self.options_node.heads_desbloqueadas["p2"].size() -1:
		p2_head_int += 1
	else:
		p2_head_int = 0
	personaje2_head.texture = load(self.options_node.heads_desbloqueadas["p2"][p2_head_int])

func _on_btn_p_1_l_button_up():
	if p1_head_int > 0:
		p1_head_int -= 1
	else:
		p1_head_int = self.options_node.heads_desbloqueadas["p1"].size() -1

	personaje1_head.texture = load(self.options_node.heads_desbloqueadas["p1"][p1_head_int])

func _on_btn_p_1_r_button_up():
	if p1_head_int < self.options_node.heads_desbloqueadas["p1"].size() -1:
		p1_head_int += 1
	else:
		p1_head_int = 0
		
	personaje1_head.texture = load(self.options_node.heads_desbloqueadas["p1"][p1_head_int])

#-----------------------------------BOTINES-----------------------------------
func _on_btn_p_2_l_2_button_up():
	if p2_botin_int > 0:
		p2_botin_int -= 1
	else:
		p2_botin_int = self.options_node.botines_desbloqueados["p2"].size() -1

	personaje2_botin.texture = load(self.options_node.botines_desbloqueados["p2"][p2_botin_int])
	
func _on_btn_p_2_r_2_button_up():
	if p2_botin_int < self.options_node.botines_desbloqueados["p2"].size() -1:
		p2_botin_int += 1
	else:
		p2_botin_int = 0

	personaje2_botin.texture = load(self.options_node.botines_desbloqueados["p2"][p2_botin_int])

func _on_btn_p_1_l_2_button_up():
	if p1_botin_int > 0:
		p1_botin_int -= 1
	else:
		p1_botin_int = self.options_node.botines_desbloqueados["p1"].size() -1

	personaje1_botin.texture = load(self.options_node.botines_desbloqueados["p1"][p1_botin_int])
	print(p1_botin_int)
func _on_btn_p_1_r_2_button_up():
	if p1_botin_int < self.options_node.botines_desbloqueados["p1"].size() -1:
		p1_botin_int += 1
	else:
		p1_botin_int = 0
		
	personaje1_botin.texture = load(self.options_node.botines_desbloqueados["p1"][p1_botin_int])
	

#-----------------------------------PELOTA------------------------------------
func _on_btn_pelota_l_button_up():
	if pelota_int > 0:
		pelota_int -= 1
	else:
		pelota_int = self.options_node.pelotas_desbloqueadas.size() -1

	pelota.texture = load(self.options_node.pelotas_desbloqueadas[pelota_int])

func _on_btn_pelota_r_button_up():
	if pelota_int < self.options_node.pelotas_desbloqueadas.size() -1:
			pelota_int += 1
	else:
		pelota_int = 0
	
	pelota.texture = load(self.options_node.pelotas_desbloqueadas[pelota_int])
#------------------------------------MAPA-------------------------------------
func _on_btn_map_l_button_up():
	if self.mapa_int > 0:
		self.mapa_int -= 1
	else:
		self.mapa_int = options_node.mapas_desbloqueados.size() -1

	mapa_rect.texture = load(options_node.mapas_desbloqueados[self.mapa_int]["sprite"])

func _on_btn_map_r_button_up():
	if self.mapa_int < options_node.mapas_desbloqueados.size() -1:
		self.mapa_int += 1
	else:
		self.mapa_int = 0

	mapa_rect.texture = load(options_node.mapas_desbloqueados[self.mapa_int]["sprite"])
#---------------------------------OBSTACULOS----------------------------------
func _on_btn_map_l_2_button_up():
	if self.obstaculos_int > 0:
		self.obstaculos_int -= 1
	else:
		self.obstaculos_int = options_node.obstaculos_desbloqueados.size() -1

	obstaculos_rect.texture = load(options_node.obstaculos_desbloqueados[self.obstaculos_int]["sprite"])

func _on_btn_map_r_2_button_up():
	if self.obstaculos_int < options_node.obstaculos_desbloqueados.size() -1:
		self.obstaculos_int += 1
	else:
		self.obstaculos_int = 0

	obstaculos_rect.texture = load(options_node.obstaculos_desbloqueados[self.obstaculos_int]["sprite"])
#-----------------------------------------------------------------------------
func _on_btn_atras_button_up():
	get_tree().paused = false
	Transicion.change_scene("res://scenes/menu.tscn")

func _on_btn_local_button_up():
	$btn_play/btn_vs/Play.play()
	self.flag_jugador = true

func _on_btn_ia_button_up():
	$btn_play/btn_vs/Play.play()
	self.flag_jugador = false

func _on_play_finished():
	get_mapa.emit(options_node.mapas_desbloqueados[self.mapa_int]["sprite"], options_node.obstaculos_desbloqueados[self.obstaculos_int]["nombre"])
	get_pelota.emit(self.pelota)
	get_personaje1.emit(self.personaje1_head, self.personaje1_botin)
	get_personaje2.emit(self.personaje2_head, self.personaje2_botin)
	get_modo_juego.emit(self.modo_juego, self.flag_extras)
	get_jugador.emit(self.flag_jugador)
	var selector = get_parent().get_node("Selector")
	selector.visible = false
	selector.queue_free()