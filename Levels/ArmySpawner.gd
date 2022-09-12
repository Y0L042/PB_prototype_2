extends Node


export (int) var NPC_ARMIES_AMOUNT
export (int) var ARMY_SIZES

export (Color) var PLAYER_ARMY_COLOUR
export (Color) var NPC_ARMY_COLOUR

var army_scene = load("res://Army/Army.tscn")

var player_controller = load("res://Player/Player SM.tscn")
var npc_controller_default = load("res://State Machine/AI/Basic Army SM.tscn")


func _ready():
	instantiate_player_army()
	for count in ARMY_SIZES:
		instantiate_npc_armies()

func instantiate_player_army():
	var player_army = army_scene.instance()
	player_army.controller = player_controller
	player_army.ARMY_COLOUR = PLAYER_ARMY_COLOUR
	player_army.army_position = Vector2.ZERO
	player_army.actor_factory(NPC_ARMIES_AMOUNT, player_army.army_position)
	add_child(player_army)


func instantiate_npc_armies():
	var npc_army = army_scene.instance()
	npc_army.controller = npc_controller_default
	npc_army.ARMY_COLOUR = NPC_ARMY_COLOUR
	add_child(npc_army)
	npc_army.army_position = Vector2(2000,2000)
	npc_army.set_global_position(npc_army.army_position)
	npc_army.actor_factory(NPC_ARMIES_AMOUNT, npc_army.position)


