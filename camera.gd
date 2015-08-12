
extends Camera2D

var zoom_interval = .15
var zoom_max = .85
var zoom_min = 1.15
var last_zoom = 0

var current_zoom = .85

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
		last_zoom += delta
		if last_zoom > .35:
			if ( Input.is_action_pressed("ui_zoom_in") ):
				if (current_zoom > zoom_max):
					last_zoom = 0
					set_zoom(Vector2(current_zoom-zoom_interval,current_zoom-zoom_interval))
					current_zoom -= zoom_interval
			elif ( Input.is_action_pressed("ui_zoom_out") ):
				if (current_zoom < zoom_min):
					last_zoom = 0
					set_zoom(Vector2(current_zoom+zoom_interval,current_zoom+zoom_interval))
					current_zoom += zoom_interval

