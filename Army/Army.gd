extends YSort

class_name Army

#to be phased out with programatic instancing
export (PackedScene) var controller
export (Color) var ARMY_COLOUR

signal army_defeated
signal army_state_signal

onready var enemy_detector = $EnemyDetector
onready var actor_spawner = $SpawnerActor

var actor_scene = load("res://Actor/Actor.tscn")
var actor_controller  = load("res://State Machine/AI/Basic Soldier SM.tscn")

var _current_state
var enemy_armies_array = []
var soldiers_array = []
var live_soldiers_array = []
var army_position = Vector2.ZERO


var target = Vector2.ZERO

#-------------------------------------------------------------
func _ready() -> void:
	target = army_position
	set_controller()
	add_actor_to_army()
	set_child_actor_army(soldiers_array)
	enemy_detector.set_parent(self)
	army_position = calc_center_of_group(live_soldiers_array)

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

func add_actor_to_army():
	for child in get_children():
		if child.is_in_group("Actor"):
			soldiers_array.append(child)
			live_soldiers_array.append(child)
			child.connect("isDeadSignal", self, "_on_child_dead") # connect to actor dies signal

func set_child_actor_army(array):
	for child in array:
		if child.is_in_group("Actor"):
			child.set_army(self)
			child.set_army_colour(ARMY_COLOUR)

func resurrect_children(array):
	for child in array:
		if child.is_in_group("Actor"):
			child.resurrect()

#-------------------------------------------------------------

func _physics_process(delta: float) -> void:
	army_position = calc_center_of_group(live_soldiers_array)
	enemy_detector.set_global_position(army_position)
	controller._physics_process(delta)

	if live_soldiers_array.empty():
		emit_signal("army_defeated", self, soldiers_array)
		self.queue_free()


func _on_child_dead(child):
	print("child is dead")
	live_soldiers_array.remove(live_soldiers_array.find(child))

func set_target(new_target):
	for child in get_children():
		if child.is_in_group("Actor"):
			child.target = new_target


func calc_center_of_group(array):
	var center = Vector2.ZERO
	var child_count = 0
	for child in array:
		if child.is_in_group("Actor"):
			child_count += 1
			center += child.get_global_position()
	center /= child_count
	return center

func add_enemy_army(body):
	if body.army != self:
		if !enemy_armies_array.has(body.army):
			enemy_armies_array.append(body.army)
			body.army.connect("army_defeated", self, "_enemy_army_defeated")

func reparent_node(old_parent, node, new_parent):
	old_parent.remove_child(node)
	new_parent.add_child(node)

func _enemy_army_defeated(enemyarmy, defeated_soldiers_array):
	print("I steal your army")
	enemy_armies_array.remove(enemy_armies_array.find(enemyarmy))

	for soldier in defeated_soldiers_array:
		reparent_node(enemyarmy, soldier, self)

	set_child_actor_army(defeated_soldiers_array)
	resurrect_children(defeated_soldiers_array)

	#find better way
	soldiers_array.append_array(defeated_soldiers_array)
	live_soldiers_array.append_array(defeated_soldiers_array)

