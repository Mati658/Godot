extends Node2D

var particulas
# Called when the node enters the scene tree for the first time.
func _ready():
	self.particulas = $GPUParticles2D
	self.particulas.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_gpu_particles_2d_finished():
	self.queue_free()
