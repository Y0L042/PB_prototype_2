extends BaseState

var enemy_array


func enter():
	enemy_array = parent.enemy_detector.enemy_array
	set_child_attack_state()

func physics_run(_delta):
	if !enemy_array.empty():
		parent.set_target(enemy_array[0].army_position)
	elif enemy_array.empty():
		print("statechange -> armymarch")
		return "ArmyMarch"

func set_child_attack_state():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.controller.change_state("ActorAttack")

func check_empty_enemy_armies():
	for army in enemy_array:
		if army.soldiers_array.empty():
			parent.enemy_detector.remove_army(enemy_array, army)
