extends Area2D

var actor_array = []
var friendly_array = []
var enemy_array = []

var parent

func set_parent(new_parent):
	parent = new_parent


func _physics_process(_delta):
	if (randi() % 2) == 0 :
		remove_dead_actors()

func _on_actor_detector_body_entered(body):
	actor_array.append(body)
	if body.army == parent.army:
		friendly_array.append(body)
	elif body.army != parent.army:
		enemy_array.append(body)


func _on_actor_detector_body_exited(body):
	actor_array.remove(actor_array.find(body))
	if body.army == parent.army:
		friendly_array.remove(friendly_array.find(body))
	elif body.army != parent.army:
		enemy_array.remove(enemy_array.find(body))

func remove_actor(array, body):
	array.remove(array.find(body))

func remove_dead_actors():
	for actor in actor_array:
		if actor.isDead:
			remove_actor(actor_array, actor)
	for actor in friendly_array:
		if actor.isDead:
			remove_actor(friendly_array, actor)
	for actor in enemy_array:
		if actor.isDead:
			remove_actor(enemy_array, actor)
