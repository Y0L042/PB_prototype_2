extends KinematicBody2D

onready var blackboard = $blackboard
onready var nav_agent = $NavigationAgent2D
onready var state_manager = $StateManagerActor

var army : Army setget set_army, get_army
var target setget set_target, get_target


func _ready() -> void:
	state_manager.init(self)

func _physics_process(delta: float) -> void:
	state_manager._physics_process(delta)
	
func _process(delta: float) -> void:
	state_manager._process(delta)


func set_army(new_army):
	army = new_army
func get_army():
	return army

func set_target(new_target):
	target = new_target
func get_target():
	return target

