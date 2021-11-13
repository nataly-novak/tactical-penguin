extends Node2D

onready var objectsprite = get_node("Sprite")
onready var ui = get_parent()
onready var main = ui.get_parent()
onready var map = main.map
onready var hero = map.hero
onready var inventory = hero.inventory
export var iids = [-2] 
export var itms = ["zero"]
export (PackedScene) var Itm
var i_types = ["stick", "plack"]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_map_pos(cell):
	set_position(map.map_to_world(cell))
# Called when the node enters the scene tree for the first time.
func _ready():
	var items = inventory.items
	for i in len(items):
		var x = (i) % 8
		var y = (i) / 8
		print("POSITION",i,x,y)
		var flavor = i_types[items[i]]
		drop_item(flavor,Vector2(x,y))
		#print(items)
	 # Replace with function body.

func drop_item(flavor: String, location: Vector2):
	var num
	if iids != [-2]:
		num = iids.max()+1
	else:
		iids.clear()
		itms.clear()
		num = 0
	var itm = Itm.instance()
	itm.o_type = "item"
	itm.o_number = num
	itm.i_type = flavor
	iids.append(itm.o_number)
	itms.append(itm)
	add_child(itm)
	set_inv_pos(itm, location)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_inv_pos(item,cell:Vector2):
	var x = cell.x*64-256
	var y = cell.y*64-256
	item.set_position(Vector2(x,y))
	

	
