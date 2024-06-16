extends Area2D

signal get_estado(estampa_select, indice_poder, body)

var mundo
var estampa_select
var indice_poder
# Called when the node enters the scene tree for the first time.
func _ready():
	mundo = get_node("/root/mundo")

	if mundo.flag_primer_spawn:
		self.indice_poder = mundo.nombre_poder
		self.estampa_select = mundo.estampa
	mundo.flag_primer_spawn = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body:Node2D):
	get_estado.emit(self.estampa_select, indice_poder, body)
	self.queue_free()
