extends YSort

class_name Army

#to be phased out with programatic instancing
export (PackedScene) var controller


onready var enemy_detector = $EnemyDetector
onready var actor_spawner = $SpawnerActor

var actor_scene = load("res://Actor/Actor.tscn")
var actor_controller  = load("res://State Machine/AI/Basic Soldier SM.tscn")

var soldiers_array = []
var army_position = Vector2.ZERO


var target = Vector2.ZERO

#-------------------------------------------------------------
func _ready() -> void:
	target = army_position
	set_controller()
	set_child_actor_army()
	enemy_detector.set_parent(self)
	army_position = calc_center_of_group()

func actor_factory(amount, position):
	for count in amount:
		var offset = 20
		var spawn_position = Vector2(rand_range(position.x-offset, position.x+offset), rand_range(position.y-offset, position.y+offset))
		spawn_actor(actor_scene, actor_controller, spawn_position, self)

func spawn_actor(new_actor_scene, new_actor_controller, position, army):
	var actor = new_actor_scene.instance()
	actor.controller = new_actor_controller
	actor.set_army(army)
	add_child(actor)
	actor.set_global_position(position)



func set_controller():
	controller = load_scene(controller)
	controller.init(self)

func load_scene(scene):
	var instanced_scene = scene.instance()
	add_child(instanced_scene)
	return instanced_scene

func set_child_actor_army():
	for child in get_children():
		if child.is_in_group("Actor"):
			child.set_army(self)
			soldiers_array.append(child)

#-------------------------------------------------------------

func _physics_process(delta: float) -> void:
	army_position = calc_center_of_group()
	enemy_detector.set_global_position(army_position)
	controller._physics_process(delta)


func remove_dead_soldiers():
	for soldier in soldiers_array:
		if soldier.isDead:
			soldiers_array.remove(soldiers_array.find(soldier))

func set_target(new_target):
	for child in get_children():
		if child.is_in_group("Actor"):
			child.target = new_target


func calc_center_of_group():
	var center = Vector2.ZERO
	var child_count = 0
	for child in get_children():
		if child.is_in_group("Actor"):
			child_count += 1
			center += child.get_global_position()
	center /= child_count
	return center

