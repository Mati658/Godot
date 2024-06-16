extends Node2D


var personaje1_posicion = preload("res://scenes/personaje_1.tscn")
var personaje = -1
var head
var botin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if personaje == null:
		var nueva_personaje = personaje1_posicion.instantiate()
		nueva_personaje.position = position
		get_parent().add_child(nueva_personaje)
		personaje = nueva_personaje
		personaje.head.texture = head
		personaje.botin.texture = botin
		# print("hola")
func _on_selector_get_personaje_1(personaje1_head, personaje1_botin):
	head = personaje1_head.texture
	botin = personaje1_botin.texture
