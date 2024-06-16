extends Line2D

var length = 50
var point = Vector2()
var duplicado = false
var colision
var area2D
var body 
var timer : Timer
var flag_tiempo = false
var posicion_y


# Called when the node enters the scene tree for the first time.
func _ready():
	if duplicado:
		self.instanciar_area(self.get_parent().area)
		self.primera_interaccion()
		self._on_area_2d_body_entered(self.body)
		timer = Timer.new()
		timer.autostart = true
		add_child(timer)
		timer.timeout.connect(_time_out)
		timer.start(0.2)
		self.posicion_y = randi_range(-56, 67)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0
	global_position = Vector2(0,0)
	self.point = get_parent().global_position

	if !self.duplicado:
		add_point(self.point)
		while self.get_point_count() > length:
			self.remove_point(0)
	else:
		if self.colision != null:
			set_point_position(0, self.point)
			set_point_position(1, Vector2(self.colision.position.x, self.colision.position.y + self.posicion_y))
			if self.flag_tiempo:
				self.flag_tiempo = false
				self.posicion_y = randi_range(-30, 30)
			
			# print(Vector2(self.colision.position.x, randi_range(self.colision.position.y -56, self.colision.position.y + 67)))

func _on_area_2d_body_entered(body:Node2D):
	if self.duplicado:

		add_point(self.point, 0)
		add_point(self.body.position, 1)
		if self.body.name != body.name:
			var puntos = get_point_count()
			if puntos > 2:
				for punto in puntos:
					remove_point(2)		
					if get_point_count() == 2:
						break

		self.colision = self.body
		# for child in body.get_children():
		# 	if child is CollisionShape2D:
		# 		# Obtén la forma de colisión y su área
		# 		var shape = child.shape
		# 		var area_ = shape.get_rect()
		# 		print("El área del StaticBody es:", area_.size)
		# 		break

func _on_area_2d_body_exited(body):
	if self.duplicado:
		if is_instance_valid(self.body):
			if self.body.name == body.name:
				self.queue_free()
			

func primera_interaccion():
	var puntos = get_point_count()
	if puntos > 0:
		for punto in puntos:
			remove_point(0)		

func instanciar_area(area):
	self.area2D = area
	self.area2D.body_entered.connect(_on_area_2d_body_entered)
	self.area2D.body_exited.connect(_on_area_2d_body_exited)

func _time_out():
	self.flag_tiempo = true
