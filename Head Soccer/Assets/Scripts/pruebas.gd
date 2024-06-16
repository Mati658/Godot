extends Node2D

var pelota 
var arco_der
var arco_izq
var flag_gol = false
var flag_boton = false
var line : Line2D
var colision
var line2 : Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	arco_der = $Arco2
	arco_izq = $Arco
	pelota = $RigidBody2D
	pelota.contact_monitor = true
	pelota.max_contacts_reported = 1
	line = $RigidBody2D/Line2D  
	$personaje_3.flag_jugador = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag_boton:
		pelota.apply_force(Vector2(10000,300), position.direction_to(arco_der.position))
		flag_gol = false


func _on_button_button_up():
	flag_boton = true

func _on_button_2_button_down():	#derecha
	pelota.apply_force(Vector2(10000,300), position.direction_to(arco_der.position))

func _on_button_3_button_down():	#izquierda
	pelota.apply_force(Vector2(-10000,300), position.direction_to(arco_izq.position))


func _on_arco_2_body_entered(body):
	self.flag_gol = true
	flag_boton = false

func _on_rigid_body_2d_body_entered(body:Node):
	pass
	# if body.name == "personaje_1":
	# 	pelota.apply_force(Vector2(0,0), body.position)
	# 	print("xd")


func _on_area_2d_body_entered(body:Node2D):
	pass
	# line2 = line.duplicate()
	# line2.duplicado = true
	# line2.body = body
	# pelota.add_child(line2)
	# pelota.move_child(line2, 0)
