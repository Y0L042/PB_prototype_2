extends Node2D

class_name StateManagerArmy

export (NodePath) var starting_state

var current_state: BaseStateArmy

onready var states = {
	BaseStateArmy.State.ArmyMarch : $ArmyMarch,
	BaseStateArmy.State.ArmyCombat : $ArmyCombat
}

func init(parent):
	for child in get_children():
		child.parent = parent
	change_state(BaseStateArmy.State.ArmyMarch)
	
func _physics_process(delta: float) -> void:
	var new_state = current_state.physics_run(delta) #returns a value, like BT
	if new_state: #!= BaseStateArmy.State.Null: #modify to check for good return value
		change_state(new_state)

#func _process(delta: float) -> void:
#	var new_state = current_state.run(delta) #returns a value, like BT
#	if new_state: # != BaseStateArmy.State.Null: #modify to check for good return value
#		change_state(new_state)

func change_state(new_state):
	if current_state: #catches null values
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()
