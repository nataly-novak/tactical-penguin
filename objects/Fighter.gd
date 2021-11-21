extends Node

onready var AC = 10
onready var BAB = 5
onready var dnumber = 1
onready var ddice = 6
onready var dbonus = 3
onready var hp = 30
onready var crit_mult =2
onready var crit_chance = 20
onready var character = get_parent()
onready var max_hp = 300

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_attack(number, dice, attack, bonus, mult, chance):
	var roll = GlobalVars.rolled(1,20)
	if roll+bonus>= self.AC:
		if roll>=chance:
			var confirm = GlobalVars.rolled(1,20)+bonus
			if confirm > self.AC:
				return get_damage(GlobalVars.rolled(mult*number,dice)+mult*bonus)
			else:
				return get_damage(GlobalVars.rolled(number, dice)+bonus)
		else:
			return get_damage(GlobalVars.rolled(number, dice)+bonus)
	else:
		if roll == 20:
			return get_damage(GlobalVars.rolled(number, dice)+bonus)
		else:
			return get_damage(0)
		
	

# Called when the node enters the scene tree for the first time.
func _ready():

	match character.o_type:
		
		"hero":
			set_params(GlobalVars.hero_params)
		"whale":
			set_params(GlobalVars.whale_params)

			 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
	
func get_damage (damage):
	print(damage)
	print(character.o_type," health ",self.hp)
	self.hp = self.hp-damage
	print(character.o_type," damage ",self.hp)	
	if self.hp<0:
		self.hp = 0 
		return 0
	else:
		return 1
		
func set_params(params):
	self.hp = params[0]
	self.AC = params[1]
	self.dnumber = params[2]
	self.ddice = params[3]
	self.BAB=params[4]
	self.dbonus = params[5]
	self.crit_mult = params[6]
	self.crit_chance = params[7]
	self.max_hp = params[0]
		
func get_AC():
	return self.AC
	
func get_BAB():
	return self.BAB
	
func get_dnumber():	
	return self.dnumber
	
func get_ddice():
	return self.ddice
	
func get_dbonus():
	return self.dbonus
	
func get_hp():
	return self.hp
	
func get_chance():
	return self.crit_chance
	
func get_mult():
	return self.crit_mult		

func heal(heal_value):
	self.hp = min(self.hp+heal_value, self.max_hp)
