extends Control

var options_node
var animacion
var pelota

# Called when the node enters the scene tree for the first time.
func _ready():
	options_node = $options
	options_node.load_config()
	animacion = $animacion
	pelota = $Line2D/pelota
	#botones particulas
	$VFX2/coin.disabled = !options_node.particulas_dict[0]["comprado"]
	$VFX2/hielo.disabled = !options_node.particulas_dict[1]["comprado"]
	#botones estelas
	$VFX/estela.disabled = !options_node.estelas_dict[0]["comprado"]
	MusicManager.set_music("res://Assets/Audio/Musica/musica3.mp3")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_ida_vuelta_button_down():
	animacion.stop()
	animacion.play("voleo_horizontal")

func _on_btn_circular_button_down():
	animacion.stop()
	animacion.play("voleo_circular")

#----------------------------------------------------------------------------------------------------------#
#-------------------------------------------------Color 1--------------------------------------------------#
#----------------------------------------------------------------------------------------------------------#
func _on_rosa_1_button_down():
	pelota.line.gradient.set_color(0, Color(1, 0.51, 1, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_magenta_1_button_down():
	pelota.line.gradient.set_color(0, Color(0.953, 0, 0.502, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_rojo_1_button_down():
	pelota.line.gradient.set_color(0, Color(1, 0, 0, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_naranja_1_button_down():
	pelota.line.gradient.set_color(0, Color(1, 0.584, 0, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_amarillo_1_button_down():
	pelota.line.gradient.set_color(0, Color(1, 1, 0, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_amarillo_pato_1_button_down():
	pelota.line.gradient.set_color(0, Color(1, 1, 0.635, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_violeta_1_button_down():
	pelota.line.gradient.set_color(0, Color(0.545, 0.208, 1, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_azul_button_down():
	pelota.line.gradient.set_color(0, Color(0.125, 0.275, 0.6, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_celeste_1_button_down():
	pelota.line.gradient.set_color(0, Color(0.231, 1, 1, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_verdecito_1_button_down():
	pelota.line.gradient.set_color(0, Color(0, 1, 0.729, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_verdoso_1_button_down():
	pelota.line.gradient.set_color(0, Color(0.232, 0.734, 0.416, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_verde_1_button_down():
	pelota.line.gradient.set_color(0, Color(0.212, 1, 0, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_blanco_1_button_down():
	pelota.line.gradient.set_color(0, Color(1, 1, 1, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_gris_1_button_down():
	pelota.line.gradient.set_color(0, Color(0.263, 0.263, 0.263, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

func _on_negro_1_button_down():
	pelota.line.gradient.set_color(0, Color(0, 0, 0, 1))
	options_node.pelota_color1 = pelota.line.gradient.get_color(0)
	options_node.save_config()
	pelota.line.visible = true

#----------------------------------------------------------------------------------------------------------#
#-------------------------------------------------Color 2--------------------------------------------------#
#----------------------------------------------------------------------------------------------------------#
func _on_rosa_2_button_down():
	pelota.line.gradient.set_color(1, Color(1, 0.51, 1, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_magenta_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.953, 0, 0.502, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_rojo_2_button_down():
	pelota.line.gradient.set_color(1, Color(1, 0, 0, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_naranja_2_button_down():
	pelota.line.gradient.set_color(1, Color(1, 0.584, 0, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_amarillo_2_button_down():
	pelota.line.gradient.set_color(1, Color(1, 1, 0, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_amarillo_pato_2_button_down():
	pelota.line.gradient.set_color(1, Color(1, 1, 0.635, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_violeta_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.545, 0.208, 1, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_azul_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.125, 0.275, 0.6, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_celeste_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.231, 1, 1, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_verdecito_2_button_down():
	pelota.line.gradient.set_color(1, Color(0, 1, 0.729, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_verdoso_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.232, 0.734, 0.416, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_verde_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.212, 1, 0, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_blanco_2_button_down():
	pelota.line.gradient.set_color(1, Color(1, 1, 1, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_gris_2_button_down():
	pelota.line.gradient.set_color(1, Color(0.263, 0.263, 0.263, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

func _on_negro_2_button_down():
	pelota.line.gradient.set_color(1, Color(0, 0, 0, 1))
	options_node.pelota_color2 = pelota.line.gradient.get_color(1)
	options_node.save_config()
	pelota.line.visible = true

#----------------------------------------------------------------------------------------------------------#
#----------------------------------------------VFX---------------------------------------------------------#
#----------------------------------------------------------------------------------------------------------#
func _on_btn_desactivar_button_down():
	pelota.line.visible = false
	options_node.pelota_line_visible = false
	options_node.save_config()


func _on_btn_activar_button_down():
	pelota.line.visible = true
	options_node.pelota_line_visible = true
	options_node.save_config()


func _on_btn_vfx_button_down():
	if pelota.particulas != null:
		pelota.particulas.emitting = false
	if pelota.line.texture != null:
		pelota.line.texture = null
		pelota.line.width_curve = options_node.line_original_curve
	pelota.line.width = 40
	pelota.area_disabled.disabled = true

	options_node.pelota_particulas = ""
	options_node.pelota_estela = ""
	options_node.line_width = pelota.line.width
	options_node.pelota_area = pelota.area_disabled.disabled
	options_node.save_config()

#-------Particulas-------
func _on_coin_button_down():
	if pelota.particulas != null:
		pelota.particulas.emitting = false
	pelota.particulas = pelota.particulas_coin
	pelota.particulas.emitting = true
	options_node.pelota_particulas = pelota.particulas.name
	options_node.save_config()


func _on_hielo_button_down():
	if pelota.particulas != null:
		pelota.particulas.emitting = false
	pelota.particulas = pelota.particulas_hielo
	pelota.particulas.emitting = true
	options_node.pelota_particulas = pelota.particulas.name
	options_node.save_config()

#-------Estelas-------
func _on_estela_button_down():
	pelota.line.texture = pelota.line_rayo.texture
	pelota.line.width = 80
	if pelota.line.width_curve != options_node.line_nueva_curve:
		options_node.line_original_curve = pelota.line.width_curve
		pelota.line.width_curve = pelota.line_rayo.width_curve
	pelota.area_disabled.disabled = false

	options_node.pelota_estela = pelota.line.texture.resource_path
	options_node.line_width = pelota.line.width
	options_node.line_nueva_curve = pelota.line.width_curve
	options_node.pelota_area = pelota.area_disabled.disabled
	options_node.save_config()

func _on_btn_back_button_up():
	MusicManager.set_music("res://Assets/Audio/Musica/musica1.wav")
	Transicion.change_scene("res://scenes/menu.tscn")



