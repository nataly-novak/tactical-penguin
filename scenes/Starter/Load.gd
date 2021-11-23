extends Node2D


onready var text = get_node("Text")
signal load_closed
onready var starter = self.get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("load_closed",starter,"_on_load_closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_String_pressed():
	var lstr = text.text
	GlobalVars.load_from_string(lstr)
	emit_signal("load_closed")


func _on_Disk_pressed():
	GlobalVars.load_from_disk()
	emit_signal("load_closed")

