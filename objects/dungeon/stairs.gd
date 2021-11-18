extends Node2D

onready var objectsprite = get_node("Sprite")
var tex_up = preload("res://graphics/dungeon/stairs_up.png")
var tex_down = preload("res://graphics/dungeon/stairs_down.png")
var direction = 0
onready var map = get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	match direction:
		1:
			objectsprite.set_texture(tex_up)
		0:
			objectsprite.set_texture(tex_down)
			 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_dir(dir: int):
	if dir == 1:
		direction = 1
	if dir == 0:
		direction = 0
		
func get_dir():
	return direction 

func set_map_pos(cell):
	set_position(map.map_to_world(cell))
	
func get_map_pos():
	return map.world_to_map(get_position())	
