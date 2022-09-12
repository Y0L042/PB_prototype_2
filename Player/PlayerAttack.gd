extends BaseState

var enemy_array

func enter(new_state):
	state_name = new_state
	parent.emit_signal("army_state_signal", state_manager.PlayerAttack)
	enemy_array = parent.enemy_armies_array
#	for child in parent.get_children():
#		if child.is_in_group("Actor"):
#			child.controller.change_state("ActorAttack")

func physics_run(_delta):
	if !enemy_array.empty():
		parent.set_target(get_global_mouse_position())
	elif enemy_array.empty():
		return state_manager.PlayerMarch
