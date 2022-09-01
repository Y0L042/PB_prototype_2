extends Node2D

var parent
var anim_player

func set_parent(new_parent):
	parent = new_parent
	anim_player = parent.anim_player

func animation_flip_sprite(velocity):
	if velocity.x > 0:
		anim_player.set_flip_h(true)
	else:
		anim_player.set_flip_h(false)

func animation_run():
	anim_player.play("Run_W")
	
func animation_dead():
	anim_player.play("Death")

func animation_attack():
	anim_player.play("Attack_W")
	
func animation_attacked():
	anim_player.play("Attacked")

