extends Node2D

var f_type = "chair"
var ff_type = GlobalVars.ff_types

var flavors = GlobalVars.f_flavors
var f_number = -1
onready var objectsprite = get_node("Sprite")

# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_type(flavor):
	f_type = flavor
	print(ff_type)
	var i = ff_type.find(flavor)
	print(flavor)
	print(i)
	print(flavors)
	print(flavors[i])
	objectsprite.set_texture(flavors[i])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
