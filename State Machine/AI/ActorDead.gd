extends BaseState


func enter(new_name):
	state_name = new_name
	# print("isdead")
	parent.actor_dies()

func _ready():
	yield(get_tree().root, "ready")
	parent.connect("actor_state_changed", self, "check_state_change")

func physics_run(_delta):
	if FORCE_RETURN:
#		if FORCE_RETURN_VALUE == state_manager.ActorMarch:
#			return state_manager.ActorMarch
		FORCE_RETURN = false
		return FORCE_RETURN_VALUE

func check_state_change(new_state):
	if new_state != state_manager.ActorAttack:
		FORCE_RETURN = true
		FORCE_RETURN_VALUE = new_state
