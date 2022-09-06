extends BaseState

func physics_run(_delta):
	parent.move_to_target(true, parent.get_target())
#	print("marching")

