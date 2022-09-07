extends Area2D

var enemy_array = []

var parent

func set_parent(new_parent):
	parent = new_parent

func _on_EnemyDetector_body_entered(body):
	if body.army != parent:
		if !enemy_array.has(body.army):
			enemy_array.append(body.army)
			body.army.connect("army_defeated", parent, "_enemy_army_defeated")


func _on_EnemyDetector_body_exited(body):
	# enemy_array.remove(enemy_array.find(body.army))
	pass

func remove_army(array, army):
	array.remove(array.find(army))
