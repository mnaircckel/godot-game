extends Node2D

export var fire_rate = .85
export var cannon_speed = 1000
var cannon_timer_right = 0
var cannon_timer_left = 0

var max_ammo = 15
var ammo_count = 15
var ammo_regen = .5
var offset = 50

# Cannons represented by a [fire_angle, speed]
var cannons_left = [ [PI/2, cannon_speed], [PI/2.5, cannon_speed] ]
var cannons_right = [ [-PI/2, cannon_speed], [-PI/2.5, cannon_speed] ]

# Cannon balls are stored as [Node, timer]
var cannon_balls = []
var old_cannon_balls = []

# Used by GUI to scale energy 
func get_ammo():
	return ammo_count
	
func get_max_ammo():
	return max_ammo

func fire_cannons(cannons):

	
	for cannon in cannons:
		if ammo_count < 0:
			ammo_count = 0
		if ammo_count > 1:
			ammo_count -= 1
			var new_cannon_ball_body = RigidBody2D.new()
			var new_cannon_ball = Sprite.new()
			
			var new_cannon_ball_collider = RectangleShape2D.new()
			new_cannon_ball_collider.set_extents(Vector2(200,200))
			new_cannon_ball_body.add_shape(new_cannon_ball_collider)
			new_cannon_ball_body.set_shape_as_trigger(0, true)
		
			new_cannon_ball_body.set_rot(get_parent().get_rot()+cannon[0])
			new_cannon_ball_body.set_pos(get_parent().get_pos()+offset*Vector2( cos(new_cannon_ball_body.get_rot()), -sin(new_cannon_ball_body.get_rot())))
			new_cannon_ball_body.set_gravity_scale(0)
			new_cannon_ball_body.set_linear_velocity( cannon[1]*Vector2( cos(new_cannon_ball_body.get_rot()), -sin(new_cannon_ball_body.get_rot())) )
				
			new_cannon_ball.set_texture(load("res://textures/ball0.png"))
			new_cannon_ball.set_z(2)
			
			new_cannon_ball_body.add_child(new_cannon_ball)
			
			get_tree().get_root().add_child(new_cannon_ball_body)
			cannon_balls.push_back( [new_cannon_ball_body,0] )

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):

	

	cannon_timer_right += delta
	cannon_timer_left += delta
	ammo_count += delta*ammo_regen
	if ammo_count > max_ammo:
		ammo_count = max_ammo

	
	old_cannon_balls = []
	for cannon_ball in cannon_balls:
		cannon_ball[1] += delta
		if cannon_ball[1] > 1:
			get_tree().get_root().remove_child(cannon_ball[0])
			old_cannon_balls.push_back(cannon_ball)
	
	for old_cannon_ball in old_cannon_balls:
		cannon_balls.remove(cannon_balls.find(old_cannon_ball))

	if ( Input.is_action_pressed("ui_fire") ):
		if cannon_timer_left > fire_rate:
			cannon_timer_left = 0
			fire_cannons(cannons_left)
		if cannon_timer_right > fire_rate:
			cannon_timer_right = 0
			fire_cannons(cannons_right)
	
	if ( Input.is_action_pressed("ui_fire_right") ):
		if cannon_timer_right > fire_rate:
			cannon_timer_right = 0
			fire_cannons(cannons_right)
			
	if ( Input.is_action_pressed("ui_fire_left") ):
		if cannon_timer_left > fire_rate:
			cannon_timer_left = 0
			fire_cannons(cannons_left)
			