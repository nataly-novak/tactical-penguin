extends CanvasLayer
onready var hp_label = self.get_node("hp_label")

func update_hp(hp):
	hp_label.text = str(hp)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass