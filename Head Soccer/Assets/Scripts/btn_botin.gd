extends TextureButton

signal get_botin(padre, abuelo, hijo)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	self.button_pressed = true
	get_botin.emit(get_parent(), get_parent().get_parent(), self)
