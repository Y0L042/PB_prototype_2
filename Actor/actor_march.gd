extends BaseState


export (int) var MARCH_SPEED = 100

var march_velocity


func _physics_process(_delta: float):
	parent.nav_agent.set_target_location(parent.blackboard.get_target())
	var next_target = parent.nav_agent.get_next_location()
	
	march_velocity = parent.position.direction_to(next_target).normalized() * MARCH_SPEED
	parent.nav_agent.set_velocity(march_velocity)
	
#	parent.move_and_slide(march_velocity)


func _on_NavigationAgent2D_velocity_computed(safe_velocity):
	march_velocity = parent.move_and_slide(safe_velocity)
