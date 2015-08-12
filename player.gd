
extends Sprite

var player_acceleration = .001
var linear_drag = .8
var rotational_drag = 1.1
var rotation_constant = 5
var speed_constant = 2500

var player_speed = 0
var player_rotation_speed = 0

func move(delta):
	player_rotation_speed /= rotational_drag
	player_speed /= player_speed*player_speed*linear_drag + 1
	rotate(player_rotation_speed*player_speed * delta)
	
	set_pos(get_pos() + ( player_speed*speed_constant*Vector2( cos(get_rot()), -sin(get_rot())).normalized()*delta ) )

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
	move(delta)


