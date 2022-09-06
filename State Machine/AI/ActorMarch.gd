extends BaseState

func physics_run(_delta):
	parent.move_to_target(true, parent.target)
#	print("marching")

