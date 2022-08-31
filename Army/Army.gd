extends YSort

class_name Army

onready var state_manager = $StateManagerArmy
onready var enemy_detector = $EnemyDetector

var army_position = Vector2.ZERO


var target = Vector2.ZERO

func _ready() -> void:
	state_manager.init(self)
	set_child_actor_army()
	enemy_detector.set_parent(self)
	army_position = calc_center_of_group()

func _physics_process(delta: float) -> void:
	state_manager._physics_process(delta)
	army_position = calc_center_of_group()
	enemy_detector.set_global_position(army_position)

	
func _process(delta: float) -> void:
	state_manager._process(delta)

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
