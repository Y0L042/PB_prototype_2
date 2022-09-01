extends BaseStateActor

export (int) var COMBAT_SPEED = 250
var combat_velocity = Vector2.ZERO
var enemy

func physics_run(_delta: float):
	parent.animationlist.animation_flip_sprite(combat_velocity)
	
	get_enemy_in_detector_range()
	if enemy and !enemy.isDead:
		if !enemy_in_attack_range():
			move_to_target(enemy.get_global_position())
			parent.animationlist.animation_run()
		else:
			attack_enemy()
			parent.animationlist.animation_attack()
	else:
		move_to_target(parent.get_target())

	

func get_enemy_in_detector_range():
	for loop_enemy in parent.actor_detector.enemy_array:
		if !loop_enemy.isDead:
			self.enemy = loop_enemy
		else:
			parent.actor_detector.remove_actor(parent.actor_detector.enemy_array, loop_enemy)

func move_to_target(target):
	combat_velocity = parent.get_global_position().direction_to(target).normalized() * COMBAT_SPEED
	parent.move_and_slide(combat_velocity)

func enemy_in_attack_range():
	return parent.attack_range.enemy_array.has(enemy)

func attack_enemy():
	enemy.take_damage(parent.DAMAGE)
