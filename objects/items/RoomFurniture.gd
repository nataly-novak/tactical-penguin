extends Node2D

onready var rf = self
var names = GlobalVars.ff_types
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dragging = false
var f_type = "chair"
signal dragsignal;


		

# Called when the node enters the scene tree for the first time.
func _ready():
	self.input_pickable = true

	connect("dragsignal",self,"_set_drag_pc")
	
func setup(flavor):
	var id = names.find(flavor)
	var scene = GlobalVars.ofurn[id].instance()
	add_child(scene)

	var sprite = scene.get_node("Sprite")
	var clp = scene.get_node("CollisionPolygon2D")
	scene.remove_child(sprite)
	rf.add_child(sprite)
	
	scene.remove_child(clp)
	rf.add_child(clp)
	scene.queue_free()
	f_type = flavor
	
func _process(delta):
		if dragging:
				var mousepos = get_viewport().get_mouse_position()
				self.position = Vector2(mousepos.x, mousepos.y)



func _set_drag_pc():
		dragging=!dragging

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Node2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
