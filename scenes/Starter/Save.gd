extends Node2D

onready var text = get_node("Text")
signal save_closed
onready var starter = self.get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("save_closed",starter,"_on_save_closed")
	var sstr = GlobalVars.save_to_string()
	text.text = sstr# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Close_pressed():
	print("close")
	emit_signal("save_closed") # Replace with function body.


func _on_Write_pressed():
	GlobalVars.save_to_disk()
	emit_signal("save_closed") # Replace with function body.


	
