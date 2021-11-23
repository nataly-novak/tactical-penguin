extends Button

var button_id = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal pressed_id
onready var starter = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed_id", starter,"_on_pressed_id")	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	
	emit_signal("pressed_id", button_id) # Replace with function body.
