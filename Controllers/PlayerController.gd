extends YSort


var army : Army 
onready var camera_td = $"%cameraTD"

func _ready():
	for child in get_children(): #set army
		if child.is_in_group("Army"):
			army = child

func _physics_process(_delta):
	army.target = get_global_mouse_position() #get_viewport().get_mouse_position()
