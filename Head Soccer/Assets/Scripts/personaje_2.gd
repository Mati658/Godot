extends CharacterBody2D


var SPEED = 300.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flag_patada = true
var flag_moverse = true
var flag_gravedad = true
var botin
var head
var hielo
var particula_hielo
var anim_aturdido
var estrellas
var push_force = 80
var patada_max = -1
var cargar_patada = 0.5
var flag_contador = false

func _ready():
	botin = $Skeleton2D/hueso_botin/botin_1/botin
	head = $head
	hielo = $hielo
	particula_hielo = $particula_hielo
	anim_aturdido = $aturdido
	estrellas = $estrellas

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and flag_gravedad:
		velocity.y += gravity * delta
	elif !flag_gravedad:
		velocity.y = 0
		
	# Handle Jump.
	if flag_moverse:
		if Input.is_action_pressed("W") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("A", "D")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if flag_patada and flag_moverse:
		if Input.is_action_pressed("accion_patada_P2"):
			$Skeleton2D/hueso_botin.rotation = cargar_patada
			flag_contador = true
		else:
			if flag_contador:
				$Skeleton2D/hueso_botin.rotation -= 0.2
				if $Skeleton2D/hueso_botin.rotation <= patada_max:
					$Skeleton2D/hueso_botin.rotation = patada_max
					flag_contador = false
			else:
				$Skeleton2D/hueso_botin.rotation += 0.2
				if $Skeleton2D/hueso_botin.rotation >= 0:
					$Skeleton2D/hueso_botin.rotation = 0

	move_and_slide()
	