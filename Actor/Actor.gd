extends KinematicBody2D

var actor = self
export (int) var HEALTH = 3
export (int) var DAMAGE = 1
var isDead : bool = false

var controller

onready var nav_agent = $NavigationAgent2D
onready var actor_detector = $actor_detector
onready var attack_range = $attack_range
onready var animationlist = $animationlist
onready var anim_player = $animations

var army : Army setget set_army, get_army
var target setget set_target, get_target


func _ready() -> void:
	set_controller()
	controller.init(self)
	actor_detector.set_parent(self)
	attack_range.set_parent(self)
	animationlist.set_parent(self)

func _physics_process(delta: float) -> void:
	controller._physics_process(delta)

func set_controller():
	for child in get_children():
		if child.is_in_group("StateManager"):
			controller = child


func set_army(new_army):
	army = new_army
func get_army():
	return army

func set_target(new_target):
	target = new_target
func get_target():
	return target

func take_damage(damage):
	animationlist.animation_attacked()
	HEALTH -= damage
	if HEALTH <= 0:
		animationlist.animation_dead()
		isDead = true
		set_physics_process(false)
