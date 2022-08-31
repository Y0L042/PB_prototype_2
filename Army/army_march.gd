extends BaseStateArmy

func enter():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.state_manager.change_state(BaseStateActor.State.ActorMarch)

func _physics_process(_delta):
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.blackboard.set_target(parent.target)

