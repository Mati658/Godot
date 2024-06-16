extends Button

var options
var options_node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	var clase_del_nodo = self.get_parent().get_parent().get_parent()#agarro el padre del padre para saber donde estoy parado.
																	#no importa si me paso de get_parent(). Ej: si primero tengo 2 padres
																	#y yo puse 4 get_parent(), me da el nombre del padre igual, y si tengo 4 padres,
																	#me da el nombre del 4to padre. El tema es si tengo un 5to padre, ya no me lo da 
	if clase_del_nodo is Control:
		options_node = get_node("/root/Menu/options") #agarro el nodo que quiero manipular
	elif clase_del_nodo is Node2D:
		options_node = get_node("/root/mundo/options")
		get_tree().paused = false
	if options_node:
		options_node.visible = false	#lo hago invisible

