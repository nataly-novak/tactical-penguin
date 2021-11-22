extends Node2D

export (PackedScene) var Cll
var names = GlobalVars.ff_types
var cids = [-3]
var cells = ["emptycell"]
var number = 0
var furnitures = GlobalVars.furniture_collection
var collected
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_cells()

func spawn_cells():
	collected = collect_furnitures()
	for i in len(names):
		var am = collected[i]
		var flav = names[i]
		add_cell(flav, am)

func add_cell(flavor, amount):
	print(cids)
	if cids != [-3]:
		number= cids.max()+1
	else:
		cids.clear()
		cells.clear()
		number = 0
	var cll = Cll.instance()
	cids.append(number)
	cells.append(cll)
	add_child(cll)	
	cll.set_cell(flavor, amount)

	cll.set_position(Vector2(192*number, 0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func collect_furnitures():
	var collection = ["starter"]
	collection.clear()
	for i in names:
		var n = 0
		for j in furnitures:
			if j == i:
				n = n+1
		collection.append(n)
	return collection

