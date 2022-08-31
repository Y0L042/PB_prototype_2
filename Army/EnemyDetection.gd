extends Area2D

var enemy_array = []

var parent : Army

func set_parent(new_parent):
	parent = new_parent

func _on_EnemyDetector_body_entered(body):
	if body.army != parent:
		print(parent)
		print("Enemy spotted!")
		print(body)
		print(body.army)
		enemy_array.append(body)


func _on_EnemyDetector_body_exited(body):
	enemy_array.remove(enemy_array.find(body))
