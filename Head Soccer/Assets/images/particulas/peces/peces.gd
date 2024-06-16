extends Node2D

var pez_1 = preload("res://Assets/images/particulas/peces/pez.tscn")
var pez_2 = preload("res://Assets/images/particulas/peces/pez_2.tscn")
var pez_3 = preload("res://Assets/images/particulas/peces/pez_3.tscn")
var peces
var spawns 
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.peces = [self.pez_1, self.pez_2, self.pez_3]
	self.spawns= [$spawn_l, $spawn_r] 
	timer = Timer.new()
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(timer_pez)
	timer.start(1)
	spawn(spawns[randi_range(0, 1)], peces[randi_range(0, peces.size()-1)])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn(area, pez):
	var nuevo_pez = pez.instantiate()
	var position2 = area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
	nuevo_pez.position = position2
	var escala = randf_range(0.1, 0.3)
	nuevo_pez.scale = Vector2(escala, escala)
	if area.name == "spawn_r":
		nuevo_pez.flip_h = true
	self.add_child(nuevo_pez)

func timer_pez():
	spawn(spawns[randi_range(0, 1)], peces[randi_range(0, peces.size()-1)])
