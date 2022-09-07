extends BaseState

var sight_range_enemy_array
var attack_range_enemy_array
var attack_timer

func enter():
	create_timer()

	pass

func physics_run(_delta):
	if parent.isDead:
		return "ActorDead"

	sight_range_enemy_array = parent.actor_detector.enemy_array
	attack_range_enemy_array = parent.attack_range.enemy_array

	if !sight_range_enemy_array.empty():
		parent.move_to_target(false, sight_range_enemy_array[0].get_global_position())

		if !attack_range_enemy_array.empty() and (attack_timer.get_time_left() <= 0.0):
			attack_timer.start()
			# print("attacking")
			parent.animationlist.animation_attack()
			attack_range_enemy_array[0].take_damage(parent.DAMAGE)

	else:
		parent.move_to_target(false, parent.target)



func create_timer():
	attack_timer = Timer.new()
	add_child(attack_timer)
	attack_timer.one_shot = true
#	attack_timer.connect("timeout", self, "_on_timeout")

