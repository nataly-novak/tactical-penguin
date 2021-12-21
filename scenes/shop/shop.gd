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
var top = 0
var bottom = 1
var known_bp = GlobalVars.known_bp

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var n = int(main.get_viewport_rect().size.y/(128*GlobalVars.scale_param))
	bottom = n-3
	print(inventory.items)
	lst = inventory.get_total()
	l1.text = str(lst[0])
	l2.text = str(lst[1])
	l3.text = str(lst[2])
	var h = 0
	var ht = 0
	
	for i in (len(known_bp)):
		print(i)
		if entries == ["head"]:
			entries.clear()
		var body = Body.instance()
		entries.append(body)
		add_child(body)
		h = h+128
		if i<n-2:
			ht = h+128
		else:
			body.visible = false
		body.set_position(Vector2(0,h))
		body.set_item(blueprints[known_bp[i]])
		if i == selected:
			body.toggle_bg()
	tail = Tail.instance()
	h=ht+128
	add_child(tail)
	tail.set_position(Vector2(0,ht))
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
	for i in len(lst)-2:
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

func wind_down():
	top+=1
	bottom +=1
	for i in len(entries):
		entries[i].position.y = entries[i].position.y -128
		if i== top -1:
			entries[i].visible = false
		if i == bottom:
			entries[i].visible = true
func wind_up():
	top-=1
	bottom -=1
	for i in len(entries):
		entries[i].position.y = entries[i].position.y +128
		if i== top :
			entries[i].visible = true
		if i == bottom+1:
			entries[i].visible = false

			
func go_down():
	print("go_down")		
	if shop.selected<len(shop.entries)-1:
		print(bottom, shop.selected)
		if shop.selected == bottom:
			print("wind_down()")
			wind_down()
		shop.entries[shop.selected].toggle_bg()
		shop.selected += 1
		shop.entries[shop.selected].toggle_bg()
		
func go_up():
	if shop.selected>0:
		if shop.selected == top:
			wind_up()
		shop.entries[shop.selected].toggle_bg()
		shop.selected -= 1
		shop.entries[shop.selected].toggle_bg()	
