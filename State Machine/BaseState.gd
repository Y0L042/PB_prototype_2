extends Node2D

class_name BaseState

var states = {}

var FORCE_RETURN : bool
var FORCE_RETURN_VALUE

var parent
var state_manager
var state_name

func _ready():
	add_to_group("BaseState")

func enter(new_state_name):
	state_name = new_state_name

func physics_run(_delta: float):
	return null

func exit():
	pass
