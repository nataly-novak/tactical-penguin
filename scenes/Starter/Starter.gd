extends Node2D

onready var newGame = get_node("NEwGame")
onready var loadLine = get_node("Save")
onready var loadFile = get_node("Load")
onready var achievements = get_node("Achievements")
onready var quit = get_node("Quit")
onready var buttons = [newGame, loadLine, loadFile, achievements, quit]
var lines = ["New Game", "Save", "Load", "Achievements", "Quit"]
export (PackedScene) var Svr
export (PackedScene) var Ldr
var svr
var ldr
var save_on = false
var load_on = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in len(buttons):
		buttons[i].button_id = i
		buttons[i].text = lines[i]


func _on_pressed_id(id):
	print(id)
	match id:
		0:
			get_tree().change_scene("res://scenes/main/Main.tscn")
		1:
			toggle_save()
		2:
			toggle_load()
		3: pass
		4:
			get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func toggle_save():
	if save_on == false:
		svr = Svr.instance()
		add_child(svr)
		svr.set_position(get_viewport_rect().size/2)
		save_on = true
	else:
		svr.queue_free()
		save_on = false
		
func toggle_load():
	if load_on == false:
		ldr = Ldr.instance()
		add_child(ldr)
		ldr.set_position(get_viewport_rect().size/2)
		load_on = true
	else:
		ldr.queue_free()
		load_on = false

func _on_save_closed():
	toggle_save()
	print("on_save_closed")

func _on_load_closed():
	toggle_load()
	get_tree().change_scene("res://scenes/main/Main.tscn")
	print("on_LOAD_closed")
