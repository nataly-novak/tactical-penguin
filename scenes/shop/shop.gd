extends Node

onready var shop = self
onready var ui = get_parent()
onready var main = ui.get_parent()
onready var head = get_node("Head")
onready var l1 = get_node("Head/Label1")
onready var l2 = get_node("Head/Label2")
onready var l3 = get_node("Head/Label3")
onready var labels = [l1,l2,l3]
onready var map = main.map
onready var hero = map.hero
onready var controls = main.controls
onready var inventory = hero.inventory
var chair_set =[4,2]
var lst
export (PackedScene) var Body
export (PackedScene) var Tail
var blueprints = GlobalVars.ff_types
var entries = ["head"]
var tail
var selected = 0
var good = blueprints[selected]
var setups = GlobalVars.setups
signal show_shop
signal checkout

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	print(inventory.items)
	lst = inventory.get_total()
	l1.text = str(lst[0])
	l2.text = str(lst[1])
	l3.text = str(lst[2])
	var h = 0
	for i in len(blueprints):
		if entries == ["head"]:
			entries.clear()
		var body = Body.instance()
		entries.append(body)
		add_child(body)
		h = h+128
		body.set_position(Vector2(0,h))
		body.set_item(blueprints[i])
		if i == selected:
			body.toggle_bg()
	tail = Tail.instance()
	h=h+128
	add_child(tail)
	tail.set_position(Vector2(0,h))
	self.connect("show_shop", main, "_on_shop_show")
	self.connect("checkout", main, "_on_checkout")
	

func _input(event):

		if event is InputEventKey and event.pressed:
			pass
			

	
			# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func buy(flavor):
	var item
	var j = blueprints.find(flavor)
	item  = setups[j]
	var lst_new =[] 		
	for i in len(lst):
		var res = lst[i]-item[i]	
		if res < 0:
			return false
		else:
			lst_new.append(res) 
	for i in len(lst_new):
		lst[i]=lst_new[i]
	for i in len(labels):
		labels[i].text = str(lst[i])
	
	return true	

func purchase():
	if tail.fnts != ["zero"]:
		for i in tail.fnts:
			GlobalVars.furniture_collection.append(i.f_type)
		print(GlobalVars.furniture_collection)
	self.emit_signal("show_shop", hero.inventory.items)
	self.emit_signal("checkout")

