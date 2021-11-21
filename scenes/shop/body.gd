extends Node2D
var body = self

var setups = GlobalVars.setups
var textures = GlobalVars.btextures
onready var l1 = self.get_node("Label")
onready var l2 = self.get_node("Label2")
onready var l3 = self.get_node("Label3")
onready var labels = [l1,l2,l3]
onready var bp = self.get_node("Sprite/print")
var blueprints = GlobalVars.ff_types
var bodytex = preload("res://graphics/UI/Board.png")
var seltex = preload("res://graphics/UI/Board_selected.png")
onready var bg = self.get_node("Sprite")
var selected = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_item( blueprint):
	var i = blueprints.find(blueprint)
	set_values(i)
		
		
func set_numbers(values):
	for i in len(setups[values]):
		labels[i].text = str(setups[values][i])

		
func set_values(i:int):
		bp.set_texture(textures[i])
		set_numbers(i)
		
func toggle_bg():
	if selected:
		selected = false
		bg.set_texture(bodytex)
	else:
		selected = true
		bg.set_texture(seltex)
		

