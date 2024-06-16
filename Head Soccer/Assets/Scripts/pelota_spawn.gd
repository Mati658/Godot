extends Node2D

var pelota_posicion = preload("res://scenes/pelota.tscn")
var pelota = null
var mundo
var pelota_sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	mundo = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pelota == null:
		var nueva_pelota = pelota_posicion.instantiate()
		nueva_pelota.position = position
		get_parent().add_child(nueva_pelota)
		pelota = nueva_pelota
		pelota.sprite.texture = self.pelota_sprite

func _on_timer_timeout():

	#si eligen el modo tenis, poner impulso al azar en la primera ronda.
	#👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
	if self.mundo.flag_gol_p1:
		pelota.apply_central_impulse(Vector2(300,0))
	elif self.mundo.flag_gol_p2:
		pelota.apply_central_impulse(Vector2(-300,0))
	elif self.mundo.flag_tenis:
		var impulso = [300, -300]
		pelota.apply_central_impulse(Vector2(impulso.pick_random,0))
		print("hola")


func _on_selector_get_pelota(sprite_):
	self.pelota_sprite = sprite_.texture
