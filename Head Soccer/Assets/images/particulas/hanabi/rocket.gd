extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.linear_velocity = Vector2(0, self.linear_velocity.y).rotated(self.rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.linear_velocity.y > -100:
		var explosion = load("res://Assets/images/particulas/hanabi/explosion.tscn").instantiate()
		explosion.position = position
		self.get_parent().add_child(explosion)
		self.queue_free()
