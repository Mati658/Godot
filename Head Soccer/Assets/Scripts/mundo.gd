extends Node2D

var Coin
var Poder
var pelota_spawn
var personaje1_spawn
var personaje_2_spawn
var globo_spawn
var gol_animacion
var score_player1 = 0
var score_player2 = 0
var goles_ganar = 7
var label_tiempo = 30
var minutos = 1
var probabilidadCoin = 0.1
var probabilidadPoder = 0.1
var coins = 0
var tiempo_gol
var tiempo_partido
var options_node
var flag_tiempo = false
var flag_gol = false
var flag_gol_p1 = false
var flag_gol_p2 = false
var flag_pausa = false
var flag_animacion = false
var flag_fin = false
var flag_primer_spawn = false
var flag_teledirigido = false
var flag_globos = false
var flag_tenis = false
var timer_globo : Timer
var flag_extras
var flag_modo_tiempo
var flag_modo_goles
var flag_modo_1
var flag_modo_2
var modo_juego
var obstaculos1
var obstaculos2 : CanvasItem
var obstaculos3 : CanvasItem
var nombre_poder
var estampa
var fuerza
var arco_select
var traba1
var traba2
var ambiente_pausa
var coin_sound

func _ready():
	obstaculos1 = get_node("obstaculos/opcion1")
	obstaculos2 = get_node("obstaculos/opcion2")
	obstaculos3 = get_node("obstaculos/opcion3")
	options_node = get_node("options")
	personaje1_spawn = $personaje1_spawn
	personaje_2_spawn = $Personaje2_spawn
	globo_spawn = $globo_spawn
	pelota_spawn = $pelota_spawn
	traba1 = $trabesaño
	traba2 = $trabesaño2
	coin_sound = $coin_sound
	var personajes = get_tree().get_nodes_in_group("gr_personajes")
	for personaje in personajes:
		personaje.flag_moverse = false
		personaje.flag_gravedad = false
	self.get_tree().paused = true

func ready2():
	$labels/puntaje_player1.text = (str)(score_player1)
	$labels/puntaje_player2.text = (str)(score_player2)
	personaje1_spawn.personaje = null
	personaje_2_spawn.personaje = null
	pelota_spawn.pelota.queue_free()
	gol_animacion = $labels/mensaje_gol	
	$silbato_inicio.playing = true
	self.Coin = $coin
	self.Poder = $poderes
	self.tiempo_gol = $Timer
	self.tiempo_partido = $timer_partido
	self.tiempo_gol.start(1)
	self.tiempo_partido.start()
	MusicManager.set_music("res://Assets/Audio/Sonidos/Estadio.mp3")
	MusicManager.process_mode = AudioStreamPlayer.PROCESS_MODE_INHERIT
	if !self.flag_extras:
		self.probabilidadPoder = -1
	
func _process(delta):
	if Input.is_action_just_pressed("ESC") and flag_pausa:
		if !options_node.visible:
			options_node.visible = true
		else:
			options_node.visible = false
			

func _on_arco_body_entered(body):
	$gol.playing = true
	score_player2 += 1 
	$labels/puntaje_player2.text = str(score_player2)
	$Arco/hitbox_gol.call_deferred("set_disabled", true)
	$Arco2/hitbox_gol.call_deferred("set_disabled", true)
	#print("player 1 {score_player1}".format({"score_player1":score_player1}))
	gol_animacion.gol_animacion.play("golazo_tio")
	
	flag_teledirigido = false
	flag_gol_p1 = false
	flag_gol_p2 = true
	flag_gol = true

	if self.modo_juego == "goles":
		if score_player2 == self.goles_ganar:
			self.flag_fin = true
			$silbato_fin.playing = true

	self.tiempo_gol.start(3)
	self.tiempo_partido.paused = true


func _on_arco_2_body_entered(body):
	$gol.playing = true
	score_player1 += 1
	$labels/puntaje_player1.text = str(score_player1)
	$Arco2/hitbox_gol.call_deferred("set_disabled", true)
	$Arco/hitbox_gol.call_deferred("set_disabled", true)
	#print("player 2 {score_player2}".format({"score_player2":score_player2}))
	gol_animacion.gol_animacion.play("golazo_tio")

	flag_teledirigido = false
	flag_gol_p1 = true
	flag_gol_p2 = false
	flag_gol = true

	if self.modo_juego == "goles":
		if score_player1 == self.goles_ganar:
			self.flag_fin = true
			$silbato_fin.playing = true

	self.tiempo_gol.start(3)
	self.tiempo_partido.paused = true


func _on_timer_timeout():
	if (score_player1 > 0 or score_player2 > 0) and !flag_tiempo:
		gol_animacion.gol_animacion.stop()
		self.tiempo_gol.stop()
		$Arco/hitbox_gol.disabled = false
		$Arco2/hitbox_gol.disabled = false

		var personajes = get_tree().get_nodes_in_group("gr_personajes")
		for personaje in personajes:
			personaje.queue_free()

		var pelotas = get_tree().get_nodes_in_group("gr_pelota")
		for pelota in pelotas:
			pelota.queue_free()
		
		get_tree().paused = true
		self.reestablecer_valores()
		flag_tiempo = true
		self.tiempo_gol.start(1)
	else:
		self.tiempo_gol.stop()
		get_tree().paused = false
		flag_tiempo = false
		flag_gol = false
		self.tiempo_partido.paused = false
	
	if flag_fin:
		self.options_node.coins += self.coins
		self.options_node.save_config()
		MusicManager.set_music("res://Assets/Audio/Musica/musica1.wav")
		Transicion.change_scene("res://scenes/mundo.tscn")

	
func _on_selector_get_mapa(mapa_sprite, obstaculo_nombre):
	match obstaculo_nombre:
			"Obstaculo0":
				pass
			"Obstaculo1":
				obstaculos1.visible = true
				for obstaculo in obstaculos1.get_children():
					obstaculo.disabled = false
			"Obstaculo2":
				self.flag_tenis = true
				obstaculos2.visible = true
				for obstaculo in obstaculos2.get_children():
					obstaculo.disabled = false
			"Obstaculo3":
				obstaculos3.visible = true
				for obstaculo in obstaculos3.get_children():
					obstaculo.disabled = false
	
	$cancha/fondo.texture = load(mapa_sprite)

	var paredes = $cancha/paredes
	match mapa_sprite:
			"res://Assets/images/canchas/cancha_2.png":
				paredes.polygon[2] = Vector2(0, 0)
				paredes.polygon[5] = Vector2(1280, 0)
				flag_globos = true
				$modo_noche.visible = true
				timer_globo = Timer.new()
				timer_globo.autostart = true
				add_child(timer_globo)
				timer_globo.timeout.connect(_timer_globo)
				timer_globo.start(3)
			
			"res://Assets/images/canchas/cancha_4.png":
				paredes.polygon[2] = Vector2(0, 0)
				paredes.polygon[5] = Vector2(1280, 0)
				$modo_noche.visible = true
				$modo_noche/DirectionalLight2D.energy = 0.7
				var fireworks = load("res://scenes/firework.tscn").instantiate()
				add_child(fireworks)
			
			"res://Assets/images/canchas/cancha_5.png":
				paredes.polygon[2] = Vector2(0, 0)
				paredes.polygon[5] = Vector2(1280, 0)
				var sakuras = load("res://scenes/spawn_sakura.tscn").instantiate()
				add_child(sakuras)

			"res://Assets/images/canchas/cancha_6.png":
				paredes.polygon[2] = Vector2(0, 0)
				paredes.polygon[5] = Vector2(1280, 0)
				var humo = load("res://Assets/images/particulas/volcan/humo.tscn").instantiate()
				add_child(humo)
			
			"res://Assets/images/canchas/cancha_7.png":
				$cancha/fondo.texture = load("res://Assets/images/canchas/fondo7.png")
				$cancha/cupula.visible = true
				$cancha/cupula_collision.visible = true
				$cancha/cupula_collision.disabled = false
				var peces = load("res://Assets/images/particulas/peces/peces.tscn").instantiate()
				add_child(peces)

func _timer_globo():
	globo_spawn.spawn_globo($spawn_globos)

func _on_timer_partido_timeout():
	if self.spawn_prob(probabilidadCoin):
		self.spawn_coin()
	if self.spawn_prob(probabilidadPoder):
		self.spawn_poder(self.get_poder())
	
	match self.modo_juego:
		"goles":
			$labels/tiempo.visible = false

		"tiempo":
			self.label_tiempo -= 1
			$labels/tiempo.text = "{minutos}:{label_tiempo}".format({"label_tiempo":label_tiempo, "minutos":minutos})
			if self.label_tiempo == 0:
				self.minutos -= 1
				self.label_tiempo = 60
				if self.minutos == -1:
					$silbato_fin.playing = true
					self.tiempo_partido.paused = true
					self.flag_fin = true
					self.flag_tiempo = true
					$Arco/hitbox_gol.disabled = true
					$Arco2/hitbox_gol.disabled = true
					self.tiempo_gol.start(3)


func spawn_coin():
	var nueva_coin = self.Coin.duplicate()
	var area = $spawn_coins
	var position2 = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	nueva_coin.position = position2
	add_child(nueva_coin)

func spawn_prob(probabilidad: float) -> bool:
	var random = randf() # Genera un número aleatorio entre 0 y 1
	return random <= probabilidad


func spawn_poder(poder : String):
	$poderes/poder_Area2D/poder.texture = load(poder)
	var nuevo_poder = self.Poder.duplicate()
	var area = $spawn_coins
	var position2 = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	nuevo_poder.position = position2
	add_child(nuevo_poder)

func get_poder():
	var lista = self.options_node.poderes_desbloqueados.keys()

	estampa = (lista[randi_range(0, lista.size()-1)])
	get_estampa(estampa)
	# print("------------------------",estampa,"------------------------")
	var indice = self.options_node.poderes_desbloqueados[estampa].size() -1
	var indice_random_poder = randi_range(0, indice)
	var poder = self.options_node.poderes_desbloqueados[estampa][indice_random_poder]["sprite"]
	self.nombre_poder = self.options_node.poderes_desbloqueados[estampa][indice_random_poder]["poder"]

	return poder

func get_estampa(estampa):
	if estampa == "good":
		$poderes/poder_Area2D/estampa.texture = load("res://Assets/images/poderes/Estampa poderes.png")
	else:
		$poderes/poder_Area2D/estampa.texture = load("res://Assets/images/poderes/Estampa poderes 2.png")
	

func _on_options_draw():
	self.tiempo_partido.paused = true
	self.tiempo_gol.paused = true
	if flag_globos == true:
		self.timer_globo.paused = true

	get_tree().paused = true
	
	var personajes = get_tree().get_nodes_in_group("gr_personajes")
	for personaje in personajes:
		personaje.flag_moverse = false
		personaje.flag_gravedad = false

	# Verifica si la animación de gol está reproduciéndose antes de pausarla
	if gol_animacion.gol_animacion.is_playing():
		gol_animacion.gol_animacion.pause()
		flag_animacion = true


func _on_options_hidden():
	self.tiempo_gol.paused = false
	print(ambiente_pausa)
	if flag_globos == true:
		self.timer_globo.paused = false

	get_tree().paused = false
	var personajes = get_tree().get_nodes_in_group("gr_personajes")
	for personaje in personajes:
		personaje.flag_moverse = true
		personaje.flag_gravedad = true

	if !flag_gol:
		self.tiempo_partido.paused = false
	# Verifica si la animación de gol estaba reproduciéndose antes de reanudarla
	if flag_animacion:
		flag_animacion = false
		gol_animacion.gol_animacion.play("golazo_tio")


func _on_selector_hidden():
	flag_pausa = true


func _on_selector_get_modo_juego(modo_juego, flag_extras):
	self.modo_juego = modo_juego
	self.flag_extras = flag_extras
	match modo_juego:
		"goles":
			$labels/tiempo.visible = false

		"tiempo":
			pass
			
	self.ready2()

	
func _on_area_2d_body_entered(body):
	self.coins += randi_range(1,10)
	$labels/label_coins.text = str(self.coins)
	

func _on_poder_area_2d_get_estado(estampa_select, indice_poder, body):
	# print("------------------------",estampa_select,"------------------------")
	# print("Indice: ", indice_poder)
	var jugador = body.name

	if body.is_in_group("gr_pelota"):
		jugador = self.pelota_spawn.pelota.jugador
	# print("Jugador: ", jugador)

	if estampa_select == "good" and jugador != null:
		$powerUp_sound.play()
		match indice_poder:
			"achicar":
				print("Poder achicar arco propio")
				print(jugador)

				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.achicar_arco($Arco)
					self.traba1.position.y = 510
					self.traba1.get_child(0).polygon[0] = Vector2(-3,425)
					self.traba1.get_child(0).polygon[1] = Vector2(126,426)
					self.traba1.get_child(0).polygon[2] = Vector2(96,467)
				else:
					self.Poder.achicar_arco($Arco2)
					self.traba2.position.y = 510
					self.traba2.get_child(0).polygon[0] = Vector2(1154,418)
					self.traba2.get_child(0).polygon[1] = Vector2(1182,457)
					self.traba2.get_child(0).polygon[3] = Vector2(1285,417)
			"agrandar": 
				print("Poder agrandar arco contrario")
				print(jugador)
				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.agrandar_arco($Arco2)
					self.traba2.position.y = 390
					self.traba2.get_child(0).polygon[0] = Vector2(1135,379)
					self.traba2.get_child(0).polygon[3] = Vector2(1289,377)
				else:
					self.Poder.agrandar_arco($Arco)
					self.traba1.position.y = 390
					self.traba1.get_child(0).polygon[0] = Vector2(-8,387)
					self.traba1.get_child(0).polygon[1] = Vector2(145,384)
			"aturdir": 
				print("Poder aturdir enemigo")

				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.aturdir(self.personaje_2_spawn.personaje)
				else:
					self.Poder.aturdir(self.personaje1_spawn.personaje)
			"congelar": 
				print("Poder congelar contrario")

				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.congelar(self.personaje_2_spawn.personaje)
				else:
					self.Poder.congelar(self.personaje1_spawn.personaje)
			"teledirigido": 
				print("Poder teledirigido")
				self.traba1.constant_linear_velocity = Vector2(1000,-600)
				self.traba2.constant_linear_velocity = Vector2(-1000,-600)
				if jugador == "personaje_1" or jugador == "botin_1":
					self.fuerza = Vector2(500,300)
					self.arco_select = $Arco2
				else:
					self.fuerza = Vector2(-500,300)
					self.arco_select = $Arco

				self.flag_teledirigido = true
			"velocidad": 
				print("Poder velocidad")

				self.Poder.velocidad(self.pelota_spawn.pelota)
	else:
		$powerDown_sound.play()
		match indice_poder:
			"achicar":
				print("Poder achicar arco propio")
				
				if jugador == "personaje_2" or jugador == "botin_2":
					self.Poder.achicar_arco($Arco2)
					self.traba2.position.y = 510
					self.traba2.get_child(0).polygon[0] = Vector2(1154,418)
					self.traba2.get_child(0).polygon[1] = Vector2(1182,457)
					self.traba2.get_child(0).polygon[3] = Vector2(1285,417)
				else:
					self.Poder.achicar_arco($Arco)
					self.traba1.position.y = 510
					self.traba1.get_child(0).polygon[0] = Vector2(-3,425)
					self.traba1.get_child(0).polygon[1] = Vector2(126,426)
					self.traba1.get_child(0).polygon[2] = Vector2(96,467)
			"agrandar": 
				print("Poder agrandar arco propio")
				print(jugador)

				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.agrandar_arco($Arco)
					self.traba1.position.y = 390
					self.traba1.get_child(0).polygon[0] = Vector2(-8,387)
					self.traba1.get_child(0).polygon[1] = Vector2(145,384)
				else:
					self.Poder.agrandar_arco($Arco2)
					self.traba2.position.y = 390
					self.traba2.get_child(0).polygon[0] = Vector2(1135,379)
					self.traba2.get_child(0).polygon[3] = Vector2(1289,377)
			"aturdir": 
				print("Poder aturdir")
				print(jugador)

				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.aturdir(self.personaje1_spawn.personaje)
				else:
					self.Poder.aturdir(self.personaje_2_spawn.personaje)
			"congelar": 
				print("Poder congelar propio")

				if jugador == "personaje_1" or jugador == "botin_1":
					self.Poder.congelar(self.personaje1_spawn.personaje)
				else:
					self.Poder.congelar(self.personaje_2_spawn.personaje)
			"velocidad": 
				print("Poder menor velocidad y pelota más pesada")

				self.Poder.lentitud(self.pelota_spawn.pelota)



func reestablecer_valores():
	var poderes_del = get_tree().get_nodes_in_group("gr_poderes")
	poderes_del.pop_at(0)
	for poder_del in poderes_del:
		poder_del.queue_free()

	# var coin_del = get_tree().get_nodes_in_group("gr_coin")
	# coin_del.pop_at(0)
	# for coin_ in coin_del:
	# 	coin_.queue_free()

	$Arco.scale.y = 1
	$Arco2.scale.y = 1
	self.traba1.position.y = 455
	self.traba2.position.y = 455
	self.traba1.get_child(0).polygon[0] = Vector2(-4,419)
	self.traba1.get_child(0).polygon[1] = Vector2(137,423)
	self.traba2.get_child(0).polygon[0] = Vector2(1138,408)
	self.traba2.get_child(0).polygon[3] = Vector2(1283,410)

	flag_teledirigido = false
	pelota_spawn.pelota.flag_velocidad = false
	pelota_spawn.pelota.physics_material_override.bounce = 0.8
	pelota_spawn.pelota.physics_material_override.absorbent = false

	self.traba1.constant_linear_velocity = Vector2(100,0)
	self.traba2.constant_linear_velocity = Vector2(-100,0)

