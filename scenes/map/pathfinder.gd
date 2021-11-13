extends Node
onready var map = get_parent()
var aStar:AStar2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	 # Replace with function body.


func get_a_cells():
	

	aStar = AStar2D.new()
	aStar.reserve_space(map.a*map.b)
	for i in range(map.a):
		for j in range(map.b):
			if map.is_blocked(Vector2(i,j)) == "empty":
				var idx = getAStarCellId(Vector2(i,j))

				aStar.add_point(idx, Vector2(i,j))
	for i in range(map.a):
		for j in range(map.b):
			if map.is_blocked(Vector2(i,j)) == "empty":
				var idx = getAStarCellId(Vector2(i,j))
				for vNeighborCell in [Vector2(i,j-1),Vector2(i,j+1),Vector2(i-1,j),Vector2(i+1,j)]:
					var idxNeighbor=getAStarCellId(vNeighborCell)
					if aStar.has_point(idxNeighbor):

						aStar.connect_points(idx, idxNeighbor, false)



	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func getAStarCellId(vCell:Vector2):
	var id = (vCell.y+vCell.x*map.b)
	return  id
	
	
func occupy(pos:Vector2):
	var idx = getAStarCellId(pos)
	if aStar.has_point(idx):
		aStar.set_point_disabled(idx, true)
		
func freed(pos:Vector2):
	var idx = getAStarCellId(pos)
	if aStar.has_point(idx):
		aStar.set_point_disabled(idx, false)
		
func get_a_path(aStar, start:Vector2, target:Vector2):

	var idStart = getAStarCellId(start)

	var idTarget = getAStarCellId(target)
	
	if aStar.has_point(idStart) and aStar.has_point(idTarget):


		return Array(aStar.get_point_path(idStart, idTarget))
	else:	
		return []
