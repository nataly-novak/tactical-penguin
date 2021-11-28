extends CanvasLayer
onready var hp_label = self.get_node("hp_label")
onready var lvl_label =self.get_node("Level")
onready var turn_label = self.get_node("Turn")
onready var bottom = self.get_node("BG/Bottom")
onready var top = self.get_node("BG/Top")
onready var left = self.get_node("BG/Left")
onready var right = self.get_node("BG/Right")
onready var logger = self.get_node("Log")
onready var main = self.get_parent()

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
	self.get_node("Log").get_font("normal_font").size=GlobalVars.def_font_size*GlobalVars.scale_param
	resize()
	get_tree().get_root().connect("size_changed", self, "resize") # Replace with function body.
	main.connect("rescale", self, "rescale")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func resize():
	var h = get_parent().get_viewport_rect().size.y
	var w = get_parent().get_viewport_rect().size.x
	rescale()
	bottom.position.y = h-64
	
	if logger.rect_size.y > h-logger.rect_position.y-64:
		logger.rect_size.y = h-logger.rect_position.y-64
		
	
func rescale():
	var w = get_parent().get_viewport_rect().size.x
	right.position.x = w-64*5*GlobalVars.scale_param
	self.get_node("Log").get_font("normal_font").size=GlobalVars.def_font_size*GlobalVars.scale_param
