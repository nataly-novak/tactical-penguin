extends Node2D

onready var ui = self.get_parent()
onready var main = ui.get_parent()
onready var map = main.get_node("TileMap")
onready var buttons = self.get_children()
var scale_param
var dist 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal control_presed

# Called when the node enters the scene tree for the first time.
func _ready():
	scale_param = GlobalVars.scale_param
	dist = self.get_node("Right").position.x-self.get_node("Left").position.x
	var ratio = max(scale_param, 200/(320))
	scale_param = ratio
	main.connect("rescale", self, "rescale")
	resize()
	if OS.has_touchscreen_ui_hint() == false:
		for i in buttons:
			
			print(i.get_node("Label"))
			i.get_node("Label").visible = false
	self.connect("control_presed", map, "_on_control_pressed") # Replace with function body.
	self.connect("control_presed", main, "_on_control_pressed")
	get_tree().get_root().connect("size_changed", self, "resize")
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pick_pressed():
	emit_signal("control_presed","PICK")


func _on_Up_pressed():
	emit_signal("control_presed","UP")


func _on_Down_pressed():
	emit_signal("control_presed","DOWN")


func _on_Left_pressed():
	emit_signal("control_presed","LEFT") # Replace with function body.


func _on_Right_pressed():
	emit_signal("control_presed","RIGHT") # Replace with function body.


func _on_Done_pressed():
	emit_signal("control_presed","DONE") # Replace with function body.


func _on_Back_pressed():
	emit_signal("control_presed","BACK") # Replace with function body.


func _on_Next_pressed():
	emit_signal("control_presed","NEXT") # Replace with function body.


func _on_Shop_pressed():
	emit_signal("control_presed","SHP") # Replace with function body.


func _on_Items_pressed():
	emit_signal("control_presed","INV")# Replace with function body.
	
func _on_Sheet_pressed():
	emit_signal("control_presed","CSH")# Replace with function body.

func resize():
	rescale()
	
func rescale():
	self.scale = Vector2(GlobalVars.scale_param,GlobalVars.scale_param)
	self.position.x = get_viewport_rect().size.x-(self.get_node("Right").position.x-self.get_node("Left").position.x)/2*scale_param -128*scale_param
	self.position.y = get_viewport_rect().size.y-(self.get_node("Down").position.y-self.get_node("Done").position.y)/2*GlobalVars.scale_param -80*GlobalVars.scale_param




