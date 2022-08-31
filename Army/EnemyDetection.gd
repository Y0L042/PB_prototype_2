extends Area2D

var enemy_array = []

var parent : Army

func set_parent(new_parent):
	parent = new_parent

func _on_EnemyDetection_body_entered(body):
	if body.army != parent:
		enemy_array.append(body)


func _on_EnemyDetection_body_exited(body):
	enemy_array.remove(enemy_array.find(body))
