extends Area2D

var actor_array = []


var parent

func set_parent(new_parent):
	parent = new_parent

func _on_actor_detector_body_entered(body):
	actor_array.append(body)


func _on_actor_detector_body_exited(body):
	if parent.isDead:
		actor_array.clear()
	elif !actor_array.empty() and body != parent and actor_array.find(body) != -1:
		actor_array.remove(actor_array.find(body))


func remove_actor(array, body):
	array.remove(array.find(body))
