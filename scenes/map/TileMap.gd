extends TileMap

var a = GlobalVars.a
var b = GlobalVars.b
export (PackedScene) var Obj
export (PackedScene) var Itm
export (PackedScene) var Str

var hero_position = Vector2(1,1)
var map = self
onready var main = get_parent()
onready var generator = get_node("generator")
onready var pathfinder = get_node("pathfinder")
export var map_array =["ground"]
export var ids = [-1] 
export var ents = ["dummy"]
export var iids = [-2] 
export var itms = ["zero"]
export var used_cells = []
var monsters = 0
var max_enemies = GlobalVars.max_enemies
var rng = GlobalVars.rng
var total_enemies = rng.randi_range(max_enemies/2, max_enemies-1)
var hp = 100000
signal hp_change(hp)
signal lvl_change(lv)
signal turn_change
signal show_help
var i_types = GlobalVars.i_types
var hero
var survivers = ["empty"]
var hero_positions = ["start"]
var stairs_position = ["noescape"]
var stairs_array = ["defaultstair"]
var current_floor = 0
signal show_inventory
signal show_shop
var help_on = true
var regen_rate = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_scene(a,b, total_enemies, 1)
	current_floor = 1
	self.connect("show_inventory", main, "_on_inventory_show")
	self.connect("show_shop", main, "_on_shop_show")
	self.connect("show_help", main, "_on_help_show")
	self.connect("hp_change",self.get_parent(),"_on_hp_change")
	self.connect("lvl_change",self.get_parent(),"_on_level_change")
	self.connect("turn_change",self.get_parent(),"_on_turn_change")


func set_scene(a: int, b:int, m:int, l: int):
	get_level(a,b,l)

	map.pathfinder.get_a_cells()	


	used_cells = map.get_used_cells_by_id(0)
	print(l)
	if l >=len(hero_positions) or len(hero_positions)==1:
		hero_position = new_spawn()
		print("new")
	else:
		print("old")
		hero_position = hero_positions[l]
	if not hero:
		print("NO HERO")
		hero = spawn("hero", hero_position)
	else:
		hero.set_map_pos(hero_position)
		used_cells.erase(hero_position)
	hp = hero.fighter.hp
	
	if l >=len(survivers):
		for i in range(0,m):
			spawn("whale", new_spawn())
			monsters += 1
	else:
		
		for i in survivers[l]:
			spawn("whale", i[1])
			ents[-2].set_hp(i[0])
			
	if l>=len(stairs_position):
		if l ==1:
			add_stairs(stair_pos())
		else:
			add_stairs(one_stair_pos(hero.get_map_pos()))
	else:
		print(stairs_position[l])
		add_existing_stairs(stairs_position[l]) 

	
	map.pathfinder.get_a_cells()
	

func get_level(a,b,l:int):
	if l>=len(map_array) or len(map_array)==1:
		generator.set_map(a,b)
	else:
		generator.get_map(l)

	
func spawn(flavor: String, location: Vector2):
	var number
	if ids != [-1]:
		number = ids.max()+1
	else:
		ids.clear()
		ents.clear()
		number = 0
	var obj = Obj.instance()
	obj.o_type = flavor
	obj.o_number = number
	ids.append(obj.o_number)
	ents.append(obj)
	add_child(obj)
	obj.set_map_pos(location)
	if flavor != "hero":
		obj.o_friendly = "foe"
	used_cells.erase(location)

	return obj
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_hero():
	return hero

func stair_pos():
	var ids = range(0, len(used_cells))
	var id1 = generator.rng.randi_range(0, len(ids)-1)
	var loc1 = used_cells[id1]
	ids.remove(id1)
	var id2 = generator.rng.randi_range(0, len(ids)-1)
	var loc2 = used_cells[id2]
	print([loc1, loc2])
	return [loc1,loc2]
	
func one_stair_pos(loc1:Vector2 ):
	var ids = range(0, len(used_cells))
	var id1 = used_cells.find(loc1)
	ids.remove(id1)
	var id2 = generator.rng.randi_range(0, len(ids)-1)
	var loc2 = used_cells[id2]
	print([loc1, loc2])
	return [loc2,loc1]

func add_stairs (positions) :
	var loc1 = positions[0]
	var loc2 = positions[1]
	var strs1 = Str.instance() 
	strs1.set_dir(0)
	stairs_array.append(strs1)
	add_child(strs1)
	strs1.set_map_pos(loc1)

	var strs2 = Str.instance() 
	strs2.set_dir(1)
	stairs_array.append(strs2)
	add_child(strs2)
	strs2.set_map_pos(loc2)


	
func add_existing_stairs(state):
	var loc1 = state[0][1]
	var loc2 = state[1][1]
	var dir1 = state[0][0]
	var dir2 = state[1][0]
	var strs1 = Str.instance() 
	strs1.set_dir(dir1)
	stairs_array.append(strs1)
	add_child(strs1)
	strs1.set_map_pos(loc1)
	var strs2 = Str.instance() 
	strs2.set_dir(dir2)
	stairs_array.append(strs2)
	add_child(strs2)
	strs2.set_map_pos(loc2)	


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
	itm.set_map_pos(location)
	
		
func is_blocked(cell):
	if get_cellv(cell)==1:
		return "wall"
	else:
		if ents != ["dummy"]:
			for i in ents:

				if i.get_map_pos() ==cell:

					return "foe"
		return "empty"

func new_spawn():
	var new_spawn
	var id = generator.rng.randi_range(0,len(used_cells)-1)
	return used_cells[id]

func find_ent(loc:Vector2):
	for i in len(ents):
		if ents[i].get_map_pos() == loc:
			return i
			
func find_itm(loc:Vector2):
	if itms:
		for i in len(itms):
			if (itms[i] is String) == false:
				if itms[i].get_map_pos() == loc:
					return i
	return -1
	
func _on_hit(attacker,damager):

	var ati = find_ent(attacker)
	var dami = find_ent(damager)


	var at = ents[ati]
	var dam = ents[dami]

	var res = dam.fighter.get_attack(at.fighter.dnumber, at.fighter.ddice, at.fighter.BAB, at.fighter.dbonus, at.fighter.crit_mult, at.fighter.crit_chance)
	if dam.o_type == "hero":
		var health = dam.fighter.hp
		emit_signal("hp_change",health)
	if res == 0:
		
		if dam.o_type != "hero":
			
			var pos = dam.get_map_pos()
			
			
			#print("inventory:", drop,pos)
			dam.queue_free()
			ids.remove(dami)
			
			ents.remove(dami)
			
			used_cells.erase(pos)
			monsters-=1
			
			if dam.inventory.items != []:
				
				var drop =  i_types[dam.inventory.items[0]]
				drop_item(drop, pos)
			if monsters==0:
				print("win")
				hero.get_node("Light2D").enabled = false
				hero.get_node("Light2D2").enabled = false
				var modul = get_node("CanvasModulate")
				modul.set_color(Color(1, 1, 1, 1) )
				
		else:
			print("lose")
			hero.get_node("Light2D").enabled = false
			hero.get_node("Light2D2").enabled = false
			var modul = get_node("CanvasModulate")
			modul.set_color(Color(1, 0, 0, 1) )
			
func check_stairs(direction:int, loc: Vector2):
	print(stairs_array)
	var res = false
	for i in range(len(stairs_array)):
		if (stairs_array[i] is  String) == false:
			print([stairs_array[i].get_dir(),stairs_array[i].get_map_pos(), direction])
			if stairs_array[i].get_map_pos() == loc and direction == stairs_array[i].get_dir():
				res = true
	return res		

func pick(loc:Vector2):
	var it = find_itm(loc)
	if it >=0:
		var flav = itms[it].i_type
		var flav_id = i_types.find(flav)
		var item = itms[it]
		item.queue_free()
		itms.remove(it)
		iids.remove(it)
		if iids == []:
			iids = [-2]
		hero.inventory.add_item(flav_id)
		

func _input(event):
		if main.shop_on == false:
			if event is InputEventKey and event.pressed:
				var UP = (event.scancode == KEY_K or event.scancode ==KEY_UP)
				var DOWN = (event.scancode == KEY_J or event.scancode == KEY_DOWN)
				var LEFT = (event.scancode == KEY_H or event.scancode == KEY_LEFT)
				var RIGHT = (event.scancode == KEY_L or event.scancode == KEY_RIGHT)
				var PICK = event.scancode == KEY_P
				var INV = event.scancode == KEY_I

				var NEW = event.scancode == KEY_N
				var BCK = event.scancode == KEY_B
				
				if UP:
					hero.step(Vector2(0,-1))
					print("UP")
				if DOWN:
					hero.step(Vector2(0,1))
				if LEFT:
					hero.step(Vector2(-1,0))
				if RIGHT:
					hero.step(Vector2(1,0))
				if PICK:
					map.pick(hero.get_map_pos())
				if INV:	
					toggle_inventory()
				
				if NEW and check_stairs(0,hero.get_map_pos()):
					new_floor(a,b, total_enemies,current_floor, current_floor+1)
				if BCK and check_stairs(1,hero.get_map_pos()):
					new_floor(a,b, total_enemies,current_floor, max(1,current_floor-1))
				for i in map.ents:
					i.dothemove()

				print(main.turn_counter)
				emit_signal("turn_change")
				if main.turn_counter%regen_rate == 0:
					hero.fighter.heal(1)
					var health = hero.fighter.hp
					emit_signal("hp_change",health)
		if event is InputEventKey and event.pressed:
			var SHP = event.scancode == KEY_S
			if SHP:	
					toggle_shop()
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed: 
				if help_on ==true:
					emit_signal("show_help")
					help_on = false

func toggle_inventory():
	self.emit_signal("show_inventory", hero.inventory.items)
	
func toggle_shop():
	self.emit_signal("show_shop", hero.inventory.items)

func new_floor(a,b,m,l1,l2):
	print("NEW FLOOR")
	var mon_surv = []
	for i in ents:
		if i.o_friendly == "foe":
			var pos = i.get_map_pos()
			var hp = i.fighter.get_hp()
			var state = [hp, pos]
			print(state)
			mon_surv.append(state)
	if len(survivers)<=l1:		
		survivers.append(mon_surv)
		print("NEW ")
	else:
		survivers[l1]=[]+mon_surv
		print("OLD ")
	if len(hero_positions)<=l1:
		hero_positions.append(hero.get_map_pos())
		print("NEW ",hero_positions)
	else:
		hero_positions[l1]=hero.get_map_pos()
		print("OLD ", hero_positions)
	while len(ents)>1:
			var j = ents[-1]
			j.queue_free()
			ids.pop_back()
			ents.pop_back()
	var strs_fl = []
	
	for i in range(1,3): 
		var pos = stairs_array[i].get_map_pos()
		var dir = stairs_array[i].get_dir()
		var state = [dir,pos]
		strs_fl.append(state) 
	if len(stairs_position)<=l1:
		stairs_position.append(strs_fl)
	else:
		stairs_position[l1]=[]+strs_fl
	while len(stairs_array)>1:
		var j = stairs_array[-1]
		j.queue_free()
		stairs_array.pop_back()
	print(hero_positions)
	hp = hero.fighter.hp		 
	set_scene(a,b,m,l2)		
	current_floor = l2
	hero.fighter.hp = hp
	print(hero.fighter.hp)
	emit_signal("lvl_change",current_floor)
