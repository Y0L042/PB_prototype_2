extends KinematicBody2D

var actor = self
export (int) var HEALTH = 3
export (int) var DAMAGE = 1
var isDead : bool = false

onready var nav_agent = $NavigationAgent2D
onready var state_manager = $StateManagerActor
onready var actor_detector = $actor_detector
onready var attack_range = $attack_range
onready var animationlist = $animationlist
onready var anim_player = $animations

var army : Army setget set_army, get_army
var target setget set_target, get_target


func _ready() -> void:
	state_manager.init(self)
	actor_detector.set_parent(self)
	attack_range.set_parent(self)
	animationlist.set_parent(self)

func _physics_process(delta: float) -> void:
	state_manager._physics_process(delta)
	
func _process(_delta: float) -> void:
#	state_manager._process(delta)
	pass


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
