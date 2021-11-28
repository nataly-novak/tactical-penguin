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
onready var labels = [$Label, $hp_label, $Label2, $Level, $Label3, $Turn]
onready var label_poss = [$Label.rect_position.x, $hp_label.rect_position.x, $Label2.rect_position.x, $Level.rect_position.x, $Label3.rect_position.x, $Turn.rect_position.x]
onready var l_y = hp_label.rect_position.y
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

	GlobalVars.label_font_size = hp_label.get_font("font").size
	logger.text+=str(GlobalVars.label_font_size)
	self.get_node("Log").get_font("normal_font").size=GlobalVars.def_font_size*GlobalVars.scale_param
	resize()
	get_tree().get_root().connect("size_changed", self, "resize") # Replace with function body.
	main.connect("rescale", self, "rescale")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func resize():

	
	rescale()
	
		
	
func rescale():
	var h = get_parent().get_viewport_rect().size.y
	var w = get_parent().get_viewport_rect().size.x
	bottom.scale.y = GlobalVars.scale_param
	bottom.position.y = h-64*GlobalVars.scale_param
	
	if logger.rect_size.y > h-logger.rect_position.y-64*GlobalVars.scale_param:
		logger.rect_size.y = h-logger.rect_position.y-64*GlobalVars.scale_param


	right.position.x = w-max(200,64*5*GlobalVars.scale_param)

	self.get_node("Log").get_font("normal_font").size=max(12,int(GlobalVars.def_font_size*GlobalVars.scale_param))
	if GlobalVars.scale_param <1 :

		left.scale.x =GlobalVars.scale_param

		right.position.x = w-max(200,64*5*GlobalVars.scale_param)
		top.position.y -=126-126*GlobalVars.scale_param
		left.position.y -=126-126*GlobalVars.scale_param
		left.scale.y =GlobalVars.scale_param
		logger.rect_size.x*=(GlobalVars.scale_param)
		logger.rect_position.y-=126-126*GlobalVars.scale_param
		logger.rect_position.x-=64-64*GlobalVars.scale_param
		
		
		for i in len(labels):
			labels[i].get_font("font").size= GlobalVars.scale_param*GlobalVars.label_font_size
			labels[i].rect_position.x = label_poss[i]* GlobalVars.scale_param
			labels[i].rect_position.y = l_y* GlobalVars.scale_param
		
		
