extends Node2D

var parent
var sprite
onready var anim_player = $AnimationPlayer
#onready var anim_tree = $AnimationTree
onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
#	state_machine = $AnimationTree.get("paremeters/playback")
	pass

func set_parent(new_parent):
	parent = new_parent
	sprite = self

func animation_flip_sprite(velocity):
	if velocity.x < 0:
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)

func animation_idle():
	state_machine.travel("Idle")

func animation_run():
#	anim_player.play("RunW")
	state_machine.travel("Run")

func animation_dead():
#	anim_player.play("DeadW")
	state_machine.travel("Dead")

func animation_attack():
#	anim_player.play("AttackW")
	state_machine.travel("Attack")

func animation_attacked():
#	anim_player.play("HitW")
	state_machine.travel("Hit")


