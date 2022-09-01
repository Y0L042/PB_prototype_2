extends YSort

class_name Army

export (NodePath) var controller

onready var enemy_detector = $EnemyDetector



var army_position = Vector2.ZERO


var target = Vector2.ZERO

func _ready() -> void:
	set_controller()
	controller.init(self)
	set_child_actor_army()
	enemy_detector.set_parent(self)
	army_position = calc_center_of_group()

func _physics_process(delta: float) -> void:
	if set_controller():
		controller._physics_process(delta)
	army_position = calc_center_of_group()
	enemy_detector.set_global_position(army_position)



func set_controller():
	for child in get_children():
		if child.is_in_group("StateManager"):
			controller = child


func set_child_actor_army():
	for child in get_children():
		if child.is_in_group("Actor"):
			child.set_army(self)

func calc_center_of_group():
	var center = Vector2.ZERO
	var child_count = 0
	for child in get_children():
		if child.is_in_group("Actor"):
			child_count += 1
			center += child.get_global_position()
	center /= child_count
	return center
