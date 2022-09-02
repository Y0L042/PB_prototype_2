extends BaseState


func physics_run(_delta):
	set_march_target()

func set_march_target():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.target = get_target()

func get_target():
	var target  = get_global_mouse_position()
	return target
