
extends KinematicBody2D

var player_acceleration = .001
var linear_drag = .8
var rotational_drag = 1.1
export var rotation_constant = 9
export var speed_constant = 2500

var player_speed = 0
var player_rotation_speed = 0

func calc_movement(delta):
	var movement = player_speed*speed_constant*Vector2( cos(get_rot()), -sin(get_rot())).normalized()*delta
	player_rotation_speed /= rotational_drag
	player_speed /= player_speed*player_speed*linear_drag + 1
	rotate(player_rotation_speed*player_speed * delta)
	move(movement)

func _ready():
	raise()
	set_fixed_process(true)

func _fixed_process(delta):
	if ( Input.is_action_pressed("ui_up") ):
		player_speed += player_acceleration
	elif ( Input.is_action_pressed("ui_down") ):
		player_speed -= player_acceleration/4
		
	if ( Input.is_action_pressed("ui_left") ):
		player_rotation_speed = rotation_constant
	elif ( Input.is_action_pressed("ui_right") ):
		player_rotation_speed = -rotation_constant
	calc_movement(delta)
	set_pos( Vector2(int(get_pos().x),int(get_pos().y)) )