extends BaseState

var enemy_array


func physics_run(_delta):
	enemy_array = parent.enemy_detector.enemy_array
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.controller.change_state("ActorAttack")
	if !enemy_array.empty():
		parent.set_target(enemy_array[0].army.army_position)
