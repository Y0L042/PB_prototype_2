extends BaseStateActor


export (int) var MARCH_SPEED = 100

var march_velocity = Vector2.ZERO

func physics_run(_delta: float):
	parent.animationlist.animation_flip_sprite(march_velocity)
	
	
	var next_target = set_target_return_waypoint(parent.get_target())
	
	march_velocity = calc_target_vector(next_target)
	march_velocity *= MARCH_SPEED
	
	
	parent.move_and_slide(march_velocity)
	
	
	parent.animationlist.animation_run()

func set_target_return_waypoint(target):
	parent.nav_agent.set_target_location(target)
	return parent.nav_agent.get_next_location()



func calc_target_vector(target):
	return parent.get_global_position().direction_to(target).normalized()

func calc_cohesion_vector():
	pass
