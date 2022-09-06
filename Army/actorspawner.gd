extends Node

class_name SpawnerActor



func spawn_actor(actor_scene, actor_controller, _position, army):
	var actor = actor_scene.instance()
	actor.controller = actor_controller
	actor.set_army(army)
	add_child(actor)
	

