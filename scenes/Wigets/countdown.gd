extends Timer

onready var zero = get_parent()
onready var ui = zero.get_parent()
onready var main = ui.get_parent()
signal unspawn
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	 pass# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_countdown_timeout():
	print("down")
	
	zero.queue_free()
