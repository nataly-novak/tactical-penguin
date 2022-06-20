extends Node2D

var equipment = GlobalVars.equipment_a
var equiped = GlobalVars.equiped
onready var pen_1 = self.get_node("Penguin/weapon")
onready var pen_2 = self.get_node("Penguin/helmet")
onready var pen_3 = self.get_node("Penguin/armor")
onready var pen_4 = null
onready var pen_5 = null
onready var pen_6 = null
onready var pen = [pen_1, pen_2, pen_3, pen_4, pen_5, pen_6]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_appearence() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_appearence():
	for i in len(pen):
		if pen[i]:
			if equipment[i][equiped[i]]:
				pen[i].set_texture(equipment[i][equiped[i]][0])
			else:
				pen[i].set_texture(null)
