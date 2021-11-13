extends Node
var rng = RandomNumberGenerator.new()


var items = []
var item_types = 2
var max_items = 1
var result = [0,0] 

func add_item(obj: int):
	items.append(obj)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func remove_item(id: int):
	items.remove(id)

func find_item(obj: int):
	return items.find(obj)
	
func generate_items():
	rng.randomize()
	var numb = rng.randi_range(0,max_items)
	for i in range(numb):
		var new_item = rng.randi_range(0, item_types-1)
		add_item(new_item)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func get_total():
	
	
	for i in items:
		result[i]+=1
	return result	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
