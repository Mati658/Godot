extends Node2D


var personaje2_posicion = preload("res://scenes/personaje_2.tscn")
var personaje = -1
var head
var botin
var flag_jugador #False = IA | true = jugador

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if personaje == null:
		var nueva_personaje = personaje2_posicion.instantiate()
		nueva_personaje.position = position
		get_parent().add_child(nueva_personaje)
		personaje = nueva_personaje
		personaje.head.texture = head
		personaje.botin.texture = botin
		personaje.flag_jugador = self.flag_jugador
		
func _on_selector_get_personaje_2(personaje2_head, personaje2_botin):
	head = personaje2_head.texture
	botin = personaje2_botin.texture


func _on_selector_get_jugador(flag_jugador):
	self.flag_jugador = flag_jugador
