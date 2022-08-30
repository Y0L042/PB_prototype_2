extends Node2D

export (NodePath) var starting_state

var current_state: BaseState

func init(parent):
	for child in get_children():
		child.parent = parent
	change_state(get_node(starting_state))
	
func _physics_process(delta: float) -> void:
	var new_state = current_state._physics_process(delta) #returns a value, like BT
	if new_state: #modify to check for good return value
		change_state(new_state)

func _process(delta: float) -> void:
	var new_state = current_state._process(delta) #returns a value, like BT
	if new_state: #modify to check for good return value
		change_state(new_state)

func change_state(new_state):
	if current_state: #catches null values
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
