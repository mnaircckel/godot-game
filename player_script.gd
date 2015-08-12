
extends KinematicBody2D

const MAX_SPEED = 300.0
const IDLE_SPEED = 10.0
const ACCEL = 5.0
const VSCALE = 0.5
const SHOOT_INTERVAL = 0.3

var player_speed = 0
var speed = Vector2()

var shoot_countdown=0

func _fixed_process(delta):

	var dir = Vector2()
	if ( Input.is_action_pressed("ui_up") ):
		player_speed += player_acceleration
	elif ( Input.is_action_pressed("ui_down") ):
		player_speed -= player_acceleration/4
		
	if ( Input.is_action_pressed("ui_left") ):
		player_rotation_speed = rotation_constant
	elif ( Input.is_action_pressed("ui_right") ):
		player_rotation_speed = -rotation_constant
		
	if (dir!=Vector2()):
		dir=dir.normalized()
	speed = speed.linear_interpolate(dir*MAX_SPEED,delta*ACCEL)
	var motion = speed * delta
	motion = move(motion)
		


func _ready():
	set_fixed_process(true)
	set_process_input(true)
	pass


