extends Node2D

const colores = [
	#azul
	Color(0,0,1,1),
	#verde
	Color(0,1,0,1),
	#cyan
	Color(0,1,1,1),
	#rojo
	Color(1,0,0,1),
	#violeta
	Color(1,0,1,1),
	#amarillo
	Color(1,1,0,1),
	#blanco
	Color(1,1,1,1)
]

var explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	self.explosion = $pum
	var color = self.colores[randi_range(0,self.colores.size()-1)]
	self.explosion.process_material.color_ramp.gradient.colors[0] = color
	self.explosion.process_material.color_ramp.gradient.colors[1] = color
	self.explosion.process_material.hue_variation_min = randf_range(-0.4, 0)
	self.explosion.process_material.hue_variation_max = 0
	print(self.explosion.process_material.hue_variation_min)
	self.explosion.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not self.explosion.is_emitting():
		self.queue_free()
