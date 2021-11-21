extends Node2D
var body = self
var chairtex = preload("res://graphics/blueprints/chair.png")
var tabletex = preload("res://graphics/blueprints/Table.png")
var curtaintex = preload("res://graphics/blueprints/Curtain.png")
var bedtex = preload("res://graphics/blueprints/bed.png")
var bedsidetex = preload("res://graphics/blueprints/bedside.png")
var softtex = preload("res://graphics/blueprints/soft.png")
var setups = [[6,2,0],[8,4,0],[3,0,2],[10,9,7],[8,6,0],[8,5,2]]
var textures = [chairtex,tabletex,curtaintex,bedtex,bedsidetex,softtex]
onready var l1 = self.get_node("Label")
onready var l2 = self.get_node("Label2")
onready var l3 = self.get_node("Label3")
onready var labels = [l1,l2,l3]
onready var bp = self.get_node("Sprite/print")
var blueprints = ["chair","table","curtain","bed", "bedside", "soft"]
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
