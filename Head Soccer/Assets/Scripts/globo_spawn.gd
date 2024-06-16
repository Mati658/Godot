extends Node2D

var globo = preload("res://scenes/globo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_globo(area):
	var nuevo_globo = self.globo.instantiate()
	var position2 = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	nuevo_globo.position = position2
	var escala = randf_range(0.05, 0.1)
	nuevo_globo.scale = Vector2(escala, escala)
	self.add_child(nuevo_globo)