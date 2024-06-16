extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$disolver.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_scene(target):
	$disolver.visible = true
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
	await $AnimationPlayer.animation_finished
	$disolver.visible = false

