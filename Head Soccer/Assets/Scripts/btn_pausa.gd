extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	var options_node = get_node("/root/mundo/options")
	if options_node:
		options_node.visible = true
		get_tree().paused = true
