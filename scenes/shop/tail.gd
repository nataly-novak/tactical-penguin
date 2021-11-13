extends Node2D

var f_types = ["chair"]
export var fids = [-2] 
export var fnts = ["zero"]
export (PackedScene) var Fnt
var i_types = ["stick", "plack"]
onready var shop = get_parent()
var furns = -1# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func drop_item(flavor: String, location: int):
	var num
	if fids != [-2]:
		num = fids.max()+1
	else:
		fids.clear()
		fnts.clear()
		num = 0
	var fnt = Fnt.instance()
	furns+=1
	fnt.f_type = flavor
	fnt.f_number = num

	fids.append(fnt.f_number)
	fnts.append(fnt)
	add_child(fnt)
	set_inv_pos(fnt, location)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_inv_pos(item,cell:int):
	var x = (cell+1)*96+32
	var y = 16
	item.set_position(Vector2(x,y))
