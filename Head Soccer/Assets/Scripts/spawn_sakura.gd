extends Node2D

var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(timer_sakura)
	timer.start(3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func timer_sakura():
	var new_sakura = load("res://Assets/images/particulas/sakura/sakura.tscn").instantiate()
	new_sakura.position = Vector2(randi_range(50,1230), 150)
	add_child(new_sakura)
