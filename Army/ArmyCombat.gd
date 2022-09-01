extends BaseStateArmy





func enter():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.state_manager.change_state(BaseStateActor.State.ActorCombat)

func physics_run(_delta):
	set_children_targets()

func set_children_targets():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.set_target(parent.target)
