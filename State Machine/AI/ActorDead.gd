extends BaseState


func enter():
	parent.animationlist.animation_dead()
	parent.collision.set_disabled(true)
