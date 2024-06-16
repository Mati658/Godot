extends Node2D

var jugador_aturdido
var jugador_congelado
var sprite_normal
var mundo
var timer_aturdir
var timer_congelar

# Called when the node enters the scene tree for the first time.
func _ready():
	self.timer_aturdir = get_node("timer_aturdir")
	self.timer_congelar = get_node("timer_congelar")
	self.mundo = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.mundo.flag_teledirigido:

		self.mundo.pelota_spawn.pelota.apply_force(self.mundo.fuerza, position.direction_to(self.mundo.arco_select.position))

func achicar_arco(arco):
	arco.scale.y = 0.7

func agrandar_arco(arco):
	arco.scale.y = 1.5

func aturdir(personaje):
	self.jugador_aturdido = personaje
	self.jugador_aturdido.velocity.x = 0
	self.jugador_aturdido.flag_moverse = false
	self.jugador_aturdido.head.texture = load(self.get_indice(self.jugador_aturdido.head.texture.get_path()))
	self.jugador_aturdido.estrellas.visible = true
	self.jugador_aturdido.anim_aturdido.play("aturdido")
	self.timer_aturdir.start(3)
	
func congelar(personaje):
	self.jugador_congelado = personaje
	self.jugador_congelado.velocity.x = 0
	self.jugador_congelado.flag_moverse = false
	self.jugador_congelado.hielo.visible = true
	self.jugador_congelado.particula_hielo.emitting = true
	self.timer_congelar.start(3)

func velocidad(pelota):
	pelota.flag_velocidad = true
	pelota.physics_material_override.bounce = 1

func lentitud(pelota):
	pelota.physics_material_override.absorbent = true



func _on_timer_poder_timeout():
	if self.jugador_aturdido != null:
		self.jugador_aturdido.flag_moverse = true
		self.jugador_aturdido.head.texture = load(self.sprite_normal)
		self.jugador_aturdido.estrellas.visible = false
		self.jugador_aturdido.anim_aturdido.stop()

func _on_timer_congelar_timeout():
	if self.jugador_congelado != null:
		self.jugador_congelado.flag_moverse = true
		self.jugador_congelado.hielo.visible = false
		self.jugador_congelado.particula_hielo.emitting = false

func get_indice(sprite):
	var sprite_value
	var aturdido_value

	if self.jugador_aturdido.name == "personaje_1": #sprite reverse
		sprite_value = "sprite_reverse"
		aturdido_value = "sprite_aturdido_reverse"
	else:
		sprite_value = "sprite"
		aturdido_value = "sprite_aturdido"


	for item in self.mundo.options_node.heads_dict.values():
		if sprite == item[sprite_value]:
			self.sprite_normal = item[sprite_value]
			return item[aturdido_value]
		
	return self.jugador_aturdido.head.texture.get_path()
