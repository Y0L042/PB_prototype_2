extends StateManager



func _ready():
	states = {
		"ActorMarch" : $ActorMarch,
		"ActorAttack" : $ActorAttack,
		"ActorDead" : $ActorDead
	}
