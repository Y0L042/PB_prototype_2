extends BaseState

#func _ready():
#	yield(get_tree().root, "ready")
#	parent.connect("actor_state_changed", self, "check_state_change")


func enter(state_name):
#	parent.connect("actor_state_changed", self, "check_state_change")
	pass

func physics_run(_delta):
	if FORCE_RETURN:
		if FORCE_RETURN_VALUE == state_manager.ActorAttack:
			return state_manager.ActorAttack
		FORCE_RETURN = false


	parent.move_to_target(true, parent.get_target())

func check_state_change(new_state):
	if new_state != state_manager.ActorMarch:
		FORCE_RETURN = true
		FORCE_RETURN_VALUE = new_state




