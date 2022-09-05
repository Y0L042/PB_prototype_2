extends BaseState


func physics_run(_delta):
	print("Attack")
	parent.move_to_target(false, parent.target)
