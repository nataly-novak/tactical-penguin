extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print(get_enemy())# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func create_current_prob():
	var inits = []
	for i in len(GlobalVars.e_i_freq):
		if GlobalVars.e_lims[i]<=self.get_parent().current_floor:
			inits.append(GlobalVars.e_i_freq[i])
	if len(inits)>1:
		for i in len(inits)-2:
			i=i-self.get_parent().current_floor*3
	var probs = []
	for i in len(inits):
		for j in inits[i]:
			probs.append(i)
	return probs
	
func get_enemy():
	var line = create_current_prob()
	var nmb = line[GlobalVars.rolled(1, len(line))-1]
	var enemy = GlobalVars.e_types[nmb] 
	print(enemy)
	return enemy
	
	


