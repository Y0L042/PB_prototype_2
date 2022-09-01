extends Node

class_name BaseStateActor

enum State {
	Null,
	ActorMarch,
	ActorCombat,
	ActorDead
}

var parent

func enter():
	pass

func run(_delta: float):
	return null 

func exit():
	pass
