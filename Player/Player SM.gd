extends StateManager

onready var cameraTD = $cameraTD
onready var blue_actor = "res://Assets/Puny-Characters/Soldier-Red.png"

func _ready():
	states = {
		"PlayerMarch" : $PlayerMarch
	}
	

func _physics_process(delta):
	cameraTD.set_global_position(parent.army_position)
