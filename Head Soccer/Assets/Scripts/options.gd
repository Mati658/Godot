extends Control

var padre
var save_path 
var slider_music
var slider_SFX
var music_bus
var sfx_bus
var pelota_particulas = ""
var pelota_estela = ""
var pelota_color1 = Color(1,1,1,1)
var pelota_color2 = Color(1,1,1,1)
var pelota_line_visible = true
var pelota_area = true
var line_width = 40
var line_original_curve = Curve.new()
var line_nueva_curve = Curve.new()
var music = 0
var sfx = 0
var coins = 0
var botines_dict = {
	0 : {
		"nombre" : "Botin1",
		"precio" : 0,
		"sprite" : "res://Assets/images/personajes/botines/Botin1.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin1Reverse.png",
		"comprado" : true
	},
	1 : {
		"nombre" : "Botin2",
		"precio" : 0,
		"sprite" : "res://Assets/images/personajes/botines/Botin2.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin2Reverse.png",
		"comprado" : true
	},
	2 : {
		"nombre" : "Botin3",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin3.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin3Reverse.png",
		"comprado" : false
	},
	3: {
		"nombre" : "Botin4",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin4.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin4Reverse.png",
		"comprado" : false
	},
	4 : {
		"nombre" : "Botin5",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin5.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin5Reverse.png",
		"comprado" : false
	},
	5 : {
		"nombre" : "Botin6",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin6.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin6Reverse.png",
		"comprado" : false
	},
	6 : {
		"nombre" : "Botin7",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin7.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin7Reverse.png",
		"comprado" : false
	},
	7 : {
		"nombre" : "Botin8",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin8.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin8Reverse.png",
		"comprado" : false
	},
	8 : {
		"nombre" : "Botin9",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin9.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin9Reverse.png",
		"comprado" : false
	},
	9 : {
		"nombre" : "Botin10",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/botines/Botin10.png",
		"sprite_reverse" : "res://Assets/images/personajes/botines/Botin10Reverse.png",
		"comprado" : false
	}
}
var heads_dict = {
	0 : {
		"nombre" : "Head1",
		"precio" : 0,
		"sprite" : "res://Assets/images/personajes/heads/Personaje1.png",
		"sprite_reverse" : "res://Assets/images/personajes/heads/Personaje1Reverse.png",
		"sprite_aturdido" : "res://Assets/images/personajes/heads/Personaje1 aturdido.png",
		"sprite_aturdido_reverse" : "res://Assets/images/personajes/heads/Personaje1Reverse aturdido.png",
		"comprado" : true
	},
	1 : {
		"nombre" : "Head2",
		"precio" : 0,
		"sprite" : "res://Assets/images/personajes/heads/Personaje2.png",
		"sprite_reverse" : "res://Assets/images/personajes/heads/Personaje2Reverse.png",
		"sprite_aturdido" : "res://Assets/images/personajes/heads/Personaje2 aturdido.png",
		"sprite_aturdido_reverse" : "res://Assets/images/personajes/heads/Personaje2Reverse aturdido.png",
		"comprado" : true
	},
	2 : {
		"nombre" : "Head3",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/heads/Personaje3.png",
		"sprite_reverse" : "res://Assets/images/personajes/heads/Personaje3Reverse.png",
		"sprite_aturdido" : "res://Assets/images/personajes/heads/Personaje3 aturdido.png",
		"sprite_aturdido_reverse" : "res://Assets/images/personajes/heads/Personaje3Reverse aturdido.png",
		"comprado" : false
	},
	3 : {
		"nombre" : "Head4",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/heads/Personaje4.png",
		"sprite_reverse" : "res://Assets/images/personajes/heads/Personaje4Reverse.png",
		"sprite_aturdido" : "res://Assets/images/personajes/heads/Personaje4 aturdido.png",
		"sprite_aturdido_reverse" : "res://Assets/images/personajes/heads/Personaje4Reverse aturdido.png",
		"comprado" : false
	},
	4 : {
		"nombre" : "Head5",
		"precio" : 50,
		"sprite" : "res://Assets/images/personajes/heads/Personaje5.png",
		"sprite_reverse" : "res://Assets/images/personajes/heads/Personaje5Reverse.png",
		"sprite_aturdido" : "res://Assets/images/personajes/heads/Personaje5 aturdido.png",
		"sprite_aturdido_reverse" : "res://Assets/images/personajes/heads/Personaje5Reverse aturdido.png",
		"comprado" : false
	}
}
var pelotas_dict = {
	0 : {
		"nombre" : "Pelota1",
		"precio" : 0,
		"sprite" : "res://Assets/images/pelotas/Pelota1.png",
		"comprado" : true
	},
	1 : {
		"nombre" : "Pelota2",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota2.png",
		"comprado" : false
	},
	2 : {
		"nombre" : "Pelota3",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota3.png",
		"comprado" : false
	},
	3: {
		"nombre" : "Pelota4",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota4.png",
		"comprado" : false
	},
	4 : {
		"nombre" : "Pelota5",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota5.png",
		"comprado" : false
	},
	5 : {
		"nombre" : "Pelota6",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota6.png",
		"comprado" : false
	},
	6 : {
		"nombre" : "Pelota7",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota7.png",
		"comprado" : false
	},
	7 : {
		"nombre" : "Pelota8",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota8.png",
		"comprado" : false
	},
	8 : {
		"nombre" : "Pelota9",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota9.png",
		"comprado" : false
	},
	9 : {
		"nombre" : "Pelota10",
		"precio" : 50,
		"sprite" : "res://Assets/images/pelotas/Pelota10.png",
		"comprado" : false
	}
}
var poderes_dict = {
	0 : {
		"nombre" : "Poder1",
		"poder" : "achicar arco",
		"precio" : 0,
		"sprite" : "res://Assets/images/poderes/Poder achicar arco propio.png",
		"tipo" : "good",
		"comprado" : true

	},
	1 : {
		"nombre" : "Poder1",
		"poder" : "achicar arco",
		"precio" : 0,
		"sprite" : "res://Assets/images/poderes/Poder achicar arco contrario.png",
		"tipo" : "bad",
		"comprado" : true
	},
	2 : {
		"nombre" : "Poder2",
		"poder" : "agrandar arco",
		"precio" : 0,
		"sprite" : "res://Assets/images/poderes/Poder agrandar arco contrario.png",
		"tipo" : "good",
		"comprado" : true
	},
	3: {
		"nombre" : "Poder2",
		"poder" : "agrandar arco",
		"precio" : 0,
		"sprite" : "res://Assets/images/poderes/Poder agrandar arco propio.png",
		"tipo" : "bad",
		"comprado" : true
	},
	4 : {
		"nombre" : "Poder3",
		"poder" : "aturdir",
		"precio" : 100,
		"sprite" : "res://Assets/images/poderes/Poder aturdir (enemigo-propio).png",
		"tipo" : "good-bad",
		"info" : "pro: Aturde al jugador contrario por 3 segundos.\ncontra: Aturde al jugador propio por 3 segundos.",
		"comprado" : false
	},
	5 : {
		"nombre" : "Poder4",
		"poder" : "congelar",
		"precio" : 100,
		"sprite" : "res://Assets/images/poderes/Poder congelar contrario.png",
		"tipo" : "good",
		"info" : "pro: Congela al jugador contrario por 3 segundos.\ncontra: Congela al jugador propio por 3 segundos.",
		"comprado" : false
	},
	6 : {
		"nombre" : "Poder4",
		"poder" : "congelar",
		"precio" : 100,
		"sprite" : "res://Assets/images/poderes/Poder congelar propio.png",
		"tipo" : "bad",
		"comprado" : false
	},
	7 : {
		"nombre" : "Poder5",
		"poder" : "teledirigido",
		"precio" : 250,
		"sprite" : "res://Assets/images/poderes/Poder teledirigido.png",
		"tipo" : "good",
		"info" : "La pelota se dirige hacia el arco contrario hasta meter gol",
		"comprado" : false
	},
	8 : {
		"nombre" : "Poder6",
		"poder" : "velocidad",
		"precio" : 75,
		"sprite" : "res://Assets/images/poderes/Poder velocidad.png",
		"tipo" : "good-bad",
		"info" : "pro: La pelota aumenta su velocidad\ncontra: La pelota pierde su capacidad de rebote",
		"comprado" : false
	}
}
var estelas_dict ={
	0 : {
		"nombre" : "Estela1",
		"precio" : 300,
		"comprado" : false
	},
	1 : {
		"nombre" : "Estela2",
		"precio" : 300,
		"comprado" : false
	},
	2 : {
		"nombre" : "Estela3",
		"precio" : 300,
		"comprado" : false
	}
}
var particulas_dict ={
	0 : {
		"nombre" : "Particula1",
		"precio" : 150,
		"comprado" : false
	},
	1 : {
		"nombre" : "Particula2",
		"precio" : 150,
		"comprado" : false
	},
	2 : {
		"nombre" : "Particula3",
		"precio" : 150,
		"comprado" : false
	}
}
var mapas_dict = {
	0 : {
		"nombre" : "Mapa1",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_1.png",
		"comprado" : true
	},
	1 : {
		"nombre" : "Mapa2",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_2.png",
		"comprado" : false
	},
	2 : {
		"nombre" : "Mapa3",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_3.png",
		"comprado" : false
	},
	3 : {
		"nombre" : "Mapa4",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_4.png",
		"comprado" : false
	},
	4 : {
		"nombre" : "Mapa5",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_5.png",
		"comprado" : false
	},
	5 : {
		"nombre" : "Mapa6",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_6.png",
		"comprado" : false
	},
	6 : {
		"nombre" : "Mapa7",
		"precio" : 200,
		"sprite" : "res://Assets/images/canchas/cancha_7.png",
		"comprado" : false
	}	
}
var obstaculos_dict = {
	0 : {
		"nombre" : "Obstaculo1",
		"precio" : 100,
		"sprite" : "res://Assets/images/obstaculos/obstaculo1.png",
		"comprado" : true
	},
	1 : {
		"nombre" : "Obstaculo2",
		"precio" : 100,
		"sprite" : "res://Assets/images/obstaculos/obstaculo2.png",
		"comprado" : false
	},
	2 : {
		"nombre" : "Obstaculo3",
		"precio" : 100,
		"sprite" : "res://Assets/images/obstaculos/obstaculo3.png",
		"comprado" : false
	}
	
}
#------------------------------------------------------------------------------
var botines_desbloqueados = {
	"p1":{
		0 : "res://Assets/images/personajes/botines/Botin1.png",
		1 : "res://Assets/images/personajes/botines/Botin2.png"
	},
	"p2":{
		0 : "res://Assets/images/personajes/botines/Botin2Reverse.png",
		1 : "res://Assets/images/personajes/botines/Botin1Reverse.png"
	}
}
var heads_desbloqueadas = {
	"p1":{
		0 : "res://Assets/images/personajes/heads/Personaje1Reverse.png",
		1 : "res://Assets/images/personajes/heads/Personaje2Reverse.png"
	},
	"p2":{
		0 : "res://Assets/images/personajes/heads/Personaje2.png",
		1 : "res://Assets/images/personajes/heads/Personaje1.png"
	}
}
var pelotas_desbloqueadas = {
		0 : "res://Assets/images/pelotas/Pelota1.png"
}
var poderes_desbloqueados = {
	"good":{
		0 : {
			"poder" : "achicar",
			"sprite" : "res://Assets/images/poderes/Poder achicar arco propio.png"
		},
		1 :{
			"poder" : "agrandar",
			"sprite" : "res://Assets/images/poderes/Poder agrandar arco contrario.png"
		} 
	},
	"bad":{
		0 : {
			"poder" : "achicar",
			"sprite" : "res://Assets/images/poderes/Poder achicar arco contrario.png"
		},
		1 : {
			"poder" : "agrandar",
			"sprite" : "res://Assets/images/poderes/Poder agrandar arco propio.png"
		}
	}
}
var mapas_desbloqueados = {
	0 : {
		"nombre" : "Mapa1",
		"sprite" : "res://Assets/images/canchas/cancha_1.png"
	}
}
var obstaculos_desbloqueados = {
	0 : {
		"nombre" : "Obstaculo0",
		"sprite" : ""
	},
	1 : {
		"nombre" : "Obstaculo1",
		"sprite" : "res://Assets/images/obstaculos/obstaculo1.png"
	}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	self.save_path = OS.get_user_data_dir() + "/datos.cfg"
	slider_music = $slider_music
	slider_SFX = $slider_SFX
	music_bus = AudioServer.get_bus_index("Music")
	sfx_bus = AudioServer.get_bus_index("SFX")
	self.padre = get_parent()
	self.load_config()
	slider_music.value = self.music
	slider_SFX.value = self.sfx

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_slider_music_value_changed(value:float):
	self.music = value
	AudioServer.set_bus_volume_db(self.music_bus, value)
	AudioServer.set_bus_mute(self.music_bus, value == -40)
	
	
func _on_slider_sfx_value_changed(value:float):
	self.sfx = value
	AudioServer.set_bus_volume_db(self.sfx_bus, value)
	AudioServer.set_bus_mute(self.sfx_bus, value == -40)

func _on_btn_back_button_down():
	self.save_config()

func save_config():    
	var config = ConfigFile.new() #se instancia

	#guardo los valores
	config.set_value("music", "volume_music", self.music)
	config.set_value("SFX", "volume_sfx", self.sfx)
	config.set_value("Coins", "coins", self.coins)

	config.set_value("Pelota Propiedades", "particulas", pelota_particulas)
	config.set_value("Pelota Propiedades", "estela", pelota_estela)
	config.set_value("Pelota Propiedades", "color 1", pelota_color1)
	config.set_value("Pelota Propiedades", "color 2", pelota_color2)
	config.set_value("Pelota Propiedades", "area", pelota_area)
	config.set_value("Pelota Propiedades", "line", pelota_line_visible)
	config.set_value("Pelota Propiedades", "line width", line_width)
	config.set_value("Pelota Propiedades", "line original curve", line_original_curve)
	config.set_value("Pelota Propiedades", "line nueva curve", line_nueva_curve)
	config.set_value("Pelota Propiedades", "line", pelota_line_visible)
	config.set_value("Pelota Propiedades", "line", pelota_line_visible)

	config.set_value("Botines", "botines", self.botines_dict)
	config.set_value("Botines Desbloqueados", "botines", self.botines_desbloqueados)
	config.set_value("Heads", "heads", self.heads_dict)
	config.set_value("Heads Desbloqueadas", "heads", self.heads_desbloqueadas)

	config.set_value("Pelotas", "pelotas", self.pelotas_dict)
	config.set_value("Pelotas Desbloqueadas", "pelotas", self.pelotas_desbloqueadas)

	config.set_value("Poderes", "poderes", self.poderes_dict)
	config.set_value("Poderes Desbloqueados", "poderes", self.poderes_desbloqueados)

	config.set_value("Estelas", "estelas", self.estelas_dict)
	config.set_value("Particulas", "particulas", self.particulas_dict)

	config.set_value("Canchas", "canchas", self.mapas_dict)
	config.set_value("Canchas Desbloqueadas", "canchas", self.mapas_desbloqueados)
	
	config.set_value("Obstaculos", "obstaculos", self.obstaculos_dict)
	config.set_value("Obstaculos Desbloqueados", "obstaculos", self.obstaculos_desbloqueados)
	config.save(self.save_path)

func load_config():
	var config = ConfigFile.new()

	# carga los datos del archivo
	var err = config.load(OS.get_user_data_dir() + "/datos.cfg")
	# si no se cargó, lo ignora
	if err != OK:
		return
	
	self.music = config.get_value("music","volume_music")
	self.sfx = config.get_value("SFX","volume_sfx")
	self.coins = config.get_value("Coins","coins")

	self.pelota_particulas = config.get_value("Pelota Propiedades", "particulas")
	self.pelota_estela = config.get_value("Pelota Propiedades", "estela")
	self.pelota_color1 = config.get_value("Pelota Propiedades", "color 1")
	self.pelota_color2 = config.get_value("Pelota Propiedades", "color 2")
	self.pelota_area = config.get_value("Pelota Propiedades", "area")
	self.pelota_line_visible = config.get_value("Pelota Propiedades", "line")
	self.line_width = config.get_value("Pelota Propiedades", "line width")
	self.line_original_curve = config.get_value("Pelota Propiedades", "line original curve")
	self.line_nueva_curve = config.get_value("Pelota Propiedades", "line nueva curve")

	self.botines_dict = config.get_value("Botines","botines")
	self.botines_desbloqueados = config.get_value("Botines Desbloqueados","botines")
	self.heads_dict = config.get_value("Heads","heads")
	self.heads_desbloqueadas = config.get_value("Heads Desbloqueadas","heads")

	self.pelotas_dict = config.get_value("Pelotas","pelotas")
	self.pelotas_desbloqueadas = config.get_value("Pelotas Desbloqueadas","pelotas")
	self.poderes_dict = config.get_value("Poderes","poderes")
	self.poderes_desbloqueados = config.get_value("Poderes Desbloqueados","poderes")

	self.estelas_dict = config.get_value("Estelas", "estelas")
	self.particulas_dict = config.get_value("Particulas", "particulas")

	self.mapas_dict = config.get_value("Canchas","canchas")
	self.mapas_desbloqueados = config.get_value("Canchas Desbloqueadas","canchas")
	self.obstaculos_dict = config.get_value("Obstaculos","obstaculos")
	self.obstaculos_desbloqueados = config.get_value("Obstaculos Desbloqueados","obstaculos")
