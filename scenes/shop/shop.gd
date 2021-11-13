extends Node

onready var shop = self
onready var ui = get_parent()
onready var main = ui.get_parent()
onready var head = get_node("Head")
onready var l1 = get_node("Head/Label1")
onready var l2 = get_node("Head/Label2")
onready var body = get_node("Body")
onready var tail = get_node("Tail")
onready var map = main.map
onready var hero = map.hero
onready var inventory = hero.inventory
var chair_set =[4,2]
var lst

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	lst = inventory.get_total()
	l1.text = str(lst[0])
	l2.text = str(lst[1])


func _input(event):

		if event is InputEventKey and event.pressed:
			var ENTER = event.scancode == KEY_ENTER
			if ENTER:
				if buy("chair"):
					tail.drop_item("chair", tail.furns)
			# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func buy(flavor):
	var item
	match flavor:
		"chair":
			item = chair_set
	var lst_new =[] 		
	for i in len(lst):
		var res = lst[i]-item[i]	
		if res < 0:
			return false
		else:
			lst_new.append(res) 
	for i in len(lst_new):
		lst[i]=lst_new[i]
	l1.text = str(lst[0])
	l2.text = str(lst[1])
	return true	
