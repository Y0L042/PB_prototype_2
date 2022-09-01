extends Area2D

var enemy_array = []

var parent

func set_parent(new_parent):
	parent = new_parent

func _on_EnemyDetector_body_entered(body):
	if body.army != parent:
		enemy_array.append(body)


func _on_EnemyDetector_body_exited(body):
	enemy_array.remove(enemy_array.find(body))

func remove_actor(array, actor):
	array.remove(array.find(actor))
