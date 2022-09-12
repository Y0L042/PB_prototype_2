extends StateManager

export (String) var ActorMarch = "March"
export (String) var ActorAttack = "Attack"
export (String) var ActorDead = "Dead"



func _ready():
	states = {
		ActorMarch : $ActorMarch,
		ActorAttack : $ActorAttack,
		ActorDead : $ActorDead,
	}

	yield(get_tree().root, "ready")
	starting_state = ActorMarch
	parent.connect("actor_state_changed", self, "check_state_change")

func check_state_change(new_state):
	if current_state != states[new_state]:
		if !parent.isDead:
			change_state(new_state)
