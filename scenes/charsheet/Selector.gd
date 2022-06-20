extends Node2D

onready var charsheet = self.get_parent()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	charsheet.item_back()


func _on_Next_pressed():
	charsheet.item_next()
	pass # Replace with function body.


func _on_Done_pressed():
	charsheet.toggle_pic()
	pass # Replace with function body.
