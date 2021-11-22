extends Node2D

export (PackedScene) var Rfn
var number = 0
var fids = [-4]
var fnts = ["zerofurnishing"]
var names = GlobalVars.ff_types
onready var row = get_node("Node2D")
signal show_room_help
var help_on = false
export (PackedScene) var Hlp
var hlp
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("show_room_help", self, "_on_room_help_show")
	emit_signal("show_room_help")
	load_layout()

	# Replace with function body.

func _on_cell_clicked(f_type, number):
	var id = names.find(f_type)
	row.collected[id ]-=1
	add_furn(f_type, Vector2(300,300))


func add_furn(flavor, position:Vector2):
	if fids != [-4]:
		number = fids.max()+1
	else:
		number = 0
		fids.clear()
		fnts.clear()
	var rfn = Rfn.instance()
	add_child(rfn)
	fids.append(number)
	fnts.append(rfn)
	rfn.set_position(position) 
	rfn.setup(flavor)
	GlobalVars.furniture_collection.erase(flavor)
	
func save_layout():
	var furns = ["furns"]
	furns.clear()
	for i in fnts:
		furns.append([i.f_type, i.get_position()])
	print(furns)
	GlobalVars.saved_room = []+furns
	print(GlobalVars.saved_room)
	print(GlobalVars.furniture_collection) 
	
func load_layout():
	if GlobalVars.saved_room != ["save"]:
		for i in GlobalVars.saved_room:
			add_furn(i[0], i[1])
			

func _input(event):
	if event is InputEventKey and event.pressed:
		var SAVE = event.scancode == KEY_S
		var LOAD = event.scancode == KEY_L
		var REPEAT = event.scancode == KEY_R
		if SAVE:
			save_layout()
		if LOAD:
			load_layout()
		if REPEAT:
			save_layout()
			get_tree().change_scene("res://scenes/main/Main.tscn")
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed: 
				if help_on ==true:
					emit_signal("show_room_help")
					help_on = false			
				
func _on_room_help_show():
	print("HELP")		
	if  help_on == false:
		hlp = Hlp.instance()

		print(hlp)
		self.add_child(hlp)

		hlp.set_position(get_viewport_rect().size / 2) 
		help_on = true
	else:
		hlp.queue_free()
		help_on = false	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
