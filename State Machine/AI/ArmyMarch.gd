extends BaseState

var patrol_path
var patrolidx = 0
var move_target

func _ready():
	if get_patrol_child():
		follow_patrol_path()


func physics_run(_delta):
	if get_patrol_child():
		if parent.calc_center_of_group().distance_to(move_target) < 100 :
			follow_patrol_path()
	parent.set_target(get_target())

	if !parent.enemy_detector.enemy_array.empty():
		print("statechange -> armyattack")
		return "ArmyAttack"



func set_target(new_target):
	move_target = new_target
func get_target():
	return move_target

func get_patrol_child():
	for child in get_children():
		if child.is_in_group("Patrol"):
			patrol_path = child
			return true
	return false

func follow_patrol_path():
	var next_point = patrol_path.get_curve().get_point_position(patrolidx)
	set_target(next_point)
	patrolidx += 1
	if (patrolidx == patrol_path.get_curve().get_point_count()):
		patrolidx = 0
