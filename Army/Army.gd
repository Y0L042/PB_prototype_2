extends YSort

class_name Army

#to be phased out with programatic instancing
export (PackedScene) var controller

onready var enemy_detector = $EnemyDetector


var army_position = Vector2.ZERO


var target = Vector2.ZERO

func _ready() -> void:
	set_controller()
	
	set_child_actor_army()
	enemy_detector.set_parent(self)
	army_position = calc_center_of_group()

func _physics_process(delta: float) -> void:
	controller._physics_process(delta)
	army_position = calc_center_of_group()
	enemy_detector.set_global_position(army_position)

func load_scene(scene):
	var instanced_scene = scene.instance()
	add_child(instanced_scene)
	return instanced_scene

func set_controller():
	controller = load_scene(controller)
	controller.init(self)

func set_child_actor_army():
	for child in get_children():
		if child.is_in_group("Actor"):
			child.set_army(self)

func set_target(new_target):
	for child in get_children():
		if child.is_in_group("Actor"):
			child.target = new_target



func calc_center_of_group():
	var center = Vector2.ZERO
	var child_count = 0
	for child in get_children():
		if child.is_in_group("Actor"):
			child_count += 1
			center += child.get_global_position()
	center /= child_count
	return center

