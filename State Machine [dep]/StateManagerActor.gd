extends Node2D

class_name StateManagerActor

export (NodePath) var starting_state

var current_state: BaseStateActor

onready var states = {
	BaseStateActor.State.ActorMarch : $ActorMarch,
	BaseStateActor.State.ActorCombat : $ActorCombat,
	BaseStateActor.State.ActorDead : $ActorDead
}

func init(parent):
	for child in get_children():
		child.parent = parent
	change_state(BaseStateActor.State.ActorMarch)
	
func _physics_process(delta: float) -> void:
	var new_state = current_state.physics_run(delta) #returns a value, like BT
	if new_state: #modify to check for good return value
		change_state(new_state)


func change_state(new_state):
	if current_state: #catches null values
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()
