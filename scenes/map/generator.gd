extends Node
var rng = RandomNumberGenerator.new()
onready var map = get_parent()

var max_size = 12
var min_size = 2
var max_num = 8
var min_num = 2
var mp = [-1]
var hall_width = 1
var max_room_start = 16
var max_room = max_room_start
var room_lim = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_tile(re,cell:Vector2, val):
	re[cell.y][cell.x] = val

# Called when the node enters the scene tree for the first time.
func _ready():

	print("generator")
	rng.randomize()


	
			
func set_map(a,b):
	var res=fill_map(a,b)
	map.map_array.append(res)
	for i in len(res)-1:
		for j in len(res[0])-1:
			map.set_cell(j,i,res[i][j])
	res = []
	max_room = max_room_start
	print("NEW")
			
func get_map(l:int):
	var res = map.map_array[l]
	for i in len(res)-1:
		for j in len(res[0])-1:
			map.set_cell(j,i,res[i][j])	
	print("BACK")
			
func fill_map(x, y):
	var chunks = [Rect2(0,0,x,y)]
	while max_room>room_lim:
		split_chunk(chunks,x,y)
	print("Max Room ", max_room)	
	var doors = get_doors(chunks,x,y)
	var re = []
	for i in range (y+1):
		var ln = []
		for j in range(x+1):
			ln.append(0)
		re.append(ln)
	for r in chunks:
		for i in range(r.position.x,r.position.x+r.size.x):
			for j in range(r.position.y, r.position.y+r.size.y):
				set_tile(re,Vector2(i,j),1)
		for i in range(r.position.x+1,r.position.x+r.size.x-1):
			for j in range(r.position.y+1, r.position.y+r.size.y-1):
				set_tile(re,Vector2(i,j),0)			
	for i in doors:
		set_tile(re,i,0)
	for i in range(x):
		set_tile(re, Vector2(i, 0), 1)
		set_tile(re, Vector2(i,y-1),1) 
	for j in range(y):
		set_tile(re, Vector2(0,j),1)
		set_tile(re, Vector2(x-1,j),1)
	return re		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func split_chunk(chunks,x,y):
	var big_chunks =[]
	for i in chunks:
		if i.size.x>hall_width+(min_size+1)*2 or i.size.y>hall_width+(min_size+1)*2:
			big_chunks.append(i)
	if big_chunks != []:
		var big_id = rng.randi_range(0,len(big_chunks)-1)
		var id = chunks.find(big_chunks[big_id])
		print("id ",id)
		var old_chunk = chunks[id]
		
		chunks.remove(id)
		var direction = -1
		#var 
		if old_chunk.size.x>hall_width+(min_size+1)*2:
			if old_chunk.size.y>hall_width+(min_size+1)*2:
				direction = rng.randi_range(0,1)
			else:
				direction = 0
		elif old_chunk.size.y>hall_width+(min_size+1)*2:
			direction = 1
		else:
			direction = -1	
		print(direction)			
			
		if direction == 0:


			var location = rng.randi_range(max(5,old_chunk.position.x+min_size+1), min(old_chunk.position.x+old_chunk.size.x-min_size-3, x-5 ))
			print(location)

			chunks.append(Rect2(old_chunk.position.x, old_chunk.position.y,location-old_chunk.position.x, old_chunk.size.y))
			chunks.append(Rect2(location+hall_width, old_chunk.position.y, old_chunk.size.x+old_chunk.position.x-location-hall_width, old_chunk.size.y))

		elif direction ==1:
			var location = rng.randi_range(max(5,old_chunk.position.y+min_size+2), min(old_chunk.position.y+old_chunk.size.y-min_size-3, y-5))

			print(location)
			chunks.append(Rect2(old_chunk.position.x, old_chunk.position.y, old_chunk.size.x,location-old_chunk.position.y))
			chunks.append(Rect2(old_chunk.position.x,location+hall_width, old_chunk.size.x, old_chunk.size.y+old_chunk.position.y-location-hall_width))

		else:	
			chunks.append(old_chunk)

		var max_chunk = 0
		for i in chunks:
			if max(i.size.x, i.size.y)> max_chunk:
				max_chunk = max(i.size.x, i.size.y)
		max_room = max_chunk
	else:
		max_room=1

func get_doors(chunks,a,b):
	var doors =[]
	for r in chunks:
		var perimeter = []
		for i in range(r.position.x+1, r.position.x+r.size.x-1):
			if r.position.y != 0:
				perimeter.append(Vector2(i,r.position.y))
			if r.position.y+r.size.y  !=b:
				perimeter.append(Vector2(i,r.position.y+r.size.y-1))
		for i in range(r.position.y+1, r.position.y+r.size.y-1):
			if r.position.x != 0:
				perimeter.append(Vector2(r.position.x,i))
			if r.position.x+r.size.x  !=a:
				perimeter.append(Vector2(r.position.x+r.size.x-1,i))
		var num = rng.randi_range(1,3)

		for i in range(num+1):
			var door = rng.randi_range(0,len(perimeter)-1)
			doors.append(perimeter[door])
	return doors		  
			
