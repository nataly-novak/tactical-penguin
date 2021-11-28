extends Node2D
onready var main = self 
onready var hud = self.get_node("HUD")
onready var ui = self.get_node("UI")
onready var controls = ui.get_node("controls")
onready var map = self.get_node("TileMap")
export (PackedScene) var Inv 
export (PackedScene) var Shp
export (PackedScene) var Hlp
export (PackedScene) var Zro
var inventory_on = false
var shop_on = false
var help_on = false
var inv
var shp
var hlp
var zro
signal show_help
var turn_counter = 0
signal controls_pressed
var right_lim
var bottom_lim
signal rescale
onready var dpier = get_node("HUD/CheckButton")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("show_help", main, "_on_help_show")
	hud.update_hp(map.hp)
	emit_signal("show_help")
	if GlobalVars.platform != "HTML5":
		dpier.visible = false
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_hp_change(hp):
	hud.update_hp(hp)
	
func _on_level_change(lvl):
	print("SIGNAL ",lvl)
	hud.update_lvl(lvl)
	
func _on_turn_change():
	print("SIGNAL",turn_counter)
	turn_counter+=1
	
	hud.update_turn(turn_counter)	
		
	
func _on_inventory_show(inventory):
	print("TOGGLE:", inventory_on)
	if  inventory_on == false:
		inv = Inv.instance()

		print(inv)
		ui.add_child(inv)
		inv.scale = Vector2(GlobalVars.scale_param, GlobalVars.scale_param)
		inv.set_position(get_viewport_rect().size / 2) 
		inventory_on = true
	else:
		inv.queue_free()
		inventory_on = false
		
				
func _on_shop_show(inventory):
	print("TOGGLE:", shop_on)
	if  shop_on == false:
		shp = Shp.instance()

		print(shp)
		ui.add_child(shp)
		shp.scale = Vector2(GlobalVars.scale_param, GlobalVars.scale_param)
		shp.set_position(Vector2(get_viewport_rect().size.x / 2-224*GlobalVars.scale_param,0)) 
		shop_on = true
	else:
		shp.queue_free()
		shop_on = false
	
		
func _on_help_show():
	print("HELP")		
	if  help_on == false:
		hlp = Hlp.instance()

		print(hlp)
		ui.add_child(hlp)
		hlp.scale = Vector2(GlobalVars.scale_param, GlobalVars.scale_param)
		hlp.set_position(get_viewport_rect().size / 2) 
		help_on = true
	else:
		hlp.queue_free()
		help_on = false	

func _on_checkout():
	get_tree().change_scene("res://scenes/Room/Room.tscn")
	
func _on_zero():
	_on_shop_show(0)
	zro = Zro.instance()
	ui.add_child(zro)
	zro.set_position(get_viewport_rect().size / 2)  
	print("zero")





func _on_CheckButton_toggled(button_pressed):
	GlobalVars.scale_param = 1+int(button_pressed)
	emit_signal("rescale")
