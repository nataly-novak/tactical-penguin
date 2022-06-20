extends Node2D


onready var sheet = self
onready var ui = self.get_parent()
onready var main = ui.get_parent()
onready var map = main.map
onready var select_1 = self.get_node("Selection_1")
onready var select_2 = self.get_node("Selection_2")
onready var select_3 = self.get_node("Selection_3")
onready var select_4 = self.get_node("Selection_4")
onready var select_5 = self.get_node("Selection_5")
onready var select_6 = self.get_node("Selection_6")
onready var selector = self.get_node("selector")
onready var pic_1 = self.get_node("Field/Pictures/W_Pic")
onready var pic_2 = self.get_node("Field/Pictures/H_Pic")
onready var pic_3 = self.get_node("Field/Pictures/B_Pic")
onready var pic_4 = self.get_node("Field/Pictures/O_Pic")
onready var pic_5 = self.get_node("Field/Pictures/F_Pic")
onready var pic_6 = self.get_node("Field/Pictures/R_Pic")
onready var selector_pic = selector.get_node("Image")
onready var pen_1 = self.get_node("Penguin/Weapon")
onready var pen_2 = self.get_node("Penguin/Pan")
onready var pen_3 = self.get_node("Penguin/Pillow")
onready var pen_4 = null
onready var pen_5 = null
onready var pen_6 = null

onready var lbl_1 = self.get_node("Field/Labels/W_Bonus")
onready var lbl_2 = self.get_node("Field/Labels/H_Bonus")
onready var lbl_3 = self.get_node("Field/Labels/B_Bonus")
onready var lbl_4 = self.get_node("Field/Labels/O_Bonus")
onready var lbl_5 = self.get_node("Field/Labels/F_Bonus")
onready var lbl_6 = self.get_node("Field/Labels/R_Bonus")

onready var text = selector.get_node("Bonus")
onready var title = selector.get_node("Slot")

signal equip_updated

onready var names = ["Weapon", "Head", "Body", "Booster", "Feet", "Random"]
onready var selections=[select_1, select_2, select_3, select_4, select_5, select_6]
onready var pics=[pic_1, pic_2, pic_3, pic_4, pic_5, pic_6]
onready var penguin = [pen_1, pen_2, pen_3, pen_4, pen_5, pen_6]
onready var lbls = [lbl_1, lbl_2, lbl_3, lbl_4, lbl_5, lbl_6]


var selector_on = false
var selected = 0
var equipment = GlobalVars.equipment_a
var equiped = GlobalVars.equiped
var selection = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("equip_updated", map, "_on_equip_updated")
	selections[0].show()
	for i in len(penguin):
		if penguin[i]:
			if equipment[i][equiped[i]]:
				penguin[i].set_texture(equipment[i][equiped[i]][0])
				pics[i].set_texture(equipment[i][equiped[i]][0])
			else:
				penguin[i].set_texture(null)
				pics[i].set_texture(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func go_next():
	print("next")
	selections[selected].hide()
	if selected<5:
		selected+=1
	else:
		selected=0
	selections[selected].show()
	
func go_back():
	selections[selected].hide()
	if selected>0:
		selected-=1
	else:
		selected=5
	selections[selected].show()
	
func toggle_selector():
	if selector_on:
		selector.hide()
		selector_on = false
	else:
		title.text = names[selected]
		var imag
		var line
		if len(equipment[selected])>1 and equipment[selected][equiped[selected]]:
			imag  = equipment[selected][equiped[selected]][0]
			line = GlobalVars.get_line(equipment[selected][equiped[selected]][1], equipment[selected][equiped[selected]][2])
		else:
			imag = null
			line = ""
		selector.show()
		selector_on = true
		selector_pic.set_texture(imag)
		text.text = line
		
func item_next():
	var n = len(equipment[selected])
	var i = equiped[selected]
	if i<n-1:
		i+=1
	else:
		i=0
	equiped[selected]=i
	var imag
	var line
	if len(equipment[selected])>1 and equipment[selected][i]:
		imag  = equipment[selected][equiped[selected]][0]
		line = GlobalVars.get_line(equipment[selected][equiped[selected]][1], equipment[selected][equiped[selected]][2])
	else:
		imag = null
		line = ""
	selector_pic.set_texture(imag)
	selection=i
	text.text = line
	
	
func item_back():
	var n = len(equipment[selected])
	var i = equiped[selected]
	if i>0:
		i-=1
	else:
		i=n-1
	equiped[selected]=i
	var imag
	var line
	if len(equipment[selected])>1 and equipment[selected][i]:
		imag  = equipment[selected][equiped[selected]][0]
		line = GlobalVars.get_line(equipment[selected][equiped[selected]][1], equipment[selected][equiped[selected]][2])
	else:
		imag = null
		line = ""
	selector_pic.set_texture(imag)
	selection=i
	text.text = line
	
func toggle_pic():
	if len(equipment[selected])>1 and equipment[selected][equiped[selected]]:
		pics[selected].set_texture(equipment[selected][selection][0])
		lbls[selected].text = GlobalVars.get_line(equipment[selected][selection][1],equipment[selected][selection][2])
		penguin[selected].set_texture(equipment[selected][equiped[selected]][0])
	else:
		pics[selected].set_texture(null)
		if penguin[selected]:
			penguin[selected].set_texture(null)
		lbls[selected].text = ""
	toggle_selector()
	
func update_char():
	emit_signal("equip_updated")


			
			
			


func _on_Back_pressed():
	go_back()


func _on_Next_pressed():
	go_next() # Replace with function body.


func _on_Save_pressed():
	map.toggle_charsheet()
