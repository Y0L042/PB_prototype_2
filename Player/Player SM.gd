extends StateManager

onready var cameraTD = $cameraTD
onready var blue_actor = "res://Assets/Puny-Characters/Soldier-Red.png"

export (String) var PlayerMarch = "March"
export (String) var PlayerAttack = "Attack"

func _ready():
	starting_state = PlayerMarch

	states = {
		PlayerMarch : $PlayerMarch,
		PlayerAttack : $PlayerAttack
	}


func _physics_process(_delta):
	cameraTD.set_global_position(parent.army_position)
