extends StateManager

export (String) var ArmyMarch = "March"
export (String) var ArmyAttack = "Attack"

func _ready():
	starting_state = ArmyMarch

	states = {
		ArmyMarch : $ArmyMarch,
		ArmyAttack : $ArmyAttack,
	}
