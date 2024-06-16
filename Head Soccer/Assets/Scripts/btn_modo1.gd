extends Button
var selector

# Called when the node enters the scene tree for the first time.
func _ready():
	selector = self.get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_up():
	self.flat = false
	selector.flag_extras = true
	selector.flag_btn2 = true


func _on_btn_modo_2_button_up():
	self.flat = true
	selector.flag_extras = false
	selector.flag_btn2 = true
