extends BaseStateArmy

func enter():
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.state_manager.change_state(BaseStateActor.State.ActorMarch)

func _physics_process(_delta):
	for child in parent.get_children():
		if child.is_in_group("Actor"):
			child.set_target(parent.target)



func _on_EnemyDetector_body_entered(body):
	if body.get_army() != parent:
		return State.ArmyCombat
