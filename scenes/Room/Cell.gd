extends StaticBody2D

onready var row = self.get_parent()
onready var room = row.get_parent()
var textures = GlobalVars.f_flavors
var names = GlobalVars.ff_types
var f_type = "chair"
onready var texture = get_node("Image")
onready var amount = get_node("Amount")
signal cell_clicked
var value = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_cell("bed", 10)
	self.connect("cell_clicked", room, "_on_cell_clicked")


func set_cell(flavor, number):
	f_type = flavor
	var id = names.find(flavor)
	texture.set_texture(textures[id])
	value = number
	amount.text = str(value)
	
func set_amount(number):
	value = number
	amount.text = str(value)	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StaticBody2D_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:

		if event.button_index == BUTTON_LEFT and event.pressed:
			if value > 0:
				emit_signal("cell_clicked", f_type, value)
				set_amount(value-1)
			
