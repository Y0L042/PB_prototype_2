extends Node2D

class_name StateManager

export (String) var starting_state

var current_state : BaseState
var parent

onready var states = {}

func _ready():
	add_to_group("StateManager")

func init(new_parent):
	parent = new_parent
	for child in get_children():
		child.parent = new_parent
	change_state(starting_state)
	
func _physics_process(delta: float) -> void:
	var new_state = current_state.physics_run(delta) #returns a value, like BT
	if new_state:  #modify to check for good return value
		change_state(new_state)


func change_state(new_state):
	if current_state: #catches null values
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()
