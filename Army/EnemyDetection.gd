extends Area2D

var parent

func set_parent(new_parent):
	parent = new_parent

func _on_EnemyDetector_body_entered(body):
	parent.add_enemy_army(body)





func _on_EnemyDetector_body_exited(body):
	# enemy_array.remove(enemy_array.find(body.army))
	pass

func remove_army(array, army):
	array.remove(array.find(army))
