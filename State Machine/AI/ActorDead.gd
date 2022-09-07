extends BaseState


func enter():
	# print("isdead")
	parent.animationlist.animation_dead()
	parent.collision.set_disabled(true)
	parent._emit_is_dead()

