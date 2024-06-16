extends Area2D

var mundo

# Called when the node enters the scene tree for the first time.
func _ready():
	mundo = get_node("/root/mundo")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body:Node2D):
	mundo.coin_sound.play()
	self.queue_free()
