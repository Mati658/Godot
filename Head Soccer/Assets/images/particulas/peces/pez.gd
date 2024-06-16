extends Node2D

var pez
var textura1
var velocidad = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	if self.flip_h:
		$VisibleOnScreenNotifier2D.position = Vector2(200,0)
		velocidad = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += velocidad


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
