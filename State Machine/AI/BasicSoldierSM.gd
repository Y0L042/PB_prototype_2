extends StateManager


func _ready():
	states = {
		"ActorMarch" : $ActorMarch,
		"ActorCombat" : $ActorCombat
	}