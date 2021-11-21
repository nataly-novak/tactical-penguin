extends Node

var rng = RandomNumberGenerator.new()

var i_types = ["stick", "plack", "cloth"]

var ff_types = ["chair","table","curtain","bed", "bedside", "soft"]
var setups = [[6,2,0],[8,4,0],[3,0,2],[10,9,7],[8,6,0],[8,5,2]]
var chairtex = preload("res://graphics/furniture/chair.png")
var tabletex = preload("res://graphics/furniture/Table.png")
var curtaintex = preload("res://graphics/furniture/Curtain.png")
var bedtex = preload("res://graphics/furniture/bed.png")
var bedsidetex = preload("res://graphics/furniture/bedside.png")
var softtex = preload("res://graphics/furniture/soft.png")
var f_flavors = [chairtex, tabletex, curtaintex, bedtex, bedsidetex, softtex]
var chairtexb = preload("res://graphics/blueprints/chair.png")
var tabletexb = preload("res://graphics/blueprints/Table.png")
var curtaintexb = preload("res://graphics/blueprints/Curtain.png")
var bedtexb = preload("res://graphics/blueprints/bed.png")
var bedsidetexb = preload("res://graphics/blueprints/bedside.png")
var softtexb = preload("res://graphics/blueprints/soft.png")
var btextures = [chairtexb,tabletexb,curtaintexb,bedtexb,bedsidetexb,softtexb]

var hero_params = [300,12,5,1,6,3,2,19]
var whale_params = [20,13,2,2,4,1,2,20]

var playertex = preload("res://graphics/player/Penguin.png")
var whaletex = preload("res://graphics/monster/Whale.png")

var max_enemies = 20

var a = 30
var b = 30
var max_size = 12
var min_size = 2
var max_num = 8
var min_num = 2
var hall_width = 1
var max_room_start = 16


var placktex = preload("res://graphics/items/plackl.png")
var sticktex = preload("res://graphics/items/Stick.png")
var clothtex = preload("res://graphics/items/cloth.png")
var itemtex = [placktex, sticktex, clothtex]# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize() # Replace with function body.

func rolled(number, dice):
	var res = 0
	for i in number:
		res+=rng.randi_range(1,dice)
		print(res)
	return res
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
