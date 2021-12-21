extends Node



var rng = RandomNumberGenerator.new()

var i_types = ["stick", "plank", "cloth","food", "blueprint"]

var ff_types = ["chair","table","curtain","bed", "bedside", "soft"]
var setups = [[6,2,0],[8,4,0],[3,0,2],[10,9,7],[0,6,0],[0,5,2]]
var known_bp = [0,1]

var chairtex = preload("res://graphics/furniture/chair.png")
var tabletex = preload("res://graphics/furniture/Table.png")
var curtaintex = preload("res://graphics/furniture/Curtain.png")
var bedtex = preload("res://graphics/furniture/bed.png")
var bedsidetex = preload("res://graphics/furniture/bedside.png")
var softtex = preload("res://graphics/furniture/soft.png")
var f_flavors = [chairtex, tabletex, curtaintex, bedtex, bedsidetex, softtex]
var chairtexb = preload("res://graphics/blueprints/chair.png")
var tabletexb = preload("res://graphics/blueprints/Table.png")
var curtaintexb = preload("res://graphics/blueprints/Curtain.png")
var bedtexb = preload("res://graphics/blueprints/bed.png")
var bedsidetexb = preload("res://graphics/blueprints/bedside.png")
var softtexb = preload("res://graphics/blueprints/soft.png")
var btextures = [chairtexb,tabletexb,curtaintexb,bedtexb,bedsidetexb,softtexb]

var hero_params = [300,12,5,1,6,3,2,19,-1,-1]
var whale_params = [20,13,2,2,4,1,2,20,1,7]

var food_heal = 20
var pasta_heal = 60
var min_walru_depth = -1
var walrus_freq = 1
var min_blueprint_depth = 3
var blueprint_freq = 20

var playertex = preload("res://graphics/player/Penguin.png")
var whaletex = preload("res://graphics/monster/Whale.png")
var walrustex = preload("res://graphics/kitchen/walrus_token.png")

var max_enemies = 20

var a = 30
var b = 30
var max_size = 12
var min_size = 2
var max_num = 8
var min_num = 2
var hall_width = 1
var max_room_start = 16
var max_free_items = 7 



var level_ups = [5,10,20,40,80, 160]


var placktex = preload("res://graphics/items/plackl.png")
var sticktex = preload("res://graphics/items/Stick.png")
var clothtex = preload("res://graphics/items/cloth.png")
var foodtex = preload("res://graphics/items/food.png")
var blueprinttex = preload("res://graphics/items/blueprint.png")
var itemtex = [sticktex, placktex, clothtex, foodtex, blueprinttex]# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var furniture_collection = ["room"]
#var furniture_collection = ["chair", "chair","chair"]


var ochair = preload("res://objects/Home/chair.tscn")
var otable = preload("res://objects/Home/table.tscn")
var ocurtain = preload("res://objects/Home/curtain.tscn")
var obed = preload("res://objects/Home/bed.tscn")
var obedside = preload("res://objects/Home/bedside.tscn")
var osoft = preload("res://objects/Home/soft.tscn")
var ofurn = [ochair, otable, ocurtain, obed,obedside, osoft ]

var saved_room = ["save"]

var platform = OS.get_name()

var scale_param = 1

var def_font_size = 18
var label_font_size = 40

var unknown_bp = [2]


#var saved_room = [["chair", Vector2(300,300)]]
# Called when the node enters the scene tree for the first time.
func _ready():
	print(platform)
	rng.randomize() # Replace with function body.
	get_unknowns()
	

func rolled(number, dice):
	var res = 0
	for i in number:
		res+=rng.randi_range(1,dice)
		print(res)
	return res
	
	
func save_to_string():
	var save_str = ""
	if saved_room !=  ["save"]:
		for i in saved_room:
			var itm = str(ff_types.find(i[0]))
			var x = str(int(i[1].x))
			var y = str(int(i[1].y))
			var ln = itm+","+x+","+y+";" 
			save_str = save_str+ln
		save_str = save_str+"_"
		for i in known_bp:
			save_str= save_str+str(i)+","
	return save_str
	
func load_from_string(save_str:String):
	var save = ["save"]
	if save_str != "":
		save.clear()
		var ls = save_str.split("_")
		var lines = ls[0].split(";",false)
		for ln in lines:
			var parts = ln.split(",")
			var itm = ff_types[int(parts[0])]
			var x = int(parts[1])
			var y = int(parts[2])
			var entry = [itm,Vector2(x,y)]
			save.append(entry)
		if len(ls)>1:
			known_bp.clear()
			var nms = ls[1].split(",",false)
			for i in nms:
				known_bp.append(int(i))
	saved_room = []+save
			
			
func save_to_disk():
	if platform != "HTML5":
		var save_game = File.new()
		save_game.open("user://savegame.save", File.WRITE)
		save_game.store_line(to_json(save_to_string()))
		save_game.close()

func load_from_disk():
	var save_game = File.new()
	if save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.READ)
		while save_game.get_position() < save_game.get_len():
			var line = parse_json(save_game.get_line())
			load_from_string(line)					
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_unknowns():
	unknown_bp.clear()
	for i in len(ff_types):
		if (i in known_bp)==false:
			unknown_bp.append(i)
			
	
func learn_bp(x: int):
	var i = unknown_bp[x]
	
	unknown_bp.remove(x)
	if i in known_bp == false:
		known_bp.append(i)
		
func get_bp():
	var  l = len(unknown_bp)-1
	var x = rng.randi_range(0, l)
	return x
			
			
			
 
