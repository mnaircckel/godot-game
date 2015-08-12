extends Node2D

var tiles = {}
var tile_size = 1024

var tiles_to_render = {}

func _ready():
	var x = 0
	var y = 0
	for i in range(289):
		if x != 16 and y != 16:
			tiles_to_render[[x,y]] = 0
			tiles[[x,y]] = Sprite.new()
			tiles[[x,y]].set_texture(load("res://slices/tiles"+str(i)+".jpg"))
			tiles[[x,y]].set_pos(Vector2(x*tile_size,y*tile_size))
		x += 1
		if x > 16:
			x = 0
			y += 1
	set_process(true)

func _process(delta):
	var tile_x = int(floor(get_node("Player").get_pos()[0]/tile_size))
	var tile_y = int(floor(get_node("Player").get_pos()[1]/tile_size))
	for i in range (-4,5):
		for j in range(-4,5):
			if i == -4 or i == -3 or i == 3 or i == 4 or j == -4 or j == -3 or j == 3 or j == 4:
					if tiles_to_render.has([tile_x+i,tile_y+j]) and tiles_to_render[[tile_x+i,tile_y+j]] == 1:
						remove_child(tiles[[tile_x+i,tile_y+j]])
						tiles_to_render[[tile_x+i,tile_y+j]] = 0
			else:
				if tiles_to_render.has([tile_x+i,tile_y+j]) and tiles_to_render[[tile_x+i,tile_y+j]] == 0:
					add_child(tiles[[tile_x+i,tile_y+j]])
					tiles_to_render[[tile_x+i,tile_y+j]] = 1