extends Node2D

export var o_type = "hero"
export var o_friendly = "friendly"
export var o_number = -1
var playertex = GlobalVars.playertex
var whaletex = GlobalVars.whaletex
onready var objectsprite = get_node("Sprite")
onready var camera = get_node("Camera2D")
onready var fighter = get_node("Fighter")
onready var inventory = get_node("Inventory")
onready var map = get_parent()
onready var pathfinder = map.pathfinder
onready var aStar = map.pathfinder.aStar
signal hit (attacker, damager)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Set our position in map cell coordinates
func set_map_pos(cell):
	set_position(map.map_to_world(cell))

# Get our position in map cell coordinates
func get_map_pos():
	return map.world_to_map(get_position())

func getimage():
	match o_type:
		"hero":
			objectsprite.set_texture(playertex)
		"whale":
			objectsprite.set_texture(whaletex)
# Called when the node enters the scene tree for the first time.
func _ready():
	if o_type == "hero":
		camera.current = true
		camera.limit_right = 64*map.a+96
		camera.limit_bottom = 64*map.b+96
		fighter.set_params(GlobalVars.hero_params)
		get_node("Light2D2").enabled = true
		get_node("Light2D").enabled = true

		print(get_node("Light2D").enabled)
		print(get_node("Light2D2").enabled)
	if o_type != "hero":
		get_node("Light2D").enabled = false
		get_node("Light2D2").enabled = false
		fighter.set_params(GlobalVars.whale_params)
		inventory.generate_items()
			
	set_process_input(true)
	getimage()
	self.connect("hit",self.get_parent(), "_on_hit")

func step(dir):
	dir.x = clamp(dir.x, -1, 1)
	dir.y = clamp(dir.y, -1, 1)
	var old_cell = get_map_pos()
	var new_cell = get_map_pos() + dir
	var check = map.is_blocked(new_cell)
	
	if  check== "empty" :
		set_map_pos(new_cell)
		map.pathfinder.occupy(new_cell)
		map.pathfinder.freed(old_cell)
	elif check=="foe":
		var enemy_cell = new_cell
		new_cell = old_cell
		if o_type == "hero":
			self.emit_signal("hit",old_cell,enemy_cell)
			
		
	else:
		print("You bravely walk into the wall.")
		new_cell = old_cell
	if o_type == "hero":
		map.hero_position = new_cell


	
	
	return check
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_directions(start:Vector2, end:Vector2):
	return end-start
	
func dothemove():
	match o_type:
		"whale":
			#map.pathfinder.get_a_cells()
			var paths = pathfinder.get_a_path(aStar, self.get_map_pos(), map.hero_position)

			if paths != [] and len(paths)>2 and len(paths)<7:
				var step_dir = get_directions(self.get_map_pos(), paths[1])
				step(step_dir)
				
			elif len(paths) == 2:
				self.emit_signal("hit",paths[0],paths[1])
				
		
func set_hp(hp:int):
	fighter.hp = hp
