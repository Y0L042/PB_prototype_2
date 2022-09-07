extends BaseState

var enemy_array = []
var actor_array = []
var attack_timer

export (int) var ATTACK_RANGE = 100

func enter():
	create_timer()
	actor_array = parent.actor_detector.actor_array


func physics_run(_delta):
	if parent.isDead:
		return "ActorDead"

	enemy_array = set_enemies_array(actor_array)
	if enemy_is_in_sight(enemy_array):
		move_to_nearest_enemy(enemy_array)
		if get_distance_to_nearest_enemy(enemy_array) <= ATTACK_RANGE:
			attack_enemy(enemy_array[0])
	else:
		parent.move_to_target(false, parent.target)

func set_enemies_array(new_actor_array):
	var new_enemy_array = new_actor_array
	for actor in new_enemy_array:
		if actor.army == parent.army:
			new_enemy_array.remove(new_enemy_array.find(actor))
	return new_enemy_array

func enemy_is_in_sight(new_enemy_array):
	return !new_enemy_array.empty()

func move_to_nearest_enemy(new_enemy_array):
	parent.move_to_target(false, new_enemy_array[0].get_global_position())

func get_distance_to_nearest_enemy(new_enemy_array):
	return parent.get_global_position().distance_to(new_enemy_array[0].get_global_position())

func attack_enemy(new_enemy):
	if (attack_timer.get_time_left() <= 0.0):
		attack_timer.start()
		print("attacking")
		parent.animationlist.animation_attack()
		new_enemy.take_damage(parent.DAMAGE)

func create_timer():
	attack_timer = Timer.new()
	add_child(attack_timer)
	attack_timer.one_shot = true
#	attack_timer.connect("timeout", self, "_on_timeout")

