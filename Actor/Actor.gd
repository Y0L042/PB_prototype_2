extends KinematicBody2D

class_name Actor

var actor = self
var ARMY_COLOUR : Color
var actor_army_state
var _current_state
export (int) var MOVE_SPEED = 300
export (int) var HEALTH = 3
export (int) var DAMAGE = 1

export (PackedScene) var controller



onready var nav_agent = $NavigationAgent2D
onready var collision = $collision
onready var actor_detector = $actor_detector
onready var animationlist = $Sprite

onready var sprite = $Sprite
onready var anim_player = $Sprite/AnimationPlayer

var army : Army setget set_army, get_army
var target setget set_target, get_target

var isDead : bool = false
signal isDeadSignal
signal actor_state_changed



func _ready() -> void:
	set_controller()
	actor_detector.set_parent(self)
	animationlist.set_parent(self)

func connect_to_army_signals():
	army.connect("army_state_signal", self, "set_army_state")

func _physics_process(delta: float) -> void:
	controller._physics_process(delta)

func load_scene(scene):
	var instanced_scene = scene.instance()
	add_child(instanced_scene)
	return instanced_scene

func set_controller():
	controller = load_scene(controller)
	controller.init(self)


func set_army(new_army):
	army = new_army
	connect_to_army_signals()
func get_army():
	return army

func set_army_colour(colour : Color):
	ARMY_COLOUR = colour
	sprite.material.set("shader_param/NEWCOLOUR", colour)

func set_target(new_target):
	target = new_target
func get_target():
	return target

func set_army_state(new_state):
	if actor_army_state != new_state:
		emit_signal("actor_state_changed", new_state)
	actor_army_state = new_state


func move_to_target(pathfind, new_target):
	var move_velocity = Vector2.ZERO

	if new_target == null:
		new_target = Vector2.ZERO

	var move_target = new_target
#	if pathfind:
	if false:
		nav_agent.set_target_location(move_target)
		move_target = nav_agent.get_next_location()
	move_velocity = get_global_position().direction_to(move_target).normalized() * MOVE_SPEED
	move_and_slide(move_velocity)

	animationlist.animation_flip_sprite(move_velocity)
	animationlist.animation_run()

func attack_enemy(new_enemy, attack_timer):
	if (attack_timer.get_time_left() <= 0.0):
		attack_timer.start()
		print("attack!")
		animationlist.animation_attack()
		new_enemy.take_damage(DAMAGE)

func take_damage(damage):
	animationlist.animation_attacked()
	HEALTH -= damage
	if HEALTH <= 0:
		animationlist.animation_dead()
		isDead = true
		set_physics_process(false)

func _emit_is_dead():
	emit_signal("isDeadSignal", self)

func actor_dies():
	animationlist.animation_dead()
	collision.set_disabled(true)
	_emit_is_dead()

func resurrect():
	isDead = false
	HEALTH = 3
	controller.change_state(controller.starting_state)
	collision.set_disabled(false)
