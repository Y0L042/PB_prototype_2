extends Node2D

var parent
var sprite
var anim_player

func set_parent(new_parent):
	parent = new_parent
	anim_player = parent.anim_player
	sprite = parent.sprite

func animation_flip_sprite(velocity):
	if velocity.x > 0:
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)

func animation_run():
	anim_player.play("RunW")
	
func animation_dead():
	anim_player.play("DeathW")

func animation_attack():
	anim_player.play("AttackW")
	
func animation_attacked():
	anim_player.play("Attacked")

