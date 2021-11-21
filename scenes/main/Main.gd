extends Node2D
onready var main = self 
onready var hud = self.get_node("HUD")
onready var ui = self.get_node("UI")
onready var map = self.get_node("TileMap")
export (PackedScene) var Inv 
export (PackedScene) var Shp
export (PackedScene) var Hlp
var inventory_on = false
var shop_on = false
var help_on = false
var inv
var shp
var hlp
signal show_help
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("show_help", main, "_on_help_show")
	hud.update_hp(map.hp)
	emit_signal("show_help")
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_hp_change(hp):
	hud.update_hp(hp)
	
func _on_level_change(lvl):
	print("SIGNAL ",lvl)
	hud.update_lvl(lvl)
		
	
func _on_inventory_show(inventory):
	print("TOGGLE:", inventory_on)
	if  inventory_on == false:
		inv = Inv.instance()

		print(inv)
		ui.add_child(inv)

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

		shp.set_position(Vector2(get_viewport_rect().size.x / 2-224,get_viewport_rect().size.y/2-512)) 
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

		hlp.set_position(get_viewport_rect().size / 2) 
		help_on = true
	else:
		hlp.queue_free()
		help_on = false	
