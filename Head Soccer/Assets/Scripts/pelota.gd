extends RigidBody2D

var sprite
var jugador
@onready var area = $Area2D
var line
var line2 : Line2D
var area_disabled
var particulas
var particulas_coin
var particulas_hielo
var line_rayo
var flag_velocidad = false
var flag_limite = false
@onready var options_node = preload("res://scenes/options.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Sprite2D
	line = $Line2D
	particulas_coin = $particulas_coin
	particulas_hielo = $particulas_hielo
	line_rayo = $Line_rayo
	options_node.load_config()
	area_disabled = $Area2D/CollisionShape2D

	line.gradient.set_color(0, Color(options_node.pelota_color1))
	line.gradient.set_color(1, Color(options_node.pelota_color2))
	line.visible = options_node.pelota_line_visible
	area_disabled.disabled = options_node.pelota_area
	set_particulas(options_node.pelota_particulas)
	set_estela(options_node.pelota_estela)

	self.physics_material_override.bounce = 0.8
	self.contact_monitor = true		#contact_monitor = true	 y max_contacts_reported = 1 tienen que estar así para que funcione el body_entered
	self.max_contacts_reported = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag_limite:
		self.position = Vector2(648, 256)
		flag_limite = false

func _on_body_entered(body:Node):
	if body.is_in_group("gr_personajes") or body.is_in_group("gr_botin"):
		self.jugador = body.name
		if flag_velocidad:
			self.apply_force(Vector2(50000,5000), body.position)
		if body.is_in_group("gr_botin"):
			$patear.playing = true
	else:
		$pelota_rebote.playing = true

		
func set_particulas(particula_name):
	match particula_name:
		"particulas_coin":
			particulas = particulas_coin
			particulas.emitting = true
		"particulas_hielo":
			particulas = particulas_hielo
			particulas.emitting = true


func set_estela(estela_path):
	match estela_path:
		"res://scenes/pelota.tscn::AnimatedTexture_bslfy":
			line.texture = line_rayo.texture
			line.width = options_node.line_width
			line.width_curve = options_node.line_nueva_curve
			area_disabled.disabled = options_node.pelota_area

func _on_area_2d_body_entered(body:Node2D):
	line2 = line.duplicate()
	line2.duplicado = true
	line2.body = body
	self.add_child(line2)
	self.move_child(line2, 0)


func _on_visible_on_screen_notifier_2d_screen_exited():
	flag_limite = true
