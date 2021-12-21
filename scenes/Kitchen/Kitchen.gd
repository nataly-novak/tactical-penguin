extends Node2D
onready var ui = self.get_parent()
onready var main = ui.get_parent()
var stage = 1

# Declare member variables here. Examples:
# var a = 2
signal walrus_show
signal food_bought# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("walrus_show", main, "_on_walrus_show") 
	connect("food_bought", main, "_on_food_bought") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Yes_pressed():
	match stage:
		1:
			$Speech.text = "Do you want some meatballs to refresh yourself?"
			stage = 2
		2:
			$Speech.text = "Help yourself!"
			emit_signal("food_bought")
			stage = 0
			$Timer.start()# Replace with function body.


func _on_No_pressed():
	emit_signal("walrus_show")


func _on_Timer_timeout():
	
	emit_signal("walrus_show") # Replace with function body.
