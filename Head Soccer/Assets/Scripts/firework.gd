extends Node2D

var timer : Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(timer_firework)
	timer.start(0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func timer_firework():
	var new_rocket = load("res://Assets/images/particulas/hanabi/rocket.tscn").instantiate()
	new_rocket.position = Vector2(randi_range(180,1100), 720)
	new_rocket.rotation_degrees = randi_range(-15, 15)
	new_rocket.linear_velocity = Vector2(0, randi_range(-1000, -1200))
	add_child(new_rocket)