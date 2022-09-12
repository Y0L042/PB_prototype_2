extends BaseState

func enter(new_state):
	state_name = new_state
	parent.emit_signal("army_state_signal", state_manager.PlayerMarch)

func physics_run(_delta):
	set_march_target()
	if !parent.enemy_armies_array.empty():
		return state_manager.PlayerAttack

func set_march_target():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.target = get_target()


func get_target():
	var target  = get_global_mouse_position()
	return target
