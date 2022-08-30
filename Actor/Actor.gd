extends KinematicBody2D

onready var blackboard = $blackboard
onready var nav_agent = $NavigationAgent2D
onready var state_manager = $StateManager



func _ready() -> void:
	state_manager.init(self)

func _physics_process(delta: float) -> void:
	state_manager._physics_process(delta)
	
func _process(delta: float) -> void:
	state_manager._process(delta)
