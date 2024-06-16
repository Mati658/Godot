extends CharacterBody2D


var SPEED = 300.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flag_patada = true
var flag_moverse = true
var flag_gravedad = true
var flag_contador = false
var flag_jugador
var botin
var head
var hielo
var particula_hielo
var anim_aturdido
var estrellas
var push_force = 80
var patada_max = 1
var cargar_patada = -0.5
var spawn_pelota
var arco_izq
var distancia : Vector2 = Vector2(0,0)

func _ready():
	if !flag_jugador:
		spawn_pelota = get_node("/root/mundo/pelota_spawn")
		arco_izq = get_node("/root/mundo/Arco2")

	botin = $Skeleton2D/hueso_botin/botin_2/botin
	head = $head
	hielo = $hielo
	particula_hielo = $particula_hielo
	anim_aturdido = $aturdido
	estrellas = $estrellas

	
func _physics_process(delta):
	match self.flag_jugador:
		true:
			self.jugador(delta)
		false:
			self.IA(delta)


func jugador(delta):
	# Add the gravity.
	if not is_on_floor() and flag_gravedad:
		velocity.y += gravity * delta
	elif !flag_gravedad:
		velocity.y = 0
		
	# Handle Jump.
	if flag_moverse:
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if flag_patada and flag_moverse:
		if Input.is_action_pressed("accion_patada_P1"):
			$Skeleton2D/hueso_botin.rotation = cargar_patada
			flag_contador = true
		else:
			if flag_contador:
				$Skeleton2D/hueso_botin.rotation += 0.2
				if $Skeleton2D/hueso_botin.rotation >= patada_max:
					$Skeleton2D/hueso_botin.rotation = patada_max
					flag_contador = false
			else:
				$Skeleton2D/hueso_botin.rotation -= 0.2
				if $Skeleton2D/hueso_botin.rotation <= 0:
					$Skeleton2D/hueso_botin.rotation = 0
		
	move_and_slide()


func IA(delta):
	# Add the gravity.
	if not is_on_floor() and flag_gravedad:
		velocity.y += gravity * delta
	elif !flag_gravedad:
		velocity.y = 0	
	
	if flag_moverse:
		distancia = Vector2(spawn_pelota.pelota.position.x - self.position.x, spawn_pelota.pelota.position.y - self.position.y)
		if distancia.x > -300 and distancia.x < -30:
			self.move(self.spawn_pelota.pelota.position)
			self.unkick()
			if distancia.abs().y > 30 and distancia.x > -85 and distancia.x < -65:
				self.move(self.spawn_pelota.pelota.position)
				self.unkick()
				if is_on_floor():
					self.jump()
			elif distancia.abs().y < 20 and distancia.x > -84 and distancia.x < -55:
				self.kick()
				self.move(self.spawn_pelota.pelota.position)
		elif distancia.abs().x > 500:
			self.move(self.arco_izq.position)
			self.unkick()
		elif distancia.x > -29:
			self.move(self.arco_izq.position + Vector2(30, 30))
			self.unkick()
			if is_on_floor():
				self.jump()
		else:
			self.idle()
			self.unkick()
	else:
		self.idle()
		self.unkick()
		
	move_and_slide()


func idle():
	velocity.x = move_toward(velocity.x, 0, SPEED)

func move(lugar):
	var direction = position.direction_to(lugar)
	velocity.x = direction.x * SPEED

func jump():
		velocity.y = JUMP_VELOCITY

func kick():
	if flag_moverse:
		if flag_patada:
			$Skeleton2D/hueso_botin.rotation = cargar_patada
			flag_contador = true
			flag_patada = false
		elif flag_contador:
				$Skeleton2D/hueso_botin.rotation += 0.2
				if $Skeleton2D/hueso_botin.rotation >= patada_max:
					$Skeleton2D/hueso_botin.rotation = patada_max
					flag_contador = false
					flag_patada = true

func unkick():
	$Skeleton2D/hueso_botin.rotation -= 0.2
	if $Skeleton2D/hueso_botin.rotation <= 0:
		$Skeleton2D/hueso_botin.rotation = 0
