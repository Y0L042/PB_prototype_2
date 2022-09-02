extends Camera2D

#var target = get_tree.get_child("Player").get_global_position()

var parent
var zoom_level = 3.0
const MIN_ZOOM = 0.5
const MAX_ZOOM = 6.0
export (float) var ZOOM_RATE = 5.0
export (float) var ZOOM_INCREMENT = 0.5

var desired_zoom = zoom_level

func _physics_process(delta: float) -> void:
	zoom_level = lerp(zoom_level, desired_zoom, ZOOM_RATE * delta)
	self.set_zoom(Vector2(zoom_level, zoom_level))
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_zoomin"):
		zoom_in()
	if Input.is_action_just_pressed("ui_zoomout"):
		zoom_out()



func zoom_in():
	if (desired_zoom - ZOOM_INCREMENT) >= MIN_ZOOM:
		desired_zoom -= ZOOM_INCREMENT


func zoom_out():
	if (desired_zoom - ZOOM_INCREMENT) <= MAX_ZOOM:
		desired_zoom += ZOOM_INCREMENT
