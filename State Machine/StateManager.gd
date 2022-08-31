extends Node2D

class_name StateManager

export (NodePath) var starting_state

var current_state : BaseState

onready var states = {
	BaseState.State.March : $March,
	BaseState.State.Combat : $Combat
}

func init(parent):
	for child in get_children():
		child.parent = parent
	change_state(BaseState.State.March)
	
func _physics_process(delta: float) -> void:
	var new_state = current_state._physics_process(delta) #returns a value, like BT
	if new_state:# != BaseStateActor.State.Null: #modify to check for good return value
		change_state(new_state)

func _process(delta: float) -> void:
	var new_state = current_state._process(delta) #returns a value, like BT
	if new_state:# != BaseStateActor.State.Null: #modify to check for good return value
		change_state(new_state)

func change_state(new_state):
	if current_state: #catches null values
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()