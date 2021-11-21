extends CanvasLayer
onready var hp_label = self.get_node("hp_label")
onready var lvl_label =self.get_node("Level")
onready var turn_label = self.get_node("Turn")

func update_hp(hp):
	hp_label.text = str(hp)
	
func update_lvl(lvl):
	lvl_label.text = str(lvl)
	
func update_turn(turn):
	turn_label.text = str(turn)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
