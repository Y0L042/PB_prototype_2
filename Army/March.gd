extends BaseState

func enter():
	pass
#	set actors' states to match

func _physics_process(delta):
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.blackboard.set_target(parent.target)
	
	return null
