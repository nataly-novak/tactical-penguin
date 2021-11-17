extends TileMap

export var a =30
export var b = 30
export (PackedScene) var Obj
export (PackedScene) var Itm

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
var total_enemies = 10
var hp = 100000
signal hp_change(hp)
var i_types = ["stick", "plack"]
var hero
var survivers = ["empty"]


signal show_inventory
signal show_shop
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_scene(a,b, total_enemies, 1)

func set_scene(a: int, b:int, m:int, l: int):
	get_level(a,b,l)

	map.pathfinder.get_a_cells()	

	self.connect("hp_change",self.get_parent(),"_on_hp_change")
	used_cells = map.get_used_cells_by_id(0)
	hero_position = new_spawn()
	if not hero:
		hero = spawn("hero", hero_position)
	else:
		hero.set_map_pos(hero_position)
	hp = ents[0].fighter.hp
	
	for i in range(0,m):
		spawn("whale", new_spawn())
		monsters += 1

	self.connect("show_inventory", main, "_on_inventory_show")
	self.connect("show_shop", main, "_on_shop_show")
	map.pathfinder.get_a_cells()
	print(monsters)	

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
	for i in len(itms):
		if itms[i].get_map_pos() == loc:
			return i
		else: 
			return -1

func _on_hit(attacker,damager):
	print("hit")
	var ati = find_ent(attacker)
	var dami = find_ent(damager)


	var at = ents[ati]
	var dam = ents[dami]

	var res = dam.fighter.get_attack(at.fighter.dnumber, at.fighter.ddice, at.fighter.BAB, at.fighter.dbonus, at.fighter.crit_mult, at.fighter.crit_chance)
	if dam.o_type == "hero":
		var health = dam.fighter.hp
		emit_signal("hp_change",health)
	if res == 0:
		print(dam.o_type)
		if dam.o_type != "hero":
			
			var pos = dam.get_map_pos()
			
			
			#print("inventory:", drop,pos)
			dam.queue_free()
			ids.remove(dami)
			print(ents)
			ents.remove(dami)
			print(ents)
			used_cells.erase(pos)
			monsters-=1
			print(len(ids))
			if dam.inventory.items != []:
				var drop =  i_types[dam.inventory.items[0]]
				drop_item(drop, pos)
			if monsters==0:
				print("win")
				ents[0].get_node("Light2D").enabled = false
				ents[0].get_node("Light2D2").enabled = false
				var modul = get_node("CanvasModulate")
				modul.set_color(Color(1, 1, 1, 1) )
				
		else:
			print("lose")
			ents[0].get_node("Light2D").enabled = false
			ents[0].get_node("Light2D2").enabled = false
			var modul = get_node("CanvasModulate")
			modul.set_color(Color(1, 0, 0, 1) )
			
			

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
		print(hero.inventory.items)

func _input(event):

		if event is InputEventKey and event.pressed:
			var UP = event.scancode == KEY_K
			var DOWN = event.scancode == KEY_J
			var LEFT = event.scancode == KEY_H
			var RIGHT = event.scancode == KEY_L
			var PICK = event.scancode == KEY_P
			var INV = event.scancode == KEY_I
			var SHP = event.scancode == KEY_S
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
			if SHP:	
				toggle_shop()
			if NEW:
				set_scene(a,b, total_enemies, len(map_array))
			if BCK:
				set_scene(a,b, total_enemies, max(1,len(map_array)-1))
			for i in map.ents:
				i.dothemove()

func toggle_inventory():
	self.emit_signal("show_inventory", hero.inventory.items)
	
func toggle_shop():
	self.emit_signal("show_shop", hero.inventory.items)

func new_floor(a,b,m,l):
	var mon_surv = []
	for i in ents:
		if i.o_type == "foe":
			var pos = i.get_map_pos()
			var hp = i.fighter.get_hp()
			var state = [hp, pos]
			mon_surv.append(state)
	if not survivers[l]:		
		survivers.append(mon_surv)
	else:
		survivers[l]=[]+mon_surv
		
