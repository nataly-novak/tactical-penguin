extends Node2D

onready var objectsprite = get_node("Sprite")

var itemtex = GlobalVars.itemtex
export var i_type = "stick" 
var i_types = GlobalVars.i_types
export var o_type = "item"
onready var map = get_parent()
export (PackedScene) var Itm
export var o_number = -1
export var subtype = "helm"
export var subparam = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_map_pos(cell):
	set_position(map.map_to_world(cell))

# Get our position in map cell coordinates
func get_map_pos():
	return map.world_to_map(get_position())
# Called when the node enters the scene tree for the first time.
func _ready():
	get_texture(i_type)
	
func dothemove():
	pass
	
func get_texture(flavor):
	var i = i_types.find(flavor)
	objectsprite.set_texture(itemtex[i])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
