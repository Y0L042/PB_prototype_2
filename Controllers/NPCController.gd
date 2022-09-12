extends YSort


var army : Army


func _ready():
	for child in get_children(): #set army
		if child.is_in_group("Army"):
			army = child

func _physics_process(_delta):
	army.target = army.army_position

