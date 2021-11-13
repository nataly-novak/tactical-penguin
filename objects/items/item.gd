extends Node2D

onready var objectsprite = get_node("Sprite")
var placktex = preload("res://graphics/items/plackl.png")
var sticktex = preload("res://graphics/items/Stick.png")
export var i_type = "stick" 
export var i_types = ["stick", "plack"]
export var o_type = "item"
onready var map = get_parent()
export (PackedScene) var Itm
export var o_number = -1
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
	match i_type:
		"stick":
			objectsprite.set_texture(sticktex)
		"plack":
			objectsprite.set_texture(placktex)

func dothemove():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
