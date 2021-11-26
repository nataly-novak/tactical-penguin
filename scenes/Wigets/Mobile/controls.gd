extends Node2D

onready var ui = self.get_parent()
onready var main = ui.get_parent()
onready var map = main.get_node("TileMap")
onready var buttons = self.get_children()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal control_presed

# Called when the node enters the scene tree for the first time.
func _ready():

	if OS.has_touchscreen_ui_hint() == false:
		for i in buttons:
			
			print(i.get_node("Label"))
			i.get_node("Label").visible = false
	self.connect("control_presed", map, "_on_control_pressed") # Replace with function body.
	self.connect("control_presed", main, "_on_control_pressed")
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
