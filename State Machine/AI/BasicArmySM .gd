extends StateManager


func _ready():
	states = {
		"ArmyMarch" : $ArmyMarch,
		"ArmyAttack" : $ArmyAttack
	}
