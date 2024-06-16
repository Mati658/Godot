extends Control

var options_node
# Called when the node enters the scene tree for the first time.
func _ready():
	self.options_node = $options
	self.options_node.load_config()
	$Label_coins.text = str(self.options_node.coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_store_button_up():
	Transicion.change_scene("res://scenes/tienda.tscn")

func _on_btn_mod_ball_button_up():
	Transicion.change_scene("res://scenes/ball_modifation.tscn")

func _on_btn_options_button_up():
	if options_node:
		options_node.visible = true

func _on_btn_exit_button_up():
	get_tree().quit()


