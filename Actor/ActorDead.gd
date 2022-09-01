extends BaseStateActor


func _physics_process(delta):
	parent.animationlist.animation_dead()
	set_physics_process(false)
