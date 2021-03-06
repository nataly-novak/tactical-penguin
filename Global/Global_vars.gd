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

var e_types = ["whale","coolwhale"]
var e_lims = [-2,2]
var e_i_freq = [50,10]

var hero_params = [300,12,5,1,6,3,2,19,-1,-1,0]
var walrus_params =  [300,12,5,1,6,3,2,19,-1,-1,0]
var whale_params = [20,13,2,2,4,1,2,20,1,7,1]
var coolwhale_params = [30,15,2,2,5,2,4,20,3,10,2]

var food_heal = 15
var pasta_heal = 45
var min_walru_depth = 1
var walrus_freq = 3
var min_blueprint_depth = 3
var blueprint_freq = 20

var playertex = preload("res://graphics/player/Penguin.png")
var whaletex = preload("res://graphics/monster/Whale.png")
var walrustex = preload("res://graphics/kitchen/walrus_token.png")
var coolwhaletex = preload("res://graphics/monster/coolwhale.png")

var max_enemies = 20

var a = 30
var b = 30
var max_size = 12
var min_size = 2
var max_num = 8
var min_num = 2
var hall_width = 1
var max_room_start = 16
var max_free_items = 5 



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

var w_01 = preload("res://graphics/equipment/weapon/w_01.PNG")
var w_02 = preload("res://graphics/equipment/weapon/w_02.png")
var weapons = [[],[w_01, "d", 1], [w_02, "c", 3]]
var weapons_a = [[],[w_01, "d", 1], [w_02, "c", 3]]

var h_01 = preload("res://graphics/equipment/head/h_01.PNG")
var h_02 = preload("res://graphics/equipment/head/h_02.png")
var heads = [[],[h_01, "e", 1], [h_02, "e", 2]]
var heads_a = [[],[h_01, "e", 1], [h_02, "e", 2]]

var b_01 = preload("res://graphics/equipment/body/b_01.PNG")
var b_02 = preload("res://graphics/equipment/body/b_02.png")
var body = [[],[b_01, "e", 2], [b_02, "e", 4]]
var body_a = [[],[b_01, "e", 2], [b_02, "e", 4]]

var booster =[[]]
var booster_a =[[]]

var feet = [[]]
var feet_a = [[]]

var rander = [[]]
var rander_a = [[]]

var equipment = [weapons, heads, body, booster, feet, rander]
var equipment_a = [weapons_a, heads_a, body_a, booster_a, feet_a, rander_a]
var equiped =[1,0,0,0,0,0]
var displayed=[1,1,1,0,0,0]
var bonuses = [0,0,2,0,0,0]
var def_bonuses = [0,0,2,0,0,0]

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
	if len(unknown_bp) > 0:
		var i = unknown_bp[x]
		
		unknown_bp.remove(x)
		if (i in known_bp) == false:
			known_bp.append(i)
		
			return true
		else:
			return false
	else:
		return false
		
func get_bp():
	var  l = len(unknown_bp)-1
	var x = rng.randi_range(0, l)
	return x
			
			
			
func get_enemy_params(typ:String):
	match typ:
		"hero":
			return hero_params
		"walrus":
			return walrus_params
		"whale":
			return whale_params
		"coolwhale":
			return coolwhale_params
			
			
func get_enemy_tex(typ:String):
	match typ:
		"hero":
			return playertex
		"walrus":
			return walrustex
		"whale":
			return whaletex
		"coolwhale":
			return coolwhaletex

func get_line(chr:String, vl:int):
	var line = str(vl)+" "
	match chr:
		"d":
			line ="+ "+line+ "to damage"
		"a":
			line ="+ "+line+ "to attack"
		"c":
			line = "x"+line+"critical"
		"s":
			line = "+ "+line+ "stealth"
		"e":
			line = "+ "+line + "to defense"
		"h":
			line = "+ "+line + "max HP"
		_:
			line = ""
	return line

func set_bonuses():
	for i in len(bonuses):
		bonuses[i]=def_bonuses[i]

	for i in len(equipment_a):
		var chr =""
		var val =0
		print(i, equipment_a[i])
		if equipment_a[i][equiped[i]]:
			chr = equipment_a[i][equiped[i]][1]
			val = equipment_a[i][equiped[i]][2]
			print(chr, val)
		match chr:
			"a":
				bonuses[0]+=val;
			"d":
				bonuses[1]+=val;
			"c":
				if bonuses[2]<val:
					bonuses[2] = val
			"e":
				bonuses[3]+=val
			"h":
				bonuses[4]+=val
			"s":
				bonuses[5]+=val
	print(bonuses)

func get_bonuses():
	print(bonuses)
	return bonuses
