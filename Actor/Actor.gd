extends KinematicBody2D

class_name Actor

var actor = self
export (int) var MOVE_SPEED = 200
export (int) var HEALTH = 3
export (int) var DAMAGE = 1

export (PackedScene) var controller



onready var nav_agent = $NavigationAgent2D
onready var collision = $collision
onready var actor_detector = $actor_detector
onready var animationlist = $animationlist

onready var sprite = $AnimationPlayer
onready var anim_player = $AnimationPlayer/AnimationPlayer

var army : Army setget set_army, get_army
var target setget set_target, get_target

var isDead : bool = false
signal isDeadSignal



func _ready() -> void:
	set_controller()

	actor_detector.set_parent(self)
	animationlist.set_parent(self)

func _physics_process(delta: float) -> void:
	controller._physics_process(delta)

func load_scene(scene):
	var instanced_scene = scene.instance()
	add_child(instanced_scene)
	return instanced_scene

func set_controller():
#	for child in get_children():
#		if child.is_in_group("StateManager"):
#			controller = child
	controller = load_scene(controller)
	controller.init(self)


func set_army(new_army):
	army = new_army
func get_army():
	return army

func set_target(new_target):
	target = new_target
func get_target():
	return target

func load_spritesheet(file):
	anim_player.set_sprite_frames(file)



func move_to_target(pathfind, new_target):
	var move_velocity = Vector2.ZERO

	if new_target == null:
		new_target = Vector2.ZERO

	var move_target = new_target
	if pathfind:
		nav_agent.set_target_location(move_target)
		move_target = nav_agent.get_next_location()
	move_velocity = get_global_position().direction_to(move_target).normalized() * MOVE_SPEED
	move_and_slide(move_velocity)

	animationlist.animation_flip_sprite(move_velocity)
	animationlist.animation_run()


func take_damage(damage):
	animationlist.animation_attacked()
	HEALTH -= damage
	if HEALTH <= 0:
		animationlist.animation_dead()
		isDead = true
		set_physics_process(false)

func _emit_is_dead():
	emit_signal("isDeadSignal", self)

func resurrect():
	isDead = false
	HEALTH = 3
	controller.init(self)
